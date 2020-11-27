import 'package:flutter/material.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:auto_kobe/widgets/widgets.dart';

class ListingItem extends StatelessWidget {
  const ListingItem({Key key, @required this.listing}) : super(key: key);

  final Listing listing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: Text('${listing.id}', style: textTheme.caption),
      title: Text(listing.title),
      isThreeLine: true,
      subtitle: Text(listing.body),
      dense: true,
      onTap: () => showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        builder: (context, scrollController) => ListingDetail(listing),
      ),
    );
  }
}
