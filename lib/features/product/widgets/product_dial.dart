import 'package:Blackout/features/charge/bloc/charge_bloc.dart';
import 'package:Blackout/features/charge/widgets/charge_configuration.dart';
import 'package:Blackout/features/group/bloc/group_bloc.dart';
import 'package:Blackout/features/group/widgets/group_configuration.dart';
import 'package:Blackout/features/home/bloc/home_bloc.dart';
import 'package:Blackout/features/product/bloc/product_bloc.dart';
import 'package:Blackout/features/speeddial/bloc/speed_dial_bloc.dart';
import 'package:Blackout/features/speeddial/speeddial.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/routes.dart';
import 'package:flutter/material.dart' show BuildContext, Colors, Icon, Icons, Key, Navigator, StatelessWidget, TextStyle, Theme, Widget, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ProductDial extends StatelessWidget {
  const ProductDial({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeedDialBloc, SpeedDialState>(
      bloc: sl<SpeedDialBloc>(),
      listener: (context, state) async {
        if (state is GoToHome) {
          Navigator.push(context, RouteBuilder.build(Routes.HomeRoute));
        }
        if (state is ShowCreateGroupForProduct) {
          await showDialog(
            context: context,
            builder: (context) => GroupConfiguration(
              group: Group(home: state.home, name: "", unit: UnitEnum.unitless),
              newGroup: true,
              action: (group) async {
                sl<GroupBloc>().add(SaveGroup(group));
                await Navigator.push(context, RouteBuilder.build(Routes.GroupOverviewRoute));
                Navigator.pop(context);
              },
            ),
          );
          sl<HomeBloc>().add(LoadAll());
        }

        if (state is ShowCreateCharge) {
          await showDialog(
            context: context,
            builder: (context) => ChargeConfiguration(
              charge: Charge(product: state.product),
              newCharge: true,
              action: (charge) async {
                sl<ChargeBloc>().add(SaveCharge(charge));
                await Navigator.push(context, RouteBuilder.build(Routes.ChargeOverviewRoute));
                Navigator.pop(context);
              },
            ),
          );
          sl<ProductBloc>().add(LoadProduct(state.currentProduct));
        }
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        bloc: sl<ProductBloc>(),
        builder: (context, state) {
          return BlackoutDial(
            builder: (context) {
              List<SpeedDialChild> children = [
                SpeedDialChild(
                  child: const Icon(Icons.home),
                  backgroundColor: Theme.of(context).accentColor,
                  label: S.of(context).SPEEDDIAL_GOTO_HOME,
                  labelStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  onTap: () => sl<SpeedDialBloc>().add(TapOnGotoHome()),
                ),
              ];
              if (state is ShowProduct) {
                children.addAll([
                  SpeedDialChild(
                    child: const Icon(Icons.insert_drive_file),
                    backgroundColor: Theme.of(context).accentColor,
                    label: S.of(context).SPEEDDIAL_CREATE_CHARGE,
                    labelStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    onTap: () => sl<SpeedDialBloc>().add(TapOnCreateCharge(state.product)),
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.create_new_folder),
                    backgroundColor: Theme.of(context).accentColor,
                    label: S.of(context).SPEEDDIAL_CREATE_GROUP,
                    labelStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    onTap: () => sl<SpeedDialBloc>().add(TapOnCreateGroupForProduct()),
                  ),
                ]);
              }

              return children;
            },
          );
        },
      ),
    );
  }
}
