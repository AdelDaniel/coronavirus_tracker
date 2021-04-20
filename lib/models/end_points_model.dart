import 'single_end_point.dart';
import 'package:flutter/cupertino.dart';

import '../services/api.dart';

class EndPointsModel {
  EndPointsModel({@required this.endPointsValues});
  final Map<EndPoint, SingleEndPoint> endPointsValues;

  SingleEndPoint get cases => endPointsValues[EndPoint.cases];
  SingleEndPoint get casesConfirmed => endPointsValues[EndPoint.casesConfirmed];
  SingleEndPoint get casesSuspected => endPointsValues[EndPoint.casesSuspected];
  SingleEndPoint get deaths => endPointsValues[EndPoint.deaths];
  SingleEndPoint get recovered => endPointsValues[EndPoint.recovered];
}
