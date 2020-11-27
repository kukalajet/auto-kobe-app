import 'package:brand_repository/brand_repository.dart';
import 'package:auto_kobe/blocs/brand/brand_bloc.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return index >= state.favorites.length
                          ? BottomLoader()
                          : _BrandItem(
                              brand: state.favorites[index],
                              onTap: widget.onTap,
                            );
                    },
                    childCount: state.favorites.length,
                  ),
                ),
              ];
            },
            body: ListView.builder(
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

/// TESTING
class ModalScrollController extends InheritedWidget {
  /// Creates a widget that associates a [ScrollController] with a subtree.
  ModalScrollController({
    Key key,
    @required this.controller,
    @required Widget child,
  })  : assert(controller != null),
        super(
          key: key,
          child: PrimaryScrollController(
            controller: controller,
            child: child,
          ),
        );

  /// The [ScrollController] associated with the subtree.
  ///
  /// See also:
  ///
  ///  * [ScrollView.controller], which discusses the purpose of specifying a
  ///    scroll controller.
  final ScrollController controller;

  /// Returns the [ScrollController] most closely associated with the given
  /// context.
  ///
  /// Returns null if there is no [ScrollController] associated with the given
  /// context.
  static ScrollController of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ModalScrollController>();
    return result?.controller;
  }

  @override
  bool updateShouldNotify(ModalScrollController oldWidget) =>
      controller != oldWidget.controller;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ScrollController>(
        'controller', controller,
        ifNull: 'no controller', showName: false));
  }
}
