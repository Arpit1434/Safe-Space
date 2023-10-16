import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:safespace/screens/wrapper.dart';
import 'package:safespace/services/auth.dart';
import 'package:safespace/shared/loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Text('Some error has occured'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider.value(
            initialData: null,
            value: AuthService().user,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Wrapper(),
            ),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Loading(),
        );
      },
    );
  }
}