import 'package:coronavirus_tracker/localization/app_localization.dart';

import '../services/api.dart';
import 'package:flutter/material.dart';

class EndpointCardData {
  EndpointCardData(this.title, this.assetName, this.color);
  final String title;
  final String assetName;
  final Color color;
}

class EndPointCard extends StatelessWidget {
  final EndPoint endPoint;
  final int valueOfEndPoint;
  const EndPointCard({this.endPoint, this.valueOfEndPoint});

  static Map<EndPoint, EndpointCardData> _cardsData = {
    EndPoint.cases:
        EndpointCardData('Cases', 'assets/count.png', Color(0xFFFFF492)),
    EndPoint.casesSuspected: EndpointCardData(
        'Suspected cases', 'assets/suspect.png', Color(0xFFEEDA28)),
    EndPoint.casesConfirmed: EndpointCardData(
        'Confirmed cases', 'assets/fever.png', Color(0xFFE99600)),
    EndPoint.deaths:
        EndpointCardData('Deaths', 'assets/death.png', Color(0xFFE40000)),
    EndPoint.recovered:
        EndpointCardData('Recovered', 'assets/patient.png', Color(0xFF70A901)),
  };

  String _convertToString(int number) {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';
    return number.toString().replaceAllMapped(reg, mathFunc);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Card(
        child: Container(
          height: 110,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // _cardsData[endPoint].title,
                AppLocalization.of(context)
                    .translate(_cardsData[endPoint].title),
                style: ThemeData.dark()
                    .textTheme
                    .headline1
                    .copyWith(color: _cardsData[endPoint].color),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    _cardsData[endPoint].assetName,
                    color: _cardsData[endPoint].color,
                  ),
                  valueOfEndPoint == null
                      ? CircularProgressIndicator()
                      : Text(
                          _convertToString(valueOfEndPoint),
                          style: ThemeData.dark().textTheme.headline1.copyWith(
                              color: _cardsData[endPoint].color,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
