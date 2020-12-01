import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_repository/listing_repository.dart';

class ListingsList extends StatefulWidget {
  @override
  _ListingsListState createState() => _ListingsListState();
}

class _ListingsListState extends State<ListingsList> {
  final _scrollController = ScrollController(initialScrollOffset: 1.0);
  ListingBloc _listingBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _listingBloc = context.bloc<ListingBloc>()..add(ListingSearchTypeFetched());
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
            return CustomScrollView(
              slivers: [
                // Move `SliverAppBar` in a method.
                SliverAppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  snap: true,
                  forceElevated: true,
                  floating: true,
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 12, 4),
                      child: SearchButton(
                        picker: Text('HELLO'),
                        width: 200.0,
                      ),
                    ),
                  ],
                  title: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BlocBuilder<ListingBloc, ListingState>(
                          buildWhen: (previous, current) =>
                              previous.selectedType != current.selectedType,
                          builder: (context, state) {
                            IconData icon;
                            if (state.selectedType.value.id == 0) {
                              icon = Icons.access_time;
                            } else if (state.selectedType.value.id == 1) {
                              icon = Icons.local_fire_department;
                            }

                            return FeedTypeButton(
                              icon: icon ?? Icons.search,
                              width: 88.0,
                              height: 48.0,
                              picker: Container(
                                decoration:
                                    BoxDecoration(color: Colors.indigo[50]),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(state.types.length,
                                      (index) {
                                    return _ListingTypeSearchItem(
                                      type: state.types[index],
                                      onTap: (type) {
                                        context.bloc<ListingBloc>().add(
                                            ListingSearchTypeChanged(type));
                                        Navigator.pop(context);
                                      },
                                    );
                                  }),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return index >= state.listings.length
                            ? BottomLoader()
                            : ListingItem(listing: state.listings[index]);
                      },
                      itemCount: state.hasReachedMax
                          ? state.listings.length
                          : state.listings.length + 1,
                    ),
                  ]),
                ),
              ],
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

class _ListingTypeSearchItem extends StatelessWidget {
  final SearchType type;
  final Function(SearchType) onTap;

  const _ListingTypeSearchItem({
    Key key,
    @required this.type,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(type),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(type.title, style: TextStyle(color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
