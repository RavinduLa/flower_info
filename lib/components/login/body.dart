import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_info/screens/admin/admin_dashboard.dart';
import 'package:flower_info/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isObscurePassword = true;

  final Map<String, String> _authData = {
    'email' : '',
    'password': ''
  };

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error !'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(msg),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Try again', style: TextStyle(color: Colors.green),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _onSubmit() async {
    if(!_formKey.currentState!.validate())
    {
      return;
    }
    _formKey.currentState!.save();
    String email = _authData['email'].toString();
    String password = _authData['password'].toString();

    try {
      print("------------- SIGN IN ---------------  ");
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('email', email);

      Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AdminDashboard(),
              ),
            );

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => AdminDashboard(),
      //   ),
      //       (route) => Home(),
      // );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showErrorDialog("Your email is wrong");
      } else if (e.code == 'wrong-password') {
        _showErrorDialog("Your password is wrong");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final ValueChanged<String> onChanged;
    IconData icon;

    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.28),
                const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 40,fontWeight: FontWeight.w700),
                ),
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.only(left: 38, top: 0, right: 38),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                        child: Theme(
                            data: ThemeData(
                              disabledColor: Colors.white,
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.email, color: Colors.green),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      color: Colors.green
                                  )
                              ),
                              validator: (value) {
                                if(value!.isEmpty)
                                {
                                  return 'Invalid email!';
                                }
                                if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please enter a valid email");
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value)
                              {
                                _authData['email'] = value!;
                                //emailController.text = value!;
                              },
                            )
                        ),
                      )
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.only(left: 38, top: 0, right: 38),
                  child: Stack(
                    alignment: const Alignment(0, 0),
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 0),
                            child: Theme(
                              data: ThemeData(
                                disabledColor: Colors.white,
                              ),
                            child: TextFormField(
                              obscureText: true ? isObscurePassword : false,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.lock, color: Colors.green,),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Colors.green
                                ),
                              ),
                              validator: (value)
                              {
                                if(value!.isEmpty || value.length<=2)
                                {
                                  return 'Invalid password!';
                                }
                                return null;
                              },
                              onSaved: (value)
                              {
                                _authData['password'] = value!;
                                //passwordController.text = value!;
                              },
                            ),
                          ),
                          )
                      ),
                      Positioned(
                        right: 15,
                        child: IconButton(
                            icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
                            onPressed: (){
                              setState(() {
                                isObscurePassword = !isObscurePassword;
                              });
                            }
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Padding(
                    padding: const EdgeInsets.only(left: 25, top: 0, right: 25),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                        child: RaisedButton(
                          color: Colors.green,
                          splashColor: Colors.white,
                          onPressed: () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a Snackbar.
                              _onSubmit();
                              Scaffold.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Checking Credentials!',textAlign: TextAlign.center,),
                                    backgroundColor: Colors.grey,
                                  )
                              );
                            }
                          },
                          child: const Text(
                            'SIGN IN',
                            style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.w700),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(color: Colors.white)
                          ),
                        ),
                      ),
                    )
                ),
                SizedBox(height: size.height * 0.015),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


