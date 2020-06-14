import 'package:Blackout/features/group_overview/bloc/group_bloc.dart';
import 'package:Blackout/features/product_overview/bloc/product_bloc.dart';
import 'package:Blackout/features/product_overview/widgets/product_configuration.dart';
import 'package:Blackout/features/speeddial/bloc/speed_dial_bloc.dart';
import 'package:Blackout/features/speeddial/speeddial.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/routes.dart';
import 'package:flutter/material.dart' show BuildContext, Colors, Icon, Icons, Key, Navigator, StatelessWidget, TextStyle, Widget, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class GroupDial extends StatelessWidget {
  const GroupDial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeedDialBloc, SpeedDialState>(
      bloc: sl<SpeedDialBloc>(),
      listener: (context, state) async {
        if (state is GoToHome) {
          Navigator.push(context, RouteBuilder.build(Routes.HomeRoute));
        }
        if (state is ShowCreateProductInGroup) {
          await showDialog(
            context: context,
            builder: (context) => ProductConfiguration(
              product: Product(home: state.home, description: "", unit: UnitEnum.unitless, group: state.group),
              newProduct: true,
              groups: state.groups,
              action: (product) async {
                sl<ProductBloc>().add(SaveProduct(product));
                await Navigator.push(context, RouteBuilder.build(Routes.ProductOverviewRoute));
                Navigator.pop(context);
              },
            ),
          );
          sl<GroupBloc>().add(LoadGroup(state.currentGroup));
        }
      },
      child: BlocBuilder<GroupBloc, GroupState>(
        bloc: sl<GroupBloc>(),
        builder: (context, state) {
          return BlackoutDial(
            builder: (context) {
              List<SpeedDialChild> children = [
                SpeedDialChild(
                  child: const Icon(Icons.home),
                  backgroundColor: Colors.red,
                  label: S.of(context).SPEEDDIAL_GOTO_HOME,
                  labelStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  onTap: () => sl<SpeedDialBloc>().add(TapOnGotoHome()),
                ),
              ];
              if (state is ShowGroup) {
                children.addAll([
                  SpeedDialChild(
                    child: const Icon(Icons.insert_drive_file),
                    backgroundColor: Colors.red,
                    label: S.of(context).SPEEDDIAL_CREATE_PRODUCT,
                    labelStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    onTap: () => sl<SpeedDialBloc>().add(TapOnCreateProductInGroup(state.group)),
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
