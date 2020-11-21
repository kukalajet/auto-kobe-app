import 'package:brand_repository/brand_repository.dart';
import 'package:auto_kobe/blocs/brand/brand_bloc.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingBrandsList extends StatefulWidget {
  final Function(Brand) onTap;

  ListingBrandsList({Key key, @required this.onTap}) : super(key: key);

  @override
  _ListingBrandsListState createState() => _ListingBrandsListState();
}

class _ListingBrandsListState extends State<ListingBrandsList> {
  final _scrollController = ScrollController();
  BrandBloc _brandBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _brandBloc = context.bloc<BrandBloc>()
      ..add(BrandFetched())
      ..add(BrandFavoriteFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrandBloc, BrandState>(
      listener: (context, state) {
        if (!state.hasReachedMax && _isBottom) {
          _brandBloc..add(BrandFetched()); // ..add(BrandFavoriteFetched());
        }
      },
      builder: (context, state) {
        final brandStatus = state.status;
        final favoritestatus = state.favoriteStatus;
        if (brandStatus == BrandStatus.failure ||
            favoritestatus == BrandFavoriteStatus.failure) {
          return const Center(child: Text('failed to fetch brands'));
        }
        if (brandStatus == BrandStatus.success ||
            favoritestatus == BrandFavoriteStatus.success) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // crossAxisSpacing: 5.0,
                    // mainAxisSpacing: 5.0,
                  ),
                  itemCount: state.favorites.length,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.favorites.length
                        ? BottomLoader()
                        : _BrandItem(
                            brand: state.favorites[index],
                            onTap: widget.onTap,
                          );
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.brands.length
                        ? BottomLoader()
                        : _BrandItem(
                            brand: state.brands[index],
                            onTap: widget.onTap,
                          );
                  },
                  itemCount: state.hasReachedMax
                      ? state.brands.length
                      : state.brands.length + 1,
                  controller: _scrollController,
                ),
              ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _brandBloc.add(BrandFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _BrandItem extends StatelessWidget {
  const _BrandItem({
    Key key,
    @required this.brand,
    @required this.onTap,
  }) : super(key: key);

  final Brand brand;
  final Function(Brand) onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      // leading: Text('${brand.id}', style: textTheme.caption),
      title: Text(brand.name),
      isThreeLine: true,
      subtitle: Text(brand.name),
      dense: true,
      onTap: () => onTap(brand),
    );
  }
}
