enum NoteFontType { normal, italic, bold }

extension NoteFontTypeParser on NoteFontType {
  static NoteFontType fromString(String font) {
    NoteFontType fontType =
        NoteFontType.values.firstWhere((element) => element.name == font);
    return fontType;
  }
}
