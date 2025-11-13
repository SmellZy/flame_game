part of 'egg_bloc.dart';

@immutable
sealed class EggEvent {}

class GetAllEggsEvent extends EggEvent {}

class GetEggByIdEvent extends EggEvent {
  final int id;

  GetEggByIdEvent({required this.id});
}
