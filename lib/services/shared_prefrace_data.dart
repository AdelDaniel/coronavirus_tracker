import '../models/end_points_model.dart';
import '../models/end_point_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class DataCacheService {
  DataCacheService({@required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  static String endPointValueKey(EndPoint endPoint) => '$endPoint/value';
  static String endPointDateKey(EndPoint endPoint) => '$endPoint/date';

  EndPointsModel getData() {
    Map<EndPoint, EndPointModel> values = {};
    EndPoint.values.forEach((endPoint) {
      final value = sharedPreferences.getInt(endPointValueKey(endPoint));
      final dateString = sharedPreferences.getString(endPointDateKey(endPoint));
      if (value != null && dateString != null) {
        final date = DateTime.tryParse(dateString);
        values[endPoint] = EndPointModel(value: value, date: date);
      }
    });
    return EndPointsModel(endPointsValues: values);
  }

  Future<void> setData(EndPointsModel endPointsModel) async {
    endPointsModel.endPointsValues.forEach((ep, sep) async {
      await sharedPreferences.setInt(
        endPointValueKey(ep),
        sep.value,
      );
      await sharedPreferences.setString(
        endPointDateKey(ep),
        sep.date.toIso8601String(),
      );
    });
  }
}
