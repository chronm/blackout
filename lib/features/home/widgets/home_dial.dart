import 'package:Blackout/features/group/bloc/group_bloc.dart' show GroupBloc, SaveGroup;
import 'package:Blackout/features/group/widgets/group_configuration.dart';
import 'package:Blackout/features/home/bloc/home_bloc.dart' show HomeBloc, HomeInitialState, HomeState, LoadAll;
import 'package:Blackout/features/product/bloc/product_bloc.dart';
import 'package:Blackout/features/product/widgets/product_configuration.dart';
import 'package:Blackout/features/speeddial/bloc/speed_dial_bloc.dart' show GoToProduct, ShowCreateGroup, ShowCreateProduct, SpeedDialBloc, SpeedDialState, TapOnCreateGroup, TapOnCreateProduct, TapOnScanEan;
import 'package:Blackout/features/speeddial/speeddial.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/routes.dart';
import 'package:flutter/material.dart' show BuildContext, Colors, Icon, Icons, Key, Navigator, StatelessWidget, TextStyle, Widget, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeDial extends StatelessWidget {
  const HomeDial({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeedDialBloc, SpeedDialState>(
      bloc: sl<SpeedDialBloc>(),
      listener: (context, state) async {
        if (state is GoToProduct) {
          Navigator.push(context, RouteBuilder.build(Routes.ProductOverviewRoute));
        }
        if (state is ShowCreateGroup) {
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
        if (state is ShowCreateProduct) {
          await showDialog(
            context: context,
            builder: (context) => ProductConfiguration(
              product: Product(home: state.home, description: "", unit: UnitEnum.unitless, group: null, ean: state.ean),
              newProduct: true,
              groups: state.groups,
              action: (product) async {
                sl<ProductBloc>().add(SaveProduct(product));
                await Navigator.push(context, RouteBuilder.build(Routes.ProductOverviewRoute));
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
                  backgroundColor: Colors.red,
                  label: S.of(context).SPEEDDIAL_SCAN,
                  labelStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  onTap: () => sl<SpeedDialBloc>().add(TapOnScanEan()),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.insert_drive_file),
                  backgroundColor: Colors.red,
                  label: S.of(context).SPEEDDIAL_CREATE_PRODUCT,
                  labelStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  onTap: () => sl<SpeedDialBloc>().add(TapOnCreateProduct()),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.create_new_folder),
                  backgroundColor: Colors.red,
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
