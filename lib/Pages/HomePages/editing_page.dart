import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smazee_task/CustomWidgets/miniloadingButton.dart';
import 'package:smazee_task/Models/address.dart';
import 'package:smazee_task/Models/custom_button.dart';
import 'package:smazee_task/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smazee_task/constants.dart';

enum EditPageState { init, loading, loaded }

class EditingPage extends StatefulWidget {
  EditingPage({required this.loggedInUser});
  final UserModel? loggedInUser;

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  final _auth = FirebaseAuth.instance;

  final _registrationFormKey = GlobalKey<FormState>();

  EditPageState buttonState = EditPageState.init;

  late final TextEditingController nameController,
      ageController,
      streetNameController,
      postalCodeController,
      houseNoController,
      cityNameController,
      countryController,
      phoneNumberController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.loggedInUser!.name);
    ageController =
        TextEditingController(text: widget.loggedInUser!.age.toString());
    streetNameController =
        TextEditingController(text: widget.loggedInUser!.address!.streetName);
    postalCodeController = TextEditingController(
        text: widget.loggedInUser!.address!.postalCode.toString());
    houseNoController =
        TextEditingController(text: widget.loggedInUser!.address!.houseNo);
    cityNameController =
        TextEditingController(text: widget.loggedInUser!.address!.city);
    countryController =
        TextEditingController(text: widget.loggedInUser!.address!.country);
    phoneNumberController =
        TextEditingController(text: widget.loggedInUser!.number.toString());

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = buttonState == EditPageState.loading;
    bool isStretched = buttonState == EditPageState.init;

    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    var spacedWidget = SizedBox(
      height: scrHeight * 0.020,
    );

    var inputStyle = const TextStyle(
        fontSize: 15, color: Colors.black54, fontWeight: FontWeight.bold);

    final nameField = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return "*Required field";
        }
      },
      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: inputStyle,
      decoration: textFieldDecoration("qwerty"),
    );

    final ageField = TextFormField(
      autofocus: false,
      controller: ageController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      onSaved: (value) {
        ageController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: inputStyle,
      decoration: textFieldDecoration("##"),
    );
    final streetField = TextFormField(
      autofocus: false,
      controller: streetNameController,
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      onSaved: (value) {
        streetNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: inputStyle,
      decoration: textFieldDecoration("xyz ##### "),
    );

    final postalCodeField = TextFormField(
      autofocus: false,
      controller: postalCodeController,
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      onSaved: (value) {
        postalCodeController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: inputStyle,
      decoration: textFieldDecoration("xyz ##### "),
    );

    final houseNoField = TextFormField(
      autofocus: false,
      controller: houseNoController,
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      onSaved: (value) {
        houseNoController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: inputStyle,
      decoration: textFieldDecoration("xyz ##### "),
    );
    final cityField = TextFormField(
      autofocus: false,
      controller: cityNameController,
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      onSaved: (value) {
        cityNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: inputStyle,
      decoration: textFieldDecoration("xyz ##### "),
    );
    final countyField = TextFormField(
      autofocus: false,
      controller: countryController,
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      onSaved: (value) {
        countryController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: inputStyle,
      decoration: textFieldDecoration("xyz ##### "),
    );

    final phoneNoField = TextFormField(
      autofocus: false,
      controller: phoneNumberController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return "*Required field";
        }
        return null;
      },
      onSaved: (value) {
        phoneNumberController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: inputStyle,
      decoration: textFieldDecoration("9494949494"),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: KINDA_BLUE,
        body: Stack(
          children: [
            Container(
              // color: Colors.white,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(
                  children: [
                    Hero(
                      tag: "TOPPER",
                      child: Container(
                        color: KINDA_BLUE,
                        height: 15,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter, //Starting point
                              end: Alignment.bottomCenter, //Ending point
                              stops: [0.015, 0],
                              colors: [
                                KINDA_BLUE,
                                Colors.white
                              ], // List of colors
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, top: 40),
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Text(
                                        'Update info',
                                        style: TextStyle(
                                          fontFamily: 'Cardo',
                                          fontSize: 35,
                                          color: Color(0xff0C2551),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Hero(
                                          tag: "EDIT",
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.black45,
                                          ))
                                    ],
                                  ),
                                  //
                                ),
                              ),
                              spacedWidget,
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(35, 0, 35, 10),
                                child: Form(
                                  key: _registrationFormKey,
                                  child: Column(
                                    children: [
                                      spacedWidget,
                                      topperText('Name'),
                                      nameField,
                                      spacedWidget,
                                      topperText('Age'),
                                      ageField,
                                      spacedWidget,
                                      topperText('Address (Street Name)'),
                                      streetField,
                                      spacedWidget,
                                      topperText('House No.'),
                                      houseNoField,
                                      spacedWidget,
                                      topperText('Postal Code'),
                                      postalCodeField,
                                      spacedWidget,
                                      topperText('CityName'),
                                      cityField,
                                      spacedWidget,
                                      topperText('Country'),
                                      countyField,
                                      spacedWidget,
                                      topperText('PhoneNo.'),
                                      phoneNoField,
                                    ],
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.bounceOut,
                                width: EditPageState.loading == buttonState
                                    ? scrWidth * 0.20
                                    : scrWidth * 0.85,
                                child: !isStretched
                                    ? MiniLoadingButton(
                                        isDone:
                                            EditPageState.loaded == buttonState,
                                        scrHeight: scrHeight,
                                        scrWidth: scrWidth,
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          updateInfo();
                                        },
                                        child: CustomButton(
                                          btnText: "Update Details",
                                          isLoading: isLoading,
                                          dimColor: false,
                                        ),
                                      ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: CustomButton(
                                  btnText: "Go Home",
                                  isLoading: false,
                                  dimColor: true,
                                ),
                              )
                            ],
                          ),
                        ),
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

  void updateInfo() async {
    FocusManager.instance.primaryFocus?.unfocus();

    await Future.delayed(const Duration(milliseconds: 500));

    if (_registrationFormKey.currentState!.validate()) {
      try {
        setState(() {
          buttonState = EditPageState.loading;
        });

        await postDetailsToFirestore();

        setState(() {
          buttonState = EditPageState.loaded;
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Info updated"),
        ));

        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          buttonState = EditPageState.init;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("ERROR : ${e.toString()}"),
        ));

        setState(() {
          buttonState = EditPageState.init;
        });
        // print(e.toString());
      }
    }
  }

  Future<void> postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    UserModel currentUser = UserModel(
        age: int.parse(ageController.text),
        name: nameController.text,
        uid: widget.loggedInUser!.uid,
        email: widget.loggedInUser!.email,
        number: int.parse(phoneNumberController.text),
        address: Address(
          city: cityNameController.text,
          streetName: streetNameController.text,
          country: countryController.text,
          houseNo: houseNoController.text,
          postalCode: int.parse(postalCodeController.text),
        ));

    try {
      await firebaseFirestore
          .collection(K_USERS)
          .doc(widget.loggedInUser!.uid)
          .update(currentUser.toMap());
    } catch (e) {
      setState(() {
        buttonState = EditPageState.loaded;
      });
    }
  }

  Widget topperText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xff8f9db5),
          ),
        ),
      ),
    );
  }

  InputDecoration textFieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
          fontSize: 15, color: Colors.grey[350], fontWeight: FontWeight.w600),
      contentPadding: const EdgeInsets.symmetric(vertical: 27, horizontal: 25),
      focusColor: const Color(0xff0962ff),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xff0962ff)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey[350]!,
        ),
      ),
    );
  }
}
