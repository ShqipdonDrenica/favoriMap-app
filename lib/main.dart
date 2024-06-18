import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:favori_map/src/features/auth/cubits/user_cubit.dart';
import 'package:favori_map/src/features/auth/screens/login_screen.dart';
import 'package:favori_map/src/features/auth/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()
        ..checkCurrentUser(), // Check current user's authentication state
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FavoriMap',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              return const HomePageScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
        // Define your routes here if needed
        // routes: {
        //   '/home': (context) => HomePageScreen(),
        //   '/login': (context) => LoginPage(),
        // },
      ),
    );
  }
}
