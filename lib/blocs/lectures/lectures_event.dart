part of 'lectures_bloc.dart';

@immutable
sealed class LecturesEvent {}

class LecturesFetchEvent extends LecturesEvent {
  final List<Lecture> lectures;

  LecturesFetchEvent(this.lectures);
}

class LecturesSelectedEvent extends LecturesEvent {
  final Lecture selectedLecture;

  LecturesSelectedEvent(this.selectedLecture);
}
