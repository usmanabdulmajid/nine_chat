enum NoteColor { green, yello, blue, deepPurple, darkGreen }

extension NoteColorParser on NoteColor {
  static NoteColor fromString(String value) {
    NoteColor noteColor =
        NoteColor.values.firstWhere((element) => element.name == value);
    return noteColor;
  }
}
