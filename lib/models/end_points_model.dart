import 'end_point_model.dart';
import 'package:flutter/cupertino.dart';

import '../services/api.dart';

class EndPointsModel {
  EndPointsModel({@required this.endPointsValues});
  final Map<EndPoint, EndPointModel> endPointsValues;

  EndPointModel get cases => endPointsValues[EndPoint.cases];
  EndPointModel get casesConfirmed => endPointsValues[EndPoint.casesConfirmed];
  EndPointModel get casesSuspected => endPointsValues[EndPoint.casesSuspected];
  EndPointModel get deaths => endPointsValues[EndPoint.deaths];
  EndPointModel get recovered => endPointsValues[EndPoint.recovered];
}
