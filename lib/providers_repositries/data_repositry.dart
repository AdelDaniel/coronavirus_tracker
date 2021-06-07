import '../models/end_point_model.dart';
import '../models/end_points_model.dart';
import '../services/api.dart';
import '../services/api_service.dart';
import '../services/shared_prefrace_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DataRepositry {
  DataRepositry({@required this.dataCacheService, @required this.apiService});
  final APIService apiService;
  final DataCacheService dataCacheService;
  String _accessToken = " ";

  EndPointsModel getDataFromCache() {
    return dataCacheService.getData();
  }

  Future<EndPointModel> getEndPointData({@required EndPoint endPoint}) async =>
      await _getData<EndPointModel>(
          function: () => apiService.getEndPoints(
              accessToken: _accessToken, endPoint: endPoint));

  Future<EndPointsModel> getEndPointsModel() async {
    final val =
        await _getData<EndPointsModel>(function: () => _getAllEndPointData());
    await dataCacheService.setData(val); // saving in the cache
    return val;
  }

  Future<T> _getData<T>({Future<T> Function() function}) async {
    try {
      if (_accessToken.contains(" ")) {
        _accessToken = await apiService.getAccessToken();
      }
      return function();
    } on http.Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return function();
      }
      rethrow;
    }
  }

  Future<EndPointsModel> _getAllEndPointData() async {
    final List<dynamic> fetchedData = await Future.wait([
      apiService.getEndPoints(
          accessToken: _accessToken, endPoint: EndPoint.cases),
      apiService.getEndPoints(
          accessToken: _accessToken, endPoint: EndPoint.casesConfirmed),
      apiService.getEndPoints(
          accessToken: _accessToken, endPoint: EndPoint.casesSuspected),
      apiService.getEndPoints(
          accessToken: _accessToken, endPoint: EndPoint.deaths),
      apiService.getEndPoints(
          accessToken: _accessToken, endPoint: EndPoint.recovered),
    ]);

    return EndPointsModel(endPointsValues: {
      EndPoint.cases: fetchedData[0],
      EndPoint.casesConfirmed: fetchedData[1],
      EndPoint.casesSuspected: fetchedData[2],
      EndPoint.deaths: fetchedData[3],
      EndPoint.recovered: fetchedData[4],
    });
  }
}
