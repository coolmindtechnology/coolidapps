// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:coolappflutter/data/data_global.dart';
import 'package:coolappflutter/data/helpers/check_language.dart';
import 'package:coolappflutter/data/locals/preference_handler.dart';
import 'package:coolappflutter/data/locals/shared_pref.dart';
import 'package:coolappflutter/data/response/payments/res_update_transaction_profiling.dart';
import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/afiliate/on_board/onboard_aff1.dart';
import 'package:coolappflutter/presentation/pages/main/pre_home_screen.dart';
import 'package:coolappflutter/presentation/pages/payments/midtrans_screen.dart';
import 'package:coolappflutter/presentation/pages/afiliate/naf_afiliate.dart';
import 'package:coolappflutter/presentation/pages/user/reusable_invoice_screen.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/money_formatter.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/notification_utils.dart';
import 'package:coolappflutter/presentation/widgets/button_primary.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';

import '../../../data/networks/endpoint/api_endpoint.dart';

class InvoiceRegisterAffiliate extends StatefulWidget {
  final String? snapToken;
  final String? orderId;
  final String? name;
  final DateTime? date;
  final String? paymentType;
  final String? quantity;
  final String? discount;
  final String? amount;
  final Function? onUpdate;
  final bool isWithSaldo;
  final String? id;
  final List<ItemDetailProfiling> itemDetails;
  final bool isMultiple;
  final String? fromPage;
  final bool isIndonesia;
  final bool isWithdraw;

  const InvoiceRegisterAffiliate(
      {super.key,
      this.snapToken,
      this.orderId,
      this.name,
      this.date,
      this.paymentType,
      this.quantity,
      this.discount,
      this.amount,
      this.onUpdate,
      this.isWithSaldo = false,
      this.id,
      this.itemDetails = const [],
      this.isMultiple = false,
      this.fromPage,
      this.isIndonesia = true,
      this.isWithdraw = true});

  @override
  _InvoiceRegisterAffiliateState createState() =>
      _InvoiceRegisterAffiliateState();
}

class _InvoiceRegisterAffiliateState extends State<InvoiceRegisterAffiliate> {
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

  final Dio dio = Dio();
  @override
  void initState() {
    // getIsIndonesia();
    cekSession();
    super.initState();
    initLocale();
  }

  cekSession() async {
    dynamic ceklanguage = await PreferenceHandler.retrieveISelectLanguage();
    if (ceklanguage == null) {
      Prefs().setLocale('en_US', () {
        setState(() {
          S.load(Locale('en_US'));
          setState(() {});
        });
      });
      Timer(Duration(seconds: 2), () {
        Prefs().getLocale().then((locale) {
          debugPrint(locale);

          S.load(Locale(locale)).then((value) {});
        });
      });
    } else {
      Prefs().setLocale('$ceklanguage', () {
        setState(() {
          S.load(Locale('$ceklanguage'));
          setState(() {});
        });
      });
      Timer(Duration(seconds: 2), () {
        Prefs().getLocale().then((locale) {
          debugPrint(locale);

          S.load(Locale(locale)).then((value) {});
        });
      });
    }
  }

  Future<void> cancelAffiliator() async {
    try {
      Response res = await dio.post(
          "${ApiEndpoint.baseUrl}/api/affiliate/cancel-affiliator",
          data: {"is_canceled": 1},
          options: Options(
            validateStatus: (status) {
              return status == 200 || status == 400 || status == 500;
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {'Authorization': dataGlobal.token},
          ));
      if (res.statusCode == 500) {
        debugPrint("cek batal $res");
      }
      debugPrint("cek batalll $res");
    } catch (e, st) {
      debugPrint("cek batalllll $e");
      if (kDebugMode) {
        print(st);
      }
    }
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
          S.of(context).Receipt,
          // "Invoice",
          style: TextStyle(color: whiteColor),
        ),
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
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
              widget.orderId != null
                  ? itemPayment("ID", widget.orderId)
                  : const SizedBox(),
              widget.name != null
                  ? itemPayment(S.of(context).customer, widget.name ?? "-")
                  : const SizedBox(),
              widget.date != null
                  ? itemPayment(
                      S.of(context).date,
                  DateFormat("dd MMM yyyy", Localizations.localeOf(context).toString())
                      .format(widget.date ?? DateTime.now()))
                  : const SizedBox(),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: greyColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.paymentType != null) ...[
                      itemPaymentDetail(
                          S.of(context).payment, widget.paymentType ?? "-"),
                      Divider(height: 0.0, color: greyColor.withOpacity(0.5)),
                    ],
                    widget.amount != null
                        ? itemPaymentTotal(
                            S.of(context).amount,
                            MoneyFormatter.formatMoney(
                                    widget.amount, widget.isIndonesia)
                                .toString())
                        : const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              // HtmlWidget(
              //   isIndonesia ? indonesianText : englishText,
              // ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: ButtonPrimary(
                        S.of(context).cancel,
                        onPress: () {
                          cancelAffiliator();
                          NotificationUtils.showSimpleDialog(context, () {
                            Nav.back();
                            Nav.back();
                          },
                              widget: Text(
                                S.of(context).program_cancelled,
                                textAlign: TextAlign.center,
                              ),
                              textOnButton: S.of(context).close);
                        },
                        expand: false,
                        elevation: 0.0,
                        negativeColor: true,
                        border: 1,
                        borderColor: primaryColor,
                        radius: 10,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: ButtonPrimary(
                        S.of(context).pay,
                        onPress: () async {
                          Nav.back();
                          var data = await Nav.to(MidtransScreen(
                            fromPage: "register_affiliate",
                            snapToken: widget.snapToken,
                          ));

                          if (data == "affiliate") {
                            Nav.to(const PreHomeScreen());
                          }
                        },
                        expand: false,
                        elevation: 0.0,
                        radius: 10,
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
