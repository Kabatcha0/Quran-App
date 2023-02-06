import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/bloc/cubit.dart';
import 'package:quran/bloc/states.dart';
import 'package:quran/components/components.dart';
import 'package:quran/shared/const.dart';
import 'package:quran/shared/local/local.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Surah extends StatefulWidget {
  int ayah;
  String suraName;
  int sura;
  List arabic;
  Surah(
      {super.key,
      required this.arabic,
      required this.ayah,
      required this.sura,
      required this.suraName});

  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  bool view = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = QuranCubit.get(context);
        if (cubit.fClicked) {
          view = true;
          cubit.binding(widget.ayah);
        }
        String fullSura = "";
        int prev = 0;
        if (widget.sura + 1 != 1) {
          for (int i = widget.sura - 1; i >= 0; i--) {
            prev = prev + cubit.noOfVerses[i];
          }
        }
        if (!view) {
          for (int i = 0; i < cubit.noOfVerses[widget.sura]; i++) {
            fullSura += widget.arabic[i + prev]["aya_text"];
          }
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(
              widget.suraName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            leading: InkWell(
              onTap: () {
                setState(() {
                  view = !view;
                });
              },
              child: const Icon(
                Icons.book,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          body: view
              ? ScrollablePositionedList.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubit.noOfVerses[widget.sura],
                  itemPositionsListener: cubit.itemPositionsListener,
                  itemScrollController: cubit.itemScrollController,
                  itemBuilder: (context, index) => Column(
                        children: [
                          (index != 0 || widget.sura == 0 || widget.sura == 8)
                              ? const Text("")
                              : basmala(),
                          Container(
                            color: index % 2 != 0
                                ? const Color.fromARGB(255, 253, 251, 240)
                                : const Color.fromARGB(255, 253, 247, 230),
                            child: PopupMenuButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child:
                                      verseBuilder(index, prev, widget.arabic),
                                ),
                                itemBuilder: (context) => [
                                      popUpItem(
                                          icon: Icons.bookmark,
                                          function: () {
                                            cubit.fClicked = false;
                                            CacheHelper.setInteger(
                                                key: "ayah", value: index);
                                            CacheHelper.setInteger(
                                                key: "surah",
                                                value: widget.sura);
                                          },
                                          text: "Bookmark"),
                                      popUpItem(
                                          icon: Icons.share,
                                          function: () {},
                                          text: "share"),
                                    ]),
                          )
                        ],
                      ))
              : ListView(physics: const BouncingScrollPhysics(), children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.sura + 1 != 1 && widget.sura + 1 != 9
                                ? basmala()
                                : const Text(''),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                fullSura, //mushaf mode
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: mushafFontSize,
                                  fontFamily: "quran",
                                  color: const Color.fromARGB(196, 44, 44, 44),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
        );
      },
    );
  }
}
