import '../../models/lecture.dart';

sealed class LectureEvent {}

class LectureChosenEvent extends LectureEvent {
  final Lecture lecture;
  LectureChosenEvent(this.lecture);
}
