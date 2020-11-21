import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingsList extends StatefulWidget {
  @override
  _ListingsListState createState() => _ListingsListState();
}

class _ListingsListState extends State<ListingsList> {
  final _scrollController = ScrollController();
  ListingBloc _listingBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _listingBloc = context.bloc<ListingBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListingBloc, ListingState>(
      listener: (context, state) {
        if (!state.hasReachedMax && _isBottom) {
          _listingBloc.add(ListingFetched());
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case ListingStatus.failure:
            return const Center(child: Text('failed to fetch listings'));
          case ListingStatus.success:
            if (state.listings.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.listings.length
                    ? BottomLoader()
                    : ListingItem(listing: state.listings[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.listings.length
                  : state.listings.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _listingBloc.add(ListingFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
