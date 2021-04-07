import 'package:memechat/helper/constants.dart';
import 'package:memechat/models/user.dart';
import 'package:memechat/services/database.dart';
import 'package:memechat/views/chat.dart';
import 'package:memechat/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;
  QuerySnapshot searchResultSnapshot1;

  bool isLoading = false;
  bool haveUserSearched = false;
  // bool showagain = false;

  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .searchByName(searchEditingController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  // searchmyusers(String name, int index) async {
  //   print(name);
  //   await databaseMethods.searchByName(name).then((snapshot) {
  //     if (mounted) {
  //       setState(() {
  //         searchResultSnapshot1 = snapshot;
  //       });
  //     }
  //   });
  //   if (index == widget.ls.length - 1) {
  //     if (mounted) {
  //       setState(() {
  //         showagain = false;
  //       });
  //     }
  //   }
  // }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            itemCount: searchResultSnapshot.documents.length,
            itemBuilder: (context, index) {
              return userTile(
                searchResultSnapshot.documents[index].data["userName"],
                searchResultSnapshot.documents[index].data["userEmail"],
              );
            })
        : GestureDetector();
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userName) {
    List<String> users = [Constants.myName, userName];

    String chatRoomId = getChatRoomId(Constants.myName, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                  userName: userName,
                )));
    print(userName);
  }

  Widget userTile(String userName, String userEmail) {
    return GestureDetector(
      onTap: () {
        sendMessage(userName);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0XFFFFC629)),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/userchat.jpg"),
                        radius: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 13,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userName,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userEmail,
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0XFF524e4d)),
        // automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              flex: 7,
              child: TextField(
                controller: searchEditingController,
                style: TextStyle(color: Colors.black, fontSize: 24),
                decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Color(0XFF524e4d)),
                    border: InputBorder.none),
              ),
            ),
            GestureDetector(
              onTap: () {
                initiateSearch();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.search,
                  color: Color(0XFF524e4d),
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0XFFFFC629),
        elevation: 0.0,
      ),
      body: (isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
              child: Container(
                child: SafeArea(
                  child: Container(
                    child: userList(),
                  ),
                ),
              ),
            )),
    );
  }
}
