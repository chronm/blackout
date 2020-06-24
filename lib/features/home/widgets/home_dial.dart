import 'package:flutter/material.dart' show BuildContext, Colors, Icon, Icons, Key, Navigator, StatelessWidget, TextStyle, Theme, Widget, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../models/product.dart';
import '../../../models/unit/unit.dart';
import '../../../routes.dart';
import '../../group/bloc/group_bloc.dart' show GroupBloc, SaveGroup;
import '../../group/widgets/group_configuration.dart';
import '../../product/bloc/product_bloc.dart';
import '../../product/widgets/product_configuration.dart';
import '../../speeddial/bloc/speed_dial_bloc.dart' show GoToProduct, ShowCreateGroup, ShowCreateProduct, SpeedDialBloc, SpeedDialState, TapOnCreateGroup, TapOnCreateProduct, TapOnScanEan;
import '../../speeddial/speeddial.dart';
import '../bloc/home_bloc.dart' show HomeBloc, HomeInitialState, HomeState, LoadAll;

class HomeDial extends StatelessWidget {
  const HomeDial({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeedDialBloc, SpeedDialState>(
      bloc: sl<SpeedDialBloc>(),
      listener: (context, state) async {
        if (state is GoToProduct) {
          Navigator.pushNamed(context, Routes.product);
        }
        if (state is ShowCreateGroup) {
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
        if (state is ShowCreateProduct) {
          await showDialog(
            context: context,
            builder: (context) => ProductConfiguration(
              product: Product(home: state.home, description: "", unit: UnitEnum.unitless, group: null, ean: state.ean),
              newProduct: true,
              groups: state.groups,
              action: (product) async {
                sl<ProductBloc>().add(SaveProduct(product));
                await Navigator.pushNamed(context, Routes.product);
                Navigator.pop(context);
              },
            ),
          );
        sl<HomeBloc>().add(LoadAll());
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        bloc: sl<HomeBloc>(),
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
                  onTap: () => sl<SpeedDialBloc>().add(TapOnScanEan()),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.insert_drive_file),
                  backgroundColor: Theme.of(context).accentColor,
                  label: S.of(context).SPEEDDIAL_CREATE_PRODUCT,
                  labelStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  onTap: () => sl<SpeedDialBloc>().add(TapOnCreateProduct()),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.create_new_folder),
                  backgroundColor: Theme.of(context).accentColor,
                  label: S.of(context).SPEEDDIAL_CREATE_GROUP,
                  labelStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  onTap: () => sl<SpeedDialBloc>().add(TapOnCreateGroup()),
                ),
              ];
            },
          );
        },
      ),
    );
  }
}
