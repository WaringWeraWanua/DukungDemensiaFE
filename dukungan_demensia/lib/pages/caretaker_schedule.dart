import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:dukungan_demensia/pages/edit_alarm.dart';
import 'package:dukungan_demensia/pages/ring.dart';
import 'package:dukungan_demensia/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:dukungan_demensia/models/schedule_models.dart';
import 'package:dukungan_demensia/services/schedule_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/layout/colors_layout.dart';
import 'package:dukungan_demensia/widgets/layout/text_layout.dart';
import 'package:dukungan_demensia/components/globals.dart' as globals;

import 'package:dukungan_demensia/models/proof_image_models.dart';
import 'package:dukungan_demensia/services/proof_image_api.dart';

class CaretakerAlarmScreen extends StatefulWidget {
  const CaretakerAlarmScreen({Key? key}) : super(key: key);

  @override
  State<CaretakerAlarmScreen> createState() => _CaretakerAlarmScreenState();
}

class _CaretakerAlarmScreenState extends State<CaretakerAlarmScreen> {
  late List<AlarmSettings> alarms;

  static StreamSubscription? subscription;
  ScheduleAPI client = ScheduleAPI();
  @override
  void initState() {
    super.initState();
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
    
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ExampleAlarmRingScreen(alarmSettings: alarmSettings),
        ));
    loadAlarms();
  }

  Future<void> navigateToAlarmScreen(DetilEvent? settings) async {
    final res = await showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: ExampleAlarmEditScreen(alarmSettings: settings),
          );
        });

    if (res != null && res == true) loadAlarms();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Caretaker Screen')),
      body: FutureBuilder(
        future: client.getEvent(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<DetilEvent> event = snapshot.data as List<DetilEvent>; 
            return SafeArea(
                child: event.isNotEmpty
                    ? ListView.separated(
                        itemCount: event.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          return ExampleAlarmTile(
                            key: Key(event[index].id.toString()),
                            time: TimeOfDay(
                              hour: event[index].startTime!.hour,
                              minute: event[index].startTime!.minute,
                            ).format(context),
                            description: event[index].description!,
                            title: event[index].title!,
                            showImage: event[index].proofImageUrl != "" && event[index].proofImageUrl != null,
                            alreadySendToday: event[index].doneTime?.toLocal() != null && event[index].doneTime?.toLocal().toString() != "",
                            //onPressed: () => event[index].proofImageUrl == "" ? null : DisplayPictureCaretaker(event[index].proofImageUrl!),
                            onPressed: () async {
                              try {
                                if(event[index].proofImageUrl != "" && event[index].proofImageUrl != null) {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DisplayPictureCaretaker(proofImageUrl: event[index].proofImageUrl!, id: event[index].id.toString()),
                                    ),
                                  );
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            onDismissed: () {
                              Alarm.stop(int.parse(event[index].id!)).then((_) => loadAlarms());
                            },
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "Anda belum mengatur mengatur jadwal",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
              );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Anda belum memiliki pasien",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () => navigateToAlarmScreen(null),
              child: const Icon(Icons.alarm_add_rounded, size: 33),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class DisplayPictureCaretaker extends StatefulWidget {
  final String? proofImageUrl;
  final String? id;

  const DisplayPictureCaretaker({Key? key, this.proofImageUrl, this.id}) : super(key: key);

  @override
  State<DisplayPictureCaretaker> createState() => _DisplayPictureCaretakerState();
}

class _DisplayPictureCaretakerState extends State<DisplayPictureCaretaker> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> acceptProofImage() async {
    DateTime dateToday =new DateTime.now(); 
    String date = dateToday.toString().substring(0,10);
    String time = dateToday.toString().substring(11,23);
    AcceptProofImageBody requestBody = AcceptProofImageBody(
      doneTime: date + "T" + time + "Z",
    );
    print(requestBody.doneTime);

    final client = AcceptProofImage();
    try {
      print("TEST");
      final response = await client.acceptProofImage(requestBody, widget.id!);
      print(response);
      await Fluttertoast.showToast(
        msg: "Sukses menyetujui!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          Container(
            height:400,
            width:400,
            child: Image.network(widget.proofImageUrl!),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorLayout.brBlue50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: (){
              acceptProofImage();
            }, 
            child: Text('Setujui', style: TextLayout.title18.copyWith(color: ColorLayout.neutral5)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorLayout.brBlue50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: (){
              Navigator.pop(context, true);
            }, 
            child: Text('Batalkan', style: TextLayout.title18.copyWith(color: ColorLayout.neutral5)),
          ),
        ],
      )
    );
  }
}