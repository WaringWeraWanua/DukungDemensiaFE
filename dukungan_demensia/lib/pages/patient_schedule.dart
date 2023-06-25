import 'dart:async';
import 'dart:io';
import 'package:dukungan_demensia/models/schedule_models.dart';
import 'package:uuid/uuid.dart';

import 'package:camera/camera.dart';
import 'package:alarm/alarm.dart';
import 'package:dukungan_demensia/pages/edit_alarm.dart';
import 'package:dukungan_demensia/pages/ring.dart';
import 'package:dukungan_demensia/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:dukungan_demensia/main.dart';
import '../widgets/layout/colors_layout.dart';
import 'package:dukungan_demensia/widgets/layout/text_layout.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:dukungan_demensia/models/schedule_models.dart';
import 'package:dukungan_demensia/services/schedule_api.dart';

import 'package:dukungan_demensia/models/proof_image_models.dart';
import 'package:dukungan_demensia/services/proof_image_api.dart';

import 'package:dukungan_demensia/components/globals.dart' as globals;

class PatientAlarmScreen extends StatefulWidget {
  const PatientAlarmScreen({Key? key}) : super(key: key);

  @override
  State<PatientAlarmScreen> createState() => _PatientAlarmScreenState();
}

class _PatientAlarmScreenState extends State<PatientAlarmScreen> {
  late List<AlarmSettings> alarms;

  ScheduleAPI client = ScheduleAPI();

  static StreamSubscription? subscription;
  late List<DetilEvent> listEvent;

  

  @override
  void initState() {
    super.initState();
    loadAlarms();
    loadData();
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
  }

  void loadData() async {
    listEvent = await client.getEvent();
    for (var i=0; i<listEvent.length; i++) {
      final now = DateTime.now();
      if(!listEvent[i].startTime!.isBefore(DateTime.now())) {
        DateTime dateTime = DateTime(
          now.year,
          now.month,
          now.day,
          listEvent[i].startTime!.hour,
          listEvent[i].startTime!.minute,
          0,
          0,
        );
        if (dateTime.isBefore(DateTime.now())) {
          dateTime = dateTime.add(const Duration(days: 1));
        }
        final alarmSettings = AlarmSettings(
          id: i,
          dateTime: dateTime,
          loopAudio: true,
          vibrate: true,
          notificationTitle: listEvent[i].title,
          notificationBody: listEvent[i].description,
          assetAudioPath: 'assets/marimba.mp3',
          stopOnNotificationOpen: false,
        );
        print(alarmSettings);
        Alarm.stop(i);
        Alarm.set(alarmSettings: alarmSettings);
      } else {
        Alarm.stop(i);
      }
    }
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
      appBar: AppBar(title: const Text('Patient Screen')),
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
                            alreadySendToday: event[index].proofImageUrl != "" && event[index].proofImageUrl != null,
                            onPressed: () async {
                              try {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DisplayPictureScreen(id: event[index].id.toString()),
                                  ),
                                );
                              } catch (e) {
                                print(e);
                              }
                            },
                            isClicked: false,
                            onDismissed: () {
                              Alarm.stop(alarms[index].id).then((_) => loadAlarms());
                            },
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "Anda belum mengatur jadwal",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
              );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
                 
  }
}

class DisplayPictureScreen extends StatefulWidget {
  final String? id;
  const DisplayPictureScreen({Key? key, this.id}) : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  //final String? id;

  late String imagePath = "";
  late String imageUrl = "";
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool getPicture = true;
  XFile? image;
  bool _isLoading = false;

  List<CameraDescription>? cameras;
  CameraController? controller; 

  loadCamera() async {
    cameras = await availableCameras();
    if(cameras != null){
      controller = CameraController(cameras![0], ResolutionPreset.max);                    
      controller!.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
      });
    }else{
      print("NO any camera found");
    }
  }

  Future<void> _submitForm() async {
    var imageUrl;
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      try {
        imageUrl = await uploadImage();
      } catch (e) {
        print("Gagal mengunggah gambar");
        setState(() {
          _isLoading = false;
        });
      }
      print(imageUrl);
      ImageRequestBody requestBody = ImageRequestBody(
        imageUrl: imageUrl,
      );
      print(requestBody.imageUrl);
      final client = ProofImage();
      try {
        print("MARK");
        final response = await client.postProofImage(requestBody, widget.id!);
        print(response);
        await Fluttertoast.showToast(
          msg: "Berhasil mengunggah bukti!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
        Navigator.pop(context);
      } catch (e) {
        await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      }  finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  uploadImage() async {
    try {
      final _firebaseStorage = FirebaseStorage.instance;
      
      var uuid = Uuid();
      var file = File(imagePath);
      final ref = FirebaseStorage.instance.ref().child("file/" + uuid.v4());
      var uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = urlDownload;
      });
      print(urlDownload);
      return urlDownload;
    } catch (e) {
      print(e);
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (getPicture) Container(
            height:400,
            width:300,
            child: controller == null?
              Center(child:Text("Loading Camera...")):
                    !controller!.value.isInitialized?
                      Center(
                        child: CircularProgressIndicator(),
                      ):
                      CameraPreview(controller!)
          ),
          if (!getPicture) Container(
            height:400,
            width:300,
            child: Image.file(File(imagePath)),
          ),
          // Image.file(File(imagePath)),
          if (getPicture) ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorLayout.brBlue50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async{
                try {
                  if(controller != null){ //check if contrller is not null
                      if(controller!.value.isInitialized){ //check if controller is initialized
                          image = await controller!.takePicture(); //capture image
                          setState(() {
                            //update UI
                            getPicture = false;
                            imagePath = image!.path;
                          });
                      }
                  }
                } catch (e) {
                    print(e); //show error
                }
            },
            child: Text('Capture', style: TextLayout.title18.copyWith(color: ColorLayout.neutral5)),
          ),
          if (!getPicture) ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorLayout.brBlue50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: (){
              setState(() {
                imagePath = "";
                getPicture = true;
              });
            }, 
            child: Text('Ulangi', style: TextLayout.title18.copyWith(color: ColorLayout.neutral5)),
          ),
          if (!getPicture) ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorLayout.brBlue50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: _isLoading ? null : (){
              _submitForm();
              // uploadImage().then((_) => Navigator.pop(context));
            }, 
            child: _isLoading ?CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(ColorLayout.brBlue75),
                                ) : Text('Simpan', style: TextLayout.title18.copyWith(color: ColorLayout.neutral5)),
          ),
        ]
      )
      )
    );
  }

}