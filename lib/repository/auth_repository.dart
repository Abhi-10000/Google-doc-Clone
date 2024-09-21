// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/constants.dart';
import 'package:googledocclone/models/error_model.dart';
import 'package:googledocclone/models/user_model.dart';
import 'package:googledocclone/repository/local_storagerepository.dart';
import 'package:http/http.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
    localStoragerepository: LocalStoragerepository(),
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final LocalStoragerepository _localStoragerepository;
  AuthRepository(
      {required GoogleSignIn googleSignIn,
      required Client client,
      required LocalStoragerepository localStoragerepository})
      : _googleSignIn = googleSignIn,
        _client = client,
        _localStoragerepository = localStoragerepository;

  Future<ErrorModel> SignInWithGoogle() async {
    ErrorModel error = ErrorModel(
      error: 'Some Unexpected error occured!!',
      data: null,
    );
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = UserModel(
          profilepic: user.photoUrl??'',
          name: user.displayName??'',
          email: user.email,
          uid: '',
          token: '',
        );

        var res = await _client.post(Uri.parse('$host/api/signup'),
            body: userAcc.toJson(),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            });

        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
              token: jsonDecode(res.body)['token'],
            );
            error = ErrorModel(error: null, data: newUser);
            _localStoragerepository.setToken(newUser.token);
            break;
        }
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> getUserData() async {
    ErrorModel error = ErrorModel(
      error: 'Some Unexpected error occured!!',
      data: null,
    );
    try {
      String? token = await _localStoragerepository.getToken();
      if (token != null) {
        var res = await _client.get(Uri.parse('$host/'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });
        switch (res.statusCode) {
          case 200:
            final newUser = UserModel.fromJson(
              jsonEncode(
                jsonDecode(res.body)['user'],
              ),
            ).copyWith(
              token: token,
            );
            error = ErrorModel(error: null, data: newUser);
            _localStoragerepository.setToken(newUser.token);
            break;
        }
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }


  void signout() async{
    await _googleSignIn.signOut();
    _localStoragerepository.setToken('');
  }
}
