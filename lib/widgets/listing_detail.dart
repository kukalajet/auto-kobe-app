import 'package:flutter/material.dart';
import 'package:listing_repository/listing_repository.dart';

class ListingDetail extends StatelessWidget {
  ListingDetail(this.listing);

  final Listing listing;

  final String path =
      'https://files.porsche.com/filestore/image/multimedia/none/rd-2020-homepage-banner-pcna-panamera-kw43/normal/19742820-0d30-11eb-80ce-005056bbdc38/porsche-normal.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.network(path),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // First child in the Row for the name and the
                // Release date information.
                new Expanded(
                  // Name and Release date are in the same column
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Code to create the view for name.
                      new Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: new Text(
                          "Original Name: " + listing.title,
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Code to create the view for release date.
                      new Text(
                        "Release Date: " + '27.05.1998',
                        style: new TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
