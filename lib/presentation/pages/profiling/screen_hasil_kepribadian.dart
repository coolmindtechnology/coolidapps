import 'package:cool_app/data/provider/provider_profiling.dart';
import 'package:cool_app/data/response/profiling/res_list_profiling.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/brain/screen_brain_activition.dart';
import 'package:cool_app/presentation/pages/profiling/certificate_screen.dart';
import 'package:cool_app/presentation/pages/profiling/results/result_detail.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/circular_progress_widget.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:cool_app/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenHasilKepribadian extends StatefulWidget {
  final DataProfiling? data;
  const ScreenHasilKepribadian({super.key, this.data});

  @override
  State<ScreenHasilKepribadian> createState() => _ScreenHasilKepribadianState();
}

class _ScreenHasilKepribadianState extends State<ScreenHasilKepribadian> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderProfiling.showDetail(
            context, widget.data?.idLogResult ?? "");
      },
      child: Consumer<ProviderProfiling>(
        builder: (BuildContext context, value, Widget? child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              S.of(context).calculation_results,
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 290,
                  width: 290,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 20, color: primaryColor.withOpacity(0.6)),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).your_personality,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      value.isShowDetail
                          ? SizedBox(
                              height: 60,
                              child: Center(
                                child: CircularProgressWidget(
                                  color: primaryColor,
                                ),
                              ),
                            )
                          : Text(
                              "${value.dataShowDetail?.result}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40,
                                  letterSpacing: 3,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "${S.of(context).congratulations} ${value.dataShowDetail?.name ?? ""}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 54,
                  child: ButtonPrimary(
                    S.of(context).result_detail,
                    onPress: () {
                      Nav.to(ResultDetail(data: widget.data));
                    },
                    expand: true,
                    radius: 10,
                    border: 1,
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 54,
                  child: ButtonPrimary(
                    "Brain activation",
                    onPress: () {
                      Nav.to(ScreenBrainActivation(
                          widget.data, value.dataShowDetail?.idResult ?? ""));
                    },
                    expand: true,
                    radius: 10,
                    negativeColor: true,
                    border: 1,
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 54,
                  child: ButtonPrimary(
                    "${S.of(context).download} ${S.of(context).certificate}",
                    onPress: () {
                      Nav.to(CertificateScreen(
                          data: widget.data,
                          shareCode: value.dataShowDetail?.shareCode));
                    },
                    expand: true,
                    radius: 10,
                    negativeColor: true,
                    border: 1,
                    elevation: 0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
