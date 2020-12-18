import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ListingDetail extends StatefulWidget {
  ListingDetail(this.listing);

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
              ListView(
                reverse: false,
                shrinkWrap: true,
                controller: ModalScrollController.of(context),
                physics: ClampingScrollPhysics(),
                children: [
                  _headerBar(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.listing.model.name,
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28.0,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        widget.listing.brand.name,
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  MaterialButton(
                                    onPressed: () => null,
                                    color: Colors.redAccent.withOpacity(0.9),
                                    textColor: Colors.white70,
                                    child: Icon(Icons.favorite, size: 24),
                                    padding: EdgeInsets.all(8.0),
                                    shape: CircleBorder(),
                                    minWidth: 0.0,
                                  ),
                                ],
                              ),
                              _description(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _infos(),
                  SizedBox(height: 96.0),
                ],
              ),
              _bottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tile({
    @required String field,
    @required String value,
    double fieldFontSize = 18.0,
    double valueFontSize = 24.0,
  }) {
    double side = MediaQuery.of(context).size.width * 0.9 / 3;
    return Container(
      height: side * 0.75,
      width: side,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0.0, top: 8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                field,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: fieldFontSize,
                    fontWeight: FontWeight.w300,
                    // fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: valueFontSize,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infos() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _tile(
                field: 'YEAR',
                value: widget.listing.registrationDate.year.toString(),
                valueFontSize: 28.0,
              ),
              _tile(
                field: 'MILEAGE',
                value: '${widget.listing.mileage.toString()} KM',
                valueFontSize: 20.0,
              ),
              _tile(
                field: 'CONDITION',
                value: widget.listing.condition.type.toString().split('.').last,
                valueFontSize: 24.0,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _tile(
                field: 'POWER',
                value: '${widget.listing.motorPower} kW',
              ),
              _tile(
                field: 'FUEL',
                value: widget.listing.fuelType.type.toString().split('.').last,
              ),
              _tile(
                field: 'DOORS',
                value: widget.listing.doorType.number,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _tile(
                field: 'EMISSION',
                value:
                    '${widget.listing.emission.standard} ${widget.listing.emission.tier}',
              ),
              _tile(
                field: 'TRANSMISSION',
                value:
                    widget.listing.transmission.type.toString().split('.').last,
                fieldFontSize: 16.0,
                valueFontSize: 24.0,
              ),
              _tile(
                field: 'CUBIC',
                value: '${widget.listing.cubicCapacity} cc',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _description() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1.0,
            width: width,
            color: Colors.black12,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: Text(
              widget.listing.description,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Container(
            height: 1.0,
            width: width,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  Widget _headerBar() {
    return Stack(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            height: 275.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: widget.listing.images.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.amber),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) => Container(
                      height: 175,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    fit: BoxFit.fitHeight,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.listing.images.map((image) {
            int index = widget.listing.images.indexOf(image);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.8)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _bottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 72.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '${widget.listing.price.value.toString()} ${widget.listing.price.valute.symbol}',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            ButtonTheme(
              minWidth: 175.0,
              child: RaisedButton(
                color: Colors.red.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red.shade500),
                ),
                onPressed: () => null,
                child: Text(
                  'CONTACT',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 4.0,
              offset: Offset(0.0, 0.75),
            )
          ],
          color: Colors.white,
        ),
      ),
    );
  }
}
