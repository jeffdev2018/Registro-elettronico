import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:registro_elettronico/data/db/moor_database.dart';

abstract class AttachmentDownloadEvent extends Equatable {
  const AttachmentDownloadEvent();

  @override
  List<Object> get props => [];
}

class DownloadAttachment extends AttachmentDownloadEvent {
  final Notice notice;
  final Attachment attachment;
  DownloadAttachment({
    @required this.notice,
    @required this.attachment,
  });
}
