import 'dart:async';

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/check_language.dart';
import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/data/provider/provider_auth_affiliate.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/affiliate_register/input_code_referral_affiliate.dart';

import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

import '../afiliate/home_affiliate.dart';

class TermHomeAffiliasi extends StatefulWidget {
  const TermHomeAffiliasi({super.key});

  @override
  State<TermHomeAffiliasi> createState() => _TermConditionsBrainState();
}

class _TermConditionsBrainState extends State<TermHomeAffiliasi> {
  String indonesianText = '''
<div>
<h1>Program Afiliasi:</h1>
  <p>Selamat datang di Program Afiliasi kami!<br>Dengan bergabung, Anda dapat mendapatkan penghasilan tambahan dengan mengacu produk atau layanan kami kepada orang lain.</p>
 <h3>SYARAT & KETENTUAN AFILIASI</h3>
        <ol>
            <li>
                <b>Registrasi Awal & Aktivasi Akun:</b> TOP UP untuk 10x Profiling, senilai Rp 2 Juta
                <ul>
                    <li>➡️Harga Normal<br>1 x Profiling = Rp 250K</li>
                    <li>➡️FEE 1 x Profiling = Rp 50K</li>
                </ul>
            </li>
            <li>WAJIB minimal TOP UP 2 Juta/bulan, berlaku untuk bulan berikutnya (1 bulan setelah registrasi) dan selama menjadi Afiliator. TOP UP paling lambat sesuai tanggal pendaftaran.</li>
            <li>MASA AKTIF AKUN: Bila minimal setelah 3 bulan pertama (bulan ke-2,3,4 setelah registrasi) Afiliator tidak TOP UP, Akun otomatis NON AKTIF SEMENTARA, masuk masa vakum 2 bulan.</li>
            <li>Bila Afiliator TOP UP dalam masa vakum, otomatis AKUN AKTIF KEMBALI dan berlaku ketentuan dari awal.</li>
            <li>Bila setelah AKTIVASI ke-2 Afiliator kembali tidak TOP UP, AKUN akan NON AKTIF PERMANEN dan nama dihapus dari List AFILIASI AGEN.</li>

            <li>Afiliator yang NON AKTIF PERMANEN dapat mendaftar kembali sebagai Afiliasi (Daftar Ulang ke AGEN) setelah 6 bulan Akun Non Aktif Permanen, dan selama AGEN masih memiliki kuota Afiliasi.</li>
            <li>Selama Akun Non Aktif Permanen, Afiliator dapat menghabiskan sisa top up dengan melakukan profiling, dan tarik dana FEE Profiling.</li>
        </ol>
        <p>Bergabunglah sekarang dan mulailah mendapatkan penghasilan tambahan!</p>
    </div>''';

  String englishText = '''
<div>
<h1>Affiliate Program:</h1>
<p>
Welcome to our Affiliate Program!<br>
By joining, you can earn additional income by referring our products or services to others.</p>
        <h3>AFFILIATE TERMS & CONDITIONS</h3>
        <ol>
            <li>
                <b>Initial Registration & Account Activation:</b> TOP UP for 10x Profiling, worth Rp 2 Million
                <ul>
                    <li>➡️Normal Price<br>1 x Profiling = Rp 250K</li>
                    <li>➡️FEE 1 x Profiling = Rp 50K</li>
                </ul>
            </li>
            <li>A minimum TOP UP of Rp 2 Million/month is REQUIRED, applicable for the following month (1 month after registration) and for the duration of being an Affiliate. TOP UP must be completed no later than the registration date.</li>
            <li>ACCOUNT ACTIVE PERIOD: If after at least the first 3 months (months 2, 3, 4 after registration) the Affiliate does not TOP UP, the Account will automatically become TEMPORARILY INACTIVE, entering a 2-month dormant period.</li>
            <li>If the Affiliate TOPs UP during the dormant period, the ACCOUNT AUTOMATICALLY REACTIVATES, and the initial terms apply.</li>
            <li>If after the 2nd ACTIVATION the Affiliate again does not TOP UP, the ACCOUNT will be PERMANENTLY INACTIVE and the name will be removed from the AFFILIATE AGENT List.</li>
            <li>If during the dormant period the Affiliate does not TOP UP, the ACCOUNT will be PERMANENTLY INACTIVE and the name will be removed from the AFFILIATE AGENT List.</li>
            <li>Affiliates who do not TOP UP a minimum of Rp 2 Million in the 2nd, 3rd, and 4th months after registration, the ACCOUNT will be PERMANENTLY INACTIVE and the name will be removed from the AFFILIATE AGENT List.</li>
            <li>Affiliates who are PERMANENTLY INACTIVE can re-register as Affiliates (Re-register with AGENT) after 6 months of the Account being Permanently Inactive, and as long as the AGENT still has Affiliate quotas.</li>
            <li>During the Permanently Inactive period, Affiliates can use up the remaining top up by conducting profiling and withdrawing Profiling FEE funds.</li>
        </ol>
        <p>Join now and start earning extra income!</p>
    </div>
''';

  bool isIndonesia = true;
  initLocale() async {
    isIndonesia = await LocaleChecker().cekLocaleIsIndonesia();
    setState(() {});
  }

  bool checkbox = false;
  late Future<TermsAndConditions> _termsFuture;
  final ApiService _apiService = ApiService();
  final String _token =
      "your_bearer_token_here"; // Ganti dengan token yang valid

  @override
  void initState() {
    // getIsIndonesia();
    _termsFuture = _apiService.fetchTerms(_token);
    super.initState();
    initLocale();
  }

  void triger() {
    setState(() {
      checkbox = !checkbox;
    });
  }

// buat nanti untuk semua udah convert
  // getIsIndonesia() async {
  //   Future.microtask(() {
  //     setState(() {
  //       isIndonesia = context.read<ProviderUser>().isIndonesia();
  //     });
  //   });
  //   print(isIndonesia);
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            S.of(context).affiliate,
            style: TextStyle(color: whiteColor),
          ),
          iconTheme: IconThemeData(color: whiteColor),
          backgroundColor: primaryColor,
        ),
        body: FutureBuilder<TermsAndConditions>(
          future: _termsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final terms = snapshot.data!;
              return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/icons/logo_cool_vertical.png",
                          height: 60.0,
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: greyColor.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(16)),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Html(
                        data: terms.data,
                        style: {
                          "body": Style(
                            fontSize: FontSize.large,
                            textAlign: TextAlign.justify, // Rata kiri-kanan
                            lineHeight:
                                const LineHeight(1.5), // Jarak antar baris
                            margin: Margins.all(0), // Hilangkan margin berlebih
                            padding: HtmlPaddings.all(
                                0), // Hilangkan padding berlebih
                          ),
                          "p": Style(
                            margin: Margins.only(
                                bottom: 8), // Jarak antar paragraf minimal
                          ),
                          "br": Style(
                            display: Display.none, // Hilangkan <br> tambahan
                          ),
                        },
                      ),
                      // HtmlWidget(
                      //   isIndonesia ? indonesianText : englishText,
                      // ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: checkbox,
                              onChanged: (val) {
                                triger();
                              }),
                          Expanded(child: Text(S.of(context).save_agreement)),
                        ],
                      ),
                      Consumer<ProviderAuthAffiliate>(
                        builder: (context, provider, child) {
                          final isBusy = provider.isLoading || provider.isRegisterAffiliate;

                          return SizedBox(
                            height: 54,
                            child: isBusy
                                ? const Center(child: CircularProgressIndicator())
                                : ButtonPrimary(
                              S.of(context).register_affiliate,
                              onPress: () async {
                                if (checkbox == true) {
                                  await provider.autofill(
                                    dataGlobal.dataUser?.id.toString() ?? "id kosong",
                                    context,
                                  );

                                  final referalCode = provider.dataCodeReferal;
                                  if (referalCode != null && referalCode.toString() != "null") {
                                    await provider.registerAffiliate(
                                      context,
                                      referalCode.toString(),
                                    );
                                  } else {
                                    Nav.replace(const InputCodeReferralAffiliate());
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Silahkan ceklis persetujuan terlebih dahulu!'),
                                    ),
                                  );
                                }
                              },
                              expand: false,
                              elevation: 0,
                              radius: 10,
                            ),
                          );
                        },
                      )

                    ],
                  ));
            } else {
              return const Center(child: Text('Tidak ada data'));
            }
          },
        ));
  }
}
