// ignore_for_file: prefer_const_constructors, prefer_final_fields, no_leading_underscores_for_local_identifiers, unused_field

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:udyog/forms/form_class.dart';
import 'package:udyog/forms/user_review_screen.dart';
import 'package:udyog/provider/cat_provider.dart';
import 'package:udyog/services/firebase_services.dart';

class FormScreen extends StatefulWidget {
  static const String id = 'form-screen';
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  FormClass _formClass = FormClass();
  final _formKey = GlobalKey<FormState>();
  FirebaseService _service = FirebaseService();
  validate(CategoryProvider provider) {
    if (_formKey.currentState!.validate()) {
      provider.dataToFirestore.addAll({
        'category': provider.selectedCategory,
        'title': _titleController.text,
        'company': _compController.text,
        'logourl' : _logoController.text,
        'qualification': _reqController.text,
        'description': _descController.text,
        'vacancy': _vcyController.text,
        'time': _timeController.text,
        'salary': _salController.text,
        'experience': _expController.text,
        'address': _addressController.text,
        'tc': _tcController.text,
        'selleruid': _service.user!.uid,
        'postedAt': DateTime.now().microsecondsSinceEpoch,
        'favourites':[]
      });
      Navigator.pushNamed(context, UserReviewScreen.id);
    }
  }

  var _titleController = TextEditingController();
  var _compController = TextEditingController();
  var _logoController = TextEditingController();
  var _reqController = TextEditingController();
  var _descController = TextEditingController();
  var _vcyController = TextEditingController();
  var _timeController = TextEditingController();
  var _salController = TextEditingController();
  var _expController = TextEditingController();
  var _addressController = TextEditingController();
  var _tcController = TextEditingController();
  @override
  void initState() {
    _service.getUserData().then((value) {
      setState(() {
        _addressController = value['address'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Text(
          'Add details',
          style: TextStyle(color: Colors.black),
        ),
        shape: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Text(
                  '${_provider.selectedCategory} Job',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  maxLength: 25,
                  decoration: InputDecoration(
                      labelText: 'Title',
                      helperText: 'Mention the title of the job'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _compController,
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  decoration: InputDecoration(
                      labelText: 'Company',
                      helperText:
                      'Mention the company name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _logoController,
                  keyboardType: TextInputType.text,
                  maxLength: 100,
                  decoration: InputDecoration(
                      labelText: 'Company logo url',
                      helperText:
                      'Strictly provide the company logo'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _reqController,
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  decoration: InputDecoration(
                      labelText: 'Qualification',
                      helperText:
                          'Mention the qualification required for the job'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descController,
                  keyboardType: TextInputType.multiline,
                  maxLength: 250,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      helperText: 'Provide the detailed job description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _vcyController,
                  keyboardType: TextInputType.text,
                  maxLength: 6,
                  decoration: InputDecoration(
                      labelText: 'Job Vacancy',
                      helperText:
                      'Provide the number of vacancies for the job'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _timeController,
                  keyboardType: TextInputType.text,
                  maxLength: 12,
                  decoration: InputDecoration(
                      labelText: 'Job Type',
                      helperText: 'Mention the job type'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _salController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                      labelText: 'Salary',
                      helperText:
                      'Provide the approx. salary range'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _expController,
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  decoration: InputDecoration(
                      labelText: 'Experience',
                      helperText:
                          'Provide the required experience for the employee'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter required field';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  keyboardType: TextInputType.streetAddress,
                  maxLength: 100,
                  decoration: InputDecoration(
                      labelText: 'Job Address',
                      helperText: 'Provide the work address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter required field';
                    }
                    return null;
                  },
                ),
                Text('By continue you accept T&C.',style: TextStyle(fontSize: 20,color: Colors.grey),),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeumorphicButton(
                style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () {
                  validate(_provider);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
