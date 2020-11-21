import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listing_repository/listing_repository.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => ListingBloc(
          listingRepository: RepositoryProvider.of<ListingRepository>(context),
        )..add(ListingFetched()),
        child: ListingsList(),
      ),
    );
  }
}
