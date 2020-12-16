import 'package:auto_kobe/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:transmission_repository/transmission_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingTrasmissionsList extends StatefulWidget {
  final Function(Transmission) onTap;

  ListingTrasmissionsList({Key key, @required this.onTap}) : super(key: key);

  @override
  _ListingTrasmissionListState createState() => _ListingTrasmissionListState();
}

class _ListingTrasmissionListState extends State<ListingTrasmissionsList> {
  TransmissionBloc _transmissionBloc;

  @override
  void initState() {
    super.initState();
    _transmissionBloc = context.bloc<TransmissionBloc>()
      ..add(TransmissionFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransmissionBloc, TransmissionState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case TransmissionStatus.failure:
            return const Center(child: Text('failed to fetch door types'));
          case TransmissionStatus.success:
            if (state.transmissions.isEmpty) {
              return const Center(child: Text('no types'));
            }
            return Container(
              decoration: BoxDecoration(color: Colors.indigo[50]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(state.transmissions.length, (index) {
                  return _TransmissionItem(
                    transmission: state.transmissions[index],
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

class _TransmissionItem extends StatelessWidget {
  final Transmission transmission;
  final Function(Transmission) onTap;

  const _TransmissionItem({
    Key key,
    @required this.transmission,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(transmission),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(transmission.type.toString().split('.').last,
                style: TextStyle(color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
