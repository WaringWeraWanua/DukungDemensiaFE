import 'dart:async';
import 'dart:io';
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

class PatientAlarmScreen extends StatefulWidget {
  const PatientAlarmScreen({Key? key}) : super(key: key);

  @override
  State<PatientAlarmScreen> createState() => _PatientAlarmScreenState();
}

class _PatientAlarmScreenState extends State<PatientAlarmScreen> {
  late List<AlarmSettings> alarms;

  static StreamSubscription? subscription;

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

  Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
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
      body: SafeArea(
        child: alarms.isNotEmpty
            ? ListView.separated(
                itemCount: alarms.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ExampleAlarmTile(
                    key: Key(alarms[index].id.toString()),
                    time: TimeOfDay(
                      hour: alarms[index].dateTime.hour,
                      minute: alarms[index].dateTime.minute,
                    ).format(context),
                    title: alarms[index].notificationTitle!,
                    onPressed: () async {
                      try {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(),
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

class DisplayPictureScreen extends StatefulWidget {
  const DisplayPictureScreen({Key? key}) : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late String imagePath = "";
  late String imageUrl = "";
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool getPicture = true;
  XFile? image;

  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera

    loadCamera() async {
      cameras = await availableCameras();
      if(cameras != null){
        controller = CameraController(cameras![0], ResolutionPreset.max);
                    //cameras[0] = first camera, change to 1 to another camera
                    
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

  @override
  void initState() {
    loadCamera();
    super.initState();
/*     _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize(); */
  }

  uploadImage() async {
    try {
      final _firebaseStorage = FirebaseStorage.instance;
      
      var uuid = Uuid();
      var file = File(imagePath);
      final ref = FirebaseStorage.instance.ref().child("file/" + uuid.v4());
      var uploadTask = ref.putFile(file);
      final snapshot = await uploadTask!.whenComplete(() => {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = urlDownload;
      });
      print("HASIL DOWNLOAD: ");
      print(urlDownload);
      print("==================================");
    } catch (e) {
      print("MARKKK");
      print(e);
      print("MARKKK");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          if (getPicture) Container(
            height:400,
            width:400,
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
            width:400,
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
            onPressed: (){
              uploadImage().then((_) => Navigator.pop(context));
            }, 
            child: Text('Simpan', style: TextLayout.title18.copyWith(color: ColorLayout.neutral5)),
          ),
        ]
      )
    );
  }

}