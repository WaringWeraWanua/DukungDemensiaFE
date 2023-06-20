// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dukungan_demensia/models/auth_models.dart';
import 'package:dukungan_demensia/widgets/layout/text_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  final _caregiverUsernameController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _roleController.dispose();
    _caregiverUsernameController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      final name = _nameController.text;
      final email = _emailController.text;
      final phoneNumber = _phoneNumberController.text;
      final role = _roleController.text;
      final caregiverUsername = _caregiverUsernameController.text;
      final username = _usernameController.text;
      final password = _passwordController.text;
      print('Name: $name');
      print('Email: $email');
      print('Phone Number: $phoneNumber');
      print('Role: $role');
      print('Caregiver ID: $caregiverUsername');
      print('Username: $username');
      print('Password: $password');

      final requestBody = RegisterRequestBody(
        username: username,
        password: password,
        email: email,
        name: name,
        role: role,
        phoneNumber: phoneNumber,
        caregiverUsername: caregiverUsername.isNotEmpty ? caregiverUsername : null,
      );

      const url = 'https://localhost:3000/register'; // Replace with your API endpoint
      const headers = {'Content-Type': 'application/json'};

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(requestBody.toJson()),
        );

        // Handle the response here
        if (response.statusCode == 200) {
          // Registration successful
          // Handle success case
        } else {
          // Registration failed
          // Handle error case
        }
      } catch (e) {
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 32, vertical: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('DementiaCare', style: TextLayout.display42.copyWith(color: ColorLayout.brBlue50)),
                        SizedBox(height: 10),
                        Text('An app for protecting and keeping your beloved ones around', style: TextLayout.body16.copyWith(color: ColorLayout.black4), textAlign: TextAlign.center,),
                        SizedBox(height: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Nama', style: TextLayout.title18),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: 'Silahkan isi nama Anda',
                                  border: InputBorder.none,
                                  hintStyle: TextLayout.body16,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16)
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Mohon isi nama yang valid!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Username', style: TextLayout.title18),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: 'Silahkan isi username Anda',
                                  border: InputBorder.none,
                                  hintStyle: TextLayout.body16,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16)
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Mohon isi username yang valid!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Email', style: TextLayout.title18),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Silahkan isi email Anda',
                                  border: InputBorder.none,
                                  hintStyle: TextLayout.body16,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16)
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
                                    return 'Mohon isi email yang valid!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Password', style: TextLayout.title18),
                            SizedBox(height: 10),
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
                            SizedBox(height: 10),
                            Text('Nomor Telepon', style: TextLayout.title18),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                controller: _phoneNumberController,
                                decoration: InputDecoration(
                                  hintText: 'Silahkan isi nomor telepon Anda',
                                  border: InputBorder.none,
                                  hintStyle: TextLayout.body16,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16)
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                                    return 'Mohon isi nomor telepon yang valid!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: ColorLayout.neutral4,
                                borderRadius: BorderRadius.circular(8),
                                // shadow
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorLayout.brBlue25.withOpacity(0.25),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(0, 4), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  borderRadius: BorderRadius.circular(8),
                                  dropdownColor: ColorLayout.neutral4,
                                  isExpanded: true,
                                  value: _roleController.text.isEmpty ? null : _roleController.text,
                                  hint: Text('Role', style: TextLayout.body16,),
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Caregiver', style: TextLayout.body16,),
                                      value: 'caregiver',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Patient', style: TextLayout.body16,),
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
                            ),
                            Visibility(
                              visible: _roleController.text == 'patient',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text('Username Caregiver', style: TextLayout.title18),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: TextFormField(
                                      controller: _caregiverUsernameController,
                                      decoration: InputDecoration(
                                        hintText: 'Silahkan isi username caregiver Anda',
                                        border: InputBorder.none,
                                        hintStyle: TextLayout.body16,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 45,
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
                            child: Text('REGISTER', style: TextLayout.title18.copyWith(color: ColorLayout.neutral5)),
                          ),
                        ),
                        SizedBox(height: 24,),
                        Row(
                          children: [
                            Text('Sudah memiliki akun? ', style: TextLayout.body16,),
                            Text('Login', style: TextLayout.body16.copyWith(color: ColorLayout.brBlue75)) // perlu diganti ke navigate
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}