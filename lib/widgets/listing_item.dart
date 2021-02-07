import 'package:auto_kobe/styles/styles.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ListingItem extends StatelessWidget {
  const ListingItem({Key key, @required this.listing}) : super(key: key);

  final Listing listing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 16.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildPreviewImage(),
              _buildInfos(),
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

  Widget _buildPreviewImage() {
    String url = listing.images.first;

    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Container(
        height: 160.0,
        child: Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget _buildLeftTile() {
    String model = listing.model.name;
    String brand = listing.brand.name;

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(model, style: textTitle2PrimaryVariantColorStyle),
          Text(brand, style: textTitle3Style),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 16.0,
      width: 1.0,
      color: Colors.black54,
    );
  }

  Widget _buildTopRightTile() {
    String mileage = listing.mileage.toString();
    String year = listing.registrationDate.year.toString();

    return Align(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Text('$mileage KM', style: textHeadlineStyle),
          ),
          _buildVerticalDivider(),
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Text(year, style: textHeadlineStyle),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomRightTile() {
    String value = listing.price.value.toString();
    String valute = listing.price.valute.symbol;

    return Align(
      alignment: Alignment.bottomRight,
      child: Text('$value $valute', style: textTitle1PrimaryVariantColorStyle),
    );
  }

  Widget _buildInfos() {
    return Container(
      height: 72.0,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Stack(
        children: [
          _buildLeftTile(),
          _buildTopRightTile(),
          _buildBottomRightTile(),
        ],
      ),
    );
  }
}
