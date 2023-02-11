import 'package:flutter/material.dart';

class Utill {
  //function final
  static String removeSlangWords({required String inputtext}) {
    String ans = '';
    ans = findSlang(inputtext.toUpperCase());
    return ans;
  }

  static List<String> removeSlang(
      List<List<String>> slangWords, char, index, str) {
    var temp = str.split(" ");
    for (int i = 0; i < temp.length; i++) {
      if (temp[i].substring(0, 1) == char) {
        for (int i = 0; i < slangWords[index].length; i++) {
          for (int j = 0; j < temp.length; j++) {
            if (temp[j] == slangWords[index][i]) {
              temp.remove(temp[j]);
            }
          }
        }
      }
    }
    return temp;
  }

  //function 2
  static String findSlang(String inputtext) {
    String text = inputtext;
    var myArr = [
      "wanker",
      "yuck",
      "Yaar",
      "Chakkar",
      "Ghanta",
      "Bak Bak",
      "Bakwas",
      "Baap re Baap",
      "chup",
      "piss",
      "prick",
      "pussy",
      "shit",
      "shit ass",
      "shite",
      "sisterfucker",
      "slut",
      "son of a bitch",
      "son of a whore",
      "spastic",
      "sweet Jesus",
      "turd",
      "twat",
      "Bhodu",
      "Annd",
      "Jhaat",
      "Bhenchod",
      "Kutiya",
      "Chakka",
      "Hijada",
      "Gand",
      "Bhos",
      "Lodo",
      "Land",
      "Chodu",
      "Chutiya",
      "Madarchod",
      "akkalmattho",
      "akkal no authmir",
      "advitaro",
      "Labaad",
      "lukkho",
      "loda",
      "chodina",
      "chodyaa",
      "Chutmarino",
      "bhosdina",
      "Babuchak",
      "beb thok",
      "Bhadwo",
      "boob thok",
      "budhalal",
      "Dobbo",
      "Sarakbamno",
      "Tel piva ja",
      "Toppa",
      "Vaydino",
      "Kutro",
      "Kutri no",
      "Gando",
      "Nich",
      "Waghri na petno",
      "Harami"
    ];
    for (var i = 0; i < myArr.length; i++) {
      myArr[i] = myArr[i].toUpperCase();
    }

    List<List<String>> slangWords = [];
    slangWords.add(myArr.where((f) => f.startsWith('A')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('B')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('C')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('D')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('E')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('F')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('G')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('H')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('I')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('J')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('K')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('L')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('M')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('N')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('O')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('P')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('Q')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('R')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('S')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('T')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('U')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('V')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('W')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('X')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('Y')).toList());
    slangWords.add(myArr.where((f) => f.startsWith('Z')).toList());
    // print(slangWords);
    // print(removeSlang(slangWords, "A", 0, "ANND BHODU I AM"));

    var arr = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    var str = "";
    str = removeSlang(slangWords, arr[0], 0, text).join(" ");
    for (int j = 0; j < str.length; j++) {
      for (int i = 0; i < 26; i++) {
        if (str[j].substring(0, 1) == arr[i]) {
          str = removeSlang(slangWords, arr[i], i, str).join(" ");
          // print(str);
        }
      }
    }
    return str;
  }

  //print(str);
}
