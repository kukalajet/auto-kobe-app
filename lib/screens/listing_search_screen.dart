import 'package:auto_kobe/blocs/search/search_bloc.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listing_repository/listing_repository.dart';

class ListingSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(
        listingRepository: RepositoryProvider.of<ListingRepository>(context),
      ),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) => null,
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final areListingsFetched = state.listings.isNotEmpty;
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white38,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'SEARCH',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  elevation: 0.0,
                ),
              ),
              body: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child:
                    areListingsFetched ? SearchedListingsList() : SearchForm(),
              ),
            ),
          );
        },
      ),
    );
  }
}
