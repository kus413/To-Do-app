import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_list.dart';

class NewNote extends StatefulWidget {
  final String title;
  final String desc;

  final Function addNotes;
  NewNote(this.addNotes, this.title, this.desc);
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  NoteList noteList;
  void submitData() {
    final enteredTitle = itemTitleController.text;
    final enteredDesc = itemDescController.text;
    if (enteredTitle.isEmpty || enteredDesc.isEmpty) {
      return;
    } else {
      widget.addNotes(enteredTitle, enteredDesc);

      Navigator.pop(context);
    }
  }

  final itemTitleController = new TextEditingController();
  final itemDescController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    itemTitleController.text = widget.title;
    itemDescController.text = widget.desc;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: 500,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: itemTitleController,
                cursorColor: Colors.green,
                onSubmitted: (_) {
                  submitData();
                },
              ),
            ),
            Container(
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(labelText: "Description"),
                controller: itemDescController,
                cursorColor: Colors.green,
                onSubmitted: (_) {
                  submitData();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Colors.green.shade500,
                  onPressed: () {
                    noteList.deleteNote(Notes(
                        titleNote: widget.title, descriptionNote: widget.desc));
                    submitData();
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
