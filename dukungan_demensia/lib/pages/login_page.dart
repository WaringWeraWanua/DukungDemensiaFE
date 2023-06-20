// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dukungan_demensia/widgets/layout/text_layout.dart';
import 'package:flutter/material.dart';

import '../widgets/layout/colors_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      // Call API, perform authentication, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text('DementiaCare', style: TextLayout.display42.copyWith(color: ColorLayout.brBlue50)),
                        SizedBox(height: 12),
                        Text('An app for protecting and keeping your beloved ones around', style: TextLayout.body16.copyWith(color: ColorLayout.black4), textAlign: TextAlign.center,),
                        SizedBox(height: 60),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Username', style: TextLayout.title18.copyWith(color: ColorLayout.black4)),
                            SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Silahkan isi username Anda',
                                  border: InputBorder.none,
                                  hintStyle: TextLayout.body16,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16)
                                ),
                                style: TextLayout.body16,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Mohon isi username yang valid!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 16),
                            Text('Password', style: TextLayout.title18.copyWith(color: ColorLayout.black4)),
                            SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                        color: ColorLayout.black4,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                style: TextLayout.body16,
                                obscureText: !_passwordVisible,
                                validator:(value) {
                                  if (value!.isEmpty) {
                                    return 'Mohon isi password yang valid!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 32,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorLayout.brBlue50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: (){}, 
                        child: Text('LOGIN', style: TextLayout.title18.copyWith(color: ColorLayout.neutral5)),
                      ),
                    ),
                    SizedBox(height: 32,),
                    Row(
                      children: [
                        Text('Tidak memiliki akun?', style: TextLayout.body16,),
                        Text(' Register', style: TextLayout.body16.copyWith(color: ColorLayout.brBlue75)) // perlu diganti ke navigate
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}