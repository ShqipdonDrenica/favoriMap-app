import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:favori_map/src/features/auth/cubits/user_cubit.dart';
import 'package:favori_map/src/features/auth/widgets/user_profile_widget.dart';
import 'package:favori_map/src/features/auth/screens/login_screen.dart'; // Import your login screen

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..fetchUserData(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green.withOpacity(0.5),
          centerTitle: false,
          title: const Row(
            children: [
              Image(
                image: AssetImage('assets/map.png'),
                height: 30,
              ),
              Text('FavoriMap'),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 9.0),
              child: ElevatedButton(
                onPressed: () async {
                  await context.read<UserCubit>().signOut();
                  // Navigate to login screen after sign-out
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false, // Clear all previous routes
                  );
                },
                child: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is UserLoaded) {
              if (state.user == null || state.user!.email.isEmpty) {
                return const Center(child: Text('Error loading user data'));
              } else {
                return UserProfileWidget(user: state.user!);
              }
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
