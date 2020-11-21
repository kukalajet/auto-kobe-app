import 'package:auto_kobe/blocs/door_type/door_type.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:door_type_repository/door_type_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingDoorTypeList extends StatefulWidget {
  final Function(DoorType) onTap;

  ListingDoorTypeList({Key key, @required this.onTap}) : super(key: key);

  @override
  _ListingDoorTypeListState createState() => _ListingDoorTypeListState();
}

class _ListingDoorTypeListState extends State<ListingDoorTypeList> {
  DoorTypeBloc _doorTypeBloc;

  @override
  void initState() {
    super.initState();
    _doorTypeBloc = context.bloc<DoorTypeBloc>()..add(DoorTypeFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoorTypeBloc, DoorTypeState>(
      listener: (context, state) {
        // TEST
      },
      builder: (context, state) {
        switch (state.status) {
          case DoorTypeStatus.failure:
            return const Center(child: Text('failed to fetch door types'));
          case DoorTypeStatus.success:
            if (state.types.isEmpty) {
              return const Center(child: Text('no types'));
            }
            return ListView.builder(
              itemCount: state.types.length,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.types.length
                    ? BottomLoader()
                    : _DoorTypeItem(
                        type: state.types[index],
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

class _DoorTypeItem extends StatelessWidget {
  final DoorType type;
  final Function(DoorType) onTap;

  const _DoorTypeItem({
    Key key,
    @required this.type,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: Text(type.number),
      // isThreeLine: true,
      dense: true,
      onTap: () => onTap(type),
    );
  }
}
