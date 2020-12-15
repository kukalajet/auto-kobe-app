import 'package:auto_kobe/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valute_repository/valute_repository.dart';

class ListingValutesList extends StatefulWidget {
  ListingValutesList({Key key, @required this.onTap}) : super(key: key);

  final Function(Valute) onTap;

  @override
  _ListingValutesListState createState() => _ListingValutesListState();
}

class _ListingValutesListState extends State<ListingValutesList> {
  ValuteBloc _valuteBloc;

  @override
  void initState() {
    super.initState();
    _valuteBloc = context.bloc<ValuteBloc>()..add(ValuteFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ValuteBloc, ValuteState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case ValuteStatus.failure:
            return const Center(child: Text('failed to fetch door types'));
          case ValuteStatus.success:
            if (state.valutes.isEmpty) {
              return const Center(child: Text('no types'));
            }
            return Container(
              decoration: BoxDecoration(color: Colors.indigo[50]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(state.valutes.length, (index) {
                  return _ValuteItem(
                    valute: state.valutes[index],
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

class _ValuteItem extends StatelessWidget {
  final Valute valute;
  final Function(Valute) onTap;

  const _ValuteItem({
    Key key,
    @required this.valute,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(valute),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(valute.name, style: TextStyle(color: Colors.black87)),
            Text(valute.symbol, style: TextStyle(color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
