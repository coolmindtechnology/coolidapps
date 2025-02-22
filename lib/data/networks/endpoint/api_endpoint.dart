class ApiEndpoint {
  // static String baseUrl = "https://cool-compass.mycool.id";
  // static String baseUrl = "https://staging-cool.hantrr.com";
  static String baseUrl = "https://coolstaging.amalprihatinsabah.com";

  // static String baseUrl = "https://coolcompas-staging.mycool.id";

  static void setDev() {
    // baseUrl = "https://cool-compass.mycool.id";
    baseUrl = "https://coolstaging.amalprihatinsabah.com";

    // baseUrl = "https://staging-cool.hantrr.com";
  }

  /// Sets the base URL to "https://cool-compass.mycool.id" for production environment.
  ///
  /// This function is used to configure the base URL for the production environment.
  /// It updates the value of the `baseUrl` variable to "https://cool-compass.mycool.id".
  ///
  /// This function does not take any parameters and does not return any value.
  static void setProd() {
    // baseUrl = "https://cool-compass.mycool.id";
    baseUrl = "https://coolstaging.amalprihatinsabah.com";

    // baseUrl = "https://staging-cool.hantrr.com";
  }

  /// Base API Endpoint
  static final String _baseUrlApi = '$baseUrl/api/';

  // Getter untuk _baseUrlApi
  static String get baseUrlApi => _baseUrlApi;

  static String imageUrl = "$imageUrlPreHome/storage/images/ebook/";
  static String imageUrlUser = "$imageUrlPreHome/storage/user/";

  static const String imageUrlPreHome =
      "https://s3.ap-southeast-1.amazonaws.com/";

  ////endpoint image
  static String baseUrlImage = "$imageUrlPreHome/";

  //base endpoint boarding
  static final String _boardingUrlApi = "${_baseUrlApi}boarding/";

  //base endpoint auth
  static final String _authUrlApi = "${_baseUrlApi}auth/";

  ///base endpoint user
  static final String _userUrlApi = "${_baseUrlApi}user/";

  //base endpoint feature
  static final String _featureUrlApi = "${_baseUrlApi}feature/";

  //base endpoint deposit
  static final String _depositUrlApi = "${_baseUrlApi}deposit/";

  //base endpoint home
  static final String _homeUrlApi = "${_baseUrlApi}home/";

  //base endpoint home
  static final String _coolchatUrlApi = "${_baseUrlApi}cool-chat/";

  //base endpoint midtrans
  static final String _midtransUrlApi = "${_baseUrlApi}midtrans/";

  //base endpoint brain
  static final String _brainActivationsUrlApi =
      "${_baseUrlApi}brain-activations/";
  //base endpoint brain v1
  static final String _brainActivationsV1UrlApi =
      "${_baseUrlApi}brain-activations/v1/";

  //base endpoint affiliate
  static final String _affiliateUrlApi = "${_baseUrlApi}affiliate/";

  //base endpoint transaction real money
  static final String _transactionRealMoneyUrlApi =
      "${_baseUrlApi}transaction-real-money/";

  // Cool APP
  //// Boarding
  //verion ap
  static String versionApp = "${_baseUrlApi}app-version";
  //splash screen
  static String splashScreen = "${_boardingUrlApi}get-splash-logo";
  //onboarding
  static String onBoarding = "${_boardingUrlApi}get-on-boarding";

  // Otp
  static String getOtp = "${_authUrlApi}get-otp";
  static String verifyOtp = "${_authUrlApi}verify-otp";
  static String resendOtp = "${_authUrlApi}resend-otp";
  static String sendOtp = "${_authUrlApi}send-otp";

  //// Auth
  static String logout = "${_authUrlApi}logout";
  static String loginWithPhone = "${_baseUrlApi}auth/login";
  static String register = "${_baseUrlApi}auth/register";
  static String resetPassword = "${_authUrlApi}reset-password";
  static String checkCountry = "${_authUrlApi}check-country";

  //// User
  static String getUser = "${_userUrlApi}me";
  static String updateUser = "${_userUrlApi}update";
  static String cekAsalMember = "${_userUrlApi}get-country";
  static String updatePassword = "${_userUrlApi}update-password";
  static String updatePhotoUser = "${_userUrlApi}update-photo-profile";
  static String checkProfile = "${_userUrlApi}cek-profile";
  static String getTotalSaldo = "${_userUrlApi}getTotalSaldo";
  static String getAddress = "${_userUrlApi}get/extra/address";
  static String ReportBugByUser = "${_baseUrlApi}users/log/reports";
  static String getCategoryBug = "${_baseUrlApi}category-user";

  //API Consultation
  static String getListConsultation =
      "${_baseUrlApi}consultation/get-list-session";
  static String getListTheme = "${_baseUrlApi}consultation/get-theme";
  static String getListTime(time) =>
      "${_baseUrlApi}consultation/get-sessions-time?date=$time";
  static String getListConsultanPerson =
      "${_baseUrlApi}consultant/get-list-consultant";
  static String getDetailConsultant(id) =>
      "${_baseUrlApi}consultant/get-list-consultant?consultant_id=$id";

  //==============================base endpoint Consultant==========================================//
  static final String _consultantUrlApi = "${_baseUrlApi}consultant/";
  static final String _consultationUrlApi = "${_baseUrlApi}consultation/";

  ///Consultant
  static String registerConsultant = "${_consultantUrlApi}register-consultant";
  static String getSummaryApproval = "${_consultantUrlApi}get-approval-detail";
  static String getHomeConsultant = "${_consultantUrlApi}overview";
  static String getParticipant = "${_consultationUrlApi}get-participant";

  static String getTermConsultant =
      "${_baseUrlApi}terms-and-condition/consultant";
  static String getHistoryCommission = "${_consultantUrlApi}get-comission";
  static String updateAvailable(id) =>
      "${_consultantUrlApi}update-available/$id";
  static String approveByConsultant =
      "${_consultantUrlApi}approval-by-consultant";

  //// Home
  // Api Ebook
  static String apiPreHome = "${_homeUrlApi}get-pre-home";
  static String listEbookHome = "${_homeUrlApi}get-list-ebook";
  static String listAllEbook = "${_homeUrlApi}get-all-ebook";
  static String detailEbook(id) => "${_homeUrlApi}get-ebook/$id";
  // static String approvalAkadMember(id) => "$baseUrl/akad_member/approval/$id";
  static String historyEbook = "${_homeUrlApi}get-ebook-by-user";
  static String listBrain = "${_homeUrlApi}get-list-brain";
  static String createLogEbook = "${_homeUrlApi}log-ebook";
  static String historyDetailEbook(id) => "${_homeUrlApi}invoice-ebook/$id";
  static String historyBrainActivation =
      "${_homeUrlApi}get-brain-transaction-by-user";
  static String historyDetailBrain(id) => "${_homeUrlApi}invoice-brain/$id";

  //search anything
  static String searchAnything = "${_homeUrlApi}search-content";

  //// Api Midtrans
  static String payProfiling = "${_midtransUrlApi}checkout-transaction";
  static String payPreference = "${_midtransUrlApi}show-preferences/";
  static String paymentTransaksiEbook =
      "${_midtransUrlApi}checkout-transaction";
  static String transaksiBrainActivation =
      "${_midtransUrlApi}brain-activations-transaction";
  static String updatePayment(idOrder) =>
      "${_midtransUrlApi}transaction-status/$idOrder";
  static String transaksiSubscribeBrainActivation =
      "${_midtransUrlApi}subscribe-brain-transaction";
  static String affiliateTransaction =
      "${_midtransUrlApi}affiliate-transaction";

  static String subcribeBrainProfiling =
      "${_midtransUrlApi}subscribe-brain-profiling";
  //// Brain
  static String listBrainActivation(id) =>
      "${_brainActivationsUrlApi}show-data-log/$id";
  static String timerPlayAudio(idAudio) =>
      "${_brainActivationsUrlApi}check-play-brain/$idAudio";
  static String apiCekDaily(idAudio) =>
      "${_brainActivationsUrlApi}total-play-brain/$idAudio";
  static String getListSubscribePerItem =
      "${_brainActivationsUrlApi}subscribe-per-item";
  static String getListSubscribeAllItem =
      "${_brainActivationsUrlApi}subscribe-all-item";
  static String getShowPrice = "${_brainActivationsUrlApi}show-price";
  static String checkAllowSubcribe(idLog) =>
      "${_brainActivationsUrlApi}check-allow-subscribe/$idLog";

  static String getListSubscribePerItemV1 =
      "${_brainActivationsV1UrlApi}subscribe-per-item";

  //// Feature
  // Api Profiling
  static String listProfiling = "${_featureUrlApi}list_profiling";
  static String detailProfiling(id) => "${_featureUrlApi}detail_profiling/$id";
  static String addProfiling = "${_featureUrlApi}create_profiling";
  //  static String sertifikatProfiling(id) =>
  //     "${_featureUrlApi}generate-detail-pdf/$id";
  static String sertifikatProfiling(id) =>
      "${_featureUrlApi}generate-certificate/$id";
  static String historyProfiling = "${_baseUrlApi}user/list-history";
  static String showProfiling(id) => "${_featureUrlApi}show_profiling/$id";
  static String getUserProfiling = "${_featureUrlApi}get-user-profiliing";
  static String cekAvailableProfiling =
      "${_featureUrlApi}check-location-profiling";
  static String createMultipleProfiling =
      "${_featureUrlApi}create_multiple_profiling";
  static String listMultipleProfiling =
      "${_featureUrlApi}list-multiple-profiling";
  static String checkMaximumProfiling =
      "${_featureUrlApi}check-maximum-profiling";

  //qr code
  static String qrCode = "${_featureUrlApi}qrcode";
  static String donwnloadDetailPdf(id, isLanguage) =>
      "${_featureUrlApi}download-detail-pdf/$id?$isLanguage";
  // static String donwnloadDetailPdf(id) =>
  //     "${_featureUrlApi}download-detail-pdf/$id";

  static String donwnloadCertificatrPdf(id) =>
      "${_featureUrlApi}download-certificate-pdf/$id";

  static String shareResultDetail = "${_featureUrlApi}share-detail";
  static String shareCertificate = "${_featureUrlApi}share-certificate";

  //topup
  static String listTopUp = "${_featureUrlApi}list-top-up";

  //// Cool chat
  static String listPostByUserId(id) => "${_coolchatUrlApi}get-by-user-id/$id";
  static String imageUrlPost = "$baseUrl/storage/";
  static String addPost = "${_coolchatUrlApi}create";
  static String apiGetShareCode(id) => "${_coolchatUrlApi}get-post/$id";
  static String apiSharePost = "${_coolchatUrlApi}get-post/url";
  static String apiGetFollower(id) => "${_coolchatUrlApi}get-count/$id";
  static String apiGetPost = "${_coolchatUrlApi}get-list-post";
  static String chatGetListComment(id) =>
      "${_coolchatUrlApi}get-list-comment/$id";
  static String postReaction = "${_coolchatUrlApi}post-reaction";
  static String deletePost(id) => "${_coolchatUrlApi}delete/$id";
  static String getUserProfilingByIdProfiling(id) =>
      "${_coolchatUrlApi}get-user-profiliing-by-id/$id";
  static String totalCountByPost(id) => "${_coolchatUrlApi}get-count-post/$id";
  static String followAkun = "${_coolchatUrlApi}follow-user";
  static String commentPost = "${_coolchatUrlApi}comment-post";
  static String cekHasFollow(id) => "${_coolchatUrlApi}cek-follow/$id";
  static String cekHasLike(id) => "${_coolchatUrlApi}cek-like/$id";

  //// Deposit
  static String showAmount = "${_depositUrlApi}show-amount";
  static String historyTopup = "${_depositUrlApi}history";
  static String invoice(id) => "${_depositUrlApi}invoice/$id";
  static String transactionProfiling = "${_depositUrlApi}transaction-profiling";
  static String updateTransactionProfiling =
      "${_depositUrlApi}update-transaction-profiling";

  //// Affiliate
  ///
  static String affiliateHistoryTopup = "${_affiliateUrlApi}history";
  static String affiliateRegister = "${_affiliateUrlApi}register";
  static String affiliateHistorySaldoReduction =
      "${_affiliateUrlApi}history?reduction=1";
  static String affiliateSingleTotalSaldo =
      "${_affiliateUrlApi}single-total-saldo";
  static String affiliateInvoiceSaldo = "${_affiliateUrlApi}invoice";
  static String affiliateManagement = "${_affiliateUrlApi}get-management";
  static String getMyAffiliateQR = "${_affiliateUrlApi}getMyAffiliateQR";
  static String checkIsAffiliate = "${_affiliateUrlApi}check-is-affiliate";
  static String apiGetBankAccount = "${_affiliateUrlApi}validateBankAccount";
  static String apiListRek = "${_affiliateUrlApi}listBankAccount";
  static String apiSaveRek = "${_affiliateUrlApi}save-rekening";
  static String checkTopupAffiliate = "${_affiliateUrlApi}cek-topup-affiliate";
  static String upgradeToMember = "${_affiliateUrlApi}update-to-member";
  static String updateTopupNotif = "${_affiliateUrlApi}update-topup-notif";
  static String checkCompleteBank = "${_affiliateUrlApi}cek-complete-bank";

  ///Affiliate
  static String homeAffiliate(id) => "${baseUrlApi}affiliate/overview/$id";

  static String apiListMember = "${baseUrlApi}affiliate/getMember";

  static String apiDetailMember(id) => "${baseUrlApi}affiliate/getMember/$id";

  //transaction real money

  static String updateTransactionSaldoWithRealMoney =
      "${_transactionRealMoneyUrlApi}updateLogTransaction";
  static String apiHistoryRealMoney =
      "${_transactionRealMoneyUrlApi}getIncomeHistory";
  static String createWithdraw =
      "${_transactionRealMoneyUrlApi}withdrawRealMoney";
  static String getInvoiceWithdraw =
      "${_transactionRealMoneyUrlApi}getVoucherHistory";
  static String transactionLastWithdraw =
      "${_transactionRealMoneyUrlApi}transactionLastWithdraw";

  //Convert Currency
  static String convertCurrency = "${baseUrlApi}convert-currency";

  ///api soung opening
  // static String apiOpeningCool = "${_baseUrlApi}boarding/get-sound";
}
