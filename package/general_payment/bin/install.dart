import 'dart:io';

import 'package:general_lib/general_lib.dart';

void main(List<String> args) {
  Dart.pub
      .installFromDirectoryFresh(directoryPackage: Directory.current)
      .printPretty();
}
