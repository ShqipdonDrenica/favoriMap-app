import 'package:favori_map/src/features/auth/cubits/user_cubit.dart';
import 'package:favori_map/src/features/auth/screens/home_page.dart';
import 'package:favori_map/src/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded && state is UserLoading) {
          return HomePageScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
