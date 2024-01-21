import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class InfoReader {
  Future<String> getInfo() async {
    String s = "";
    try {
      s = await rootBundle.loadString('assets/data/products.json');
      return s;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> getPathFile(String nameFile) async {
    final f = await getApplicationCacheDirectory();
    return File('${f.path}/$nameFile.json');
  }
}
