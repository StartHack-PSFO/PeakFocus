import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuroapp/views/loadingView.dart';
import 'package:flutter/services.dart';
import 'package:neuroapp/views/resultView.dart';

import 'views/data_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DataController());
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xF6E81D), brightness: Brightness.dark),
        useMaterial3: true,
        fontFamily: 'Raleway',
      ),
      home: const LoadingView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
