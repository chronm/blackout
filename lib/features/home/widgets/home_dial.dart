import 'package:flutter/material.dart' show BuildContext, Colors, Icon, Icons, Key, Navigator, StatelessWidget, TextStyle, Theme, Widget, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../models/product.dart';
import '../../../models/unit/unit.dart';
import '../../../routes.dart';
import '../../group/cubit/group_cubit.dart' show GroupCubit;
import '../../group/widgets/group_configuration.dart';
import '../../product/cubit/product_cubit.dart';
import '../../product/cubit/product_cubit.dart' show ProductCubit;
import '../../product/widgets/product_configuration.dart';
import '../../speeddial/cubit/speed_dial_cubit.dart' show GoToProduct, GoToCreateGroup, GoToCreateProduct, SpeedDialCubit, SpeedDialState;
import '../../speeddial/speeddial.dart';
import '../cubit/home_cubit.dart' show HomeCubit, HomeInitialState, HomeState;

class HomeDial extends StatelessWidget {
  const HomeDial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeedDialCubit, SpeedDialState>(
      cubit: sl<SpeedDialCubit>(),
      listener: (context, state) async {
        if (state is GoToProduct) {
          Navigator.pushNamed(context, Routes.product);
        }
        if (state is GoToCreateGroup) {
          await showDialog(
            context: context,
            builder: (context) => GroupConfiguration(
              group: Group(home: state.home, name: "", unit: UnitEnum.unitless),
              newGroup: true,
              action: (group) async {
                sl<GroupCubit>().saveGroup(group);
                await Navigator.pushNamed(context, Routes.group);
                Navigator.pop(context);
              },
            ),
          );
          sl<HomeCubit>().redraw();
        }
        if (state is GoToCreateProduct) {
          await showDialog(
            context: context,
            builder: (context) => ProductConfiguration(
              product: Product(home: state.home, description: "", unit: UnitEnum.unitless, group: null, ean: state.ean),
              newProduct: true,
              groups: state.groups,
              action: (product) async {
                sl<ProductCubit>().saveProduct(product);
                await Navigator.pushNamed(context, Routes.product);
                Navigator.pop(context);
              },
            ),
          );
          sl<HomeCubit>().redraw();
        }
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        cubit: sl<HomeCubit>(),
        builder: (context, state) {
          return BlackoutDial(
            builder: (context) {
              if (state is HomeInitialState) {
                return [];
              }
              return [
                SpeedDialChild(
                  child: const Icon(Icons.center_focus_weak),
                  backgroundColor: Theme.of(context).accentColor,
                  label: S.of(context).SPEEDDIAL_SCAN,
                  labelStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  onTap: () => sl<SpeedDialCubit>().tapOnScanEan(),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.insert_drive_file),
                  backgroundColor: Theme.of(context).accentColor,
                  label: S.of(context).SPEEDDIAL_CREATE_PRODUCT,
                  labelStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  onTap: () => sl<SpeedDialCubit>().tapOnCreateProduct(),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.create_new_folder),
                  backgroundColor: Theme.of(context).accentColor,
                  label: S.of(context).SPEEDDIAL_CREATE_GROUP,
                  labelStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  onTap: () => sl<SpeedDialCubit>().tapOnCreateGroup(),
                ),
              ];
            },
          );
        },
      ),
    );
  }
}
