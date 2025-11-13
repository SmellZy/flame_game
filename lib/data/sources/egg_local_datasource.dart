import 'dart:convert';
import 'package:flame_game/data/models/egg_model.dart';
import 'package:flutter/services.dart' show rootBundle;

abstract class EggLocalDataSource {
  Future<List<EggModel>> loadEggs();
}

class EggLocalDataSourceImpl implements EggLocalDataSource {
  final String assetPath;

  EggLocalDataSourceImpl({this.assetPath = 'assets/eggs/eggs.json'});

  @override
  Future<List<EggModel>> loadEggs() async {
    final jsonString = await rootBundle.loadString(assetPath);
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList
        .map((e) => EggModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
