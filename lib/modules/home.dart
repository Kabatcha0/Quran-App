import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/bloc/cubit.dart';
import 'package:quran/bloc/states.dart';
import 'package:quran/components/components.dart';
import 'package:quran/modules/settings.dart';
import 'package:quran/modules/surah.dart';
import 'package:quran/shared/const.dart';
import 'package:quran/shared/local/local.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranStates>(
        builder: (context, state) {
          var cubit = QuranCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "Quran",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: Search(quran: cubit.arabicName));
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 25,
                    ))
              ],
            ),
            drawer: Drawer(
              backgroundColor: Colors.white,
              elevation: 0,
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/man.png",
                            fit: BoxFit.fill,
                            height: 160,
                            width: 160,
                          ),
                        )),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              listTile(
                                  function: () {
                                    navigator(context, const Settings());
                                  },
                                  icon: Icons.settings,
                                  data: "Settings"),
                              const SizedBox(height: 10),
                              listTile(
                                  function: () {
                                    log("message");
                                    Share.share(
                                        'check out my website https://google.com',
                                        subject: 'Look what I made!');
                                    Navigator.pop(context);
                                  },
                                  icon: Icons.share,
                                  data: "Share"),
                              const SizedBox(height: 10),
                              listTile(
                                  function: () async {
                                    if (!await launchUrl(link,
                                        mode: LaunchMode.externalApplication)) {
                                      throw "error";
                                    }
                                  },
                                  icon: Icons.star,
                                  data: "Rating"),
                            ],
                          ),
                        )),
                  ],
                ),
              )),
            ),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    cubit.fClicked = false;
                    return indexRow(
                        i: index,
                        sura: cubit.arabicName[index]["name"],
                        context: context,
                        quran: cubit.json);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: cubit.arabicName.length),
            )),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                cubit.fClicked = true;

                navigator(
                    context,
                    Surah(
                        arabic: cubit.json,
                        sura: CacheHelper.getInteger(key: "surah"),
                        ayah: CacheHelper.getInteger(key: "ayah"),
                        suraName: cubit.arabicName[
                            CacheHelper.getInteger(key: "surah")]["name"]));
              },
              child: const Icon(Icons.bookmark),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        },
        listener: (context, state) {});
  }
}

class Search extends SearchDelegate {
  List quran;
  Search({required this.quran});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(
            Icons.cancel,
            color: Colors.black,
            size: 25,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 25,
          color: Colors.black,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filter = quran.where((element) {
      return element["name"].startsWith(query);
    }).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => SizedBox(
                width: double.infinity,
                child: query == ""
                    ? Text(
                        quran[index]["name"],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        filter[index]["name"],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
          itemCount: query == "" ? quran.length : filter.length),
    );
  }
}
