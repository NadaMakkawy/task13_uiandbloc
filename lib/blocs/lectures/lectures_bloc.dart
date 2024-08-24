// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// import '../../models/lecture.dart';
// import '../../utils/app_enums.dart';

// part 'lecture_event.dart';
// part 'lecture_state.dart';

// class LectureBloc extends Bloc<LectureEvent, LectureState> {
//   LectureBloc() : super(LectureInitial()) {
//     on<LectureFetchEvent>(_onGetLecture);

//     on<LectureChosenEvent>(_onLectureChosen);
//   }

//   Lecture? lecture;

//   FutureOr<void> _onGetLecture(event, Emitter<LectureState> emit) {
//     lecture = event.lecture;
//     emit(CoursesOptionStateChanges(CourseOptions.Lecture));
//   }

//   FutureOr<void> _onLectureChosen(
//       LectureChosenEvent event, Emitter<LectureState> emit) {
//     emit(LectureChosenState(event.lecture));
//   }
// }
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/lecture.dart';

part 'lectures_event.dart';
part 'lectures_state.dart';

class LecturesBloc extends Bloc<LecturesEvent, LecturesState> {
  LecturesBloc() : super(LecturesInitial()) {
    on<LecturesFetchEvent>(_onFetchLectures);
    on<LecturesSelectedEvent>(_onSelectLecture);
  }

  FutureOr<void> _onFetchLectures(
      LecturesFetchEvent event, Emitter<LecturesState> emit) {
    emit(LecturesLoaded(event.lectures));
  }

  FutureOr<void> _onSelectLecture(
      LecturesSelectedEvent event, Emitter<LecturesState> emit) {
    emit(LecturesChosenState(event.selectedLecture));
  }
}
