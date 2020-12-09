import 'package:flutter/material.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:auto_kobe/widgets/widgets.dart';

const url =
    'https://images.cdn.circlesix.co/image/1/640/0/uploads/posts/2016/11/c1fe56d30f09c23a496b5a73a50de865.jpg';

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
                  Ink.image(
                    height: 175,
                    image: NetworkImage(url),
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                              'Golf VI Cabrio',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0,
                                color: Colors.indigo[600].withOpacity(0.95),
                              ),
                            ),
                            Text(
                              'Volkswagen',
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
                                '2010',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                  color: Colors.grey[700].withOpacity(0.8),
                                ),
                              ),
                              Text(
                                '17500 KM',
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
                          '7500 €',
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
                            'PETROL',
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
            builder: (context, scrollController) => ListingDetail(listing),
          ),
        ),
      ),
    );
  }
}
