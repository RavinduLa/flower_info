import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flower_info/api/firebase_api.dart';
import 'package:flower_info/models/flower_model.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
                          imageLink: _tempImageLink);

                      /*print('flower details');
                      print('Com Name : ' + flower.commonName);
                      print('Scie Name : ' + flower.scientificName);
                      print('Mature Size : ' + flower.matureSize);
                      print('Nat Region : ' + flower.nativeRegion);
                      print('Image Link : ' + flower.imageLink);*/

                      Future<DocumentReference> result = addFlower(flower);

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

  Future<DocumentReference> addFlower(Flower flower) {
    return FirebaseApi.addFlower(flower);
  }
}
