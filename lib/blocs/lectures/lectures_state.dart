part of 'lectures_bloc.dart';

@immutable
sealed class LecturesState {}

class LecturesInitial extends LecturesState {}

class LecturesLoaded extends LecturesState {
  final List<Lecture> lectures;

  LecturesLoaded(this.lectures);
}

class LecturesChosenState extends LecturesState {
  final Lecture lecture;

  LecturesChosenState(this.lecture);
}
