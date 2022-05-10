import 'package:flutter/material.dart';
import 'package:smazee_task/CustomWidgets/custom_logo_button.dart';
import 'package:smazee_task/Models/custom_button.dart';
import 'package:smazee_task/Pages/HomePages/profile_page.dart';
import 'package:smazee_task/Pages/LoginPages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LoginState { init, loading, loaded }

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginState loginButtonState = LoginState.init;

  final _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    bool isLoading = loginButtonState == LoginState.loading;
    bool isStretched = loginButtonState == LoginState.init;

    var spacedWidget = SizedBox(
      height: scrHeight * 0.03,
    );

    var inputStyle = const TextStyle(
        fontSize: 15, color: Colors.black54, fontWeight: FontWeight.bold);

    //email input field
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

    //password input field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password is required";
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      style: inputStyle,
      decoration: textFieldDecoration("Qwerty@123"),
      textInputAction: TextInputAction.next,
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
                      padding: EdgeInsets.only(left: 40.0, top: 40),
                      child: Text(
                        'Login ',
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
                      padding: EdgeInsets.only(left: 40, top: 5),
                      child: Text(
                        'with ',
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
                        CustomLogoButton(
                          char: '@',
                          activated: true,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        CustomLogoButton(
                          char: 'G',
                          activated: false,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: scrHeight * 0.035,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(34, 0, 34, 15),
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          topperText("Email"),
                          emailField,
                          spacedWidget,
                          topperText("Password"),
                          passwordField,
                        ],
                      ),
                    ),
                  ),
                  spacedWidget,
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.bounceOut,
                    width: LoginState.loading == loginButtonState
                        ? scrWidth * 0.20
                        : scrWidth * 0.85,
                    child: !isStretched
                        ? miniLoadingButton(scrWidth, scrHeight,
                            LoginState.loaded == loginButtonState)
                        :
                        // ignore: dead_code
                        GestureDetector(
                            onTap: () async {
                              signIn(
                                  email: emailController.text,
                                  password: passwordController.text);
                            },
                            child: CustomButton(
                              btnText: "Login",
                              dimColor: false,
                              isLoading: isLoading,
                            )),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => RegisterPage(),
                        ),
                        (route) =>
                            false, //if you want to disable back feature set to false
                      )
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff8f9db5).withOpacity(0.45),
                            ),
                          ),
                          const TextSpan(
                            text: 'Register Here',
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signIn({String? email, String? password}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await Future.delayed(const Duration(milliseconds: 400));

    if (_loginFormKey.currentState!.validate()) {
      try {
        setState(() => loginButtonState = LoginState.loading);
        await _auth.signInWithEmailAndPassword(
            email: email!, password: password!);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login Successfull")));
        setState(() => loginButtonState = LoginState.loaded);

        await Future.delayed(const Duration(milliseconds: 300));

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ProfilePage()));
      } catch (e) {
        String err = e.toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("ERROR : ${e.toString()}"),
          duration: const Duration(seconds: 10),
        ));
        // print(e.toString());
        setState(() => loginButtonState = LoginState.init);
      }
    }
  }

  //text at top of input field
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

  Widget miniLoadingButton(var scrWidth, var scrHeight, bool isDone) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: 75,
        decoration: BoxDecoration(
          color: const Color(0xff0962ff),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: isDone
              ? const Icon(
                  Icons.done,
                  size: 40,
                  color: Colors.white70,
                )
              : const CircularProgressIndicator(
                  color: Colors.white70, strokeWidth: 6),
        ));
  }
}
