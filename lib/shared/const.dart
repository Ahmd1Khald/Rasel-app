import 'package:chatapp/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../local/cachehelper.dart';
import '../screens/chat_screen.dart';
import 'components.dart';

Widget widget=const LoginScreen();

Uri appUrl = Uri.parse('https://github.com/Ahmd1Khald');

void submit(context) {
  CacheHelper.saveData(key:'chatPage', value: true);
  navigateAndRemove(
    context: context,
    widget: const ChatScreen(),
  );
}

Color? mainColor = Colors.green[200];


String date(String s){
var now = DateTime.now();
var formatter = DateFormat('dd-MM-yyyy');
String formattedTime = DateFormat('kk:mm:a').format(now);
String formattedDate = formatter.format(now);
if(s=='t'){
  return formattedTime;
}
if(s=='y'){
  return formattedDate;
}
else{
  return 'Enter t or y only';
}
}













/*class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }
}*/

String userEmail = CacheHelper.getDate(key: 'userEmail');


















