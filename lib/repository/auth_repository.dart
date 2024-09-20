// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => Auth_repo(
    googleSignIn: GoogleSignIn(),
  ),
);

class Auth_repo {
  final GoogleSignIn _googleSignIn;
  Auth_repo({
    required googleSignIn,
  }) : _googleSignIn = googleSignIn;

  void SignInWithGoogle() async {
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        print(user.email);
        print(user.displayName);
        print(user.photoUrl);
      }
    } catch (e) {
      print(e);
    }
  }
}
