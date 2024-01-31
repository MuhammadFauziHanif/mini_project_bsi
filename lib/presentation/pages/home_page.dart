import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_project_bsi_chat/domain/entities/room.dart';
import 'package:mini_project_bsi_chat/domain/usecases/create_room.dart';
import 'package:mini_project_bsi_chat/domain/usecases/get_messages.dart';
import 'package:mini_project_bsi_chat/presentation/pages/login_page.dart';
import 'package:mini_project_bsi_chat/presentation/pages/chat_page.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/user_room.dart';
import '../../domain/usecases/get_rooms.dart';

enum MenuItem { logout }

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variable
  MenuItem? _selectMenuItem;
  late var box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('user');
  }

  Future<void> _createRoomDialog(BuildContext context) async {
    TextEditingController _destinationController = TextEditingController();
    GlobalKey<FormState> _formRoom = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Create new chat room'),
            content: Form(
              key: _formRoom,
              child: TextFormField(
                controller: _destinationController,
                decoration: InputDecoration(
                  labelText: 'Username destination',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.length == 0) {
                    return 'Username cannot be empty';
                  }
                  return null;
                },
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Batal')),
              TextButton(
                  onPressed: () async {
                    if (_formRoom.currentState!.validate()) {
                      Rooms _room = Rooms(
                        from: box.get('username'),
                        to: _destinationController.text,
                      );
                      String _newRoom = await CreateRoom().execute(_room);
                      box.put(
                          'usernameDestination', _destinationController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPage(_newRoom)));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Berhasil membuat percakapan baru')));
                    }
                  },
                  child: Text('Add')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String _username = box.get('username', defaultValue: '');
    if (box.get('isLogin', defaultValue: false) == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('BSI Chat Application'),
        actions: [
          PopupMenuButton<MenuItem>(
              initialValue: _selectMenuItem,
              itemBuilder: (context) => <PopupMenuEntry<MenuItem>>[
                    PopupMenuItem(
                      value: MenuItem.logout,
                      onTap: () {
                        box.put('isLogin', false);
                        box.put('username', '');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Row(
                        children: [Icon(Icons.logout), Text('Keluar')],
                      ),
                    )
                  ])
        ],
      ),
      body: FutureBuilder<UserRoom>(
        future: GetRooms().execute(_username),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List? listRooms = snapshot.data!.room;
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: List.generate(listRooms!.length, (index) {
                              return FutureBuilder<ChatMessage?>(
                                future: GetMessage().execute(listRooms[index]),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var _users = snapshot.data!.users;
                                    var _messages = snapshot.data!.messages;
                                    var _messagesCheck =
                                        snapshot.data!.messages?.isEmpty;
                                    String _nameMessage =
                                        box.get('username') == _users[1]
                                            ? _users[0]
                                            : _users[1];
                                    String? datetime;
                                    if (_messagesCheck == false) {
                                      var date =
                                          DateTime.fromMillisecondsSinceEpoch(
                                              _messages!.last.timestamp);
                                      datetime = date.year.toString() +
                                          "/" +
                                          date.month.toString() +
                                          "/" +
                                          date.day.toString();
                                    }
                                    return Card(
                                      margin: EdgeInsets.all(10),
                                      color: Colors.white70,
                                      elevation: 10.0,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.all(5),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            child: Text('${_nameMessage[0]}'),
                                          ),
                                          title: Text(
                                            '${_nameMessage}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          subtitle: _messages!.length > 0
                                              ? Text(
                                                  '${_messages.last.text}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : Text(''),
                                          trailing: _messages.length > 0
                                              ? Text('${datetime}')
                                              : Text(''),
                                          onTap: () {
                                            box.put('usernameDestination',
                                                _nameMessage);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatPage(
                                                            listRooms[index])));
                                          },
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  } else {
                                    return Text('');
                                  }
                                },
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Column(
              children: [CircularProgressIndicator()],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createRoomDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
