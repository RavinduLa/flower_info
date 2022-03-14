import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
      "https://firebasestorage.googleapis.com/v0/b/flower-info.appspot.com/o/flower_images%2Fflower-info-logo.png?alt=media&token=d71b12b9-4d82-4f94-86d4-15ba7d6943fe";
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  image != null
                      ? Image.file(
                          image!,
                          width: 160,
                          height: 160,
                          fit: BoxFit.cover,
                        )
                      : const FlutterLogo(
                          size: 160,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, bottom: 20, top: 10),
                        child: IconButton(
                          icon: const Icon(
                            Icons.folder,
                            size: 50,
                            color: Colors.green,
                          ),
                          onPressed: () => pickImage(ImageSource.gallery),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 20, top: 10),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 50,
                            color: Colors.green,
                          ),
                          onPressed: () => pickImage(ImageSource.camera),
                        ),
                      ),
                    ],
                  ),
                  /*ElevatedButton(
                    onPressed: () => pickImage(ImageSource.gallery),
                    child: Text("Select Image"),
                  ),
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.camera),
                    child: Text("Capture Image"),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _controllerCommonName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill this field';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Common Name',
                        focusColor: Colors.green,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _controllerScientificName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill this field';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Scientific Name',
                        focusColor: Colors.green,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _controllerMatureSize,
                      decoration: const InputDecoration(
                        labelText: 'Mature Size',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill this field';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _controllerNativeRegion,
                      decoration: const InputDecoration(
                        labelText: 'Native Region',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill this field';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 2.0, right: 2.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (image != null) {
                            if (_formKey.currentState!.validate()) {
                              commonName = _controllerCommonName.text;
                              scientificName = _controllerScientificName.text;
                              matureSize = _controllerMatureSize.text;
                              nativeRegion = _controllerNativeRegion.text;

                              Future<DocumentReference> result =
                                  enterFlowerEntry();

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
                                () =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Done'),
                                  ),
                                ),
                              );
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("No Image found"),
                                    content: const Text(
                                        "Please select an image or capture a photograph"),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Ok"),
                                      )
                                    ],
                                  );
                                });
                          }
                        },
                        child: const Text('Add Flower'),
                      ),
                    ),
                  )
                ],
              ),
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

    if (image != null) {
      await uploadImage(newId);
      updateImageLink(newId, imageLink);
    }

    return entryCreateResult;
  }

  void updateImageLink(String id, String link) {
    FirebaseApi.updateFlowerImageLink(id, link);
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
