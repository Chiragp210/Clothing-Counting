
import 'package:hive/hive.dart';

part 'Cloths.g.dart';

@HiveType(typeId: 1)
class Cloths extends HiveObject{
  @HiveField(0)
  DateTime? date;
  @HiveField(1)
  int? pants;
  @HiveField(2)
  int? shirts;
  @HiveField(3)
  int? tshirts;
  @HiveField(4)
  int? shorts;
  @HiveField(5)
  int? towel;
  @HiveField(6)
  int? tracks;
  @HiveField(7)
  int? covers;
  @HiveField(8)
  int? total;

  Cloths(
      {required this.date,
        required this.pants,
        required this.shirts,
        required this.tshirts,
        required this.shorts,
        required this.towel,
        required this.tracks,
        required this.covers,
        required this.total});

  Cloths.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    pants = json['pants'];
    shirts = json['shirts'];
    tshirts = json['tshirts'];
    shorts = json['shorts'];
    towel = json['towel'];
    tracks = json['tracks'];
    covers = json['covers'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['pants'] = this.pants;
    data['shirts'] = this.shirts;
    data['tshirts'] = this.tshirts;
    data['shorts'] = this.shorts;
    data['towel'] = this.towel;
    data['tracks'] = this.tracks;
    data['covers'] = this.covers;
    data['total'] = this.total;
    return data;
  }
}