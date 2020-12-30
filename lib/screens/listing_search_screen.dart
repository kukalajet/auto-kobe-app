import 'package:auto_kobe/blocs/search/search_bloc.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) => null,
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Material(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white38,
                body: SingleChildScrollView(
                  primary: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [SearchForm()],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
