import 'package:flutter/material.dart'
    show
        BuildContext,
        Colors,
        Icon,
        Icons,
        Key,
        Navigator,
        StatelessWidget,
        TextStyle,
        Theme,
        Widget,
        showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/charge.dart';
import '../../../models/group.dart';
import '../../../models/unit/unit.dart';
import '../../../routes.dart';
import '../../charge/bloc/charge_bloc.dart';
import '../../charge/widgets/charge_configuration.dart';
import '../../group/bloc/group_bloc.dart';
import '../../group/widgets/group_configuration.dart';
import '../../home/bloc/home_bloc.dart';
import '../../speeddial/bloc/speed_dial_bloc.dart';
import '../../speeddial/speeddial.dart';
import '../bloc/product_bloc.dart';

class ProductDial extends StatelessWidget {
  const ProductDial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeedDialBloc, SpeedDialState>(
      bloc: sl<SpeedDialBloc>(),
      listener: (context, state) async {
        if (state is GoToHome) {
          Navigator.pushNamed(context, Routes.home);
        }
        if (state is ShowCreateGroupForProduct) {
          await showDialog(
            context: context,
            builder: (context) => GroupConfiguration(
              group: Group(home: state.home, name: "", unit: UnitEnum.unitless),
              newGroup: true,
              action: (group) async {
                sl<GroupBloc>().add(SaveGroup(group));
                await Navigator.pushNamed(context, Routes.group);
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
                await Navigator.pushNamed(context, Routes.charge);
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
              var children = <SpeedDialChild>[
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
                    onTap: () => sl<SpeedDialBloc>()
                        .add(TapOnCreateCharge(state.product)),
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.create_new_folder),
                    backgroundColor: Theme.of(context).accentColor,
                    label: S.of(context).SPEEDDIAL_CREATE_GROUP,
                    labelStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    onTap: () =>
                        sl<SpeedDialBloc>().add(TapOnCreateGroupForProduct()),
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
