import 'package:flutter/material.dart';
import 'package:googledocclone/Screens/home_screen.dart';
import 'package:googledocclone/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/repository/auth_repository.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  void SignInWithGoogle(WidgetRef ref, BuildContext context) async {
    final sMessanger = ScaffoldMessenger.of(context);
    final navigator = Routemaster.of(context);
    final errorModel =
        await ref.read(authRepositoryProvider).SignInWithGoogle();
    if (errorModel.error == null) {
      ref.read(userProvider.notifier).update((state) => errorModel.data);
      navigator.replace('/');
    } else {
      sMessanger.showSnackBar(
        SnackBar(
          content: Text(errorModel.error!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => SignInWithGoogle(ref, context),
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
