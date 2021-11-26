// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$LocationService extends LocationService {
  _$LocationService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = LocationService;

  @override
  Future<Response<dynamic>> postUserLocation(
      String address,
      String addressDescription,
      bool isActive,
      double longitude,
      double latitude) {
    final $url = '/location/create/';
    final $body = <String, dynamic>{
      'address_name': address,
      'address_description': addressDescription,
      'is_active': isActive,
      'longitude': longitude,
      'latitude': latitude
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getLocationList() {
    final $url = '/location/list/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
