import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
User loggedInUser;
final _firestore = FirebaseFirestore.instance;
class ChatScreen extends StatefulWidget {

  static const String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final myController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String messagetext;
  String emailof;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentuser();
  }

  void getCurrentuser() async {
    final user = await _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        print("char screen " + loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void messageStream() async {
    await for (var snapshot in _firestore.collection("messages").snapshots()) {
      for (var message in snapshot.docs) print(message.data());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // _auth.signOut();
                // Navigator.pop(context);
                messageStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("messages").snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                final messages = snapshot.data.docs;
                List<messagebuble> messageWidgets = [];
                for (var message in messages) {
                  final messageText = message["text"];
                  final messageSender = message["sender"];
                  final currentuser=loggedInUser.email;
                  if(currentuser==messageSender)
                    {

                    }
                  final messageWidget = messagebuble(
                    sender: messageSender,
                    text: messageText,
                    isme:currentuser== messageSender
                  );
                  messageWidgets.add(messageWidget);
                }
                return Expanded(
                  child: ListView(
                    children: messageWidgets,
                  ),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: myController,

                      onChanged: (value) {
                        messagetext = value;

                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      myController.clear();
                      _firestore.collection("messages").add(
                          {"text": messagetext, "sender": loggedInUser.email});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class messagebuble extends StatelessWidget {
  messagebuble({this.sender, this.text,this.isme});
  final sender;
  final text;
  final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme ? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text("$sender",
          style: TextStyle(
            color: Colors.grey,
          ),
          ),
          SizedBox(height: 5.0,),
          Material(
            elevation: 5.0,
            borderRadius:isme? BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft:Radius.circular(30.0),bottomRight:Radius.circular(30.0),):
            BorderRadius.only(topRight: Radius.circular(30.0),bottomLeft:Radius.circular(30.0),bottomRight:Radius.circular(30.0),),
            color: isme?Colors.lightBlueAccent:Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 16.0,
                  color:isme ? Colors.white: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
