import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledocclone/colors.dart';
import 'package:googledocclone/repository/auth_repository.dart';
import 'package:googledocclone/repository/document_repository.dart';
import 'package:http/http.dart';
import 'package:routemaster/routemaster.dart';

final documentRepositoryProvider = Provider(
  (ref) => DocumentRepository(
    client: Client(),
  ),
);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void SignOut(WidgetRef ref) {
    ref.read(authRepositoryProvider).signout();
    ref.read(userProvider.notifier).update((State) => null);
  }

  void createDocument(BuildContext context, WidgetRef ref) async {
    String token = ref.read(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    final errorModel =
        await ref.read(documentRepositoryProvider).createDocument(token);
    
    if (errorModel.data!=null) {
      navigator.push('/document/${errorModel.data.id}');
    }
    else{
      snackbar.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhitec,
        actions: [
          IconButton(
            onPressed: () {
              createDocument(context, ref);
            },
            icon: const Icon(Icons.add),
            color: kblackc,
          ),
          IconButton(
            onPressed: () {
              SignOut(ref);
            },
            icon: const Icon(Icons.logout),
            color: kredc,
          ),
        ],
      ),
      body: Center(
        child: Text(
          ref.watch(userProvider)!.uid,
        ),
      ),
    );
  }
}
