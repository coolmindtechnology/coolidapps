import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TermConditionsBrain extends StatefulWidget {
  const TermConditionsBrain({super.key});

  @override
  State<TermConditionsBrain> createState() => _TermConditionsBrainState();
}

class _TermConditionsBrainState extends State<TermConditionsBrain> {
  String englishText = '''  <div>
        <h3>Welcome to the Program<br>Brain Activation<br>COOL MIND TECHNOLOGY</h3>
        <p>Brain activation and optimization through brainwave technology.</p>
    </div>
    <div>
        <h3>PROCEDURE<br>BRAIN ACTIVATION COOL</h3>
        <ol>
            <li>Before performing Brain Activation, make sure you know your Brain Type from the Profiling results.</li>
            <li>Perform Brain Activation according to your respective Brain Type. For optimal results, use a HEADSET as a medium for listening to the sound.</li>
            <li>
                Brain Activation according to each Brain Type is done as follows:
                <ol type="a">
                    <li>Perform in a relaxed and comfortable state, either sitting or lying down.</li>
                    <li> <b>Do not perform Brain Activation while driving.</b> </li>
                    <li>Perform for a maximum of 10 minutes, 3 times a day.</li>
                    <li>For FREE Brain Activation in COOL APPS, it is only available for 5 minutes, 3 times a day, for 40 consecutive days.</li>
                </ol>
            </li>
            <li>For Brain Activation of the other brain hemisphere, it can be performed after you have completed Brain Activation for your Brain Type for 40 consecutive days.</li>
            <li>Brain Activation for the other hemisphere begins with the Brain Type MASTER Activation, followed by other Brain Types in any order.</li>
            <li>Other Sound Therapies available in COOL APPS (e.g., Happy, Healthy, Wealthy, etc.) can be performed as needed. Perform one type of Therapy per day for a maximum of 5 minutes. It can be repeated as needed.</li>
            <li>Brain Activation for all Brain Types can be repeated as needed, once the 40-day Brain Activation period for each Brain Type has been completed.</li>
            <li>Brain Activation can be used by anyone who has undergone COOLTECH Profiling, for brain activation and optimization according to their respective Brain Types, and subsequently for all brain hemispheres.</li>
        </ol>
    </div>
    <div>
        <p>Thank you for joining us,</p>
        <p>Brain Activation<br>
        COOL MIND TECHNOLOGY</p>
    </div>''';

  String indonesianText = ''' <div>
        <h3>Selamat Datang di Program<br>
        Brain Activation<br>
        COOL MIND TECHNOLOGY</h3>
        <p>Aktivasi dan Optimasi Otak melalui teknologi gelombang otak.</p>
    </div>
    <div>
        <h3>TATA CARA<br>BRAIN ACTIVATION COOL</h3>
        <ol>
            <li>Sebelum melakukan Brain Activation, pastikan Anda mengetahui Tipe Otak Anda dari hasil Profiling yang telah dilakukan.</li>
            <li>Lakukan Brain Activation sesuai Tipe Otak Anda masing-masing, untuk hasil yang lebih optimal gunakan HEADSET sebagai media untuk mendengarkan suara.</li>
            <li>
                Brain Activation sesuai dengan Tipe Otak masing-masing dilakukan dengan tata cara sebagai berikut:
                <ol type="a">
                    <li>Lakukan dalam kondisi tubuh rileks dan nyaman, baik dalam keadaan duduk maupun berbaring.</li>
                    <li> <b>Tidak diperbolehkan melakukan Brain Activation pada saat sedang berkendara.</b> </li>
                    <li>Lakukan maksimal selama 10 menit, sebanyak 3 kali dalam 1 hari.</li>
                    <li>Untuk FREE Brain Activation dalam COOL APPS, hanya tersedia untuk 5 menit, 3x dalam sehari, selama 40 hari berturut-turut.</li>
                </ol>
                
            </li>
            <li>Untuk Brain Activation belahan otak yang lainnya, dapat dilakukan setelah Anda melakukan Brain Activation Tipe Otak Anda selama 40 hari berturut-turut.</li>
            <li>Brain Activation belahan otak lainnya diawali dengan Brain Activation Tipe Otak MASTER, dilanjutkan dengan Tipe Otak lainnya dengan urutan bebas.</li>
            <li>Terapi Suara lain yang tersedia dalam COOL APPS (Ex. Happy, Healthy, Wealthy, dst.) dapat dilakukan sesuai kebutuhan. Lakukan 1 jenis Terapi dalam 1 hari maksimal 5 menit. Dapat diulang sesuai kebutuhan.</li>
            <li>Brain Activation semua Tipe Otak dapat diulang kembali sesuai kebutuhan, bila sudah memenuhi batas Brain Activation tipe otak masing-masing selama 40 hari berturut-turut.</li>
            <li>Brain Activation dapat digunakan untuk siapa saja yang telah melakukan COOLTECH Profiling, untuk Aktivasi dan Optimasi Otak sesuai dengan Tipe Otak masing-masing, serta selanjutnya untuk seluruh belahan otak.</li>
        </ol>
    </div>
    <div>
        <p>Terimakasih telah bergabung bersama kami,</p>
        <p>Brain Activation<br>COOL MIND TECHNOLOGY</p>
    </div>''';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).terms_conditions_brain_act,
        style: TextStyle(color: greyColor),
      ),
      content: SingleChildScrollView(
          child: HtmlWidget(
        S.of(context).terms_conditions_brain_act ==
                "Terms and Conditions Brain Activation"
            ? englishText
            : indonesianText,
        textStyle: TextStyle(color: greyColor),
      )),
      actions: [
        SizedBox(
          height: 40,
          child: ButtonPrimary(
            S.of(context).close,
            onPress: () {
              Nav.back();
            },
            elevation: 0.0,
            expand: true,
          ),
        )
      ],
    );
  }
}
