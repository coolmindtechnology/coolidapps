import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';

class RelatedFigure extends StatefulWidget {
  const RelatedFigure({super.key});

  @override
  State<RelatedFigure> createState() => _RelatedFigureState();
}

class _RelatedFigureState extends State<RelatedFigure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tokoh Terkait",
          style: TextStyle(color: whiteColor),
        ),
        iconTheme: IconThemeData(color: whiteColor),
        actionsIconTheme: IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/person_satu.png",
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Pavel Durov",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                style: TextStyle(fontWeight: FontWeight.w300, color: greyColor),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Career",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Upon leaving Russia, he obtained Saint Kitts and Nevis citizenship by donating \$250,000 to the country's Sugar Industry Diversification Foundation and secured \$300 million in cash within Swiss banks. This allowed him to focus on creating his next company, Telegram, focused on an encrypted messaging service of the same name.",
                style: TextStyle(color: greyColor, fontWeight: FontWeight.w300),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ),
    );
  }
}
