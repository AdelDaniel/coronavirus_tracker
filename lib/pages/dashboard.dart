import 'dart:io';

import '../models/end_points_model.dart';
import '../repositries/data_repositry.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/time_last_update_text.dart';
import '../services/api.dart';
import 'package:provider/provider.dart';
import '../widgets/end_point_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndPointsModel _endPointsModel;

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepositry>(context, listen: false);
    _endPointsModel = dataRepository.getDataFromCache();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final DataRepositry dataRepositry =
          Provider.of<DataRepositry>(context, listen: false);
      final EndPointsModel endPointsModel =
          await dataRepositry.getEndPointsModel();
      setState(() {
        _endPointsModel = endPointsModel;
      });
    } on SocketException catch (_) {
      showAlertDialog(
        context: context,
        title: 'Connection Error',
        content: 'Could not retrieve data. Please try again later.',
        defaultActionText: 'OK',
      );
    } catch (_) {
      showAlertDialog(
        context: context,
        title: 'Unknown Error',
        content: 'Please contact support or try again later.',
        defaultActionText: 'OK',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text.rich(
            TextSpan(
              text: 'Covid ', // default text style
              children: <TextSpan>[
                TextSpan(
                    text: ' 19 ',
                    style: TextStyle(fontStyle: FontStyle.italic)),
                TextSpan(
                    text: 'Tracker',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _updateData,
          child: ListView(
            children: [
              TimeLastUpdateText(
                  dateTime: _endPointsModel == null
                      ? null
                      : _endPointsModel.endPointsValues[EndPoint.cases]?.date),
              for (EndPoint item in EndPoint.values)
                EndPointCard(
                  endPoint: item,
                  valueOfEndPoint: _endPointsModel == null
                      ? null
                      : _endPointsModel.endPointsValues[item]
                          ?.value, // ? => conditional member access operator
                )
            ],
          ),
        ),
      ),
    );
  }
}
