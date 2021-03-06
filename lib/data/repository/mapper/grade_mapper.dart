import 'package:registro_elettronico/data/db/moor_database.dart' as db;
import 'package:registro_elettronico/domain/entity/api_responses/grades_response.dart';
import 'package:registro_elettronico/utils/global_utils.dart';

class GradeMapper {
  const GradeMapper();

  db.Grade convertGradeEntityToInserttable(Grades grade) {
    return db.Grade(
      subjectId: grade.subjectId ?? -1,
      subjectDesc: grade.subjectDesc ?? "",
      evtId: grade.evtId ?? -1,
      evtCode: grade.evtCode ?? "",
      eventDate: DateTime.parse(grade.evtDate) ?? DateTime.now(),
      decimalValue: grade.decimalValue ?? -1.00,
      displayValue: grade.displayValue ?? "",
      displayPos: grade.displaPos ?? 1,
      notesForFamily: grade.notesForFamily ?? "",
      cancelled: grade.canceled ?? false,
      underlined: grade.underlined ?? false,
      periodPos: grade.periodPos ?? -1,
      periodDesc: grade.periodDesc ?? "",
      componentPos: grade.componentPos ?? -1,
      componentDesc: grade.componentDesc ?? "",
      weightFactor: grade.weightFactor ?? 1,
      skillId: grade.skillId ?? -1,
      gradeMasterId: grade.gradeMasterId ?? -1,
    );
  }
}
