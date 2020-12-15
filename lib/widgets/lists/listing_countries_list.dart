import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingCountriesList extends StatefulWidget {
  final Function(Country) onTap;

  ListingCountriesList({Key key, @required this.onTap}) : super(key: key);

  @override
  _ListingCountriesListState createState() => _ListingCountriesListState();
}

class _ListingCountriesListState extends State<ListingCountriesList> {
  CountryBloc _countryBloc;

  @override
  void initState() {
    super.initState();
    _countryBloc = context.bloc<CountryBloc>()..add(CountryFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CountryBloc, CountryState>(
      listener: (context, state) {
        // TEST
      },
      builder: (context, state) {
        switch (state.status) {
          case CountryStatus.failure:
            return const Center(child: Text('failed to fetch door types'));
          case CountryStatus.success:
            if (state.countries.isEmpty) {
              return const Center(child: Text('no types'));
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.countries.length,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.countries.length
                    ? BottomLoader()
                    : _CountryItem(
                        country: state.countries[index],
                        onTap: widget.onTap,
                      );
              },
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class _CountryItem extends StatelessWidget {
  final Country country;
  final Function(Country) onTap;

  const _CountryItem({
    Key key,
    @required this.country,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(country),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(country.name, style: TextStyle(color: Colors.black87)),
            Image.network(country.image, height: 50, fit: BoxFit.fill),
          ],
        ),
      ),
    );
  }
}
