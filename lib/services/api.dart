import 'package:flutter/cupertino.dart';

import 'api_keys.dart';

enum EndPoint { cases, casesSuspected, casesConfirmed, deaths, recovered }

class API {
  final String apiKey;
  API({@required this.apiKey});

  //factory constructor
  factory API.sandBox() => API(apiKey: APIKeys.sandBoxKey);

  static final String host = "ncov2019-admin.firebaseapp.com";

  Uri tokenUri() => Uri(scheme: 'https', host: host, path: 'token');

  Uri endPointUri(EndPoint endPoint) =>
      Uri(scheme: 'https', host: host, path: _paths[endPoint]);

  Map<EndPoint, String> _paths = {
    EndPoint.cases: 'cases',
    EndPoint.casesConfirmed: 'casesConfirmed',
    EndPoint.casesSuspected: 'casesSuspected',
    EndPoint.deaths: 'deaths',
    EndPoint.recovered: 'recovered'
  };
}
