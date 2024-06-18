import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:favori_map/src/features/auth/cubits/user_cubit.dart';
import 'package:favori_map/src/features/auth/screens/home_page.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController profilePictureController =
      TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLogin = true;

    return Scaffold(
      appBar: AppBar(title: const Text('FavoriApp')),
      body: BlocProvider(
        create: (context) => UserCubit(),
        child: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is UserLoaded) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePageScreen()),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isLogin)
                      Column(
                        children: [
                          TextField(
                            controller: firstNameController,
                            decoration:
                                const InputDecoration(labelText: 'First Name'),
                          ),
                          TextField(
                            controller: lastNameController,
                            decoration:
                                const InputDecoration(labelText: 'Last Name'),
                          ),
                          TextField(
                            controller: profilePictureController,
                            decoration: const InputDecoration(
                                labelText: 'Profile Picture URL'),
                          ),
                        ],
                      ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    if (state is UserLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () {
                          if (isLogin) {
                            context
                                .read<UserCubit>()
                                .signInWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text,
                                );
                          } else {
                            context
                                .read<UserCubit>()
                                .createUserWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text,
                                  firstNameController.text,
                                  lastNameController.text,
                                  profilePictureController.text,
                                );
                          }
                        },
                        child: Text(isLogin ? 'Login' : 'Register'),
                      ),
                    TextButton(
                      onPressed: () {
                        isLogin = !isLogin;
                        (context as Element).markNeedsBuild();
                      },
                      child:
                          Text(isLogin ? 'Register instead' : 'Login instead'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
