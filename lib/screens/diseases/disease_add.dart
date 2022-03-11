import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_info/api/disease_api.dart';
import 'package:flower_info/models/disease_model.dart';

class DiseaseAdd extends StatefulWidget {
  const DiseaseAdd({Key? key}) : super(key: key);

  static String routeName = "/admin/disease/disease-add";

  @override
  State<DiseaseAdd> createState() => _DiseaseAddState();
}

class _DiseaseAddState extends State<DiseaseAdd> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _look = TextEditingController();
  final _cause = TextEditingController();
  final _treat = TextEditingController();
  final _prevent = TextEditingController();
  final _imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flower-info.appspot.com/o/disease_images%2Fdisease1.jpg?alt=media&token=1ed7ed0f-d257-474d-a42d-dcdf7a83dc8b";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Diseases Create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
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
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void processingData() {
    if (_formKey.currentState!.validate()) {
      Disease disease = Disease(
          name: _name.text,
          look: _look.text,
          cause: _cause.text,
          treat: _treat.text,
          prevent: _prevent.text,
          image: _imageUrl);

      Future<DocumentReference> res = _createDisease(disease);
      print(res);
      _notification('Processing Data');
      _clearFields();
      _notification('Done!');
    }
  }

  // CRUD : Create Method Caller
  Future<DocumentReference> _createDisease(Disease disease) {
    return DiseaseApi.addDisease(disease);
  }

  // Common Notification
  void _notification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // Clear Form Fields
  void _clearFields() {
    _name.clear();
    _look.clear();
    _cause.clear();
    _treat.clear();
    _prevent.clear();
  }
}
