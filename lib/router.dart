import 'package:flutter/material.dart';
import 'package:googledocclone/Screens/document_screen.dart';
import 'package:googledocclone/Screens/home_screen.dart';
import 'package:googledocclone/Screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(child: HomeScreen()),
  '/document/:id':  (route) =>  MaterialPage(child: DocumentScreen(id: route.pathParameters['id'] ?? '')),
});