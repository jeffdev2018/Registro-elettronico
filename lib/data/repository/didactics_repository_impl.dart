import 'package:registro_elettronico/data/db/dao/didactics_dao.dart';
import 'package:registro_elettronico/data/db/dao/profile_dao.dart';
import 'package:registro_elettronico/data/db/moor_database.dart';
import 'package:registro_elettronico/data/network/service/api/spaggiari_client.dart';
import 'package:registro_elettronico/data/repository/mapper/didactics_mapper.dart';
import 'package:registro_elettronico/domain/entity/api_responses/didactics_response.dart';
import 'package:registro_elettronico/domain/repository/didactics_repository.dart';

class DidacticsRepositoryImpl implements DidacticsRepository {
  SpaggiariClient spaggiariClient;
  DidacticsDao didacticsDao;
  ProfileDao profileDao;

  DidacticsRepositoryImpl(
    this.spaggiariClient,
    this.didacticsDao,
    this.profileDao,
  );
  @override
  Future<List<int>> getDidacticsFile() {
    return null;
  }

  @override
  Future updateDidactics() async {
    final profile = await profileDao.getProfile();
    final didactics = await spaggiariClient.getDidactics(profile.studentId);
    List<DidacticsTeacher> teachers = [];
    didactics.teachers.forEach((teacher) {
      List<DidacticsFolder> folders = [];
      final teacherDb =
          DidacticsMapper.convertTeacherEntityToInsertable(teacher);
      teacher.folders.forEach((folder) {
        folders.add(
          DidacticsMapper.convertFolderEntityToInsertable(folder, teacherDb.id),
        );
        List<DidacticsContent> contents = [];
        folder.contents.forEach((content) {
          contents.add(DidacticsMapper.convertContentEntityToInsertable(
              content, folder.folderId));
        });
        didacticsDao.insertContents(contents);
      });

      didacticsDao.insertFolders(folders);
      teachers.add(teacherDb);
    });

    didacticsDao.insertTeachers(teachers);
  }

  @override
  Future<List<DidacticsTeacher>> getTeachersGrouped() {
    return didacticsDao.getTeachersGrouped();
  }

  @override
  Future<List<DidacticsFolder>> getFolders() {
    return didacticsDao.getAllFolders();
  }

  @override
  Future<List<DidacticsContent>> getContents() {
    return didacticsDao.getAllContents();
  }

  @override
  Future<List<int>> getFileAttachment(int fileID) async {
    final profile = await profileDao.getProfile();
    final res = spaggiariClient.getAttachmentFile(profile.studentId, fileID);
    return res;
  }

  @override
  Future<DownloadAttachmentTextResponse> getTextAtachment(int fileID) async {
    final profile = await profileDao.getProfile();
    final res = spaggiariClient.getAttachmentText(profile.studentId, fileID);
    return res;
  }

  @override
  Future<DownloadAttachmentURLResponse> getURLAtachment(int fileID) async {
    final profile = await profileDao.getProfile();
    final res = spaggiariClient.getAttachmentUrl(profile.studentId, fileID);
    return res;
  }
}
