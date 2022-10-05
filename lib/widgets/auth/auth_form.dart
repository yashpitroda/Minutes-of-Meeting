import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AuthMode { Signup, Signin }

class AuthForm extends StatefulWidget {
  final Function submitdata;
  final isloading;
  const AuthForm(
      {super.key, required this.submitdata, required this.isloading});
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.Signin;

  String _userEmail = '';
  String _userpassword = '';
  String _username = '';
  String _usermobilenumber = '';
  String _userrole = '';

  bool _isSignIn = false;

  @override
  void dispose() {
    super.dispose();
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Signin) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      //we move to login page to signup page
      // _animationController!.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Signin;
      });
      // _animationController!.reverse();
    }
  }

  void _showErrorDialog(String masage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("an error occur"),
              content: Text(masage),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("okey"))
              ],
            ));
  }

  void _trySave() {
    _isSignIn = (_authMode == AuthMode.Signin);
    final isvalid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isvalid) {
      _formkey.currentState!.save();

      widget.submitdata(
        _userEmail.trim(),
        _usermobilenumber.trim(),
        _username.trim(),
        _userrole.trim(),
        _userpassword.trim(),
        _isSignIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryhelp = MediaQuery.of(context).size;
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        height: _authMode == AuthMode.Signup
            ? MediaQueryhelp.height * 0.51
            : MediaQueryhelp.height * 0.3,
        child: Card(
            child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('emailKey'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Adress'),
                    onSaved: (newValue) {
                      _userEmail = newValue!;
                    },
                  ),
                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                      key: ValueKey('mobileNoKey'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter a valid mobile number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'mobile number'),
                      onSaved: (newValue) {
                        _usermobilenumber = newValue!;
                      },
                    ),
                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                      key: ValueKey('nameKey'),
                      onSaved: (newValue) {
                        _username = newValue!;
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'username is too short';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                      key: ValueKey('roleKey'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter a valid role';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'role'),
                      onSaved: (newValue) {
                        _userrole = newValue!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('passwdkey'),
                    onSaved: (newValue) {
                      _userpassword = newValue!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'password must be atlist 7 character more!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true, //hide pass
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isloading) CircularProgressIndicator(),
                  if (!widget.isloading)
                    ElevatedButton(
                      onPressed: _trySave,
                      child: Text(
                          (_authMode == AuthMode.Signin ? 'Signin' : "Signup")),
                    ),
                  if (!widget.isloading)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_authMode == AuthMode.Signin
                            ? 'Create an account! '
                            : "Already have an account! "),
                        TextButton(
                          onPressed: _switchAuthMode,
                          child: Text(_authMode == AuthMode.Signin
                              ? 'Signup'
                              : "Signin"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
