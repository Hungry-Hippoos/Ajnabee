import 'package:memechat/helper/authenticate.dart';
import 'package:memechat/helper/constants.dart';
import 'package:memechat/helper/helperfunctions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:memechat/services/auth.dart';
import 'package:memechat/services/database.dart';
import 'package:memechat/views/chat.dart';
import 'package:memechat/views/search.dart';
import 'package:flutter/material.dart';
import 'package:memechat/widget/chatoptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return ChatRoomsTile(
                        userName: snapshot
                            .data.documents[index].data['chatRoomId']
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(Constants.myName, ""),
                        chatRoomId:
                            snapshot.data.documents[index].data["chatRoomId"],
                      );
                    }),
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // backgroundColor: Color(0xffffc629),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              Expanded(
                child: (GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Search()));
                  },
                  child: Icon(
                    Icons.search,
                    color: Color(0xff524e4d),
                    size: 33,
                  ),
                )),
              ),
              Expanded(
                child: (GestureDetector(
                  onTap: () async {
                    final FirebaseUser user =
                        await FirebaseAuth.instance.currentUser();
                    final String uid = user.email;
                    var temp2;

                    var newuser;
                    final userDoc = await Firestore.instance
                        .collection('users')
                        .where('userEmail', isEqualTo: uid)
                        .limit(1)
                        .getDocuments();

                    if (userDoc.documents.length != 0) {
                      newuser = userDoc.documents[0];
                    }

                    temp2 = newuser.data['userName'];

                    print(temp2);

                    http.Response response = await http.get(
                      "https://48ecbb2b57e1.ngrok.io/rtest/api/rtest/$temp2",
                    );

                    var response_data;

                    if (response.statusCode == 200) {
                      response_data = json.decode(response.body);
                      response_data = response_data["data"];
                    } else {
                      print("error");
                    }

                    var ls = [];

                    if (response_data.length != 0) {
                      for (int i = 0; i < response_data.length; i++) {
                        ls.add(response_data[i]['username']);
                      }
                    }
                    Alert(
                      context: context,
                      type: AlertType.info,
                      title: "MOST COMPATIBLE ",
                      desc: ls.isEmpty
                          ? "Cannot find :( Try again later !"
                          : "Usernames are : $ls",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Got it !",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                    ).show();

                    print(ls);
                  },
                  child: Icon(
                    Icons.refresh,
                    color: Color(0xff524e4d),
                    size: 33,
                  ),
                )),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    AuthService().signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authenticate()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(Icons.exit_to_app,
                        size: 33, color: Color(0xff524e4d)),
                  ),
                ),
              )
            ],
          ),
          elevation: 2,
          backgroundColor: Color(0xffffc629),
          centerTitle: false,
        ),
        body: SafeArea(
          child: Container(
            child: chatRoomsList(),
          ),
        ),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chat(
                        chatRoomId: chatRoomId,
                        userName: userName,
                      )));
        },
        child: Chatopt(userName));
  }
}
