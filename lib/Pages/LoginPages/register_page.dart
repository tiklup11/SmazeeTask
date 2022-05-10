import 'package:flutter/material.dart';
import 'package:smazee_task/CustomWidgets/custom_logo_button.dart';
import 'package:smazee_task/CustomWidgets/miniloadingButton.dart';
import 'package:smazee_task/Models/address.dart';
import 'package:smazee_task/Models/custom_button.dart';
import 'package:smazee_task/Models/user.dart';
import 'package:smazee_task/Pages/HomePages/profile_page.dart';
import 'package:smazee_task/Pages/LoginPages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smazee_task/constants.dart';

enum RegistrationState { init, loading, loaded }

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;

  final _registrationFormKey = GlobalKey<FormState>();

  RegistrationState registerButtonState = RegistrationState.init;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLoading = registerButtonState == RegistrationState.loading;
    bool isStretched = registerButtonState == RegistrationState.init;

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
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter email");
        }
        //we can also use advance reg expression to validate
        if ((value.contains('@')) == false) {
          return ("Please enter valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: inputStyle,
      decoration: textFieldDecoration("example@example.com"),
    );
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter password");
        }
        if (value.length < 8) {
          return "Password length must be atleast 8";
        }
        //checking for atleast one capital letter
        bool atleastOneUpperCase = false;
        for (var rune in value.runes) {
          var character = String.fromCharCode(rune);
          if (character.toUpperCase() == character) {
            atleastOneUpperCase = true;
          }
        }

        if (atleastOneUpperCase == false) {
          return ("Include atleast one capital letter");
        }

        //checking for special character
        if (!(value.contains('(') ||
            value.contains(')') ||
            value.contains('}') ||
            value.contains('{') ||
            value.contains(']') ||
            value.contains('[') ||
            value.contains('!') ||
            value.contains('@') ||
            value.contains('#') ||
            value.contains('%') ||
            value.contains('^') ||
            value.contains('&') ||
            value.contains('*'))) {
          return ('Please include one special letter');
        }

        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: inputStyle,
      decoration: textFieldDecoration("8+ Characters,1 Capital letter"),
    );

    final confirmPassField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: confirmPassController,
      validator: (value) {
        if (value!.isEmpty) {
          return "*Required field";
        }
        if (passwordController.text != confirmPassController.text) {
          return "Passwords don't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPassController.text = value!;
      },
      textInputAction: TextInputAction.next,
      style: inputStyle,
      decoration: textFieldDecoration("8+ Characters,1 Capital letter"),
    );

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 40),
                      child: Text(
                        'Register Here',
                        style: TextStyle(
                          fontFamily: 'Cardo',
                          fontSize: 35,
                          color: Color(0xff0C2551),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      //
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, top: 5),
                      child: Text(
                        'Already registered ? Login with',
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  spacedWidget,
                  Container(
                    margin: const EdgeInsets.only(left: 38),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => LoginPage(),
                              ),
                              (route) =>
                                  false, //if you want to disable back feature set to false
                            );
                          },
                          child: CustomLogoButton(
                            char: '@',
                            activated: false,
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        CustomLogoButton(
                          char: 'G',
                          activated: false,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 35, 15),
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
                          spacedWidget,
                          topperText('Email'),
                          emailField,
                          spacedWidget,
                          topperText('Password'),
                          passwordField,
                          spacedWidget,
                          topperText('Confirm Password'),
                          confirmPassField,
                        ],
                      ),
                    ),
                  ),
                  spacedWidget,
                  Text(
                    "Creating an account means you're okay with\nour Terms of Service and Privacy Policy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff8f9db5).withOpacity(0.45),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.bounceOut,
                    width: RegistrationState.loading == registerButtonState
                        ? scrWidth * 0.20
                        : scrWidth * 0.85,
                    child: !isStretched
                        ? MiniLoadingButton(
                            isDone:
                                RegistrationState.loaded == registerButtonState,
                            scrHeight: scrHeight,
                            scrWidth: scrWidth,
                          )
                        : GestureDetector(
                            onTap: () {
                              signUp(
                                  email: emailController.text,
                                  password: passwordController.text);
                            },
                            child: CustomButton(
                              btnText: "Register Account",
                              dimColor: false,
                              isLoading: isLoading,
                            )),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff8f9db5).withOpacity(0.45),
                          ),
                        ),
                        const TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff90b7ff),
                          ),
                        )
                      ],
                    ),
                  ),
                  spacedWidget
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp({String? email, String? password}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await Future.delayed(const Duration(milliseconds: 400));

    if (_registrationFormKey.currentState!.validate()) {
      setState(() {
        registerButtonState = RegistrationState.loading;
      });

      try {
        final UserCredential userCredentials = await _auth
            .createUserWithEmailAndPassword(email: email!, password: password!);

        await postDetailsToFirestore(userCredentials.user);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ProfilePage()));

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User Registered"),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("ERROR : ${e.toString()}"),
          duration: Duration(seconds: 10),
        ));

        setState(() {
          registerButtonState = RegistrationState.init;
        });
        // print(e.toString());
      }
    }
  }

  Future<void> postDetailsToFirestore(User? user) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    UserModel currentUser = UserModel(
        age: int.parse(ageController.text),
        email: emailController.text,
        name: nameController.text,
        uid: user!.uid,
        number: int.parse(phoneNumberController.text),
        address: Address(
          city: cityNameController.text,
          streetName: streetNameController.text,
          country: countryController.text,
          houseNo: houseNoController.text,
          postalCode: int.parse(postalCodeController.text),
        ));

    await firebaseFirestore
        .collection(K_USERS)
        .doc(user.uid)
        .set(currentUser.toMap());
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
