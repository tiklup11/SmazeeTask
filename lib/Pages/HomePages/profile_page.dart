import 'package:flutter/material.dart';
import 'package:smazee_task/Models/user.dart';
import 'package:smazee_task/Pages/HomePages/editing_page.dart';
import 'package:smazee_task/Pages/LoginPages/login_page.dart';
import 'package:smazee_task/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum PageState { loading, loaded, loggingOut }

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final double _drawerIconSize = 24;
  final double _drawerFontSize = 17;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  PageState pageState = PageState.loading;

  Future<void> fetchUserData() async {
    print("fetchign usr data");
    setState(() {
      pageState = PageState.loading;
    });
    final userDoc = await FirebaseFirestore.instance
        .collection(K_USERS)
        .doc(user!.uid)
        .get();
    loggedInUser = UserModel.fromMap(userDoc.data());
    setState(() {
      pageState = PageState.loaded;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: KINDA_BLUE,
        title: const Text(
          "Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.35,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Container(
            margin: EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Stack(
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets.only(bottom: 14),
                  icon: Hero(
                    tag: "EDIT",
                    child: Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  ),
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditingPage(
                                  loggedInUser: loggedInUser,
                                )));

                    fetchUserData();
                  },
                ),
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: Container(
                  color: KINDA_BLUE,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Settings",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: _drawerIconSize,
                ),
                title: Text(
                  pageState == PageState.loggingOut
                      ? 'Logging out..'
                      : 'Logout',
                  style: TextStyle(fontSize: _drawerFontSize),
                ),
                onTap: () {
                  if (pageState != PageState.loggingOut) {
                    setState(() {
                      pageState = PageState.loggingOut;
                    });
                    logOut();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Hero(
              tag: "TOPPER",
              child: Container(
                color: KINDA_BLUE,
                height: 70,
              ),
            ),
            if (pageState == PageState.loading)
              Container(
                height: scrHeight,
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                  ),
                ),
              )
            else
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 5, color: Colors.white),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      loggedInUser.name!,
                      style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "User Information",
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Card(
                            child: Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      ...ListTile.divideTiles(
                                        color: Colors.grey,
                                        tiles: [
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4),
                                            leading: Icon(Icons.numbers),
                                            title: Text("Age"),
                                            subtitle: Text(
                                                loggedInUser.age!.toString()),
                                          ),
                                          ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 20),
                                            leading: Icon(Icons.my_location),
                                            title: Text("Location"),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${loggedInUser.address!.houseNo!}, ${loggedInUser.address!.streetName!}"),
                                                Text(
                                                    "${loggedInUser.address!.city!},${loggedInUser.address!.postalCode!}"),
                                                Text(
                                                    "${loggedInUser.address!.country!},"),
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.email),
                                            title: Text("Email"),
                                            subtitle: Text(loggedInUser.email!),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.phone),
                                            title: Text("Phone"),
                                            subtitle: Text(
                                                "${loggedInUser.number!}"
                                                    .toString()),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<void> logOut() async {
    print("loging outttttttttttttttttttttttttttttttttttttttttttttt");
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
