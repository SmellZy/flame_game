import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/level_model.dart';

abstract class LevelLocalDataSource {
  Future<List<LevelModel>> loadLevels();
}

class LevelLocalDataSourceImpl implements LevelLocalDataSource {
  final String assetPath;

  LevelLocalDataSourceImpl({this.assetPath = 'assets/levels/levels.json'});

  @override
  Future<List<LevelModel>> loadLevels() async {
    final jsonString = await rootBundle.loadString(assetPath);
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList
        .map((e) => LevelModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
