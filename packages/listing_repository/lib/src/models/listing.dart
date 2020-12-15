import 'package:brand_repository/brand_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:door_type_repository/door_type_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';
import 'package:meta/meta.dart';
import 'package:model_repository/model_repository.dart';
import 'package:valute_repository/valute_repository.dart';

import 'date.dart';
import 'listing_status.dart';

class Listing extends Equatable {
  const Listing({
    @required this.id,
    @required this.brand,
    @required this.model,
    @required this.registrationDate,
    @required this.price,
    @required this.mileage,
    @required this.country,
    @required this.doorType,
    @required this.cubicCapacity,
    @required this.fuelType,
    @required this.motorPower,
    @required this.description,
    @required this.status,
    @required this.images,
  });

  final String id;
  final Brand brand;
  final Model model;
  final Date registrationDate;
  final Price price;
  final int mileage;
  final Country country;
  final DoorType doorType;
  final int cubicCapacity;
  final Fuel fuelType;
  final int motorPower;
  final String description;
  final ListingStatus status;
  final List<String> images;

  @override
  List<Object> get props => [
        id,
        brand,
        model,
        registrationDate,
        price,
        mileage,
        country,
        doorType,
        cubicCapacity,
        fuelType,
        motorPower,
        description,
        status,
        images,
      ];
}
