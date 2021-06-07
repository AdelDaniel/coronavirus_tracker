import 'dart:convert';

import '../models/end_point_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

//This class used to make requests
class APIService {
  final API api;
  APIService(this.api);

  //request for the access token
  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final String accessToken = data['access_token'];

      if (accessToken.isNotEmpty) {
        return accessToken;
      }
    }
    print(
        'Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<EndPointModel> getEndPoints(
      {@required String accessToken, EndPoint endPoint}) async {
    final response = await http.get(
      api.endPointUri(endPoint),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      Map<String, dynamic> map = data[0];
      final int endPointData = map[_responseEndPointsOfJson[endPoint]];
      final String accessTokenDateString = map['date'];
      final DateTime date = DateTime.tryParse(accessTokenDateString);
      if (endPointData != null) {
        return EndPointModel(value: endPointData, date: date);
      }
    }
    print(
        'Request ${api.endPointUri(endPoint)} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Map<EndPoint, String> _responseEndPointsOfJson = {
    EndPoint.cases: 'cases',
    EndPoint.casesConfirmed: 'data',
    EndPoint.casesSuspected: 'data',
    EndPoint.deaths: 'data',
    EndPoint.recovered: 'data'
  };
}
