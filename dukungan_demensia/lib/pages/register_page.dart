// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dukungan_demensia/widgets/layout/text_layout.dart';
import 'package:flutter/material.dart';

import '../widgets/layout/colors_layout.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _roleController = TextEditingController();
  final _caregiverIdController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _roleController.dispose();
    _caregiverIdController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      final name = _nameController.text;
      final email = _emailController.text;
      final phoneNumber = _phoneNumberController.text;
      final role = _roleController.text;
      final caregiverId = _caregiverIdController.text;
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
                        Text('Name', style: TextLayout.title18),
                        SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Your name',
                              border: InputBorder.none,
                              hintStyle: TextLayout.body14,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16)
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Text('Username', style: TextLayout.title18),
                        SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: _usernameController,
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
                        Text('Phone Number', style: TextLayout.title18),
                        SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              hintText: 'Your phone number',
                              border: InputBorder.none,
                              hintStyle: TextLayout.body14,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16)
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'Please enter a valid phone number';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Text('Email', style: TextLayout.title18),
                        SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Your email',
                              border: InputBorder.none,
                              hintStyle: TextLayout.body14,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16)
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
                                return 'Please enter a valid email';
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
                            controller: _passwordController,
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
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            value: _roleController.text,
                            hint: Text('Role', style: TextLayout.body14,),
                            items: [
                              DropdownMenuItem(
                                child: Text('Caregiver', style: TextLayout.body14,),
                                value: 'caregiver',
                              ),
                              DropdownMenuItem(
                                child: Text('Patient', style: TextLayout.body14,),
                                value: 'patient',
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _roleController.text = value.toString();
                              });
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
                    onPressed: (){
                      _submitForm();
                    }, 
                    child: Text('REGISTER', style: TextLayout.title18,),
                  ),
                ),
                Row(
                  children: [
                    Text('Sudah memiliki akun?', style: TextLayout.body14,),
                    Text(' Login', style: TextLayout.body14)
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