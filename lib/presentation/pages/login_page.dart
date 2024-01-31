import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mini_project_bsi_chat/domain/usecases/auth_users.dart';
import 'package:mini_project_bsi_chat/presentation/pages/home_page.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  late var box;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();

  LoginPage() {
    box = Hive.box('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // BSI logo
        Image.asset(
          'images/logo-bsi.png',
          width: 300,
        ),

        SizedBox(height: 20),

        // Welcome text
        Text(
          'Welcome to BSI Chat Application',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Please login to with your username',
        ),

        SizedBox(height: 20),

        // Username field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                hintText: 'Please input your registered username',
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Username cannot be empty' : null,
            ),
          ),
        ),

        SizedBox(height: 20),

        // Login button
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (await AuthUser().execute(_usernameController.text)) {
                box.put('isLogin', true);
                box.put('username', _usernameController.text);

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Login Success')));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Username is not registered')));
              }
            }
          },
          child: Text('Login'),
        )
      ],
    ));
  }
}
