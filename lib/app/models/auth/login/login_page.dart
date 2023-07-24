import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/models/auth/login/login_controller.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({ super.key });

   @override
   Widget build(BuildContext context) {
        Provider.of<LoginController>(context);
       return Scaffold(
           appBar: AppBar(title: const Text('Login Page'),),
           body: Container(),
       );
  }
}