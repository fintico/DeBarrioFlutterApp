// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$RatingService extends RatingService {
  _$RatingService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = RatingService;

  Future<Response> postRateSeller(int ratedValue, int sellerId) {
    final $url = '/rating/create/';
    final $body = {'rated_value': ratedValue, 'seller': sellerId};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
