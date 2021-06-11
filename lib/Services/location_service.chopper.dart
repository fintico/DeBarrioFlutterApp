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

  Future<Response> postUserLocation(String address, String addressDescription,
      bool isActive, double longitude, double latitude) {
    final $url = '/location/create/';
    final $body = {
      'address_name': address,
      'address_description': addressDescription,
      'is_active': isActive,
      'longitude': longitude,
      'latitude': latitude
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getLocationList() {
    final $url = '/location/list/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
