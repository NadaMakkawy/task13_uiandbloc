import '../../models/lecture.dart';

sealed class LectureState {}

final class LectureInitial extends LectureState {}

class LectureChosenState extends LectureState {
  final Lecture lecture;
  LectureChosenState(this.lecture);
}
