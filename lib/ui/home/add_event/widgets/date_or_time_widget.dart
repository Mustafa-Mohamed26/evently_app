import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DateOrTimeWidget extends StatelessWidget {
  IconData iconDateOrTime;
  String eventDateOrTime;
  String chooseDateOrTime;
  VoidCallback onChooseDateOrTimeClick;
  DateOrTimeWidget({
    super.key,
    required this.iconDateOrTime,
    required this.eventDateOrTime,
    required this.chooseDateOrTime,
    required this.onChooseDateOrTimeClick,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Icon(iconDateOrTime, color: Theme.of(context).dividerColor),
        SizedBox(width: width * 0.02),
        Text(eventDateOrTime, style: Theme.of(context).textTheme.titleLarge),
        Spacer(),
        TextButton(
          onPressed: () {
            onChooseDateOrTimeClick();
          },
          child: Text(chooseDateOrTime, style: AppStyles.medium16Primary),
        ),
      ],
    );
  }
}
