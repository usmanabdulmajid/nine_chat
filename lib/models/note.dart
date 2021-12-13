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
  final DateTime date;

  Note({
    required this.id,
    required this.note,
    required this.from,
    required this.noteColor,
    required this.fontType,
    required this.duration,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note': note,
      'from': from.toString(),
      'noteColr': noteColor.name,
      'fontType': fontType.name,
      'duration': duration,
      'dateTime': date,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      note: json['note'],
      from: User.fromSource(json['from']),
      noteColor: NoteColorParser.fromString(json['noteColor']),
      fontType: NoteFontTypeParser.fromString(json['fontType']),
      duration: json['duration'],
      date: json['dateTime'],
    );
  }
}
