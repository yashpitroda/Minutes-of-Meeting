import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minuteofmeeting/models/url.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _storedataforsignup(
    String userIdByFirebase,
    String email,
    String mobileno,
    String username,
    String role,
    String password,
  ) async {
    // print("abc");
    // final response = await http.post(Uri.parse(urlGetter.signupUrl),
    //     headers: {"Content-Type": "application/json"},
    //     body: jsonEncode({
    // 'useridbyfirebase': userIdByFirebase,
    // 'emailid': email,
    // 'mobileno': mobileno,
    // 'username': username,
    // 'role': role,
    // 'password': password
    //     }));
    FirebaseFirestore.instance.collection('users').doc(userIdByFirebase).set({
      'useridbyfirebase': userIdByFirebase,
      'emailid': email,
      'mobileno': mobileno,
      'username': username,
      'role': role,
      'password': password
    });
    // print('pqw');
  }

  void _submitAuthform(String email, String mobileno, String username,
      String role, String password, bool isSignIn) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (isSignIn) {
        //do signin or login
        final authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        //complete login or signin
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   duration: Duration(seconds: 2),
        //   content: Text(
        //     'SignIn sucessfull.',
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   backgroundColor: Theme.of(context).backgroundColor,
        // ));
      } else {
        //do signup
        final authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final userByFirebase = authResult.user!;

        await _storedataforsignup(userByFirebase.uid,
            userByFirebase.email as String, mobileno, username, role, password);
        //when user signup do then
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   duration: Duration(seconds: 2),
        //   content: const Text(
        //     'SignUp completed',
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   backgroundColor: Theme.of(context).backgroundColor,
        // ));
      }

      // setState(() {
      //   _isLoading = false;
      // });
    } on PlatformException catch (e) {
      print(e);
      var masage = "Authentication failed... \n" + e.message.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(masage),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      var masage = "Authentication aa failed... \n" + err.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(masage),
        backgroundColor: Theme.of(context).errorColor,
      ));
      // // throw err;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: AuthForm(
          submitdata: _submitAuthform,
          isloading: _isLoading,
        ),
      ),
    );
  }
}
