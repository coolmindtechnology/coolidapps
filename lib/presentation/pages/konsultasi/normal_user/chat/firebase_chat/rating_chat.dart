import 'dart:async';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/main/nav_home.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingChat extends StatefulWidget {
  const RatingChat(
      {super.key, required this.consultanId, required this.consultationId});
  final String consultanId;
  final String consultationId;

  @override
  State<RatingChat> createState() => _RatingState();
}

class _RatingState extends State<RatingChat> {
  bool isLoading = false;
  bool showTextButton = false;
  int _selectedRating = 0;
  final TextEditingController _controller = TextEditingController();

  Future<void> _submitRating() async {
    if (_selectedRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).Give_Rating)),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token =
          prefs.getString('token'); // Ambil token dari SharedPreferences

      if (token == null) {
        throw Exception("Token tidak ditemukan");
      }
      debugPrint("${widget.consultationId}");
      debugPrint("${widget.consultanId}");
      debugPrint(_selectedRating.toString());
      debugPrint(_controller.text.trim());
      debugPrint("${token}");

      final dio = Dio();
      final response = await dio.post(
        "${ApiEndpoint.baseUrl}/api/consultation/rate-consultant",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
        data: {
          "consultation_id": widget.consultationId.toString(),
          "consultant_id": widget.consultanId.toString(),
          "rate": _selectedRating.toString(),
          "feedback": _controller.text.trim().isEmpty
              ? "Sangat good dan bagus bagus pisan"
              : _controller.text.trim(),
        },
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Rating berhasil dikirim")),
        );
        setState(() {
          showTextButton = true;
        });
      } else {
        debugPrint("Response Code: ${response.statusCode}");
        debugPrint("Response Data: ${response.data}");
        debugPrint("Response Data: ${widget.consultanId} ${widget.consultationId}, ${token.toString()}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
      // debugPrint("Error: $e");

    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
            const SizedBox(height: 20),
            Center(
              child: Text(
                S.of(context).Give_Rating,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            Text(S.of(context).Share_Experience),
            const SizedBox(height: 5),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: S.of(context).Share_Experience,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300))),
            ),
            const Spacer(),
            const SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : showTextButton
                    ? Center(
                        child: TextButton(
                          onPressed: () {
                            Nav.to(NavMenuScreen());
                          },
                          child: Text(S.of(context).Add_Session),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitRating,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            S.of(context).Give_Rating,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
