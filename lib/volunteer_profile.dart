// import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart';

// class VolunteerProfileScreen extends StatefulWidget {
//   const VolunteerProfileScreen({super.key});

//   @override
//   State<VolunteerProfileScreen> createState() => _VolunteerProfileScreenState();
// }

// class _VolunteerProfileScreenState extends State<VolunteerProfileScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController locationController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             Container(
//               height: Get.height*0.4,

//               child: Stack(
//                 children: [
//                   greenIntroWidgetWithoutLogos(),

//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       width: 120,
//                       height: 120,
//                       margin: EdgeInsets.only(bottom: 20),
//                       decoration: BoxDecoration(
//                         shape:BoxShape.circle,
//                         color: Colors.white,
//                       )
//                       child:Center(child: Icon(Icons.camera_alt_outlined,size:40, color: Colors.white,))
//                     )
//                   )
//                 ]
//               )

//             )
//           ],
//         ),
//       )
//     );
//   }
// }
