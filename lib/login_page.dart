// import 'package:favori_map/auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String? errorMessage = '';
//   bool isLogin = true;

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController profilePictureController =
//       TextEditingController();

//   Future<void> signInWithEmailAndPassword() async {
//     try {
//       await Auth().signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   Future<void> createUserWithEmailAndPassword() async {
//     try {
//       await Auth().createUserWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//         firstName: firstNameController.text,
//         lastName: lastNameController.text,
//         profilePicture: profilePictureController.text,
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('FavoriApp')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (!isLogin)
//               Column(
//                 children: [
//                   TextField(
//                     controller: firstNameController,
//                     decoration: const InputDecoration(labelText: 'First Name'),
//                   ),
//                   TextField(
//                     controller: lastNameController,
//                     decoration: const InputDecoration(labelText: 'Last Name'),
//                   ),
//                   TextField(
//                     controller: profilePictureController,
//                     decoration:
//                         const InputDecoration(labelText: 'Profile Picture URL'),
//                   ),
//                 ],
//               ),
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             Text(errorMessage == '' ? '' : 'Error: $errorMessage',
//                 style: const TextStyle(color: Colors.red)),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (isLogin) {
//                   await signInWithEmailAndPassword();
//                 } else {
//                   await createUserWithEmailAndPassword();
//                 }
//               },
//               child: Text(isLogin ? 'Login' : 'Register'),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   isLogin = !isLogin;
//                 });
//               },
//               child: Text(isLogin ? 'Register instead' : 'Login instead'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
