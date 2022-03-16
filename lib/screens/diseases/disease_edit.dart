import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_info/api/disease_api.dart';
import 'package:flower_info/models/disease_model_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class DiseaseEdit extends StatefulWidget {
  const DiseaseEdit({Key? key}) : super(key: key);

  static String routeName = "/admin/disease/disease-edit";

  @override
  State<DiseaseEdit> createState() => _DiseaseEditState();
}

class _DiseaseEditState extends State<DiseaseEdit> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _look = TextEditingController();
  final _cause = TextEditingController();
  final _treat = TextEditingController();
  final _prevent = TextEditingController();

  String _imageLink = "";
  UploadTask? task;
  File? image;

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as DiseaseSingleView;
    _name.text = data.disease.name;
    _look.text = data.disease.look;
    _cause.text = data.disease.cause;
    _treat.text = data.disease.treat;
    _prevent.text = data.disease.prevent;
    _imageLink = data.disease.image;

    void processingData() async {
      _notification('Processing Data');

      if (_formKey.currentState!.validate()) {
        DiseaseWithId disease = DiseaseWithId(
            documentId: data.disease.documentId,
            name: _name.text,
            look: _look.text,
            cause: _cause.text,
            treat: _treat.text,
            prevent: _prevent.text,
            image: _imageLink);
        Future<void> result = _updateDisease(disease);

        if(image != null) {
          await uploadImage(data.disease.documentId);
          updateImageUrl(data.disease.documentId, _imageLink);
          if (kDebugMode) {
            print("Image Uploading Processed!");
          }
        }

        if (kDebugMode) {
          print(result);
        }
        _notification('Done!');
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Disease Update"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image != null
                        ? Image.file(
                            image!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : _imageLink.isNotEmpty
                            ? SizedBox(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    imageUrl: data.disease.image,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.green),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              )
                            : Image.asset(
                                'assets/images/flower-info-logo.png',
                                height: 150,
                                width: 150,
                              ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Colors.green,
                          ),
                          onPressed: () => selectImage(ImageSource.camera),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.folder,
                            size: 30,
                            color: Colors.green,
                          ),
                          onPressed: () => selectImage(ImageSource.gallery),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)),
                    helperText: ' ',
                    labelText: 'Name of Diseases/Pests',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _name,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)),
                    helperText: ' ',
                    labelText: 'What Does it Look Like?',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _look,
                  minLines: 1,
                  maxLines: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)),
                    helperText: ' ',
                    labelText: 'What Causes it?',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _cause,
                  minLines: 1,
                  maxLines: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)),
                    helperText: ' ',
                    labelText: 'How to Treat it?',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _treat,
                  minLines: 1,
                  maxLines: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)),
                    helperText: ' ',
                    labelText: 'How to Prevent it?',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _prevent,
                  minLines: 1,
                  maxLines: 10,
                ),
                ElevatedButton(
                  onPressed: processingData,
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Image Selector Method
  Future selectImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 10);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (error) {
      if (kDebugMode) {
        print('Failed to select image : $error');
      }
    }
  }

  // Image Uploading Process
  Future uploadImage(String newId) async {
    if (image == null) return;
    task = DiseaseApi.uploadImage(newId, image!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      _imageLink = urlDownload;
    });

    if (kDebugMode) {
      print('Image Link : $_imageLink');
    }
  }

  // CRUD : Update Method Caller
  Future<void> _updateDisease(DiseaseWithId disease) async {
    await DiseaseApi.updateDisease(disease);
  }

  // CRUD : Update Image URL Method Caller
  void updateImageUrl(String documentId, String link) {
    DiseaseApi.updateImageLink(documentId, link);
  }

  // Common Notification
  void _notification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
