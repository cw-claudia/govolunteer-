import 'package:flutter/material.dart';

class ViewVolunteers extends StatefulWidget {
  const ViewVolunteers({super.key});

  @override
  State<ViewVolunteers> createState() => _ViewVolunteersState();
}

class _ViewVolunteersState extends State<ViewVolunteers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Information'),
        centerTitle: true,
        leading: BackButton(),
      ),

      body: Column(
        children: [
          SizedBox(height: 20,)

        ],
      ),
    );
  }
}
