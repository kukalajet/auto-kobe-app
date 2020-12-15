import 'package:auto_kobe/utils/palette.dart';
import 'package:brand_repository/brand_repository.dart';
import 'package:auto_kobe/blocs/brand/brand_bloc.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ListingBrandsList extends StatefulWidget {
  final Function(Brand) onTap;

  ListingBrandsList({Key key, @required this.onTap}) : super(key: key);

  @override
  _ListingBrandsListState createState() => _ListingBrandsListState();
}

class _ListingBrandsListState extends State<ListingBrandsList> {
  ScrollController _scrollController;
  BrandBloc _brandBloc;

  @override
  void initState() {
    super.initState();
    _brandBloc = context.bloc<BrandBloc>()
      ..add(BrandFetched())
      ..add(BrandFavoriteFetched());
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = ModalScrollController.of(context);
    _scrollController.addListener(_onScroll);

    return CupertinoScaffold(
      transitionBackgroundColor: kWhite,
      body: BlocConsumer<BrandBloc, BrandState>(
        listener: (context, state) {
          if (!state.hasReachedMax && _isBottom) {
            _brandBloc..add(BrandFetched());
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
            return NestedScrollView(
              controller: ScrollController(),
              physics: ScrollPhysics(parent: PageScrollPhysics()),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    delegate: SliverChildListDelegate(
                      [
                        for (final favorite in state.favorites)
                          _BrandItem(
                            brand: favorite,
                            onTap: widget.onTap,
                          )
                      ],
                    ),
                  ),
                ];
              },
              body: ListView.builder(
                controller: ModalScrollController.of(context),
                itemBuilder: (context, index) {
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
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
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
    return GestureDetector(
      onTap: () => onTap(brand),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          brand.name,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}
