import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_info/api/disease_api.dart';
import 'package:flower_info/models/disease_model_id.dart';
import 'package:flutter/material.dart';

import '../../models/disease_model.dart';

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
  final _image =
      "https://firebasestorage.googleapis.com/v0/b/flower-info.appspot.com/o/disease_images%2Fdisease1.jpg?alt=media&token=1ed7ed0f-d257-474d-a42d-dcdf7a83dc8b";

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as DiseaseSingleView;
    _name.text = data.disease.name;
    _look.text = data.disease.look;
    _cause.text = data.disease.cause;
    _treat.text = data.disease.treat;
    _prevent.text = data.disease.prevent;

    void processingData() {
      _notification('Processing Data');

      if (_formKey.currentState!.validate()) {
        DiseaseWithId disease = DiseaseWithId(
            documentId: data.disease.documentId,
            name: _name.text,
            look: _look.text,
            cause: _cause.text,
            treat: _treat.text,
            prevent: _prevent.text,
            image: _image);
        Future<void> result = _updateDisease(disease);
        print(result);
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

  // CRUD : Update Method Caller
  Future<void> _updateDisease(DiseaseWithId disease) async {
    DiseaseApi.updateDisease(disease);
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
