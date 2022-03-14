import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_info/api/firebase_api.dart';
import 'package:flower_info/models/flower_admin_single_view_arguments.dart';
import 'package:flower_info/models/flower_model_with_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditFlower extends StatefulWidget {
  const EditFlower({
    Key? key,
  }) : super(key: key);
  static String routeName = "/admin/flowers/edit-flower";

  @override
  _EditFlowerState createState() => _EditFlowerState();
}

class _EditFlowerState extends State<EditFlower> {
  final _formKey = GlobalKey<FormState>();
  final _controllerCommonName = TextEditingController();
  final _controllerScientificName = TextEditingController();
  final _controllerMatureSize = TextEditingController();
  final _controllerNativeRegion = TextEditingController();
  final _tempImageLink =
      "https://firebasestorage.googleapis.com/v0/b/flower-info.appspot.com/o/flower_images%2Flotus.jpg?alt=media&token=62c2e541-b42c-4d6a-8681-c3d67d41ea4c";

  String _imageLink = "";

  UploadTask? task;
  File? image;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as FlowerAdminSingleViewArguments;
    _controllerCommonName.text = args.flowerWithId.commonName;
    _controllerScientificName.text = args.flowerWithId.scientificName;
    _controllerMatureSize.text = args.flowerWithId.matureSize;
    _controllerNativeRegion.text = args.flowerWithId.nativeRegion;
    _imageLink = args.flowerWithId.imageLink;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Flower"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
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
                    : _imageLink.isNotEmpty
                        ? SizedBox(
                            height: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                _imageLink,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : const FlutterLogo(
                            size: 160,
                          ),
                ElevatedButton(
                  onPressed: () => pickImage(ImageSource.gallery),
                  child: Text("Select Image"),
                ),
                ElevatedButton(
                  onPressed: () => pickImage(ImageSource.camera),
                  child: Text("Capture Image"),
                ),
                TextFormField(
                  controller: _controllerCommonName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Common Name',
                  ),
                ),
                TextFormField(
                  controller: _controllerScientificName,
                  decoration: const InputDecoration(
                    labelText: 'Scientific Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerMatureSize,
                  decoration: const InputDecoration(
                    labelText: 'Mature Size',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerNativeRegion,
                  decoration: const InputDecoration(
                    labelText: 'Native Region',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FlowerWithId flowerWithId = FlowerWithId(
                          documentId: args.flowerWithId.documentId,
                          commonName: _controllerCommonName.text,
                          scientificName: _controllerScientificName.text,
                          matureSize: _controllerMatureSize.text,
                          nativeRegion: _controllerNativeRegion.text,
                          imageLink: args.flowerWithId.imageLink);

                      Future<void> result = editFlower(flowerWithId);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                        ),
                      );

                      result.whenComplete(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Done'),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Update details'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> editFlower(FlowerWithId flowerWithId) {
    return FirebaseApi.editFlower(flowerWithId, image);
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
}
