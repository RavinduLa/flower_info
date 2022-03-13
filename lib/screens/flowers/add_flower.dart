import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_info/api/firebase_api.dart';
import 'package:flower_info/models/flower_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddFlower extends StatefulWidget {
  const AddFlower({Key? key}) : super(key: key);
  static String routeName = "/admin/flowers/add-flower";

  @override
  _AddFlowerState createState() => _AddFlowerState();
}

class _AddFlowerState extends State<AddFlower> {
  final _formKey = GlobalKey<FormState>();
  final _controllerCommonName = TextEditingController();
  final _controllerScientificName = TextEditingController();
  final _controllerMatureSize = TextEditingController();
  final _controllerNativeRegion = TextEditingController();
  final _tempImageLink =
      "https://firebasestorage.googleapis.com/v0/b/flower-info.appspot.com/o/flower_images%2Flotus.jpg?alt=media&token=62c2e541-b42c-4d6a-8681-c3d67d41ea4c";
  String imageLink = "";
  String commonName = "";
  String scientificName = "";
  String matureSize = "";
  String nativeRegion = "";


  UploadTask? task;
  File? image;

  @override
  Widget build(BuildContext context) {
    final imageName =
        image != null ? basename(image!.path) : 'No image selected';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a flower'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                image != null
                    ? Image.file(
                        image!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      )
                    : const Expanded(
                        child: FlutterLogo(
                          size: 160,
                        ),
                      ),
                ElevatedButton(
                  onPressed: () => pickImage(ImageSource.gallery),
                  child: Text("Select Image"),
                ),
                ElevatedButton(
                  onPressed: () => pickImage(ImageSource.camera),
                  child: Text("Capture Image"),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _controllerCommonName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill this field';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'Common Name'),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _controllerScientificName,
                    decoration:
                        const InputDecoration(hintText: 'Scientific Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill this field';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _controllerMatureSize,
                    decoration: const InputDecoration(hintText: 'Mature Size'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill this field';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _controllerNativeRegion,
                    decoration:
                        const InputDecoration(hintText: 'Native Region'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill this field';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Flower flower = Flower(
                          commonName: _controllerCommonName.text,
                          scientificName: _controllerScientificName.text,
                          matureSize: _controllerMatureSize.text,
                          nativeRegion: _controllerNativeRegion.text,
                          imageLink: imageLink.isNotEmpty
                              ? imageLink
                              : _tempImageLink);

                      commonName = _controllerCommonName.text;
                      scientificName = _controllerScientificName.text;
                      matureSize = _controllerMatureSize.text;
                      nativeRegion = _controllerNativeRegion.text;

                      Future<DocumentReference> result = enterFlowerEntry();

                      print(result);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                        ),
                      );

                      _controllerCommonName.clear();
                      _controllerScientificName.clear();
                      _controllerMatureSize.clear();
                      _controllerNativeRegion.clear();

                      result.whenComplete(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Done'),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Add Flower'),
                )
              ],
            )),
      ),
    );
  }

  Future<DocumentReference> enterFlowerEntry() async {
    Flower flower = Flower(
        commonName: commonName,
        scientificName: scientificName,
        matureSize: matureSize,
        nativeRegion: nativeRegion,
        imageLink: imageLink.isNotEmpty ? imageLink : _tempImageLink);
    String newId = "";


    DocumentReference entryCreateResult = await addFlower(flower).then((value) {
      newId = value.id;
      return value;
    });
    await uploadImage(newId);
    return entryCreateResult;
  }

  Future<DocumentReference> addFlower(Flower flower) {
    return FirebaseApi.addFlower(flower);
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image : $e');
      }
    }
  }

  Future uploadImage(String id) async {
    if (image == null) return;
    //final imageName = basename(image!.path);
    print("new id : $id");
    final destination = 'flower_images/$id';

    task = FirebaseApi.uploadFile(destination, image!);
    setState(() {});
    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      imageLink = urlDownload;
    });
    print('Download Link : $urlDownload');
    print('Image Link : $imageLink');
  }
}
