import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:listing_repository/src/models/models.dart';

class ListingRepository {
  ListingRepository({@required this.httpClient});

  final http.Client httpClient;

  Future<List<Listing>> fetchListings(int startIndex, int limit) async {
    final response = await httpClient.get(
      'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit',
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((dynamic rawPost) {
        return Listing(
          id: rawPost['id'] as int,
          title: rawPost['title'] as String,
          body: rawPost['body'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
