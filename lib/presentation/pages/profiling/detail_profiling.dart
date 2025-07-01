import 'package:coolappflutter/presentation/pages/profiling/screen_hasil_kepribadian.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:coolappflutter/presentation/widgets/costum_floatingbutton.dart';
import 'package:flutter/material.dart';

import '../../../data/response/profiling/res_list_profiling.dart';
import '../../../generated/l10n.dart';
import '../../theme/color_utils.dart';

class DetailProfiling extends StatefulWidget {
  final DataProfiling? data;
  const DetailProfiling({super.key, this.data});

  @override
  State<DetailProfiling> createState() => _DetailProfilingState();
}

class _DetailProfilingState extends State<DetailProfiling> {
  int usia = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime currentDate = DateTime.now();
    usia = currentDate.year - int.parse(widget.data?.yearDate.toString() ?? "");
    if (currentDate.month <
            int.parse(widget.data?.monthDate.toString() ?? "") ||
        (currentDate.month ==
                int.parse(widget.data?.monthDate.toString() ?? "") &&
            currentDate.day <
                int.parse(widget.data?.birthDate.toString() ?? ""))) {
      usia;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.data?.profilingName.toString() ?? "",
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: widget.data?.profilingName.toString() ?? "-",
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(
                                10) // Set the border color here
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      S.of(context).date_of_birth.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: widget.data?.date.toString() ?? "-",
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(
                                10) // Set the border color here
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      S.of(context).age.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                          hintText: usia.toString(),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(
                                  10) // Set the border color here
                              ),
                          fillColor: Colors.grey.withOpacity(0.5),
                          filled: true),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      S.of(context).residence.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: widget.data?.domicile ?? "-",
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(
                                10) // Set the border color here
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      S.of(context).blood_type.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: widget.data?.bloodType ?? "-",
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(
                                10) // Set the border color here
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: SizedBox(
                height: 54,
                child: ButtonPrimary(
                  S.of(context).view_results,
                  onPress: () {
                    Nav.to(ScreenHasilKepribadian(data: widget.data));
                  },
                  expand: true,
                  radius: 10,
                ),
            )),
      floatingActionButton: const CustomFAB(),

    );
  }
}
