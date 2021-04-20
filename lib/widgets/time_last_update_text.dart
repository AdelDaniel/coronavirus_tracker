import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeLastUpdateText extends StatelessWidget {
  const TimeLastUpdateText({Key key, @required this.dateTime})
      : super(key: key);
  final DateTime dateTime;

  String lastUpdatedStatusText() {
    if (dateTime != null) {
      final formatter = DateFormat.yMd().add_Hms();
      final formatted = formatter.format(dateTime);
      return 'Last updated: $formatted';
    }
    return ' ';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          lastUpdatedStatusText(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
