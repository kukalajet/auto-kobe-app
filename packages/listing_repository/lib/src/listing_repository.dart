// import 'dart:convert';

import 'package:brand_repository/brand_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:door_type_repository/door_type_repository.dart';
import 'package:fuel_type_repository/fuel_type_repository.dart';
import 'package:listing_repository/src/models/listing_status.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:listing_repository/src/models/models.dart';
import 'package:model_repository/model_repository.dart';
import 'package:valute_repository/valute_repository.dart';

class ListingRepository {
  ListingRepository({@required this.httpClient});

  final http.Client httpClient;

  List<Listing> _listings = <Listing>[
    Listing(
      id: '1',
      brand: Brand(id: 0, name: 'Tesla'),
      model: Model(id: 1, name: 'Model S'),
      registrationDate: Date(day: 1, month: 1, year: 2019),
      price: Price(
        value: 25000,
        valute: Valute(id: 1, name: 'test', symbol: '\$'),
      ),
      mileage: 154200,
      country: Country(id: 0, name: 'Italia', image: ''),
      doorType: DoorType(id: 1, number: '1/2'),
      cubicCapacity: 1,
      fuelType: Fuel(id: 0, type: FuelType.Electric),
      motorPower: 1,
      description:
          'Shiten Toyota Highlander hybrid viti 2009 13500 eu full extra me letra,Toyota Prius viti 2010 8300 eu.viti 2011 me tavan panoramik me panel diellor 7500 eu me targa te huaja,viti 2013 pluguin hibrid 1.8 l per 100km ,pershkruan edhe 50 km vetem me motor elektrik',
      status: ListingStatus.Available,
      images: [
        'https://www.tesla.com/assets/img/ms_fb_s.jpg',
        'https://i0.wp.com/www.insidehr.com.au/wp-content/uploads/2018/09/Tesla-model-S-P100D-min.jpg?fit=1000%2C500&ssl=1',
        'https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/Models.jpg',
      ],
    ),
    Listing(
      id: '2',
      brand: Brand(id: 0, name: 'Tesla'),
      model: Model(id: 1, name: 'Model S'),
      registrationDate: Date(day: 1, month: 1, year: 2019),
      price: Price(
        value: 25000,
        valute: Valute(id: 1, name: 'test', symbol: '\$'),
      ),
      mileage: 154200,
      country: Country(id: 0, name: 'Italia', image: ''),
      doorType: DoorType(id: 1, number: '1/2'),
      cubicCapacity: 1,
      fuelType: Fuel(id: 0, type: FuelType.Electric),
      motorPower: 1,
      description:
          'Shiten Toyota Highlander hybrid viti 2009 13500 eu full extra me letra,Toyota Prius viti 2010 8300 eu.viti 2011 me tavan panoramik me panel diellor 7500 eu me targa te huaja,viti 2013 pluguin hibrid 1.8 l per 100km ,pershkruan edhe 50 km vetem me motor elektrik',
      status: ListingStatus.Available,
      images: [
        'https://www.tesla.com/assets/img/ms_fb_s.jpg',
        'https://i0.wp.com/www.insidehr.com.au/wp-content/uploads/2018/09/Tesla-model-S-P100D-min.jpg?fit=1000%2C500&ssl=1',
        'https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/Models.jpg',
      ],
    ),
    Listing(
      id: '3',
      brand: Brand(id: 0, name: 'Tesla'),
      model: Model(id: 1, name: 'Model S'),
      registrationDate: Date(day: 1, month: 1, year: 2019),
      price: Price(
        value: 25000,
        valute: Valute(id: 1, name: 'test', symbol: '\$'),
      ),
      mileage: 154200,
      country: Country(id: 0, name: 'Italia', image: ''),
      doorType: DoorType(id: 1, number: '1/2'),
      cubicCapacity: 1,
      fuelType: Fuel(id: 0, type: FuelType.Electric),
      motorPower: 1,
      description:
          'Shiten Toyota Highlander hybrid viti 2009 13500 eu full extra me letra,Toyota Prius viti 2010 8300 eu.viti 2011 me tavan panoramik me panel diellor 7500 eu me targa te huaja,viti 2013 pluguin hibrid 1.8 l per 100km ,pershkruan edhe 50 km vetem me motor elektrik',
      status: ListingStatus.Available,
      images: [
        'https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/Models.jpg',
      ],
    ),
    Listing(
      id: '4',
      brand: Brand(id: 0, name: 'Tesla'),
      model: Model(id: 1, name: 'Model S'),
      registrationDate: Date(day: 1, month: 1, year: 2019),
      price: Price(
        value: 25000,
        valute: Valute(id: 1, name: 'test', symbol: '\$'),
      ),
      mileage: 154200,
      country: Country(id: 0, name: 'Italia', image: ''),
      doorType: DoorType(id: 1, number: '1/2'),
      cubicCapacity: 1,
      fuelType: Fuel(id: 0, type: FuelType.Electric),
      motorPower: 1,
      description:
          'Shiten Toyota Highlander hybrid viti 2009 13500 eu full extra me letra,Toyota Prius viti 2010 8300 eu.viti 2011 me tavan panoramik me panel diellor 7500 eu me targa te huaja,viti 2013 pluguin hibrid 1.8 l per 100km ,pershkruan edhe 50 km vetem me motor elektrik',
      status: ListingStatus.Available,
      images: [
        'https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/Models.jpg',
        'https://i0.wp.com/www.insidehr.com.au/wp-content/uploads/2018/09/Tesla-model-S-P100D-min.jpg?fit=1000%2C500&ssl=1',
        'https://www.tesla.com/assets/img/ms_fb_s.jpg',
      ],
    ),
    Listing(
      id: '5',
      brand: Brand(id: 0, name: 'Tesla'),
      model: Model(id: 1, name: 'Model S'),
      registrationDate: Date(day: 1, month: 1, year: 2019),
      price: Price(
        value: 25000,
        valute: Valute(id: 1, name: 'test', symbol: '\$'),
      ),
      mileage: 154200,
      country: Country(id: 0, name: 'Italia', image: ''),
      doorType: DoorType(id: 1, number: '1/2'),
      cubicCapacity: 1,
      fuelType: Fuel(id: 0, type: FuelType.Electric),
      motorPower: 1,
      description:
          'Shiten Toyota Highlander hybrid viti 2009 13500 eu full extra me letra,Toyota Prius viti 2010 8300 eu.viti 2011 me tavan panoramik me panel diellor 7500 eu me targa te huaja,viti 2013 pluguin hibrid 1.8 l per 100km ,pershkruan edhe 50 km vetem me motor elektrik',
      status: ListingStatus.Available,
      images: [
        'https://i0.wp.com/www.insidehr.com.au/wp-content/uploads/2018/09/Tesla-model-S-P100D-min.jpg?fit=1000%2C500&ssl=1',
        'https://www.tesla.com/assets/img/ms_fb_s.jpg',
        'https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/Models.jpg',
      ],
    ),
  ];

  Future<List<Listing>> fetchListings(int startIndex, int limit) async {
    // final response = await httpClient.get(
    //   'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit',
    // );

    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body) as List;
    //   return data.map((dynamic rawPost) {
    //     return Listing(
    //       id: '1',
    //       brand: Brand(id: 0, name: 'Tesla'),
    //       model: Model(id: 1, name: 'Model S'),
    //       registrationDate: Date(day: 1, month: 1, year: 2019),
    //       price: Price(
    //         value: 25000,
    //         valute: Valute(id: 1, name: 'test', symbol: '\$'),
    //       ),
    //       mileage: 1,
    //       country: Country(id: 0, name: 'Italia', image: ''),
    //       doorType: DoorType(id: 1, number: '1/2'),
    //       cubicCapacity: 1,
    //       fuelType: Fuel(id: 0, type: FuelType.Electric),
    //       motorPower: 1,
    //       description: 'Description',
    //       status: ListingStatus.Available,
    //       images: ['test', 'test', 'test'],
    //     );
    //   }).toList();
    // }
    // throw Exception('error fetching posts');

    // return Future.delayed(
    //   const Duration(milliseconds: 500),
    //   () => _listings,
    // );
    // return _listings;
    return startIndex < 40 ? _listings : [];
  }

  Future<List<SearchType>> fetchSearchTypes() async {
    List<SearchType> _types = [
      SearchType(id: 0, title: 'Latest'),
      SearchType(id: 1, title: 'Trending'),
    ];

    return _types;
  }
}
