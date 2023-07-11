import 'package:alarm/alarm.dart';
import 'package:dukungan_demensia/models/schedule_models.dart';
import 'package:flutter/material.dart';
import 'package:dukungan_demensia/services/schedule_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/layout/colors_layout.dart';

class ExampleAlarmEditScreen extends StatefulWidget {
  final DetilEvent? alarmSettings;

  const ExampleAlarmEditScreen({Key? key, this.alarmSettings})
      : super(key: key);

  @override
  State<ExampleAlarmEditScreen> createState() => _ExampleAlarmEditScreenState();
}

class _ExampleAlarmEditScreenState extends State<ExampleAlarmEditScreen> {
  late bool creating;

  late TimeOfDay selectedTime;
  late bool loopAudio;
  late bool vibrate;
  late bool showNotification;
  late String assetAudio;
  //late String title;

  late TextEditingController title = TextEditingController();
  late TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
    creating = widget.alarmSettings == null;

    if (creating) {
      final dt = DateTime.now().add(const Duration(minutes: 1));
      selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
      loopAudio = true;
      vibrate = true;
      showNotification = true;
      assetAudio = "assets/marimba.mp3";
    } else {
      selectedTime = TimeOfDay(
        hour: widget.alarmSettings!.startTime!.hour,
        minute: widget.alarmSettings!.startTime!.minute,
      );
      loopAudio = true;
      vibrate = true;
      showNotification = widget.alarmSettings!.title != null &&
          widget.alarmSettings!.title!.isNotEmpty &&
          widget.alarmSettings!.description != null &&
          widget.alarmSettings!.description!.isNotEmpty;
      assetAudio = widget.alarmSettings!.ringtoneType!;
    }
  }

  Future<void> pickTime() async {
    final res = await showTimePicker(
      initialTime: selectedTime,
      context: context,
    );
    if (res != null) setState(() => selectedTime = res);
  }

  AlarmSettings buildAlarmSettings() {
    final now = DateTime.now();
    final id = creating
        ? DateTime.now().millisecondsSinceEpoch % 100000
        : widget.alarmSettings!.id;

    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    final alarmSettings = AlarmSettings(
      id: int.parse(id.toString()),
      dateTime: dateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      notificationTitle: title.text,
      notificationBody: 'Waktunya melakukan ' + title.text + '!',
      assetAudioPath: assetAudio,
      stopOnNotificationOpen: false,
    );
    return alarmSettings;
  }

  Future<void> saveAlarm() async {
      DateTime dateToday =new DateTime.now(); 
      String date = dateToday.toString().substring(0,10);
      String hour = selectedTime.hour.toString();
      String minute = selectedTime.minute.toString();
      if(hour.length == 1) {
        hour = "0" + hour;
      }
      if(minute.length == 1) {
        minute = "0" + minute;
      }
      PostEventRequestBody requestBody = PostEventRequestBody(
        title: title.text,
        description: description.text,
        startTime: date + "T" + hour + ":" + minute + ":00.000Z",
        ringtoneType: assetAudio,
      );

      final client = PostScheduleAPI();
      try {
        final response = await client.postSchedule(requestBody);
        await Fluttertoast.showToast(
          msg: "Berhasil mendaftarkan kegiatan!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
        // Navigator.pushNamed(context, '/home');
      } catch (e) {
        print(e);
        await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      } 
    Navigator.pop(context, true);
  }

  void deleteAlarm() {
    Alarm.stop(int.parse(widget.alarmSettings!.id!)).then((res) {
      if (res) Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
/*       padding: EdgeInsets.only(
         bottom: MediaQuery.of(context).viewInsets.bottom,
         left: 30,
         right: 30,
         top: MediaQuery.of(context).viewInsets.bottom + 10,
      ), */
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "Batalkan",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: ColorLayout.blue4),
                ),
              ),
              TextButton(
                onPressed: saveAlarm,
                child: Text(
                  "Simpan",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: ColorLayout.blue4),
                ),
              ),
            ],
          ),
          RawMaterialButton(
            onPressed: pickTime,
            fillColor: ColorLayout.blue4,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedTime.format(context),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: ColorLayout.neutral5),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kegiatan',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorLayout.blue4),
              ),
              const SizedBox(width: 100),
              Expanded(
                child: TextFormField(
                  controller: title,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deskripsi',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorLayout.blue4),
              ),
              const SizedBox(width: 100),
              Expanded(
                child: TextFormField(
                  controller: description,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sound',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorLayout.blue4),
              ),
              DropdownButton(
                value: assetAudio,
                items: const [
                  DropdownMenuItem<String>(
                    value: 'assets/marimba.mp3',
                    child: Text('Marimba'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/nokia.mp3',
                    child: Text('Nokia'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/mozart.mp3',
                    child: Text('Mozart'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/star_wars.mp3',
                    child: Text('Star Wars'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/one_piece.mp3',
                    child: Text('One Piece'),
                  ),
                ],
                onChanged: (value) => setState(() => assetAudio = value!),
              ),
            ],
          ),
          if (!creating)
            TextButton(
              onPressed: deleteAlarm,
              child: Text(
                'Delete Alarm',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: ColorLayout.blue6),
              ),
            ),
          const SizedBox(),
        ],
      ),
    );
  }
}