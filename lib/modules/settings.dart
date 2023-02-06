import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/bloc/cubit.dart';
import 'package:quran/bloc/states.dart';
import 'package:quran/components/components.dart';
import 'package:quran/modules/home.dart';
import 'package:quran/shared/const.dart';
import 'package:quran/shared/local/local.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Settings",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              slider(
                  value: arabicFontSize,
                  min: 20,
                  max: 60,
                  function: (v) {
                    setState(() {
                      arabicFontSize = v;
                    });
                  },
                  fontSize: arabicFontSize),
              const SizedBox(
                height: 20,
              ),
              slider(
                  value: mushafFontSize,
                  min: 20,
                  max: 60,
                  function: (v) {
                    setState(() {
                      mushafFontSize = v;
                    });
                  },
                  fontSize: mushafFontSize),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  setSetting(
                      text: "Submit",
                      function: () {
                        CacheHelper.saveSettings();
                        navigator(context, const Home());
                      }),
                  const SizedBox(
                    width: 15,
                  ),
                  setSetting(
                      text: "Reset",
                      function: () {
                        setState(() {
                          arabicFontSize = 28;
                          mushafFontSize = 40;
                        });
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
