import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:auto_kobe/widgets/widgets.dart';

class SearchedListingsList extends StatefulWidget {
  @override
  _SearchedListingsListState createState() => _SearchedListingsListState();
}

class _SearchedListingsListState extends State<SearchedListingsList> {
  final _scrollController = ScrollController(initialScrollOffset: 1.0);
  SearchBloc _searchBloc;

  void _onScroll() {
    if (_isBottom) _searchBloc.add(SearchedListingFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchBloc = context.read<SearchBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (!state.hasReachedMax && _isBottom) {
          _searchBloc.add(SearchedListingFetched());
        }
      },
      builder: (context, state) {
        switch (state.searchingStatus) {
          case SearchStatus.failure:
            return const Center(child: Text('failed to fetch listings'));
          case SearchStatus.success:
            if (state.listings.isEmpty) {
              return const Center(child: Text('no results'));
            }
            return ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return index >= state.listings.length
                    ? BottomLoader()
                    : ListingItem(listing: state.listings[index]);
              },
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
