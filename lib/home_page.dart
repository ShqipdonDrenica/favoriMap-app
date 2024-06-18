// import 'dart:collection';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:favori_map/favourite_places.dart';
// import 'package:favori_map/map_view_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:favori_map/auth.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final User? user = Auth().currentUser;
//   Map<String, dynamic>? userData;

//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }

//   Future<void> fetchUserData() async {
//     if (user != null) {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user!.uid)
//           .get();

//       if (userDoc.exists) {
//         setState(() {
//           userData = userDoc.data() as Map<String, dynamic>?;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green.withOpacity(0.5),
//         centerTitle: false,
//         title: const Row(
//           children: [
//             Image(
//               image: AssetImage('assets/map.png'),
//               height: 30,
//             ),
//             Text('FavoriMap'),
//           ],
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 9.0),
//             child: ElevatedButton(
//               onPressed: () async {
//                 await Auth().signOut();
//               },
//               child: const Text(
//                 'Sign Out',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: userData == null
//           ? const Center(child: CircularProgressIndicator())
//           : Container(
//               width: double.infinity,
//               height: double.infinity,
//               padding: const EdgeInsets.all(16.0), // Add some padding
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (userData!['profile_picture'] != null &&
//                       userData!['profile_picture'].isNotEmpty)
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundImage:
//                           NetworkImage(userData!['profile_picture']),
//                     ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           userData!['first_name'] ?? 'First Name',
//                           style: TextStyle(fontSize: 20),
//                           softWrap: true,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Text(
//                           userData!['last_name'] ?? 'Last Name',
//                           style: TextStyle(fontSize: 20),
//                           softWrap: true,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Text(
//                           userData!['email'] ?? 'User Email',
//                           style: TextStyle(fontSize: 20),
//                           softWrap: true,
//                           overflow: TextOverflow.clip,
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => MapViewPage()),
//                             );
//                           },
//                           child: const Text(
//                             'Go to map',
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => FavoritePlacesScreen()),
//                             );
//                           },
//                           child: const Text(
//                             'Go to favourite places',
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
