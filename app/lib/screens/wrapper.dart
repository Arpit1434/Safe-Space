import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safespace/models/safespace_user.dart';
import 'package:safespace/screens/authenticate/authenticate.dart';
import 'package:safespace/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<SafeSpaceUser?>(context);

    if (user == null) {
      return Authenticate();
    }

    return Home();
  }
}