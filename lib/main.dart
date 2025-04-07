import 'package:flutter/material.dart';
import 'package:winatchai_music_app/app.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  if (kIsWeb) usePathUrlStrategy();

  runApp(const MyApp());
}
