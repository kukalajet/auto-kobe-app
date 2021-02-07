import 'package:auto_kobe/styles/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:constant_repository/constant_repository.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ListingDetail extends StatefulWidget {
  const ListingDetail(this.listing);

  final Listing listing;

  @override
  _ListingDetailState createState() => _ListingDetailState();
}

class _ListingDetailState extends State<ListingDetail> {
  int _current;

  @override
  void initState() {
    super.initState();
    _current = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: CupertinoScaffold(
          transitionBackgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              _buildContainer(),
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: <Widget>[
        CarouselSlider(
          items: widget.listing.images.map((image) {
            double width = MediaQuery.of(context).size.width;
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: width,
                  decoration: BoxDecoration(color: Colors.amber),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) => Container(
                      height: 272.0,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    fit: BoxFit.fitHeight,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 272.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            viewportFraction: 1.0,
            onPageChanged: (index, reason) => setState(() => _current = index),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.listing.images.map((image) {
            int index = widget.listing.images.indexOf(image);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.8)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
        _buildBackButton(),
      ],
    );
  }

  Widget _buildHeaderTile() {
    String model = widget.listing.model.name;
    String brand = widget.listing.brand.name;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(model, style: textTitle2Style),
              Text(brand, style: textTitle3Style),
            ],
          ),
          MaterialButton(
            onPressed: () => null,
            color: const Color(0xffE57373),
            textColor: Colors.white70,
            child: const Icon(Icons.favorite, size: 20),
            padding: const EdgeInsets.all(8.0),
            shape: const CircleBorder(),
            minWidth: 0.0,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider({double height, double padding = 0.0}) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        height: height,
        width: width,
        // color: Color(0xffEDE7F6),
        color: ColorConstant.primaryVariant.withOpacity(0.25),
      ),
    );
  }

  Widget _buildDescription() {
    String description = widget.listing.description;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(description, style: textBodyStyle),
    );
  }

  Widget _buildTile({String field, String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(child: Center(child: Text(field, style: textTitle3Style))),
          Expanded(child: Text(value, style: textTitle2Style)),
        ],
      ),
    );
  }

  Widget _buildInfos() {
    return Column(
      children: [
        _buildTile(
          field: 'Year',
          value: widget.listing.registrationDate.year.toString(),
        ),
        _buildDivider(height: 2.0, padding: 24.0),
        _buildTile(
          field: 'Mileage',
          value: '${widget.listing.mileage.toString()} KM',
        ),
        _buildDivider(height: 2.0, padding: 24.0),
        _buildTile(
          field: 'Condition',
          value: widget.listing.condition.type.toString().split('.').last,
        ),
        _buildDivider(height: 2.0, padding: 24.0),
        _buildTile(
          field: 'Power',
          value: '${widget.listing.motorPower} kW',
        ),
        _buildDivider(height: 2.0, padding: 24.0),
        _buildTile(
          field: 'Fuel',
          value: widget.listing.fuelType.type.toString().split('.').last,
        ),
        _buildDivider(height: 2.0, padding: 24.0),
        _buildTile(
          field: 'Doors',
          value: widget.listing.doorType.number,
        ),
        _buildDivider(height: 2.0, padding: 24.0),
        _buildTile(
          field: 'Emission',
          value:
              '${widget.listing.emission.standard} ${widget.listing.emission.tier}',
        ),
        _buildDivider(height: 2.0, padding: 24.0),
        _buildTile(
          field: 'Transmission',
          value: widget.listing.transmission.type.toString().split('.').last,
        ),
        _buildDivider(height: 2.0, padding: 24.0),
        _buildTile(
          field: 'Cubic',
          value: '${widget.listing.cubicCapacity} cc',
        ),
        SizedBox(height: 80.0),
      ],
    );
  }

  Widget _buildContainer() {
    return ListView(
      reverse: false,
      shrinkWrap: true,
      controller: ModalScrollController.of(context),
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        _buildHeader(),
        _buildHeaderTile(),
        _buildDivider(height: 4.0),
        _buildDescription(),
        _buildDivider(height: 4.0),
        _buildInfos(),
      ],
    );
  }

  Widget _buildBottomBar() {
    String price = widget.listing.price.value.toString();
    String valute = widget.listing.price.valute.symbol;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 72.0,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black45,
              blurRadius: 4.0,
              offset: Offset(0.0, 0.75),
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('$price $valute', style: textLargeTitleStyle),
            ButtonTheme(
              minWidth: 176.0,
              height: 48.0,
              child: RaisedButton(
                onPressed: () => null,
                child: Text(
                  StringConstant.contact.toUpperCase(),
                  style: textBodyStyleLight,
                ),
                color: ColorConstant.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  side: BorderSide(color: ColorConstant.primaryVariant),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
