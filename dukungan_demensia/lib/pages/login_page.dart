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

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      final username = _usernameController.text;
      final password = _passwordController.text;
      // Call API, perform authentication, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('DementiaCare', style: TextLayout.display36),
                    SizedBox(height: 12),
                    Text('An app for protecting and keeping your beloved ones around', style: TextLayout.body16, textAlign: TextAlign.center,),
                    SizedBox(height: 68),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Username', style: TextLayout.title18),
                        SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Your username',
                              border: InputBorder.none,
                              hintStyle: TextLayout.body14,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16)
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid username';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Text('Password', style: TextLayout.title18),
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
                              suffixIcon: Icon(Icons.visibility_off),
                            ),
                            validator:(value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid password';
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
                      backgroundColor: ColorLayout.brBlue75,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: (){}, 
                    child: Text('LOGIN', style: TextLayout.title18,),
                  ),
                ),
                Row(
                  children: [
                    Text('Tidak memiliki akun?', style: TextLayout.body14,),
                    Text(' Register', style: TextLayout.body14)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}