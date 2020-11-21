import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:brand_repository/src/models/models.dart';

class BrandRepository {
  final http.Client httpClient;

  BrandRepository({@required this.httpClient});

  Future<List<Brand>> fetchBrands(int startIndex, int limit) async {
    List<Brand> brands = <Brand>[
      Brand(id: 0, name: 'Honda Motor Company'),
      Brand(id: 1, name: 'Fiat Chrysler Automobiles'),
      Brand(id: 2, name: 'Volkswagen Group'),
      Brand(id: 3, name: 'BMW Group'),
      Brand(id: 4, name: 'Volkswagen Group'),
      Brand(id: 5, name: 'General Motors'),
      Brand(id: 6, name: 'Ford Motor Co.'),
      Brand(id: 7, name: 'Hyundai Motor Group'),
      Brand(id: 8, name: 'Renault-Nissan-Mitsubishi Alliance'),
      Brand(id: 9, name: 'Tata Motors'),
      Brand(id: 10, name: 'Toyota Motor Corp.'),
      Brand(id: 11, name: 'Zhejiang Geely Holding Group'),
      Brand(id: 12, name: 'Mazda Motor Corp.'),
      Brand(id: 13, name: 'Daimler AG'),
      Brand(id: 14, name: 'Nikola Motor Company'),
      Brand(id: 15, name: 'Rivian Automotive'),
      Brand(id: 16, name: 'Tesla Inc.'),
      Brand(id: 17, name: 'Nikola Motor Company'),
      Brand(id: 18, name: 'Rivian Automotive'),
      Brand(id: 19, name: 'Tesla Inc.'),
    ];
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => brands,
    );
  }

  Future<List<Brand>> fetchFavorites() {
    List<Brand> favorites = <Brand>[
      Brand(id: 0, name: 'Honda Motor Company'),
      Brand(id: 1, name: 'Fiat Chrysler Automobiles'),
      Brand(id: 2, name: 'Volkswagen Group'),
      Brand(id: 3, name: 'BMW Group'),
      Brand(id: 4, name: 'Volkswagen Group'),
      Brand(id: 5, name: 'General Motors'),
    ];
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => favorites,
    );
  }
}
