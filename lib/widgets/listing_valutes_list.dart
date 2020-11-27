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
      listener: (context, state) {
        // TEST
      },
      builder: (context, state) {
        switch (state.status) {
          case ValuteStatus.failure:
            return const Center(child: Text('failed to fetch door types'));
          case ValuteStatus.success:
            if (state.valutes.isEmpty) {
              return const Center(child: Text('no types'));
            }
            return Scaffold(
              body: Column(
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
    // final textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: Text(valute.name),
      trailing: Text(valute.symbol),
      dense: true,
      onTap: () => onTap(valute),
    );
  }
}
