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
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: FractionallySizedBox(
              heightFactor: 0.8,
              child: ExampleAlarmEditScreen(alarmSettings: settings),
            )
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Selamat datang, Perawat!',
          style: TextStyle(color: ColorLayout.blue4),
        ),
        backgroundColor: ColorLayout.neutral5,
      ),
      body: FutureBuilder(
        future: client.getEvent(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<DetilEvent> event = snapshot.data as List<DetilEvent>; 
            return SafeArea(
                child: event.isNotEmpty
                    ? ListView.builder(
                        itemCount: event.length,
                        itemBuilder: (context, index) {
                          return ExampleAlarmTile(
                            key: Key(event[index].id.toString()),
                            time: TimeOfDay(
                              hour: event[index].startTime!.hour,
                              minute: event[index].startTime!.minute,
                            ).format(context),
                            description: event[index].description!,
                            title: event[index].title!,
                            isPatient: false,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAlarmScreen(null),
        backgroundColor: ColorLayout.blue4,
        child: const Icon(
          Icons.add_alarm_sharp, 
          size: 45,
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

    final client = AcceptProofImage();
    try {
      final response = await client.acceptProofImage(requestBody, widget.id!);
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
      appBar: AppBar(
        title: const Text('Tampilkan Hasil Kegiatan'),
        backgroundColor: ColorLayout.blue4,
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Container(
              width:250,
              child: Image.network(widget.proofImageUrl!),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorLayout.blue4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: (){
                  Navigator.pop(context, true);
                }, 
                child: Text('Batalkan', style: TextLayout.body16.copyWith(color: ColorLayout.neutral5)),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorLayout.blue4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: (){
                  acceptProofImage();
                }, 
                child: Text('Setujui', style: TextLayout.body16.copyWith(color: ColorLayout.neutral5)),
              ),
            ),
          ],
        )
      )
    );
  }
}