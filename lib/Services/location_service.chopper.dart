// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$LocationService extends LocationService {
  _$LocationService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = LocationService;

  Future<Response> postUserLocation(
      String addressName, bool isActive, double longitude, double latitude) {
    final $url = '/location/create/';
    final $body = {
      'address_name': addressName,
      'is_active': isActive,
      'longitude': longitude,
      'latitude': latitude
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
