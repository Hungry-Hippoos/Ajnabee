import 'package:flutter/material.dart';
import 'package:memechat/views/chat.dart';

class Chatopt extends StatelessWidget {
  final String name;

  Chatopt(this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0XFFFFC629)),
                borderRadius: BorderRadius.circular(30),
                color: Colors.white),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/userchat.jpg"),
                      radius: 30,
                    ),
                  ),
                ),
                Expanded(
                  flex: 13,
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
