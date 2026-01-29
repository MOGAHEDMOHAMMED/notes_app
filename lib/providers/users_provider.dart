// import 'package:get/get.dart';
// import 'package:my_flutter_project/models/users_model.dart';

// class UsersController extends GetxController {
//   var passVisible = false.obs;
//   UsersModel user = UsersModel(userName: '', fullName: '', password: '');
//   void addUser(String userName, String fullName, String password) {
//     if (!userExists(userName)) {
//       throw Exception('Username already exists');
//     } else if (userName.isEmpty || fullName.isEmpty || password.isEmpty) {
//       throw Exception('All fields are required');
//     } else {
//       UsersData.usersData[userName] = {
//         'full_name': fullName,
//         'password': password,
//       };
//     }
//   }

//   bool userExists(String userName) {
//     return UsersData.usersData.containsKey(userName);
//   }

//   void clearUsers() {
//     UsersData.usersData.clear();
//   }

//   void updateUserPassword(String userName, String newPassword) {
//     if (UsersData.usersData.containsKey(userName)) {
//       UsersData.usersData[userName]!['password'] = newPassword;
//     } else {
//       throw Exception('Username does not exist');
//     }
//   }

//   void togglePasswordVisibility() {
//     passVisible.value = !passVisible.value;
//   }

//   bool get passwordVisibility => passVisible.value;
//   void validateLogin(String userName, String password) {
//     if (userName.isEmpty || password.isEmpty) {
//       throw Exception('All fields are required');
//     }
//     if ((!UsersData.usersData.containsKey(userName)) ||
//         UsersData.usersData[userName]!['password'] != password) {
//       throw Exception('Username does not exist');
//     }
//   }
// }
