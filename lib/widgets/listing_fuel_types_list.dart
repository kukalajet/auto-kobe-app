import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';

class ListingFuelTypesList extends StatefulWidget {
  final Function(FuelType) onTap;

  ListingFuelTypesList({Key key, @required this.onTap}) : super(key: key);

  @override
  _ListingFuelTypesListState createState() => _ListingFuelTypesListState();
}

class _ListingFuelTypesListState extends State<ListingFuelTypesList> {
  FuelTypeBloc _fuelTypeBloc;

  @override
  void initState() {
    super.initState();
    _fuelTypeBloc = context.bloc<FuelTypeBloc>()..add(FuelTypeFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FuelTypeBloc, FuelTypeState>(
      listener: (context, state) {
        // TEST
      },
      builder: (context, state) {
        switch (state.status) {
          case FuelTypeStatus.failure:
            return const Center(child: Text('failed to fetch door types'));
          case FuelTypeStatus.success:
            if (state.types.isEmpty) {
              return const Center(child: Text('no types'));
            }
            return ListView.builder(
              itemCount: state.types.length,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.types.length
                    ? BottomLoader()
                    : _FuelItem(
                        fuel: state.types[index],
                        onTap: widget.onTap,
                      );
              },
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class _FuelItem extends StatelessWidget {
  final FuelType fuel;
  final Function(FuelType) onTap;

  const _FuelItem({
    Key key,
    @required this.fuel,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: Text(fuel.type),
      dense: true,
      onTap: () => onTap(fuel),
    );
  }
}
