import 'package:flame_game/domain/entities/egg.dart';

class EggModel extends Egg {
  const EggModel({
    required super.id,
    required super.eggIcon,
    required super.buyPrice,
  });

  factory EggModel.fromJson(Map<String, dynamic> json) {
    return EggModel(
      id: json['id'] as int,
      eggIcon: json['eggIcon'],
      buyPrice: json['buyPrice'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eggIcon': eggIcon,
      'buyPrice': buyPrice,
    };
  }
}
