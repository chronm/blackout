import 'package:flutter/material.dart' show BuildContext, Colors, Icon, Icons, Key, Navigator, StatelessWidget, TextStyle, Theme, Widget, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/product.dart';
import '../../../models/unit/unit.dart';
import '../../../routes.dart';
import '../../product/cubit/product_cubit.dart' show ProductCubit;
import '../../product/widgets/product_configuration.dart';
import '../../speeddial/cubit/speed_dial_cubit.dart';
import '../../speeddial/speeddial.dart';
import '../cubit/group_cubit.dart';

class GroupDial extends StatelessWidget {
  const GroupDial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeedDialCubit, SpeedDialState>(
      cubit: sl<SpeedDialCubit>(),
      listener: (context, state) async {
        if (state is GoToHome) {
          Navigator.pushNamed(context, Routes.home);
        }
        if (state is GoToCreateProductInGroup) {
          await showDialog(
            context: context,
            builder: (context) => ProductConfiguration(
              product: Product(home: state.home, description: "", unit: UnitEnum.unitless, group: state.group),
              newProduct: true,
              groups: state.groups,
              action: (product) async {
                sl<ProductCubit>().saveProduct(product);
                await Navigator.pushNamed(context, Routes.product);
                Navigator.pop(context);
              },
            ),
          );
          sl<GroupCubit>().redraw();
        }
      },
      child: BlocBuilder<GroupCubit, GroupState>(
        cubit: sl<GroupCubit>(),
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
                  onTap: () => sl<SpeedDialCubit>().tapOnGoToHome(),
                ),
              ];
              if (state is ShowGroup) {
                children.addAll([
                  SpeedDialChild(
                    child: const Icon(Icons.insert_drive_file),
                    backgroundColor: Theme.of(context).accentColor,
                    label: S.of(context).SPEEDDIAL_CREATE_PRODUCT,
                    labelStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    onTap: () => sl<SpeedDialCubit>().tapOnCreateProductInGroup(state.group),
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
