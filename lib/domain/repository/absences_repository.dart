import 'package:registro_elettronico/data/db/moor_database.dart';

abstract class AbsencesRepository {
  /// This fetches to the api of spaggiari and updates all the absences
  Future updateAbsences();

  ///Insert an absence
  Future insertEvent(Absence absence);

  /// Stream of all absences
  Stream<List<Absence>> watchAllAbsences();

  Future<List<Absence>> getAllAbsences();
}
