
class PosNoteModel {
  String noteTitle;
  String note;
  
  PosNoteModel({
    required this.noteTitle,
    required this.note
  });

  factory PosNoteModel.fromMap({required Map<String, dynamic> map}) {
    return PosNoteModel(
      noteTitle: map["noteTitle"] ?? '', 
      note: map["note"] ?? '');
  }

  toMap() {
    return {
      "noteTitle": noteTitle,
      "note": note
    };
  }
}