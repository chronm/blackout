import 'package:flutter/material.dart' show BuildContext, Colors, Icon, Icons, Key, Navigator, StatelessWidget, TextStyle, Theme, Widget, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/batch.dart';
import '../../../models/group.dart';
import '../../../models/unit/unit.dart';
import '../../../routes.dart';
import '../../batch/cubit/batch_cubit.dart' show BatchCubit;
import '../../batch/widgets/batch_configuration.dart';
import '../../group/cubit/group_cubit.dart' show GroupCubit;
import '../../group/widgets/group_configuration.dart';
import '../../speeddial/cubit/speed_dial_cubit.dart';
import '../../speeddial/speeddial.dart';
import '../cubit/product_cubit.dart';

class ProductDial extends StatelessWidget {
  const ProductDial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeedDialCubit, SpeedDialState>(
      cubit: sl<SpeedDialCubit>(),
      listener: (context, state) async {
        if (state is GoToHome) {
          Navigator.pushNamed(context, Routes.home);
        }
        if (state is GoToCreateGroupForProduct) {
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
          sl<ProductCubit>().redraw();
        }

        if (state is GoToCreateBatch) {
          await showDialog(
            context: context,
            builder: (context) => BatchConfiguration(
              batch: Batch(product: state.product),
              newBatch: true,
              action: (batch) async {
                sl<BatchCubit>().saveBatch(batch);
                await Navigator.pushNamed(context, Routes.batch);
                Navigator.pop(context);
              },
            ),
          );
          sl<ProductCubit>().redraw();
        }
      },
      child: BlocBuilder<ProductCubit, ProductState>(
        cubit: sl<ProductCubit>(),
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
              if (state is ShowProduct) {
                children.addAll([
                  SpeedDialChild(
                    child: const Icon(Icons.insert_drive_file),
                    backgroundColor: Theme.of(context).accentColor,
                    label: S.of(context).SPEEDDIAL_CREATE_BATCH,
                    labelStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    onTap: () => sl<SpeedDialCubit>().tapOnCreateBatch(state.product),
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.create_new_folder),
                    backgroundColor: Theme.of(context).accentColor,
                    label: S.of(context).SPEEDDIAL_CREATE_GROUP,
                    labelStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    onTap: () => sl<SpeedDialCubit>().tapOnCreateGroupForProduct(),
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
