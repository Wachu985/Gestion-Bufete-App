import 'package:flutter/material.dart';
import 'package:gestion_bufete_app/src/app.dart';
import 'package:gestion_bufete_app/src/core/dependency_inyection/dependency_inyection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}
