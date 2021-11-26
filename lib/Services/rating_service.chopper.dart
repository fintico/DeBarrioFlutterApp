// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$RatingService extends RatingService {
  _$RatingService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = RatingService;

  @override
  Future<Response<dynamic>> postRateSeller(int ratedValue, int sellerId) {
    final $url = '/rating/create/';
    final $body = <String, dynamic>{
      'rated_value': ratedValue,
      'seller': sellerId
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
