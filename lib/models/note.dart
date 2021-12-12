import 'package:flutter/cupertino.dart';
import 'package:nine_chat/models/user.dart';
import 'package:nine_chat/utils/enums/note_color.dart';
import 'package:nine_chat/utils/enums/note_font_type.dart';

class Note {
  final String id;
  final String note;
  final User from;
  final NoteColor noteColor;
  final NoteFontType fontType;
  final DateTime duration;
  final DateTime dateTime;

  Note({
    required this.id,
    required this.note,
    required this.from,
    required this.noteColor,
    required this.fontType,
    required this.duration,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note': note,
      'from': from,
      'noteColr': noteColor.name,
      'fontType': fontType.name,
      'duration': duration,
      'dateTime': dateTime,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      note: json['note'],
      from: json['from'],
      noteColor: NoteColorParser.fromString(json['noteColor']),
      fontType: NoteFontTypeParser.fromString(json['fontType']),
      duration: json['duration'],
      dateTime: json['dateTime'],
    );
  }
}
