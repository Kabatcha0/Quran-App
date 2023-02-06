import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/bloc/cubit.dart';
import 'package:quran/bloc/states.dart';
import 'package:quran/modules/splash.dart';
import 'package:quran/shared/local/local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await CacheHelper.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranCubit()..fromJson(),
      child: BlocConsumer<QuranCubit, QuranStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          title: 'Quran App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.blueAccent,
              appBarTheme: const AppBarTheme(color: Colors.blueAccent)),
          home: const Splash(),
        ),
      ),
    );
  }
}
