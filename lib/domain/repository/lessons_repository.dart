import 'package:registro_elettronico/data/db/moor_database.dart';

abstract class LessonsRepository {
  // Future<List<Lesson>> getLessons(String studentId);
  ///Get the lessons for a date
  Future<List<Lesson>> getDateLessons(DateTime date);

  /// Updates the lessons only for the [current] day
  Future upadateTodayLessons();

  /// Updates [all] the lessons
  Future updateAllLessons();

  ///Delete all lessons
  Future deleteLessons();

  ///Gets only the lessons that are not 'sostegno'
  Stream<List<Lesson>> watchRelevantLessons();

  /// Gets the lesson ignoring sostegno
  Stream<List<Lesson>> watchRelevantLessonsOfToday(DateTime today);

  /// Gets the lessons ordering by a date
  Stream<List<Lesson>> watchLessonsOrdered();

  ///Gets the lessons by a date
  Stream<List<Lesson>> watchLessonsByDate(DateTime date);

  Stream<List<Lesson>> watchLessonsByDateGrouped(DateTime date);

  ///Gets the last lessons from a date
  Stream<List<Lesson>> watchLastLessons();

  /// Future of all the lessons
  Future<List<Lesson>> getLessons();

  // Stream all the lessons
  Stream<List<Lesson>> watchLessons();

  /// Inserts a single lesson
  Future insertLesson(Lesson lesson);

  /// Inserts a list of lessons
  Future insertLessons(List<Lesson> lessonsToInsert);
}
