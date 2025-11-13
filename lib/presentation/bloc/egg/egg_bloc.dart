import 'package:bloc/bloc.dart';
import 'package:flame_game/domain/entities/egg.dart';
import 'package:flame_game/domain/repositories/Egg_repository.dart';
import 'package:flutter/material.dart';

part 'egg_event.dart';
part 'egg_state.dart';

class EggBloc extends Bloc<EggEvent, EggState> {
  final EggRepository repository;

  EggBloc(this.repository) : super(EggInitial()) {
    on<GetAllEggsEvent>(_onGetAllEggs);
    on<GetEggByIdEvent>(_onGetEggById);
  }

  Future<void> _onGetAllEggs(
    GetAllEggsEvent event,
    Emitter<EggState> emit,
  ) async {
    try {
      emit(EggsLoading());
      final eggs = await repository.getAllEggs();
      emit(EggsLoaded(eggs: eggs));
    } catch (error) {
      emit(EggError(message: error.toString()));
    }
  }

  Future<void> _onGetEggById(
    GetEggByIdEvent event,
    Emitter<EggState> emit,
  ) async {
    try {
      emit(EggLoading());
      final egg = await repository.getEggByNumber(event.id);

      if (egg != null) {
        emit(EggLoaded(egg: egg));
      } else {
        emit(EggError(message: 'Egg ${event.id} not found.'));
      }
    } catch (error) {
      emit(EggError(message: error.toString()));
    }
  }
}
