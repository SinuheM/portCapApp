import 'package:flutter/material.dart';
import 'package:domain/domain.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:poke_test/src/app/app_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Domain.init(dotenv.env);
  runApp(const AppPage());
}
