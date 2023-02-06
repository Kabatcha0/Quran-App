import 'package:flutter/material.dart';
import 'package:quran/modules/surah.dart';
import 'package:quran/shared/const.dart';
import 'package:quran/shared/local/lang.dart';

void navigator(context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget noOfAyah({required int i}) {
  return Text(
    "\uFD3E${(i + 1).toString().toArabicNumbers}\uFD3F",
    style: const TextStyle(
        fontFamily: "quran",
        color: Colors.white,
        fontSize: 25,
        shadows: [
          Shadow(
              blurRadius: 1,
              offset: Offset(0.5, 0.5),
              color: Colors.amberAccent)
        ]),
  );
}

Widget verseBuilder(int index, int prev, List arabic) {
  return Row(
    children: [
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            arabic[index + prev]["aya_text"],
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: arabicFontSize,
                fontFamily: "quran",
                color: const Color.fromARGB(196, 0, 0, 0)),
          )
        ],
      ))
    ],
  );
}

// عشان البسملة مش موجودة فى سورةالتوبة و موجود كأية فى سورة الفاتحة
Widget basmala() {
  return Text(
    "بسم الله الرحمن الرحيم",
    textAlign: TextAlign.center,
    style: TextStyle(
        fontSize: mushafFontSize,
        fontFamily: "quran",
        color: const Color.fromARGB(196, 0, 0, 0)),
  );
}

Widget indexRow(
    {required int i,
    required String sura,
    required BuildContext context,
    required List quran}) {
  return InkWell(
    onTap: () {
      navigator(
          context, Surah(arabic: quran, ayah: 0, sura: i, suraName: sura));
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        noOfAyah(i: i),
        Text(sura,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontFamily: 'quran',
                shadows: [
                  Shadow(
                    offset: Offset(.5, .5),
                    blurRadius: 1.0,
                    color: Color.fromARGB(255, 130, 130, 130),
                  )
                ]))
      ],
    ),
  );
}

PopupMenuItem popUpItem(
    {required IconData icon,
    required Function() function,
    required String text}) {
  return PopupMenuItem(
    onTap: function,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon),
        Text(
          text,
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

Widget listTile({
  required Function() function,
  required IconData icon,
  required String data,
}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(
      data,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    ),
    onTap: function,
  );
}

Widget slider({
  required double value,
  required double min,
  required double max,
  required Function(double) function,
  required double fontSize,
}) {
  return Column(
    children: [
      Slider(
        inactiveColor: Colors.white,
        value: value,
        onChanged: function,
        min: min,
        max: max,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        "بسم الله الرحمن الرحيم",
        style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
      )
    ],
  );
}

Widget setSetting({required String text, required Function() function}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(8)),
    child: MaterialButton(
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
