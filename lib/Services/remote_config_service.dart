import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteConfigService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _cachedApiKey;

  Future<String> getOpenWeatherApiKey() async {
    if (_cachedApiKey != null) return _cachedApiKey!;

    try {
      final doc = await _firestore.collection('config').doc('api_keys').get();
      if (doc.exists && doc.data()!.containsKey('open_weather')) {
        _cachedApiKey = doc.data()!['open_weather'];
        return _cachedApiKey!;
      } else {
        throw Exception("API Key not found in Firestore");
      }
    } catch (e) {
      throw Exception("Failed to fetch secure config: $e");
    }
  }
}