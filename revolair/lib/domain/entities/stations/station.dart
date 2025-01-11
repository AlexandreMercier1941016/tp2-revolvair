import 'package:flutter/material.dart';
class Station {
  final String id;
  final String lat;
  final String long;
  final String slug;
  Color? color;
  Station({required this.id,required this.lat,required this.long, required this.slug, this.color});
  
   factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
        id: json['id'].toString(),
        lat: json['lat'].toString(),
        long: json['long'].toString(),
        slug: json['slug'].toString(),
        color: Colors.grey);
  }
 @override
  String toString() {
    return 'Station{id: $id, lat: $lat, long: $long, slug: $slug}';
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lat': lat,
      'long': long,
      'slug': slug,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Station &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            lat == other.lat &&
            long == other.long &&
            slug == other.slug;
  }

  @override
  int get hashCode {
    return id.hashCode ^ lat.hashCode  ^ long.hashCode ^ slug.hashCode;
  }
}
