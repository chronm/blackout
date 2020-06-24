import 'package:flutter/material.dart' show BuildContext, Colors, Icon, Icons, Key, Navigator, StatelessWidget, TextStyle, Theme, Widget, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/product.dart';
import '../../../models/unit/unit.dart';
import '../../../routes.dart';
import '../../product/bloc/product_bloc.dart';
import '../../product/widgets/product_configuration.dart';
import '../../speeddial/bloc/speed_dial_bloc.dart';
import '../../speeddial/speeddial.dart';
import '../bloc/group_bloc.dart';

class GroupDial extends StatelessWidget {
  const GroupDial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeedDialBloc, SpeedDialState>(
      bloc: sl<SpeedDialBloc>(),
      listener: (context, state) async {
        if (state is GoToHome) {
          Navigator.pushNamed(context, Routes.home);
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
                await Navigator.pushNamed(context, Routes.product);
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
