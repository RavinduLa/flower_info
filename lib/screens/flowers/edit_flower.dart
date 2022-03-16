import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
                              child: CachedNetworkImage(
                                imageUrl: args.flowerWithId.imageLink,
                                height: 160,
                                width: 160,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                ),
                                errorWidget: (context, url ,error) => const Icon(Icons.error, size: 50,),
                              ),
                            ),
                          )
                        : Image.asset(
                            'assets/images/flower-info-logo.png',
                            height: 160,
                            width: 160,
                          ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 30, bottom: 20, top: 10),
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
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
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
                    decoration: const InputDecoration(
                      labelText: 'Scientific Name',
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
                      child: const Text('Save Changes'),
                    ),
                  ),
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
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 10);
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
