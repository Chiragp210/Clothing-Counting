

import 'package:hive/hive.dart';

import '../Models/Cloths.dart';

class Boxes {

  static Box<Cloths> getData() => Hive.box<Cloths>('clothcounting');
}