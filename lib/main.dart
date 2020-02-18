import 'package:flutter/material.dart';
import 'package:notes_app/models/note_list.dart';
import 'package:notes_app/new_note.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'models/note.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesApp(),
    );
  }
}

class NotesApp extends StatefulWidget {
  @override
  _NotesAppState createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  NoteList noteList = new NoteList();

  void _addNewNote(String title, String desc) {
    final newNote = Notes(titleNote: title, descriptionNote: desc);
    setState(() {
      noteList.addNotes(newNote);
    });
  }

  void _showEditNote(BuildContext context, String title, String desc) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewNote(_addNewNote, title, desc);
        });
  }

  void _showAddNote(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewNote(_addNewNote, "", "");
        });
  }

  void _deleteNote(String title, String description) {
    setState(() {
      noteList
          .deleteNote(Notes(titleNote: title, descriptionNote: description));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Notes"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _showAddNote(context);
              });
            },
          )
        ],
      ),
      body: Builder(
        builder: (context) => noteList.isEmptyNoteList()
            ? Container(
//              padding: EdgeInsets.only(top: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "images/empty.jpg",
                          height: 150,
                          width: 150,
                        ),
                        Text(
                          "No any note added yet!",
                          style: TextStyle(fontSize: 24.0),
                        )
                      ],
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: noteList.getNoteListLength(),
                itemBuilder: (ctx, index) {
                  return Slidable(
                      actions: <Widget>[
                        IconSlideAction(
                          caption: "Complete",
                          color: Colors.green,
                          icon: Icons.check_circle,
                          onTap: () {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("Completed !")));
                          },
                        )
                      ],
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.2,
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: "Edit",
                          color: Colors.green,
                          icon: Icons.edit,
                          onTap: () {
                            setState(() {
                              _showEditNote(
                                  context,
                                  noteList.noteList[index].titleNote,
                                  noteList.noteList[index].descriptionNote);
                            });
                          },
                        ),
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            _deleteNote(noteList.noteList[index].titleNote,
                                noteList.noteList[index].descriptionNote);
                          },
                        ),
                      ],
                      child: ListTile(
                        title: Text(
                          noteList.noteList[index].titleNote,
                          textAlign: TextAlign.start,
                        ),
                        subtitle: Text(noteList.noteList[index].descriptionNote,
                            textAlign: TextAlign.center),
                      )
//                    child: Dismissible(
//                      key: Key(noteList.noteList[index].titleNote),
//                      onDismissed: (direction) {
//                        setState(() {
//                          noteList.noteList.removeAt(index);
//                        });
//                        Scaffold.of(context).showSnackBar(
//                            SnackBar(content: Text("Completed !")));
//                      },
//                      background: Container(color: Colors.red),
//                      child: ListTile(
//                        title: Text(
//                          noteList.noteList[index].titleNote,
//                          textAlign: TextAlign.start,
//                        ),
//                        subtitle: Text(noteList.noteList[index].descriptionNote,
//                            textAlign: TextAlign.center),
//                      ),
//                    ),
                      );
                }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _showAddNote(context);
          });
        },
      ),
    );
  }
}
