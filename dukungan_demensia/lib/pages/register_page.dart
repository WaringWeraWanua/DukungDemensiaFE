// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dukungan_demensia/models/auth_models.dart';
import 'package:dukungan_demensia/services/auth_api.dart';
import 'package:dukungan_demensia/widgets/layout/text_layout.dart';
import 'package:flutter/material.dart';
import '../widgets/layout/colors_layout.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final _careGiverUsernameController = TextEditingController();
  bool _passwordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _roleController.dispose();
    _careGiverUsernameController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && !_isLoading) {
      setState(() {
        _isLoading = true;
      });

      final name = _nameController.text;
      final email = _emailController.text;
      final phoneNumber = _phoneNumberController.text;
      final role = _roleController.text;
      final careGiverUsername = _careGiverUsernameController.text;
      final username = _usernameController.text;
      final password = _passwordController.text;

      RegisterRequestBody requestBody = RegisterRequestBody(
        username: username,
        password: password,
        email: email,
        name: name,
        role: role,
        phoneNumber: phoneNumber,
      );

      if (careGiverUsername.isNotEmpty) {
        requestBody.careGiverUsername = careGiverUsername;
      }
      final client = RegisterApi();
      try {
        final response = await client.postRegister(requestBody);
        await Fluttertoast.showToast(
          msg: "Register Successful!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
        Navigator.pushNamed(context, '/login');
      } catch (e) {
        await Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      }  finally {
        setState(() {
          _isLoading = false;
        });
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
                        Text('Dukungan Demensia', style: TextLayout.display42.copyWith(color: ColorLayout.blue4)),
                        SizedBox(height: 10),
                        Text('Peduli dan lindungi orang kesayangan Anda', style: TextLayout.body16.copyWith(color: ColorLayout.black4), textAlign: TextAlign.center,),
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
                                    color: ColorLayout.blue1.withOpacity(0.25),
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
                                      value: 'CARE_GIVER',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Patient', style: TextLayout.body16,),
                                      value: 'PATIENT',
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
                              visible: _roleController.text == 'PATIENT',
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
                                      controller: _careGiverUsernameController,
                                      decoration: InputDecoration(
                                        hintText: 'Silahkan isi username caregiver Anda',
                                        border: InputBorder.none,
                                        hintStyle: TextLayout.body16,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16)
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty && _roleController.text == 'PATIENT') {
                                          return 'Mohon isi username caregiver yang valid!';
                                        } else {
                                          return null;
                                        }
                                      },
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
                              backgroundColor: ColorLayout.blue4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _isLoading ? null : _submitForm, 
                            child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(ColorLayout.blue4),
                                )
                              : Text('DAFTAR', style: TextLayout.title18.copyWith(color: ColorLayout.neutral5)),
                          ),
                        ),
                        SizedBox(height: 24,),
                        Row(
                          children: [
                            Text('Sudah memiliki akun? ', style: TextLayout.body16,),
                            InkWell(
                              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                              child: 
                                Text('Masuk', style: TextLayout.body16.copyWith(color: ColorLayout.blue4))
                            ) // perlu diganti ke navigate
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