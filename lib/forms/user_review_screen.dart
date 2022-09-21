// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:udyog/provider/cat_provider.dart';
import 'package:udyog/screens/main_screen.dart';
import 'package:udyog/services/firebase_services.dart';

class UserReviewScreen extends StatefulWidget {
  static const String id = 'user-review-screen';
  const UserReviewScreen({Key? key}) : super(key: key);

  @override
  State<UserReviewScreen> createState() => _UserReviewScreenState();
}

class _UserReviewScreenState extends State<UserReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  FirebaseService _service = FirebaseService();
  var _nameController = TextEditingController();
  var _countryController = TextEditingController(text: '+91');
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _addressController = TextEditingController();

  Future<void> updateUser(provider, Map<String, dynamic> data, context) {
    return _service.users.doc(_service.user!.uid).update(data).then(
      (value) {
        saveProductToDb(provider, context);
      },
    ).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update details'),
        ),
      );
    });
  }

  Future<void> saveProductToDb(provider, context) {
    return _service.products.add(provider.dataToFirestore).then(
      (value) {
        provider.clearData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You will be notified after scrutiny check'),
          ),
        );
      },
    ).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add product'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        shape: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
        title: Text(
          'Review your details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot>(
          future: _service.getUserData(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              );
            }
            _nameController.text = snapshot.data!['name'];
            _phoneController.text = snapshot.data!['mobile'];
            _emailController.text = snapshot.data!['email'];
            _addressController.text = snapshot.data!['address'];
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue.shade50,
                            radius: 38,
                            child: Icon(
                              CupertinoIcons.person_alt,
                              color: Colors.red.shade300,
                              size: 60,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Contact Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _countryController,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Country',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              helperText: 'Enter contact number',
                            ),
                            maxLength: 10,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        helperText: 'Enter contact mail',
                      ),
                      validator: (value) {
                        final bool isValid =
                            EmailValidator.validate(_emailController.text);
                        if (value == null || value.isEmpty) {
                          return 'Enter Email';
                        }
                        if (value.isNotEmpty && isValid == false) {
                          return 'Enter valid Email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.streetAddress,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                          labelText: 'Address',
                          helperText: 'Provide the contact address'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter required field';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: NeumorphicButton(
                style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                child: Text(
                  'Confirm',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateUser(
                            _provider,
                            {
                              'contactDetails': {
                                'title': _nameController.text,
                                'contactMobile': _phoneController.text,
                                'contactEmail': _emailController.text,
                              }
                            },
                            context)
                        .whenComplete(() {
                      Navigator.pushReplacementNamed(context, MainScreen.id);
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
