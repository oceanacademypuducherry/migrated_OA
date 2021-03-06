import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/Login/login_widget/new_user_widget/contry_states.dart';
import 'package:flutter_app_newocean/Login/login_widget/new_user_widget/date_picker.dart';
import 'package:flutter_app_newocean/Login/login_widget/new_user_widget/gender_dropdoen_field.dart';
import 'package:flutter_app_newocean/Login/login_widget/new_user_widget/input_text_field.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileEditProfile extends StatefulWidget {
  static bool readOnly = false;

  @override
  _MobileEditProfileState createState() => _MobileEditProfileState();
}

class _MobileEditProfileState extends State<MobileEditProfile> {
  final _firestore = FirebaseFirestore.instance;
  //text field controller and variable
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String eMail;
  String companyOrSchool;
  String dgree;

  String state;
  String phoneNumber;
  String portfolioLink;
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  String dOB;
  final _dateOfBirth = TextEditingController();
  Future<DateTime> _selectDateTime(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime(1990),
        lastDate: DateTime(2025));
  }

  final _eMail = TextEditingController();
  final _companyOrSchool = TextEditingController();
  final _dgree = TextEditingController();
  // final _country = TextEditingController();
  // final _state = TextEditingController();
  final _phoneNumber = TextEditingController();

  List inputFormatte({@required String regExp, int length}) {
    List<TextInputFormatter> formater = [
      FilteringTextInputFormatter.allow(RegExp(regExp)),
      LengthLimitingTextInputFormatter(length)
    ];
    return formater;
  }

  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginResponsive.registerNumber = (prefs.getString('user') ?? null);
    print("thanks for ${LoginResponsive.registerNumber}");
    editProfile(LoginResponsive.registerNumber);
  }

  editProfile(String userNumber) async {
    var details = await _firestore
        .collection('new users')

        ///MenuBar.stayUser != null ? MenuBar.stayUser : LogIn.registerNumber
        .doc(userNumber)
        .get(); // 8015122373 insted of  LogIn.userNum
    var detailsData = details.data();

    setState(() {
      _firstName.text = detailsData['First Name'];
      _lastName.text = detailsData['Last Name'];

      GenderDropdownField.gendVal = detailsData['Gender'];
      _dateOfBirth.text = detailsData['Date of Birth'];
      _eMail.text = detailsData['E Mail'];
      _companyOrSchool.text = detailsData['Company or School'];
      _dgree.text = detailsData['Degree'];
      countryContrller.text = detailsData['Country'];
      stateContrller.text = detailsData['State'];
      _phoneNumber.text = detailsData['Phone Number'];
      profilePictureLink = detailsData['Profile Picture'];
      dOB = _dateOfBirth.text;
    });
  }

// profile picture
  Uint8List uploadFile;
  String fileName;
  String profilePictureLink;

  List<String> country = [];
  final countryContrller = TextEditingController();
  final stateContrller = TextEditingController();
  String selectedCountry;
  String selectedState;
  int listCount = 0;
  Map<String, List> CountryState = {};
  @override
  void initState() {
    super.initState();
    for (var i in contryState['countries']) {
      print(i['states']);
      country.add(i['country']);
      CountryState.addAll({i['country']: i['states']});
    }
    selectedCountry = countryContrller.text;
    selectedState = stateContrller.text;

    getSession();
    MobileEditProfile.readOnly = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  // TODO: Navigator to back
                });
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                      ),
                      color: Colors.blue,
                      iconSize: 50,
                      splashRadius: 30,
                      onPressed: () {
                        ///todo navigation
                        Get.back();
                        // Provider.of<Routing>(context, listen: false)
                        //     .updateRouting(widget: CoursesView());
                      },
                    ),
                    Text(
                      'My Profile',
                      style: TextStyle(fontSize: 25.0, color: Colors.blue),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 1500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    alignment: Alignment.centerLeft,
                    height: 300,
                    child: Wrap(
                      runSpacing: 40,
                      spacing: 5,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(500.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 8.0,
                                    offset: Offset(4.0, 4.0))
                              ]),
                          child: GestureDetector(
                            onTap: () async {
                              FilePickerResult result = await FilePicker
                                  .platform
                                  .pickFiles(type: FileType.image);
                              if (result != null) {
                                uploadFile = result.files.single.bytes;
                                fileName = basename(result.files.single.name);
                                print(fileName);
                              } else {
                                print('pick image');
                              }
                              // Upload to  firebase Storage
                              Future uploadProfilePicture(
                                  BuildContext context) async {
                                Reference firebaseStorageRef = FirebaseStorage
                                    .instance
                                    .ref()
                                    .child(fileName);
                                UploadTask uploadTask =
                                    firebaseStorageRef.putData(uploadFile);
                                // SnakBar Message
                                TaskSnapshot taskSnapShot =
                                    await uploadTask.whenComplete(() {
                                  setState(() {
                                    print('Profile Picuter Upload Complete');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Profile picture Uploaded')));
                                    // get Link
                                    uploadTask.snapshot.ref
                                        .getDownloadURL()
                                        .then((value) {
                                      setState(() {
                                        profilePictureLink = value;
                                      });
                                      print(profilePictureLink);
                                    });
                                  });
                                });
                              }

                              uploadProfilePicture(
                                  context); // call upload function
                            },
                            child: CircleAvatar(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(500.0),
                                child: Container(
                                  color: Colors.white,
                                  width: 300.0,
                                  height: 300.0,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      profilePictureLink != null
                                          ? Image.network(
                                              '${profilePictureLink}',
                                              width: 500.0,
                                              height: 500.0,
                                              fit: BoxFit.cover,
                                            )
                                          : Icon(
                                              Icons.add_a_photo,
                                              color: Colors.blue,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              radius: 50.0,
                            ),
                          ),
                        ),
                        Visibility(
                          child: MobileEditProfile.readOnly != false
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      listCount = 3;
                                      MobileEditProfile.readOnly = false;
                                      print(MobileEditProfile.readOnly);
                                    });
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Edit Account',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                    width: 130.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    FilePickerResult result = await FilePicker
                                        .platform
                                        .pickFiles(type: FileType.image);
                                    if (result != null) {
                                      uploadFile = result.files.single.bytes;
                                      fileName =
                                          basename(result.files.single.name);
                                      print(fileName);
                                    } else {
                                      print('pick image');
                                    }
                                    // Upload to  firebase Storage
                                    Future uploadProfilePicture(
                                        BuildContext context) async {
                                      Reference firebaseStorageRef =
                                          FirebaseStorage.instance
                                              .ref()
                                              .child(fileName);
                                      UploadTask uploadTask = firebaseStorageRef
                                          .putData(uploadFile);
                                      // SnakBar Message
                                      TaskSnapshot taskSnapShot =
                                          await uploadTask.whenComplete(() {
                                        setState(() {
                                          print(
                                              'Profile Picuter Upload Complete');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Profile picture Uploaded')));
                                          // get Link
                                        });
                                      });
                                    }

                                    uploadProfilePicture(
                                        context); // call upload function
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Upload Photos',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    width: 150.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                  ),
                                ),
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: MobileEditProfile.readOnly != false,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 1.0,
                                    ),
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(10.0)),
                                width: 100.0,
                                height: 100.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Courses Enrolled',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: MobileEditProfile.readOnly != false,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 1.0,
                                    ),
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(10.0)),
                                width: 100.0,
                                height: 100.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Courses Completed',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    width: double.infinity,
                    child: Form(
                      // key: formkey,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          LableWithTextField(
                            color: Colors.black,
                            lableText: 'First Name',
                            errorText: 'Enter First Name',
                            rReadOnly: MobileEditProfile.readOnly == false
                                ? false
                                : true,
                            width: 300.0,
                            controller: _firstName,
                            visible: isFirstName,
                            onChanged: (value) {},
                            inputFormatters: inputFormatte(
                                regExp: r"[a-zA-Z]+|\s", length: 15),
                          ),
                          LableWithTextField(
                              color: Colors.black,
                              lableText: 'Last Name',
                              errorText: 'Enter Last Name',
                              rReadOnly: MobileEditProfile.readOnly == false
                                  ? false
                                  : true,
                              width: 300.0,
                              visible: isLastName,
                              controller: _lastName,
                              onChanged: (value) {},
                              inputFormatters: inputFormatte(
                                  regExp: r"[a-zA-Z]+|\s", length: 15)),
                          GenderDropdownField(
                            visible: isGender,
                            errorText: 'Select',
                            color: Colors.black,
                          ),
                          DatePicker(
                            color: Colors.black,
                            errorText: 'Date Required',
                            datePickerIcon: IconButton(
                              icon: Icon(Icons.date_range),
                              onPressed: () async {
                                final selectedDate =
                                    await _selectDateTime(context);
                                setState(() {
                                  dOB =
                                      DateFormat('d-M-y').format(selectedDate);
                                  _dateOfBirth.text = dOB;
                                  print(dOB);
                                });
                              },
                            ),
                            controller: _dateOfBirth,
                            visible: isDateOfBirth,
                            onChanged: (value) {
                              setState(() {
                                _dateOfBirth.text = value;
                              });
                            },
                          ),
                          LableWithTextField(
                            color: Colors.black,
                            lableText: 'E-Mail Adsress',
                            errorText: 'Invalid Email Adress',
                            rReadOnly: MobileEditProfile.readOnly == false
                                ? false
                                : true,
                            visible: isEmail,
                            width: 300.0,
                            controller: _eMail,
                            onChanged: (value) {},
                          ),
                          LableWithTextField(
                            color: Colors.black,
                            lableText: 'Company/School',
                            errorText: 'Your Company/School Name',
                            rReadOnly: MobileEditProfile.readOnly == false
                                ? false
                                : true,
                            width: 300.0,
                            visible: isCompanyOrSchool,
                            controller: _companyOrSchool,
                            inputFormatters:
                                inputFormatte(regExp: r"[a-zA-Z]+|\s"),
                            onChanged: (value) {},
                          ),
                          LableWithTextField(
                            color: Colors.black,
                            lableText: 'Degree',
                            errorText: 'Enter your Education Qualification',
                            rReadOnly: MobileEditProfile.readOnly == false
                                ? false
                                : true,
                            width: 250.0,
                            visible: isDegree,
                            controller: _dgree,
                            onChanged: (value) {},
                          ),
                          LableWithTextField(
                            color: Colors.black,
                            lableText: 'Country',
                            errorText: 'Enter your Country Name',
                            rReadOnly: MobileEditProfile.readOnly == false
                                ? false
                                : true,
                            width: 300.0,
                            visible: isCountry,
                            controller: countryContrller,
                            onChanged: (value) {},
                          ),
                          LableWithTextField(
                            color: Colors.black,
                            lableText: 'State',
                            errorText: 'Enter your Stare Name',
                            rReadOnly: MobileEditProfile.readOnly == false
                                ? false
                                : true,
                            width: 300.0,
                            visible: isState,
                            controller: stateContrller,
                            onChanged: (value) {},
                          ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: 20, vertical: 10),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         'Country',
                          //         style: TextStyle(
                          //             fontSize: 18.0, color: Colors.black),
                          //       ),
                          //       SizedBox(
                          //         height: 9,
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         width: 300,
                          //         padding: EdgeInsets.symmetric(vertical: 5),
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(5),
                          //           color: Colors.white,
                          //         ),
                          //         child: DropDownField(
                          //           controller: countryContrller,
                          //           hintText: 'Select Country',
                          //           hintStyle: TextStyle(
                          //               fontSize: 18.0,
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.grey[500]),
                          //           textStyle: TextStyle(
                          //               fontSize: 18.0,
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.grey[700]),
                          //           enabled: true,
                          //           value: selectedCountry,
                          //           required: isCountry,
                          //           itemsVisibleInDropdown: listCount,
                          //           items: country,
                          //           onValueChanged: (value) {
                          //             setState(() {
                          //               selectedCountry = value;
                          //               stateContrller.clear();
                          //               print(selectedCountry);
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: 20, vertical: 10),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         'State',
                          //         style: TextStyle(
                          //             fontSize: 18.0, color: Colors.black),
                          //       ),
                          //       SizedBox(
                          //         height: 9,
                          //       ),
                          //       Container(
                          //         alignment: Alignment.center,
                          //         width: 300,
                          //         padding: EdgeInsets.symmetric(vertical: 5),
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(5),
                          //           color: Colors.white,
                          //         ),
                          //         child: DropDownField(
                          //           controller: stateContrller,
                          //           hintText: 'Select State',
                          //           hintStyle: TextStyle(
                          //               fontSize: 18.0,
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.grey[500]),
                          //           textStyle: TextStyle(
                          //               fontSize: 18.0,
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.grey[700]),
                          //           enabled: true,
                          //           //selectedCountry.length > 1 ? true : false,
                          //           strict: false,
                          //           required: isState,
                          //
                          //           itemsVisibleInDropdown: listCount,
                          //           items: CountryState[selectedCountry] == null
                          //               ? <String>[selectedState]
                          //               : CountryState[selectedCountry],
                          //           onValueChanged: (value) {
                          //             setState(() {
                          //               selectedState = value;
                          //               print(selectedState);
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          LableWithTextField(
                            color: Colors.black,
                            lableText: 'Phone Number',
                            errorText: 'Invalid Phonenumber',
                            width: 250.0,
                            rReadOnly: true,
                            visible: isPhoneNumber,
                            controller: _phoneNumber,
                            onChanged: (value) {},
                            inputFormatters: inputFormatte(
                                regExp: r'^\d+\.?\d{0,2}', length: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: MobileEditProfile.readOnly == false,
                          child: FlatButton(
                              minWidth: 300.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25.0),
                                ),
                              ),
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              onPressed: () {
                                print(selectedState);
                                if (registerFormValidation() == true) {
                                  fireStoreAdd();
                                  print('qqqqqqqqqqqqqqqqq');

                                  MobileEditProfile.readOnly = true;
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    ));
  }

  void fireStoreAdd() {
    _firestore.collection('new users').doc(_phoneNumber.text).update({
      'Profile Picture': profilePictureLink,
      'First Name': _firstName.text,
      'Last Name': _lastName.text,
      'Gender': GenderDropdownField.gendVal,
      'Date of Birth': dOB,
      'E Mail': _eMail.text,
      'Company or School': _companyOrSchool.text,
      'Degree': _dgree.text,
      'Country': countryContrller.text,
      'State': stateContrller.text,
      'Phone Number': _phoneNumber.text,
    });
  }

  bool isEmail = false;
  bool isFirstName = false;
  bool isLastName = false;
  bool isDateOfBirth = false;
  bool isGender = false;
  bool isCompanyOrSchool = false;
  bool isDegree = false;
  bool isCountry = false;
  bool isState = false;
  bool isPhoneNumber = false;

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool nameValidation(String value) {
    Pattern pattern = r"[a-zA-Z]+|\s";
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool phoneNumberValidation(String value) {
    Pattern pattern = r'^\d+\.?\d{0,2}';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool validateUrl(String value) {
    Pattern pattern =
        r'^(http:\/\/www\.)*(https:\/\/www\.)*(http:\/\/)*(https:\/\/)*(www\.)*(WWW\.)*[a-z0-9A-Z]+([\-\.]{1}[a-z0-9A-Z]+)*\.[a-zA-Z]{2,5}(:[0-9]{1,5})?(\/.*)?$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool registerFormValidation() {
    bool ifRFV = false;
    bool elseRFV = true;
    // first name
    if (!nameValidation(_firstName.text) || _firstName.text.length < 3) {
      setState(() {
        isFirstName = true;
        ifRFV = isFirstName;
      });
    } else {
      setState(() {
        isFirstName = false;
        elseRFV = isFirstName;
      });
    }
    //last name
    // if (!nameValidation(_lastName.text) || _lastName.text.length < 3) {
    //   setState(() {
    //     isLastName = true;
    //     ifRFV = isLastName;
    //   });
    // } else {
    //   setState(() {
    //     isLastName = false;
    //     elseRFV = isLastName;
    //   });
    // }
    // gender
    if (GenderDropdownField.gendVal == null) {
      setState(() {
        isGender = true;
        ifRFV = isGender;
      });
    } else {
      setState(() {
        isGender = false;
        elseRFV = isGender;
      });
    }
    //date
    if (_dateOfBirth.text.isEmpty || dOB.length < 2) {
      setState(() {
        isDateOfBirth = true;
        ifRFV = isDateOfBirth;
      });
    } else {
      setState(() {
        isDateOfBirth = false;
        elseRFV = isDateOfBirth;
      });
    }
    // email
    if (!validateEmail(_eMail.text)) {
      setState(() {
        isEmail = true;
        ifRFV = isEmail;
      });
    } else {
      setState(() {
        isEmail = false;
        elseRFV = isEmail;
      });
    }
    //Company or school
    if (!nameValidation(_companyOrSchool.text) ||
        _companyOrSchool.text.length < 3) {
      setState(() {
        isCompanyOrSchool = true;
        ifRFV = isCompanyOrSchool;
      });
    } else {
      setState(() {
        isCompanyOrSchool = false;
        elseRFV = isCompanyOrSchool;
      });
    }
    //Degree
    if (!nameValidation(_dgree.text) || _dgree.text.length < 1) {
      setState(() {
        isDegree = true;
        ifRFV = isDegree;
      });
    } else {
      setState(() {
        isDegree = false;
        elseRFV = isDegree;
      });
    }
    //Country
    if (countryContrller.text.length < 2) {
      setState(() {
        isCountry = true;
        ifRFV = isCountry;
      });
    } else {
      setState(() {
        isCountry = false;
        elseRFV = isCountry;
      });
    }
    //state
    if (stateContrller.text.length < 2) {
      setState(() {
        isState = true;
        ifRFV = isState;
      });
    } else {
      setState(() {
        isState = false;
        elseRFV = isState;
      });
    }
    //phonenumber
    if (_phoneNumber.text.length < 6) {
      setState(() {
        isPhoneNumber = true;
        ifRFV = isPhoneNumber;
      });
    } else {
      setState(() {
        isPhoneNumber = false;
        elseRFV = isPhoneNumber;
      });
    }

    return ifRFV == elseRFV;
  }
}
