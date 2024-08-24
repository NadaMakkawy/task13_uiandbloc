import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import '../../models/course.dart';
import '../../models/lecture.dart';
import '../../utils/app_enums.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseInitial()) {
    on<CourseFetchEvent>(_onGetCourse);
    on<CourseOptionChosenEvent>(_onCourseOptionChosen);
    on<LectureChosenEvent>(_onLectureChosen);
  }
  Course? course;
  CourseOptions? lastSelectedOption;

  FutureOr<void> _onGetCourse(
      CourseFetchEvent event, Emitter<CourseState> emit) {
    if (course != null) {
      course = null;
    }
    course = event.course;
    emit(CourseOptionStateChanges(CourseOptions.Lecture));
    // lastSelectedOption = CourseOptions.Lecture;
  }

  FutureOr<void> _onCourseOptionChosen(
      CourseOptionChosenEvent event, Emitter<CourseState> emit) {
    emit(CourseOptionStateChanges(event.courseOptions));
    // lastSelectedOption = event.courseOptions;
  }

  FutureOr<void> _onLectureChosen(
      LectureChosenEvent event, Emitter<CourseState> emit) {
    emit(LectureChosenState(
        event.lecture, lastSelectedOption ?? CourseOptions.Lecture));
    emit(CourseOptionStateChanges(lastSelectedOption!));
  }
}
