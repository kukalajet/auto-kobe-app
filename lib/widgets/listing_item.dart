import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:auto_kobe/widgets/widgets.dart';

class ListingItem extends StatelessWidget {
  const ListingItem({Key key, @required this.listing}) : super(key: key);

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
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0,
                                color: Colors.indigo[600].withOpacity(0.95),
                              ),
                            ),
                            Text(
                              listing.brand.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: Colors.indigo[400].withOpacity(0.95),
                                fontStyle: FontStyle.italic,
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
                                listing.registrationDate.year.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                  color: Colors.grey[700].withOpacity(0.8),
                                ),
                              ),
                              Text(
                                '${listing.mileage} KM',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                  color: Colors.grey[800].withOpacity(0.8),
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
                            fontSize: 28.0,
                            color: Colors.indigo[800].withOpacity(0.9),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            '${listing.fuelType.type.toString().split('.').last}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                              color: Colors.grey[600].withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          onTap: () => showCupertinoModalBottomSheet(
            expand: false,
            context: context,
            builder: (context) => ListingDetail(listing),
          ),
        ),
      ),
    );
  }
}
