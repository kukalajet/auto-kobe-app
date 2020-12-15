import 'package:flutter/material.dart';
import 'package:auto_kobe/blocs/blocs.dart';
import 'package:condition_repository/condition_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingConditionsList extends StatefulWidget {
  final Function(Condition) onTap;

  ListingConditionsList({Key key, @required this.onTap}) : super(key: key);

  @override
  _ListingDoorTypeListState createState() => _ListingDoorTypeListState();
}

class _ListingDoorTypeListState extends State<ListingConditionsList> {
  ConditionBloc _conditionBloc;

  @override
  void initState() {
    super.initState();
    _conditionBloc = context.bloc<ConditionBloc>()..add(ConditionFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConditionBloc, ConditionState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case ConditionStatus.failure:
            return const Center(child: Text('failed to fetch door types'));
          case ConditionStatus.success:
            if (state.conditions.isEmpty) {
              return const Center(child: Text('no conditions'));
            }
            return Container(
              decoration: BoxDecoration(color: Colors.indigo[50]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(state.conditions.length, (index) {
                  return _ConditionItem(
                    condition: state.conditions[index],
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

class _ConditionItem extends StatelessWidget {
  final Condition condition;
  final Function(Condition) onTap;

  const _ConditionItem({
    Key key,
    @required this.condition,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(condition),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(condition.type.toString().split('.').last,
                style: TextStyle(color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
