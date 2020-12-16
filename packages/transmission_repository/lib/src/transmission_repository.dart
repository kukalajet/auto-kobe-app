import 'models/models.dart';

class TransmissionRepository {
  Future<List<Transmission>> fetchTransmissions() async {
    List<Transmission> transmissions = <Transmission>[
      Transmission(id: 0, type: TransmissionType.Manual),
      Transmission(id: 1, type: TransmissionType.Automatic),
    ];

    return transmissions;
  }
}
