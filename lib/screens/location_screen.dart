// ignore_for_file: prefer_const_constructors, unnecessary_new, avoid_print, import_of_legacy_library_into_null_safe, unnecessary_null_comparison, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:location/location.dart';
import 'package:udyog/screens/home.dart';
import 'package:udyog/screens/main_screen.dart';
import 'package:udyog/services/firebase_services.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);
  static const String id = 'location-Screen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  FirebaseService _service = FirebaseService();
  bool _loading = true;
  Location location = new Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  late String _address;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  late String manualAddress;

  Future<LocationData?> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    final coordinates =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = address.first;
    setState(() {
      _address = first.addressLine;
      countryValue = first.countryName;
    });
    return _locationData;
  }

  @override
  Widget build(BuildContext context) {
    _service.users
        .doc(_service.user?.uid)
        .get()
        .then((DocumentSnapshot document) {
      if (document.exists) {
        if (document['address'] != null) {
          //location updated
          setState(() {
            _loading = true;
          });
          Navigator.pushReplacementNamed(context, MainScreen.id);
        } else {
          setState(() {
            _loading = false;
          });
        }
      }
    });

    ProgressDialog progressDialog = ProgressDialog(
      context: context,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      loadingText: 'Fetching location..',
      progressIndicatorColor: Theme.of(context).primaryColor,
    );

    showBottomScreen(context) {
      getLocation().then((location) {
        if (location != null) {
          progressDialog.dismiss();
          showModalBottomSheet(
              isScrollControlled: true,
              enableDrag: true,
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    SizedBox(
                      height: 26,
                    ),
                    AppBar(
                      automaticallyImplyLeading: false,
                      iconTheme: IconThemeData(
                        color: Colors.blue,
                      ),
                      elevation: 1,
                      backgroundColor: Colors.white,
                      title: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.clear),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Location',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Search City, area or neighbourhood',
                              hintStyle: TextStyle(color: Colors.grey),
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        //save address
                        progressDialog.show;
                        getLocation().then((value) {
                          if (value != null) {
                            _service.updateUser({
                              'location':
                                  GeoPoint(value.latitude!, value.longitude!),
                              'address': _address
                            }, context).then((value) {
                              progressDialog.dismiss();
                              Navigator.pushNamed(context, HomeScreen.id);
                            });
                          }
                        });
                      },
                      horizontalTitleGap: 0.0,
                      leading: Icon(
                        Icons.my_location,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Use current location',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        location == null ? 'Fetching location' : _address,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade300,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 4, top: 4),
                        child: Text(
                          'Choose City',
                          style: TextStyle(
                            color: Colors.blueGrey.shade900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: CSCPicker(
                        layout: Layout.vertical,
                        showStates: false,
                        showCities: false,
                        flagState: CountryFlag.DISABLE,
                        dropdownDecoration:
                            BoxDecoration(shape: BoxShape.rectangle),
                        defaultCountry: DefaultCountry.India,
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value!;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value!;
                            manualAddress =
                                '$cityValue, $stateValue, $countryValue';
                          });
                          if (value != null) {
                            _service.updateUser({
                              'address': manualAddress,
                              'state': stateValue,
                              'city': cityValue,
                              'country': countryValue
                            }, context);
                          }
                        },
                      ),
                    ),
                  ],
                );
              });
        } else {
          progressDialog.dismiss();
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset('assets/images/location.jpg'),
              SizedBox(
                height: 20,
              ),
              Text(
                'Pin your location',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'To enjoy all that we have to offer you\nwe need to know where to look for them',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 30,
              ),
              _loading
                  ? Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Finding location....')
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: _loading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      ))
                                    : ElevatedButton.icon(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Theme.of(context)
                                                      .primaryColor),
                                        ),
                                        onPressed: () {
                                          progressDialog.show();
                                          getLocation().then((value) {
                                            if (value != null) {
                                              _service.updateUser({
                                                'address': _address,
                                                'location': GeoPoint(
                                                    value.latitude!,
                                                    value.longitude!),
                                              }, context);
                                            }
                                          });
                                        },
                                        icon:
                                            Icon(CupertinoIcons.location_fill),
                                        label: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, bottom: 15),
                                          child: Text(
                                            'Near Me',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            progressDialog.show;
                            showBottomScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 2))),
                              child: Text(
                                'Locate manually',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
