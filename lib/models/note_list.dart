import 'package:notes_app/models/note.dart';

class NoteList {
  List<Notes> noteList = [];

  List getNoteList() {
    return noteList;
  }

  int getNoteListLength() {
    return noteList.length;
  }

  void addNotes(Notes note) {
    noteList.add(note);
  }

  void deleteNote(Notes notes) {
    noteList.removeWhere((nte) {
      return nte.titleNote == notes.titleNote &&
          nte.descriptionNote == notes.descriptionNote;
    });
  }

  bool isEmptyNoteList() {
    if (noteList.length < 1) {
      return true;
    } else {
      return false;
    }
  }
}
