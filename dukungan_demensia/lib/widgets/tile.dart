import 'package:flutter/material.dart';
import 'package:dukungan_demensia/main.dart';
import 'layout/colors_layout.dart';

class ExampleAlarmTile extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final bool isClicked;
  final void Function() onPressed;
  final void Function()? onDismissed;
  final bool showImage;
  final bool alreadySendToday;
  final bool isPatient;

  const ExampleAlarmTile({
    Key? key,
    required this.title,
    required this.description,
    required this.time,
    required this.onPressed,
    this.onDismissed,
    this.isClicked = true,
    this.showImage = false,
    this.alreadySendToday = false,
    this.isPatient = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      direction: onDismissed != null
          ? DismissDirection.endToStart
          : DismissDirection.none,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 30),
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) => onDismissed?.call(),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return alreadySendToday ? ColorLayout.blue1 : ColorLayout.neutral5;
            }
          ),
/*           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(
                color: alreadySendToday ? ColorLayout.blue4 : ColorLayout.neutral5,
              ),
            )
          ), */
        ),
        onPressed: onPressed,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                        color: alreadySendToday ? ColorLayout.black3 : ColorLayout.blue4,
                      ),
                    ),
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: alreadySendToday ? ColorLayout.black3 : ColorLayout.blue4,
                      ),
                    ),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: alreadySendToday ? ColorLayout.black3 : ColorLayout.blue4,
                      ),
                    ),
                  ],
                ),
              ),
              if ((isPatient && !alreadySendToday) || (!isPatient && showImage)) const Icon(Icons.camera_alt, size: 35, color: ColorLayout.blue4),
            ],
          ),
          ),
        ),
      ),
      )
    );
  }
}