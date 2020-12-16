import 'models/models.dart';

class EmissionRepository {
  Future<List<Emission>> fetchEmissions() async {
    List<Emission> emissions = <Emission>[
      Emission(id: 0, standard: 'Euro', tier: 1),
      Emission(id: 1, standard: 'Euro', tier: 2),
      Emission(id: 2, standard: 'Euro', tier: 3),
      Emission(id: 3, standard: 'Euro', tier: 4),
      Emission(id: 4, standard: 'Euro', tier: 5),
      Emission(id: 5, standard: 'Euro', tier: 6),
    ];

    return emissions;
  }
}
