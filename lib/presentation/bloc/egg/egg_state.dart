part of 'egg_bloc.dart';

@immutable
sealed class EggState {}

final class EggInitial extends EggState {}

final class EggLoading extends EggState {}

final class EggLoaded extends EggState {
  final Egg egg;

  EggLoaded({required this.egg});
}

final class EggsLoading extends EggState {}

final class EggsLoaded extends EggState {
  final List<Egg> eggs;

  EggsLoaded({required this.eggs});
}

final class EggError extends EggState {
  final String message;

  EggError({required this.message});
}
