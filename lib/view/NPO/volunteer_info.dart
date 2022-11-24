import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewVolunteers extends StatefulWidget {
  final String eventTitle;
  final String volunteerID;
  const ViewVolunteers({super.key, required this.eventTitle, required this.volunteerID});

  @override
  State<ViewVolunteers> createState() => _ViewVolunteersState();
}

class _ViewVolunteersState extends State<ViewVolunteers> {
  late String firstName;
  late String lastName;
  late String email;
  late String phoneNumber;
  late String eventTitle;
  late String volunteerID;

  @override
  void initState() {
    eventTitle = widget.eventTitle;
    volunteerID = widget.volunteerID;
    super.initState();
  }


  var auth = FirebaseAuth.instance;
  var Firestore = FirebaseFirestore.instance;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Information'),
        centerTitle: true,
        leading: BackButton(),
      ),

      body:StreamBuilder<DocumentSnapshot>(
        stream : FirebaseFirestore.instance.collection("my_events")
        .doc(eventTitle)
        .collection("appliedVolunteers").doc(volunteerID).snapshots(),
    builder: (BuildContext context ,
    AsyncSnapshot<DocumentSnapshot> snapshot){
    if(snapshot.hasData && snapshot.data != null){
    // get the value of the fields
    final firstName = snapshot.data!['first name'];
    final lastName = snapshot.data!['last name'];
    final email = snapshot.data!['email'];


                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                    children: [
                    SizedBox(height: 20,),
                    //First Name Title
                    Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                    'First Name',
                    style: GoogleFonts.openSans(fontSize: 24),
                    ),
                    ),
                    ),

                    SizedBox(height: 10),
                    //First Name Edit Text
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CupertinoTextField(
                    placeholder: firstName,
                    placeholderStyle: TextStyle(color: Colors.black),
                    readOnly: true,
                    maxLines: 1,
                    ),
                    ),
                    SizedBox(height: 10),

                    //Last Name Title
                    Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                    'Last Name',
                    style: GoogleFonts.openSans(fontSize: 24),
                    ),
                    ),
                    ),
                    SizedBox(height: 10,),
                    //Last name EditText
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CupertinoTextField(
                    placeholder: lastName,
                    placeholderStyle: TextStyle(color: Colors.black),
                    readOnly: true,
                    maxLines: 1,
                    ),
                    ),
                    SizedBox(height: 10,),
                    //Age Edit Text


                    //Email Title
                    Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                    'Volunteer Email',
                    style: GoogleFonts.openSans(fontSize: 24),
                    ),
                    ),
                    ),

                    SizedBox(height: 10,),
                    //Email Edit Text
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CupertinoTextField(
                    placeholder: email,
                    placeholderStyle: TextStyle(color: Colors.black),
                    readOnly: true,
                    maxLines: 1,
                    ),
                    ),
                    SizedBox(height: 10,),

                    SizedBox(
                    height: 30,
                    width: 180,
                    child: MaterialButton(
                    color: Colors.blue,
                    onPressed: (){
                      _sendingMails() async {
                        var url = Uri.parse("mailto: ${email}");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }
                      _sendingMails();
                    },
                    child: Center(
                    child: Row(
                    children: [
                    Icon(Icons.email, color: Colors.white,),
                    SizedBox(width : 10,),
                    Center(
                    child: Text('Contact Volunteer',
                    style: TextStyle(color: Colors.white),),
                    )
                    ],
                    ),
                    )),
                    )


                    //Phone number


                    ],
                    ),
                  ),



                );
                }else
                  return Container(
                    child: Center
                      (child: Text('Network Error')),
                  );
                }
                  )
                );
              }
            }