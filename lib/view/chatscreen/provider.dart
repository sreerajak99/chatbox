import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../homepage/homepage.dart';

class Chatboxprovider extends ChangeNotifier {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  final TextEditingController messagesender = TextEditingController();
  FirebaseAuth auth=FirebaseAuth.instance;
  loginservices( BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => Homepage(),
      // ));
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
    notifyListeners();
  }

  Future<void> Register(BuildContext registercontext) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());

      if (user.user!.uid.isNotEmpty) {
        FirebaseFirestore.instance.collection("user").doc(user.user!.uid).set({
          "name": email.text.trim(),
          "user_name": username.text.trim(),
          "user_id": user.user!.uid
        });

        Navigator.of(registercontext)
            .push(MaterialPageRoute(builder: (context) => const Homepage()));
      }
    } catch (e) {
      ScaffoldMessenger.of(registercontext)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    notifyListeners();
  }

  messagesendingservices(String docid,String receiver) async {
    if (messagesender.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("message")
          .doc(docid)
          .collection("messages")
          .add({
        "content": messagesender.text,
        "receiver":receiver,
        "sender":auth.currentUser!.uid,
        "time": DateTime.now().toString()
      });
      messagesender.clear();
      notifyListeners();

    } else {}
  }
 Future<void> imagepic()async{
final ImagePicker picker=ImagePicker();
final XFile? image= await picker.pickImage(source: ImageSource.gallery);
if(image==null)return;
final storageRef=FirebaseStorage.instance.ref();
final imageRef=storageRef.child("user_1.jpg");
final imageBytes=await image.readAsBytes();
await imageRef.putData(imageBytes);
notifyListeners();
  }
  Future<String> downloadImageURL(String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return '';
    }
  }


  Future<void> uploadImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    File imageFile = File(pickedFile.path);
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String fileName = 'profile_$userId.jpg';

    try {
      // Upload the image to Firebase Storage
      final ref = FirebaseStorage.instance.ref().child('user_images').child(fileName);
      await ref.putFile(imageFile);

      // Get the download URL
      final url = await ref.getDownloadURL();

      // Update the user's profile in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'imageUrl': url,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image uploaded successfully!')));
    } catch (e) {
      print('Failed to upload image: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload image')));
    }
  }




  Future<String> downloadimageURL(String userId) async {
  try {
  // Reference to the user's image in Firebase Storage
  final ref = FirebaseStorage.instance.ref().child('user_images').child('profile_$userId.jpg');

  // Get the download URL
  String downloadURL = await ref.getDownloadURL();
  return downloadURL;
  } catch (e) {
  print("Error fetching image URL: $e");
  throw Exception('Error fetching image URL');
  }
  }


}
