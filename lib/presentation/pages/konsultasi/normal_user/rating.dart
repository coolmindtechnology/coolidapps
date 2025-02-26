import 'package:coolappflutter/generated/l10n.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/GlobalButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'card_consultant.dart';
import 'profile_card.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  bool isConfirmed = false;
  bool showTextButton = false; // Flag to track if GlobalButton has been pressed
  int _selectedRating = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          S.of(context).Give_Rating,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).Status,
                      style: TextStyle(
                          color: BlueColor, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      S.of(context).Archives,
                      style: TextStyle(
                          color: BlueColor, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ProfileCard(
              imagePath: 'images/konsultasi/profile1.png',
              name: 'vivian Entira',
              title: 'Creative',
              bloodType: 'B',
              location: 'Cirebon, jawa barat',
              time: '09,00 - 0.9.30 ',
              timeRemaining: '345 Sesi Selesai',
              timeColor: BlueColor,
              status: 'Pencapaian ',
              warnastatus: Colors.white,
            ),
            SizedBox(height: 16.0),
            CardConsultant(
              topic: S.of(context).Selected_topic,
              topicSelected: S.of(context).PERSONALITY,
              consultationTime: S.of(context).Consultation_time,
              consultationTimeSelected: '09.00 - 09.30',
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                S.of(context).Give_Rating,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color:
                        index < _selectedRating ? Colors.yellow : Colors.grey,
                    size: 40,
                  ),
                );
              }),
            ),
            SizedBox(height: 10),
            Text(
              S.of(context).Share_Experience,
            ),
            SizedBox(height: 5),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: S.of(context).Share_Experience,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300))),
            ),
            SizedBox(height: 30),
            Container(
              color: Colors.lightBlueAccent.shade100,
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).Price),
                        Text(S.of(context).FREE),
                      ],
                    ),
                    Divider(
                      color: BlueColor,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(height: 10),
            // Conditionally render GlobalButton or TextButton
            showTextButton // Check if the flag is true
                ? Center(
                    child: TextButton(
                      onPressed: () {
                        // Add your onPressed functionality here
                      },
                      child: Text(S.of(context).Add_Session),
                    ),
                  )
                : GlobalButton(
                    onPressed: () {
                      setState(() {
                        // Set flag to true when GlobalButton is pressed
                        showTextButton = true;
                      });
                    },
                    color: primaryColor,
                    text: S.of(context).Give_Rating,
                  ),
          ],
        ),
      ),
    );
  }
}
