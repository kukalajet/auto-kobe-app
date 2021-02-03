import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/screens/listing_search_screen.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_repository/listing_repository.dart';

class ListingsList extends StatefulWidget {
  @override
  _ListingsListState createState() => _ListingsListState();
}

class _ListingsListState extends State<ListingsList>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController(initialScrollOffset: 1.0);
  ListingBloc _listingBloc;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _listingBloc = context.bloc<ListingBloc>()..add(ListingSearchTypeFetched());
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  Widget _buildHeader({
    BuildContext context,
    List<SearchType> types,
    int selectedType,
  }) {
    IconData icon;
    if (selectedType == 0) {
      icon = Icons.access_time;
    } else if (selectedType == 1) {
      icon = Icons.local_fire_department;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FeedTypeButton(
            width: 88.0,
            height: 48.0,
            icon: icon ?? Icons.search,
            picker: Container(
              decoration: BoxDecoration(color: Colors.indigo[50]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  types.length,
                  (index) => _ListingTypeSearchItem(
                    type: types[index],
                    onTap: (type) {
                      context
                          .read<ListingBloc>()
                          .add(ListingSearchTypeChanged(type));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ),
          SearchButton(
            picker: ListingSearchScreen(),
            width: 200.0,
            height: 48.0,
          ),
        ],
      ),
    );
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
                return index >= state.listings.length + 1
                    ? BottomLoader()
                    : (index != 0
                        ? ListingItem(listing: state.listings[index - 1])
                        : _buildHeader(
                            context: context,
                            types: state.types,
                            selectedType: state.selectedType.value.id,
                          ));
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
