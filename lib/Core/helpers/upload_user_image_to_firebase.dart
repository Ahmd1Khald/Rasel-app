import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImage({required int numImage, required image}) async {
  String path = 'Images/$numImage/chat-app-8a643.appspot.com/';
  final ref = FirebaseStorage.instance.ref().child(path);
  UploadTask? uploadTask;
  uploadTask = ref.putFile(image!);
  final snapshot = await uploadTask.whenComplete(() {});
  final urlDownload = await snapshot.ref.getDownloadURL();
  final String userImage = await ref.getDownloadURL();
  //print('Image link:$urlDownload');
  return urlDownload;
}
