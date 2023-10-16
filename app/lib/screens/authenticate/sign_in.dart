import 'package:flutter/material.dart';
import 'package:safespace/components/my_button.dart';
import 'package:safespace/components/my_text_form_field.dart';
import 'package:safespace/services/auth.dart';
import 'package:safespace/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // String email = '';
  // String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                      SizedBox(
                        height: 50.0,
                      ),
                      Icon(
                        Icons.message,
                        size: 100,
                        color: Colors.grey[800],
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        "Safe Space",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      MyTextFormField(
                          controller: emailController,
                          validator: (value) =>
                              value!.isEmpty ? 'Enter an email' : null,
                          hintText: "Email",
                          obscureText: false),
                      SizedBox(
                        height: 10.0,
                      ),
                      MyTextFormField(
                          controller: passwordController,
                          validator: (value) => value!.length < 6
                              ? 'Enter a password atleast 6 characters long'
                              : null,
                          hintText: "Password",
                          obscureText: true),
                      SizedBox(
                        height: 25.0,
                      ),
                      MyButton(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.signInWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text);
                              if (result == null) {
                                setState(() {
                                  error = "Error";
                                  loading = false;
                                });
                              }
                            }
                          },
                          text: "Sign in"),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("New to Safe Space?"),
                          SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
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
    //     title: Text('Sign in'),
    //     actions: <Widget>[
    //       TextButton(
    //         child: Text(
    //           'Register',
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
    //               'Sign in',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             onPressed: () async {
    //               if (_formKey.currentState!.validate()) {
    //                 setState(() {
    //                   loading = true;
    //                 });
    //                 dynamic result = await _auth.signInWithEmailAndPassword(email, password);
    //                 if (result == null) {
    //                   setState(() {
    //                     error = 'Could not sign in with those credentials';
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
