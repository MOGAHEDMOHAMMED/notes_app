import 'package:flutter/material.dart';
import 'package:my_flutter_project/users_managment/create_acount.dart';
import 'package:my_flutter_project/my_app_colors.dart';
import 'package:my_flutter_project/my_app_text.dart';

import '../main.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool passVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyAppText.heading1("تسجيل الدخول"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: MyAppColors.clrBackground,
        padding: EdgeInsets.all(20),
        child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 30,
          children: [
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: userNameController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyAppColors.clrNegativeAppColor,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  fillColor: MyAppColors.clrBaseAppColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: MyAppColors.blueBase,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: MyAppColors.blueBase,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: " اسم المستخدم ",
                  labelStyle: TextStyle(
                    color: MyAppColors.blueBase,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  suffixIcon: Icon(Icons.person, color: MyAppColors.blueBase),
                ),
                keyboardType: TextInputType.text,
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                textAlign: TextAlign.center,
                controller: passwordController,
                style: TextStyle(
                  color: MyAppColors.clrNegativeAppColor,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  fillColor: MyAppColors.clrBaseAppColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: MyAppColors.blueBase,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: MyAppColors.blueBase,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: " Password ",
                  labelStyle: TextStyle(
                    color: MyAppColors.blueBase,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passVisible = !passVisible;
                      });
                    },
                    icon: Icon(
                      passVisible ? Icons.visibility : Icons.visibility_off,
                      color: MyAppColors.blueBase,
                    ),
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: passVisible,
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    MyAppColors.blueBase,
                  ),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (userNameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                      if (UsersInfo.usersInfo.containsKey(userNameController.text,)) {
                        if (UsersInfo.usersInfo[userNameController.text]!.containsValue(passwordController.text)) {
                          Navigator.push( context,MaterialPageRoute(builder: (context) => MyHomePage(), ),);
                        } 
                        else { showErrorDailog(context, "كلمة المرور غير صحيحة"); }
                      }
                       else { showErrorDailog(context, " اسم المستخدم غير صحيح");}
                    } else {showErrorDailog(context, "ادخل كلمة السر واسم المستخدم");}
                  });
                },
                child: Text(
                  "دخول",
                  style: TextStyle(
                    fontSize: 25,
                    color: MyAppColors.clrBaseAppColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateAcount()),
                  );
                },
                child: Text(
                  "ليس لديك حساب؟ انشاء حساب",
                  style: TextStyle(
                    fontSize: 20,
                    color: MyAppColors.blueBase,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showErrorDailog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text("OK"),
          ),
        ],
        title: Icon(Icons.error_outline, color: Colors.red.shade700),
      ),
    );
  }
}
