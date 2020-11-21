// import 'package:meta/meta.dart';
// import 'package:http/http.dart' as http;
import 'package:country_repository/src/models/models.dart';

class CountryRepository {
  // final http.Client httpClient;

  // CountryRepository({@required this.httpClient});

  Future<List<Country>> fetchCountries() async {
    List<Country> countries = <Country>[
      Country(
          id: 0,
          name: 'Albania',
          image: 'https://cdn.countryflags.com/thumbs/albania/flag-800.png'),
      Country(
          id: 1,
          name: 'Italy',
          image: 'https://cdn.countryflags.com/thumbs/italy/flag-800.png'),
      Country(
          id: 2,
          name: 'Kosovo',
          image: 'https://cdn.countryflags.com/thumbs/kosovo/flag-800.png'),
      Country(
          id: 3,
          name: 'Germany',
          image: 'https://cdn.countryflags.com/thumbs/germany/flag-800.png'),
      Country(
          id: 4,
          name: 'France',
          image: 'https://cdn.countryflags.com/thumbs/france/flag-800.png'),
      Country(
          id: 5,
          name: 'Spain',
          image: 'https://cdn.countryflags.com/thumbs/spain/flag-800.png'),
      Country(
          id: 6,
          name: 'Greece',
          image: 'https://cdn.countryflags.com/thumbs/greece/flag-800.png'),
      Country(
          id: 7,
          name: 'Russia',
          image: 'https://cdn.countryflags.com/thumbs/russia/flag-800.png'),
      Country(
          id: 8,
          name: 'Israel',
          image: 'https://cdn.countryflags.com/thumbs/israel/flag-800.png'),
      Country(
          id: 9,
          name: 'China',
          image: 'https://cdn.countryflags.com/thumbs/china/flag-800.png'),
    ];

    return countries;
  }
}
