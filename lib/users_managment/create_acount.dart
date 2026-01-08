import 'package:flutter/material.dart';
import 'package:my_flutter_project/main.dart';
import 'package:my_flutter_project/users_managment/login_page.dart';
import 'package:my_flutter_project/my_app_colors.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ignore: must_be_immutable
class CreateAcount extends StatefulWidget {
  const CreateAcount({super.key});

  @override
  State<CreateAcount> createState() => _CreateAcountState();
}

class _CreateAcountState extends State<CreateAcount> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  bool passVisible = true;

  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إنشاء حساب"), centerTitle: true),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: MyAppColors.clrBackground,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            children: [
              SizedBox(height: 10),

              makeTextField(
                fullNameController,
                Icon(Icons.person),
                "الاسم الكامل",
              ),
              makeTextField(
                userNameController,
                Icon(Icons.verified_user),
                "اسم المستخدم",
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
                    labelText: " كلمة المرور ",
                    labelStyle: TextStyle(
                      color: MyAppColors.blueBase,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // setState(() {
                        //   passVisible = !passVisible;
                        // });
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
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: BoxBorder.all(
                    width: 2,
                    color: MyAppColors.clrNegativeAppColor,
                  ),
                ),
                child: Column(
                  children: [
                    _selectedImage != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(_selectedImage!),
                          )
                        : CircleAvatar(radius: 60, child: Text("no photo")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          label: Text(
                            " المعرض",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          icon: Icon(Icons.photo, size: 30),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _pickImage(ImageSource.camera),
                          label: Text(
                            "الكاميرا",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          icon: Icon(Icons.photo_camera, size: 30),
                        ),
                      ],
                    ),
                  ],
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
                      if (passwordController.text.isNotEmpty &&
                          userNameController.text.isNotEmpty &&
                          fullNameController.text.isNotEmpty &&
                          _selectedImage != null) {
                        if (UsersInfo.usersInfo.containsKey(
                          userNameController.text,
                        )) {
                          showErrorDailog(
                            context,
                            "اسم المستخدم هذا موجود بالفعل",
                          );
                        } else {
                          UsersInfo.usersInfo.addAll({
                            userNameController.text: {
                              'full_name': fullNameController.text,
                              'password': passwordController.text,
                            },
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        }
                      } else {
                        showErrorDailog(
                          context,
                          "يرجى ملء جميع الحقول وإضافة صورة",
                        );
                      }
                    });
                  },
                  child: Text(
                    "إنشاء",
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
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "لديك حساب؟ تسجيل الدخول",
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
      ),
    );
  }

  Future<dynamic> showErrorDailog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.red,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel),
          ),
        ],
        backgroundColor: Colors.amber.shade300,
        title: Icon(Icons.error_outline, color: Colors.red),
      ),
    );
  }

  Container makeTextField(
    TextEditingController controller,
    Icon icon,
    String label,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(color: MyAppColors.clrNegativeAppColor, fontSize: 18),
        decoration: InputDecoration(
          fillColor: MyAppColors.clrBaseAppColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: MyAppColors.blueBase),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: MyAppColors.blueBase),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: MyAppColors.blueBase,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          suffixIcon: icon,
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
