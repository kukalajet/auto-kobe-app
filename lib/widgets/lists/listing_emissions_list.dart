import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_kobe/blocs/blocs.dart';
import 'package:emission_repository/emission_repository.dart';

class ListingEmissionsList extends StatefulWidget {
  final Function(Emission) onTap;

  ListingEmissionsList({Key key, @required this.onTap}) : super(key: key);

  @override
  _ListingEmissionsListState createState() => _ListingEmissionsListState();
}

class _ListingEmissionsListState extends State<ListingEmissionsList> {
  EmissionBloc _emissionBloc;

  @override
  void initState() {
    super.initState();
    _emissionBloc = context.bloc<EmissionBloc>()..add(EmissionFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmissionBloc, EmissionState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case EmissionStatus.failure:
            return const Center(child: Text('failed to fetch door types'));
          case EmissionStatus.success:
            if (state.emissions.isEmpty) {
              return const Center(child: Text('no emissions'));
            }
            return Container(
              decoration: BoxDecoration(color: Colors.indigo[50]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(state.emissions.length, (index) {
                  return _EmissionItem(
                    emission: state.emissions[index],
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

class _EmissionItem extends StatelessWidget {
  final Emission emission;
  final Function(Emission) onTap;

  const _EmissionItem({
    Key key,
    @required this.emission,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(emission),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${emission.standard} ${emission.tier}',
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
