import 'package:safespace/components/my_button.dart';
import 'package:safespace/components/my_text_form_field.dart';
import 'package:safespace/services/auth.dart';
import 'package:safespace/shared/constants.dart';
import 'package:safespace/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({ super.key, required this.toggleView });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  // String name = '';
  // String email = '';
  // String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50.0,),
                  Icon(
                    Icons.message,
                    size: 100,
                    color: Colors.grey[800],
                  ),
                  SizedBox(height: 50.0,),
                  Text(
                    "Safe Space",
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  SizedBox(height: 25.0,),
                  MyTextFormField(
                    controller: nameController,
                    validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                    hintText: "Name",
                    obscureText: false
                  ),
                  SizedBox(height: 10.0,),
                  MyTextFormField(
                    controller: emailController,
                    validator: (value) => value!.isEmpty ? 'Enter an email' : null,
                    hintText: "Email",
                    obscureText: false
                  ),
                  SizedBox(height: 10.0,),
                  MyTextFormField(
                    controller: passwordController,
                    validator: (value) => value!.length < 6 ? 'Enter a password atleast 6 characters long' : null,
                    hintText: "Password",
                    obscureText: true
                  ),
                  SizedBox(height: 25.0,),
                  MyButton(onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      loading = true;
                      dynamic result = await _auth.registerWithEmailAndPassword(nameController.text, emailController.text, passwordController.text);
                      if (result == null) {
                        setState(() {
                          error = 'Please supply valid email';
                          loading = false;
                        });
                      }
                    }
                  }, text: "Register"),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already Registered?"),
                      SizedBox(width: 4,),
                      GestureDetector(
                        onTap: () {
                          widget.toggleView();
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12.0,),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // return loading ? Loading() : Scaffold(
    //   backgroundColor: Colors.brown[100],
    //   appBar: AppBar(
    //     backgroundColor: Colors.brown[400],
    //     elevation: 0.0,
    //     title: Text('Sign up'),
    //     actions: <Widget>[
    //       TextButton(
    //         child: Text(
    //           'Sign in',
    //           style: TextStyle(color: Colors.white),
    //           ),
    //         onPressed: () {
    //           widget.toggleView();
    //         },
    //       )
    //     ],
    //   ),
    //   body: Container(
    //     padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
    //     child: Form(
    //       key: _formKey,
    //       child: Column(
    //         children: <Widget>[
    //           SizedBox(height: 20.0,),
    //           TextFormField(
    //             decoration: textInputDecoration.copyWith(hintText: 'Name'),
    //             validator: (value) => value!.isEmpty ? 'Enter your name' : null,
    //             onChanged:(value) {
    //               setState(() {
    //                 name = value;
    //               });
    //             },
    //           ),
    //           SizedBox(height: 20.0,),
    //           TextFormField(
    //             decoration: textInputDecoration.copyWith(hintText: 'Email'),
    //             validator: (value) => value!.isEmpty ? 'Enter an email' : null,
    //             onChanged: (value) {
    //               setState(() {
    //                 email = value;
    //               });
    //             },
    //           ),
    //           SizedBox(height: 20.0,),
    //           TextFormField(
    //             decoration: textInputDecoration.copyWith(hintText: 'Password'),
    //             validator: (value) => value!.length < 6 ? 'Enter a password atleast 6 characters long' : null,
    //             obscureText: true,
    //             onChanged: (value) {
    //               setState(() {
    //                 password = value;
    //               });
    //             },
    //           ),
    //           SizedBox(height: 20.0,),
    //           ElevatedButton(
    //             style: ButtonStyle(
    //               backgroundColor: MaterialStateProperty.all(Colors.pink[400])
    //             ),
    //             child: Text(
    //               'Register',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             onPressed: () async {
    //               if (_formKey.currentState!.validate()) {
    //                 loading = true;
    //                 dynamic result = await _auth.registerWithEmailAndPassword(name, email, password);
    //                 if (result == null) {
    //                   setState(() {
    //                     error = 'Please supply valid email';
    //                     loading = false;
    //                   });
    //                 }
    //               }
    //             },
    //           ),
    //           SizedBox(height: 12.0,),
    //           Text(
    //             error,
    //             style: TextStyle(
    //               color: Colors.red,
    //               fontSize: 14.0
    //             ),
    //           )
    //         ],
    //       ),
    //     )
    //   ),
    // );
  }
}