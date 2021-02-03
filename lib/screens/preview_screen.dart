import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/screens/screens.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({Key key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => PreviewScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Auto 24',
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.indigoAccent,
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => PreviewBloc(
          listingRepository: RepositoryProvider.of<ListingRepository>(context),
        )..add(PreviewListingsFetched()),
        child: SafeArea(
          child: PreviewListingsList(),
        ),
      ),
    );
  }
}

class PreviewListingsList extends StatefulWidget {
  @override
  _PreviewListingsListState createState() => _PreviewListingsListState();
}

class _PreviewListingsListState extends State<PreviewListingsList> {
  final _scrollController = ScrollController(initialScrollOffset: 1.0);
  PreviewBloc _previewBloc;

  void _onScroll() {
    if (_isBottom) _previewBloc.add(PreviewListingsFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Widget _bottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 64.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: ExpandedButton(
                data: "SIGN IN",
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey.withOpacity(0.6),
                onTap: () =>
                    Navigator.of(context).push<void>(SignUpScreen.route()),
              ),
            ),
            Expanded(
              flex: 1,
              child: ExpandedButton(
                data: "LOG IN",
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
                color: Colors.blue.shade800.withOpacity(0.6),
                onTap: () =>
                    Navigator.of(context).push<void>(LoginPage.route()),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 2.0,
              offset: Offset(0.0, 0.75),
            )
          ],
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _previewBloc = context.read<PreviewBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BlocConsumer<PreviewBloc, PreviewState>(
          listener: (context, state) {
            if (!state.hasReachedMax && _isBottom) {
              _previewBloc.add(PreviewListingsFetched());
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case PreviewStatus.failure:
                return const Center(child: Text('failed to fetch previews'));
              case PreviewStatus.success:
                if (state.previews.isEmpty) {
                  return const Center(child: Text('no results'));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return index >= state.previews.length
                        ? BottomLoader()
                        : PreviewItem(listing: state.previews[index]);
                  },
                );
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        _bottomBar(),
      ],
    );
  }
}

//

class PreviewItem extends StatelessWidget {
  const PreviewItem({Key key, @required this.listing}) : super(key: key);

  final Listing listing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 16.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: InkWell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    CachedNetworkImage(
                      imageUrl: listing.images.first,
                      placeholder: (context, url) => Container(
                        height: 175,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Container(
                    height: 64.0,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listing.model.name,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22.0,
                                    color: Colors.indigo[600].withOpacity(0.95),
                                  ),
                                ),
                              ),
                              Text(
                                listing.brand.name,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0,
                                    color: Colors.indigo[400].withOpacity(0.95),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${listing.mileage} KM | ${listing.registrationDate.year.toString()}',
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: Colors.grey[700].withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '${listing.price.value} ${listing.price.valute.symbol}',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 32.0,
                              color: Colors.indigo[800].withOpacity(0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              Flushbar(
                flushbarStyle: FlushbarStyle.GROUNDED,
                flushbarPosition: FlushbarPosition.TOP,
                title: "Regjistrohu ose logohu",
                message:
                    "Për të aksesuar produktet ne aplikacion, duhet të logoheni",
                duration: Duration(seconds: 5),
              )..show(context);
            }),
      ),
    );
  }
}
