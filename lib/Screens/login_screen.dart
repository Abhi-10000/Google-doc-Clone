import 'package:flutter/material.dart';
import 'package:googledocclone/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/repository/auth_repository.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  void SignInWithGoogle(WidgetRef ref){
    ref.read(authRepositoryProvider).SignInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () =>SignInWithGoogle(ref),
          //icon: Image.asset('assets/Images/g-logo-2.png',height: 20,),
          // icon: Icons.Googl,
          label: const Text(
            'Sign In With Google',
            style: TextStyle(
              color: kblackc,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kwhitec,
            minimumSize: const Size(150, 50),
          ),
        ),
      ),
    );
  }
}
