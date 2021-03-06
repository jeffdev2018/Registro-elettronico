import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:registro_elettronico/data/db/moor_database.dart';
import 'package:registro_elettronico/domain/repository/lessons_repository.dart';

import './bloc.dart';

/// Bloc for updating all the [lessons]
class LessonsBloc extends Bloc<LessonsEvent, LessonsState> {
  LessonsRepository lessonsRepository;

  LessonsBloc(
    this.lessonsRepository,
  );

  Stream<List<Lesson>> get relevantLessons =>
      lessonsRepository.watchRelevantLessons();

  Stream<List<Lesson>> watchLessonsByDate(DateTime selectedDate) =>
      lessonsRepository.watchLessonsByDate(selectedDate);

  /// With this stream lessosn are grouped so there are no duplicates
  Stream<List<Lesson>> watchLessonsByDateGrouped(DateTime selectedDate) =>
      lessonsRepository.watchLessonsByDateGrouped(selectedDate);

  Stream<List<Lesson>> relevandLessonsOfToday() =>
      lessonsRepository.watchLastLessons();

  @override
  LessonsState get initialState => LessonsNotLoaded();

  @override
  Stream<LessonsState> mapEventToState(
    LessonsEvent event,
  ) async* {
    if (event is FetchTodayLessons) {
      yield LessonsLoading();
      try {
        await lessonsRepository.upadateTodayLessons();
        yield LessonsLoaded();
      } on DioError catch (e) {
        yield LessonsError(e);
      }
    }

    if (event is FetchAllLessons) {
      yield LessonsLoading();
      try {
        await lessonsRepository.updateAllLessons();
        yield LessonsLoaded();
      } on DioError catch (e) {
        yield LessonsError(e);
      }
    }
  }
}
