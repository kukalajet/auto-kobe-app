import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_kobe/blocs/blocs.dart';
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
            return Container(
              decoration: BoxDecoration(color: Colors.indigo[50]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(state.types.length, (index) {
                  return _FuelItem(
                    fuel: state.types[index],
                    onTap: widget.onTap,
                  );
                }),
              ),
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
    return GestureDetector(
      onTap: () => onTap(fuel),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(fuel.type, style: TextStyle(color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
