import 'dart:async';

import 'package:bloc/bloc.dart';

import 'lecture_event.dart';
import 'lecture_state.dart';

class LectureBloc extends Bloc<LectureEvent, LectureState> {
  LectureBloc() : super(LectureInitial()) {
    on<LectureEvent>((event, emit) {});
    on<LectureChosenEvent>(_onLectureChosen);
  }

  FutureOr<void> _onLectureChosen(
      LectureChosenEvent event, Emitter<LectureState> emit) {
    emit(LectureChosenState(event.lecture));
  }
}
