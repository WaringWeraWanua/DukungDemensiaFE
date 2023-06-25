import 'package:flutter/material.dart';
import 'package:dukungan_demensia/main.dart';

class ExampleAlarmTile extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final bool isClicked;
  final void Function() onPressed;
  final void Function()? onDismissed;
  final bool showImage;
  final bool alreadySendToday;

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      direction: onDismissed != null
          ? DismissDirection.endToStart
          : DismissDirection.none,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 30),
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) => onDismissed?.call(),
      child: RawMaterialButton(
        fillColor: alreadySendToday ? Colors.grey : Colors.white,
        onPressed: onPressed,
        child: SafeArea(
          //height: 100,
          //padding: const EdgeInsets.all(35),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isClicked || (isClicked && showImage)) const Icon(Icons.camera_alt, size: 35),
            ],
          ),
          ),
        ),
      ),
    );
  }
}