// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello World`
  String get hello_world {
    return Intl.message(
      'Hello World',
      name: 'hello_world',
      desc: '',
      args: [],
    );
  }

  /// `Choose the language familiar to you`
  String get choose_language {
    return Intl.message(
      'Choose the language familiar to you',
      name: 'choose_language',
      desc: '',
      args: [],
    );
  }

  /// `Get to know yourself more quickly, precisely and accurately`
  String get get_know_yourself {
    return Intl.message(
      'Get to know yourself more quickly, precisely and accurately',
      name: 'get_know_yourself',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Achieve success in life through\nthe best personality application`
  String get achieve_success_in_life {
    return Intl.message(
      'Achieve success in life through\nthe best personality application',
      name: 'achieve_success_in_life',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get sign_in {
    return Intl.message(
      'Login',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Password`
  String get repeat_password {
    return Intl.message(
      'Repeat Password',
      name: 'repeat_password',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `An OTP code has been sent to your cellphone number, please check your SMS box, the OTP code is valid until {timeOtp}`
  String otp_code_has_been_sent(Object timeOtp) {
    return Intl.message(
      'An OTP code has been sent to your cellphone number, please check your SMS box, the OTP code is valid until $timeOtp',
      name: 'otp_code_has_been_sent',
      desc: '',
      args: [timeOtp],
    );
  }

  /// `OTP Code`
  String get otp_code {
    return Intl.message(
      'OTP Code',
      name: 'otp_code',
      desc: '',
      args: [],
    );
  }

  /// `OTP code is wrong or timeout expired`
  String get otp_code_is_wrong {
    return Intl.message(
      'OTP code is wrong or timeout expired',
      name: 'otp_code_is_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations, you have become a regular member of COOL Apps`
  String get congratulation_you_have_become_a_regular_member {
    return Intl.message(
      'Congratulations, you have become a regular member of COOL Apps',
      name: 'congratulation_you_have_become_a_regular_member',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't Have an Account?`
  String get dont_have_an_account {
    return Intl.message(
      'Don\'t Have an Account?',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Personality`
  String get personality {
    return Intl.message(
      'Personality',
      name: 'personality',
      desc: '',
      args: [],
    );
  }

  /// `Check your\nself-worth`
  String get check_your_self_worth {
    return Intl.message(
      'Check your\nself-worth',
      name: 'check_your_self_worth',
      desc: '',
      args: [],
    );
  }

  /// `E-Book`
  String get ebook {
    return Intl.message(
      'E-Book',
      name: 'ebook',
      desc: '',
      args: [],
    );
  }

  /// `Read Ebooks Online`
  String get read_ebook_online {
    return Intl.message(
      'Read Ebooks Online',
      name: 'read_ebook_online',
      desc: '',
      args: [],
    );
  }

  /// `Latest book`
  String get latest_book {
    return Intl.message(
      'Latest book',
      name: 'latest_book',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get see_all {
    return Intl.message(
      'See All',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get read {
    return Intl.message(
      'Read',
      name: 'read',
      desc: '',
      args: [],
    );
  }

  /// `Become a Promoter`
  String get become_promotor {
    return Intl.message(
      'Become a Promoter',
      name: 'become_promotor',
      desc: '',
      args: [],
    );
  }

  /// `Result Details`
  String get result_detail {
    return Intl.message(
      'Result Details',
      name: 'result_detail',
      desc: '',
      args: [],
    );
  }

  /// `Treasure Type`
  String get treasure_type {
    return Intl.message(
      'Treasure Type',
      name: 'treasure_type',
      desc: '',
      args: [],
    );
  }

  /// `Brain Type`
  String get brain_type {
    return Intl.message(
      'Brain Type',
      name: 'brain_type',
      desc: '',
      args: [],
    );
  }

  /// `{typeFigure} Type Figures`
  String type_figure(Object typeFigure) {
    return Intl.message(
      '$typeFigure Type Figures',
      name: 'type_figure',
      desc: '',
      args: [typeFigure],
    );
  }

  /// `Pattern Type`
  String get pattern_type {
    return Intl.message(
      'Pattern Type',
      name: 'pattern_type',
      desc: '',
      args: [],
    );
  }

  /// `Keyword`
  String get keyword {
    return Intl.message(
      'Keyword',
      name: 'keyword',
      desc: '',
      args: [],
    );
  }

  /// `Play Audio`
  String get play_audio {
    return Intl.message(
      'Play Audio',
      name: 'play_audio',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Pay to see more`
  String get pay_to_see_more {
    return Intl.message(
      'Pay to see more',
      name: 'pay_to_see_more',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes, Next`
  String get yes_continue {
    return Intl.message(
      'Yes, Next',
      name: 'yes_continue',
      desc: '',
      args: [],
    );
  }

  /// `Payment Details`
  String get payment_detail {
    return Intl.message(
      'Payment Details',
      name: 'payment_detail',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get order_id {
    return Intl.message(
      'Order ID',
      name: 'order_id',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Select Payment Method`
  String get select_payment_method {
    return Intl.message(
      'Select Payment Method',
      name: 'select_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Pay with`
  String get pay_with {
    return Intl.message(
      'Pay with',
      name: 'pay_with',
      desc: '',
      args: [],
    );
  }

  /// `Debit Card`
  String get debit_card {
    return Intl.message(
      'Debit Card',
      name: 'debit_card',
      desc: '',
      args: [],
    );
  }

  /// `Credit Card`
  String get credit_card {
    return Intl.message(
      'Credit Card',
      name: 'credit_card',
      desc: '',
      args: [],
    );
  }

  /// `Payment Status`
  String get payment_status {
    return Intl.message(
      'Payment Status',
      name: 'payment_status',
      desc: '',
      args: [],
    );
  }

  /// `Payment Successful`
  String get payment_successfull {
    return Intl.message(
      'Payment Successful',
      name: 'payment_successfull',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `My Balance`
  String get my_balance {
    return Intl.message(
      'My Balance',
      name: 'my_balance',
      desc: '',
      args: [],
    );
  }

  /// `Top Up`
  String get top_up {
    return Intl.message(
      'Top Up',
      name: 'top_up',
      desc: '',
      args: [],
    );
  }

  /// `Topup Amount`
  String get top_up_amount {
    return Intl.message(
      'Topup Amount',
      name: 'top_up_amount',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Pause Audio`
  String get pause_audio {
    return Intl.message(
      'Pause Audio',
      name: 'pause_audio',
      desc: '',
      args: [],
    );
  }

  /// `password do not matched`
  String get password_not_matched {
    return Intl.message(
      'password do not matched',
      name: 'password_not_matched',
      desc: '',
      args: [],
    );
  }

  /// `Haven't received the OTP code yet?`
  String get have_not_received_the_otp {
    return Intl.message(
      'Haven\'t received the OTP code yet?',
      name: 'have_not_received_the_otp',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Bedah Diri`
  String get self_surgery {
    return Intl.message(
      'Bedah Diri',
      name: 'self_surgery',
      desc: '',
      args: [],
    );
  }

  /// `Bedah Solusi`
  String get solution_surgery {
    return Intl.message(
      'Bedah Solusi',
      name: 'solution_surgery',
      desc: '',
      args: [],
    );
  }

  /// `Password Confirmation`
  String get password_confirmation {
    return Intl.message(
      'Password Confirmation',
      name: 'password_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Profiling Results`
  String get profiling_results {
    return Intl.message(
      'Profiling Results',
      name: 'profiling_results',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Account Success`
  String get account_success {
    return Intl.message(
      'Account Success',
      name: 'account_success',
      desc: '',
      args: [],
    );
  }

  /// `Profiling`
  String get profiling {
    return Intl.message(
      'Profiling',
      name: 'profiling',
      desc: '',
      args: [],
    );
  }

  /// `SELF Surgery,\nSOLUTION Surgery`
  String get self_surgery_solution_surgery {
    return Intl.message(
      'SELF Surgery,\nSOLUTION Surgery',
      name: 'self_surgery_solution_surgery',
      desc: '',
      args: [],
    );
  }

  /// `tes`
  String get tes {
    return Intl.message(
      'tes',
      name: 'tes',
      desc: '',
      args: [],
    );
  }

  /// `Create Password`
  String get create_password {
    return Intl.message(
      'Create Password',
      name: 'create_password',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password for\nlogging into the application`
  String get create_new_password {
    return Intl.message(
      'Create New Password for\nlogging into the application',
      name: 'create_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Hooray!, Your password has been\nsuccessfully changed`
  String get password_successfully_changed {
    return Intl.message(
      'Hooray!, Your password has been\nsuccessfully changed',
      name: 'password_successfully_changed',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgot_password_2 {
    return Intl.message(
      'Forgot Password',
      name: 'forgot_password_2',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number\nto receive verification`
  String get enter_phone_number {
    return Intl.message(
      'Enter your phone number\nto receive verification',
      name: 'enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `The entered number is not registered in the system`
  String get number_not_registered {
    return Intl.message(
      'The entered number is not registered in the system',
      name: 'number_not_registered',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Please add data first through the button below`
  String get add_data_first {
    return Intl.message(
      'Please add data first through the button below',
      name: 'add_data_first',
      desc: '',
      args: [],
    );
  }

  /// `Residence`
  String get residence {
    return Intl.message(
      'Residence',
      name: 'residence',
      desc: '',
      args: [],
    );
  }

  /// `Blood Type`
  String get blood_type {
    return Intl.message(
      'Blood Type',
      name: 'blood_type',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `View Results`
  String get view_results {
    return Intl.message(
      'View Results',
      name: 'view_results',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get date_of_birth {
    return Intl.message(
      'Date of Birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Calculation Results`
  String get calculation_results {
    return Intl.message(
      'Calculation Results',
      name: 'calculation_results',
      desc: '',
      args: [],
    );
  }

  /// `Your Personality`
  String get your_personality {
    return Intl.message(
      'Your Personality',
      name: 'your_personality',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congratulations {
    return Intl.message(
      'Congratulations!',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Qr Code`
  String get qr_code {
    return Intl.message(
      'Qr Code',
      name: 'qr_code',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `ID Number`
  String get id_number {
    return Intl.message(
      'ID Number',
      name: 'id_number',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Show this QR Code to facilitate\nthe use of this application`
  String get show_qr_code {
    return Intl.message(
      'Show this QR Code to facilitate\nthe use of this application',
      name: 'show_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to\nexit the application?`
  String get exit_confirmation {
    return Intl.message(
      'Are you sure you want to\nexit the application?',
      name: 'exit_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Yes, Exit`
  String get yes_exit {
    return Intl.message(
      'Yes, Exit',
      name: 'yes_exit',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `What do you want to discuss?`
  String get what_to_discuss {
    return Intl.message(
      'What do you want to discuss?',
      name: 'what_to_discuss',
      desc: '',
      args: [],
    );
  }

  /// `Posting`
  String get posting {
    return Intl.message(
      'Posting',
      name: 'posting',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post {
    return Intl.message(
      'Post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get following {
    return Intl.message(
      'Following',
      name: 'following',
      desc: '',
      args: [],
    );
  }

  /// `Followers`
  String get followers {
    return Intl.message(
      'Followers',
      name: 'followers',
      desc: '',
      args: [],
    );
  }

  /// `Follow`
  String get follow {
    return Intl.message(
      'Follow',
      name: 'follow',
      desc: '',
      args: [],
    );
  }

  /// `Unfollow`
  String get unfollow {
    return Intl.message(
      'Unfollow',
      name: 'unfollow',
      desc: '',
      args: [],
    );
  }

  /// `Certificate`
  String get certificate {
    return Intl.message(
      'Certificate',
      name: 'certificate',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get current_password {
    return Intl.message(
      'Current Password',
      name: 'current_password',
      desc: '',
      args: [],
    );
  }

  /// `Minimum 8 characters`
  String get min_8_characters {
    return Intl.message(
      'Minimum 8 characters',
      name: 'min_8_characters',
      desc: '',
      args: [],
    );
  }

  /// `Cannot be empty`
  String get cannot_be_empty {
    return Intl.message(
      'Cannot be empty',
      name: 'cannot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Not match`
  String get not_match {
    return Intl.message(
      'Not match',
      name: 'not_match',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message(
      'Free',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `Premium`
  String get premium {
    return Intl.message(
      'Premium',
      name: 'premium',
      desc: '',
      args: [],
    );
  }

  /// `Please use user account`
  String get use_your_user_account {
    return Intl.message(
      'Please use user account',
      name: 'use_your_user_account',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Due`
  String get due_date {
    return Intl.message(
      'Due',
      name: 'due_date',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get amount {
    return Intl.message(
      'Total',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get choose {
    return Intl.message(
      'Select',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `is the data entered correct?`
  String get is_the_data_entered_correct {
    return Intl.message(
      'is the data entered correct?',
      name: 'is_the_data_entered_correct',
      desc: '',
      args: [],
    );
  }

  /// `Please select blood type`
  String get please_select_blood_type {
    return Intl.message(
      'Please select blood type',
      name: 'please_select_blood_type',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Type, ex.`
  String get type_ex {
    return Intl.message(
      'Type, ex.',
      name: 'type_ex',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `required multiple of`
  String get required_multiple {
    return Intl.message(
      'required multiple of',
      name: 'required_multiple',
      desc: '',
      args: [],
    );
  }

  /// `Enter Topup Amount`
  String get enter_topup_amount {
    return Intl.message(
      'Enter Topup Amount',
      name: 'enter_topup_amount',
      desc: '',
      args: [],
    );
  }

  /// `The amount of money that will be paid `
  String get the_amount_of_money_that_will_be_paid {
    return Intl.message(
      'The amount of money that will be paid ',
      name: 'the_amount_of_money_that_will_be_paid',
      desc: '',
      args: [],
    );
  }

  /// `is`
  String get is_adalah {
    return Intl.message(
      'is',
      name: 'is_adalah',
      desc: '',
      args: [],
    );
  }

  /// `The minimum amount that must be paid is {minAmount}`
  String the_minimum_amount_that_must_be(Object minAmount) {
    return Intl.message(
      'The minimum amount that must be paid is $minAmount',
      name: 'the_minimum_amount_that_must_be',
      desc: '',
      args: [minAmount],
    );
  }

  /// `and the maximum amount is {maxAmount}.`
  String paid_and_the_maximum_amount(Object maxAmount) {
    return Intl.message(
      'and the maximum amount is $maxAmount.',
      name: 'paid_and_the_maximum_amount',
      desc: '',
      args: [maxAmount],
    );
  }

  /// `If it is less than maximum amount and more than minimum amount, multiples of the minimum amount apply.`
  String get if_it_is_less_than_maximum_amount_and_more_than_minimum_amount {
    return Intl.message(
      'If it is less than maximum amount and more than minimum amount, multiples of the minimum amount apply.',
      name: 'if_it_is_less_than_maximum_amount_and_more_than_minimum_amount',
      desc: '',
      args: [],
    );
  }

  /// `Choose Topup`
  String get choose_topup {
    return Intl.message(
      'Choose Topup',
      name: 'choose_topup',
      desc: '',
      args: [],
    );
  }

  /// `Manual Input`
  String get manual_input {
    return Intl.message(
      'Manual Input',
      name: 'manual_input',
      desc: '',
      args: [],
    );
  }

  /// `Please profile first before joining Coolchat`
  String get plese_profiling_first_before_joining_coolchat {
    return Intl.message(
      'Please profile first before joining Coolchat',
      name: 'plese_profiling_first_before_joining_coolchat',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Rich Type`
  String get rich_type {
    return Intl.message(
      'Rich Type',
      name: 'rich_type',
      desc: '',
      args: [],
    );
  }

  /// `Type Aura`
  String get aura_type {
    return Intl.message(
      'Type Aura',
      name: 'aura_type',
      desc: '',
      args: [],
    );
  }

  /// `Pay with your Cool balance`
  String get pay_with_your_cool_balance {
    return Intl.message(
      'Pay with your Cool balance',
      name: 'pay_with_your_cool_balance',
      desc: '',
      args: [],
    );
  }

  /// `Payment with Cool balance was successful`
  String get payment_with_cool_balance_was_successful {
    return Intl.message(
      'Payment with Cool balance was successful',
      name: 'payment_with_cool_balance_was_successful',
      desc: '',
      args: [],
    );
  }

  /// `Logging In...`
  String get logging_in {
    return Intl.message(
      'Logging In...',
      name: 'logging_in',
      desc: '',
      args: [],
    );
  }

  /// `Registering...`
  String get registering {
    return Intl.message(
      'Registering...',
      name: 'registering',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Phone Number`
  String get invalid_phone_number {
    return Intl.message(
      'Invalid Phone Number',
      name: 'invalid_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Successfully updated profile`
  String get successfully_updated_user {
    return Intl.message(
      'Successfully updated profile',
      name: 'successfully_updated_user',
      desc: '',
      args: [],
    );
  }

  /// `just`
  String get just {
    return Intl.message(
      'just',
      name: 'just',
      desc: '',
      args: [],
    );
  }

  /// `An Unknown Error Occurred. Please try again later.`
  String get unknown_error {
    return Intl.message(
      'An Unknown Error Occurred. Please try again later.',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `Connection lost. Please check your internet connection.`
  String get connection_lost {
    return Intl.message(
      'Connection lost. Please check your internet connection.',
      name: 'connection_lost',
      desc: '',
      args: [],
    );
  }

  /// `Request sending time has expired.`
  String get request_timeout {
    return Intl.message(
      'Request sending time has expired.',
      name: 'request_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Response receiving time has expired.`
  String get response_timeout {
    return Intl.message(
      'Response receiving time has expired.',
      name: 'response_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Invalid request. Please check your request parameters.`
  String get invalid_request {
    return Intl.message(
      'Invalid request. Please check your request parameters.',
      name: 'invalid_request',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized. Please log in again.`
  String get unauthorized {
    return Intl.message(
      'Unauthorized. Please log in again.',
      name: 'unauthorized',
      desc: '',
      args: [],
    );
  }

  /// `Access denied. You do not have permission to perform this action.`
  String get access_denied {
    return Intl.message(
      'Access denied. You do not have permission to perform this action.',
      name: 'access_denied',
      desc: '',
      args: [],
    );
  }

  /// `Not Found`
  String get not_found {
    return Intl.message(
      'Not Found',
      name: 'not_found',
      desc: '',
      args: [],
    );
  }

  /// `You have made too many requests`
  String get too_many_requests {
    return Intl.message(
      'You have made too many requests',
      name: 'too_many_requests',
      desc: '',
      args: [],
    );
  }

  /// `Internal Server Error. Please try again later.`
  String get internal_server_error {
    return Intl.message(
      'Internal Server Error. Please try again later.',
      name: 'internal_server_error',
      desc: '',
      args: [],
    );
  }

  /// `Request cancelled. Please try again.`
  String get request_cancelled {
    return Intl.message(
      'Request cancelled. Please try again.',
      name: 'request_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred.`
  String get unknown_error_occurred {
    return Intl.message(
      'An unknown error occurred.',
      name: 'unknown_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `SSL Certificate Error. Please check your network connection.`
  String get ssl_certificate_error {
    return Intl.message(
      'SSL Certificate Error. Please check your network connection.',
      name: 'ssl_certificate_error',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error. Please check your network connection.`
  String get connection_error {
    return Intl.message(
      'Connection Error. Please check your network connection.',
      name: 'connection_error',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred.`
  String get unexpected_error {
    return Intl.message(
      'An unexpected error occurred.',
      name: 'unexpected_error',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Single`
  String get single {
    return Intl.message(
      'Single',
      name: 'single',
      desc: '',
      args: [],
    );
  }

  /// `Multiple`
  String get multiple {
    return Intl.message(
      'Multiple',
      name: 'multiple',
      desc: '',
      args: [],
    );
  }

  /// `Other Pay`
  String get other_pay {
    return Intl.message(
      'Other Pay',
      name: 'other_pay',
      desc: '',
      args: [],
    );
  }

  /// `How much data do you want to create?`
  String get how_much_data_do_you_want_to_create {
    return Intl.message(
      'How much data do you want to create?',
      name: 'how_much_data_do_you_want_to_create',
      desc: '',
      args: [],
    );
  }

  /// `Enter a value between 2 and`
  String get enter_a_value_between_2_and_10 {
    return Intl.message(
      'Enter a value between 2 and',
      name: 'enter_a_value_between_2_and_10',
      desc: '',
      args: [],
    );
  }

  /// `Form`
  String get form {
    return Intl.message(
      'Form',
      name: 'form',
      desc: '',
      args: [],
    );
  }

  /// `Maximum {max} profiling data (forms) for 1x transaction`
  String maximum_10_profiling_data_for_1x_transaction(Object max) {
    return Intl.message(
      'Maximum $max profiling data (forms) for 1x transaction',
      name: 'maximum_10_profiling_data_for_1x_transaction',
      desc: '',
      args: [max],
    );
  }

  /// `Pays All`
  String get pay_all {
    return Intl.message(
      'Pays All',
      name: 'pay_all',
      desc: '',
      args: [],
    );
  }

  /// `Please check again on form`
  String get please_check_again_on_form {
    return Intl.message(
      'Please check again on form',
      name: 'please_check_again_on_form',
      desc: '',
      args: [],
    );
  }

  /// `Pay Now`
  String get pay_now {
    return Intl.message(
      'Pay Now',
      name: 'pay_now',
      desc: '',
      args: [],
    );
  }

  /// `Update Available!`
  String get update_available {
    return Intl.message(
      'Update Available!',
      name: 'update_available',
      desc: '',
      args: [],
    );
  }

  /// `The latest version of the app is available. Please update the app to get the latest features and performance improvements.`
  String get the_latest_version_off_the_app_is_available {
    return Intl.message(
      'The latest version of the app is available. Please update the app to get the latest features and performance improvements.',
      name: 'the_latest_version_off_the_app_is_available',
      desc: '',
      args: [],
    );
  }

  /// `Update App`
  String get update_app {
    return Intl.message(
      'Update App',
      name: 'update_app',
      desc: '',
      args: [],
    );
  }

  /// `Not Now, Thank You`
  String get not_now_thankyou {
    return Intl.message(
      'Not Now, Thank You',
      name: 'not_now_thankyou',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email\nto receive verification`
  String get enter_email {
    return Intl.message(
      'Enter your email\nto receive verification',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `The entered email is not registered in the system`
  String get email_not_registered {
    return Intl.message(
      'The entered email is not registered in the system',
      name: 'email_not_registered',
      desc: '',
      args: [],
    );
  }

  /// `Not Complete`
  String get not_complete {
    return Intl.message(
      'Not Complete',
      name: 'not_complete',
      desc: '',
      args: [],
    );
  }

  /// `Sending ...`
  String get sending {
    return Intl.message(
      'Sending ...',
      name: 'sending',
      desc: '',
      args: [],
    );
  }

  /// `Please select a method to send the OTP code`
  String get please_select_a_method_to_send_otp_code {
    return Intl.message(
      'Please select a method to send the OTP code',
      name: 'please_select_a_method_to_send_otp_code',
      desc: '',
      args: [],
    );
  }

  /// `Get lots of benefits by subscribing`
  String get get_lots_of_benefits_by_subcribing {
    return Intl.message(
      'Get lots of benefits by subscribing',
      name: 'get_lots_of_benefits_by_subcribing',
      desc: '',
      args: [],
    );
  }

  /// `Subscription per type`
  String get subscription_per_type {
    return Intl.message(
      'Subscription per type',
      name: 'subscription_per_type',
      desc: '',
      args: [],
    );
  }

  /// `Subscription all types`
  String get subcription_all_type {
    return Intl.message(
      'Subscription all types',
      name: 'subcription_all_type',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy all Access`
  String get enjoy_all_access {
    return Intl.message(
      'Enjoy all Access',
      name: 'enjoy_all_access',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message(
      'Subscribe',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get yearly {
    return Intl.message(
      'Yearly',
      name: 'yearly',
      desc: '',
      args: [],
    );
  }

  /// `Please select subscription`
  String get please_select_subscription {
    return Intl.message(
      'Please select subscription',
      name: 'please_select_subscription',
      desc: '',
      args: [],
    );
  }

  /// `Want to hear more? Please subscribe`
  String get want_to_hear_more_please_subscribe {
    return Intl.message(
      'Want to hear more? Please subscribe',
      name: 'want_to_hear_more_please_subscribe',
      desc: '',
      args: [],
    );
  }

  /// `The file is too large, please upload a file less than 30 MB`
  String
      get the_file_is_too_large_please_upload_a_file_with_a_size_of_less_than_30_mb {
    return Intl.message(
      'The file is too large, please upload a file less than 30 MB',
      name:
          'the_file_is_too_large_please_upload_a_file_with_a_size_of_less_than_30_mb',
      desc: '',
      args: [],
    );
  }

  /// `An OTP code has been sent to your Whatsapp number, please check your Whatsapp message, the OTP code is valid until {timeOtp}`
  String otp_code_has_been_sent_wa(Object timeOtp) {
    return Intl.message(
      'An OTP code has been sent to your Whatsapp number, please check your Whatsapp message, the OTP code is valid until $timeOtp',
      name: 'otp_code_has_been_sent_wa',
      desc: '',
      args: [timeOtp],
    );
  }

  /// `An OTP code has been sent to your email, please check your email box, the OTP code is valid until {timeOtp}`
  String otp_code_has_been_sent_email(Object timeOtp) {
    return Intl.message(
      'An OTP code has been sent to your email, please check your email box, the OTP code is valid until $timeOtp',
      name: 'otp_code_has_been_sent_email',
      desc: '',
      args: [timeOtp],
    );
  }

  /// `Your participation in the coolApp affiliate program has been cancelled`
  String get program_cancelled {
    return Intl.message(
      'Your participation in the coolApp affiliate program has been cancelled',
      name: 'program_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the agent referral code`
  String get enter_referral_code {
    return Intl.message(
      'Please enter the agent referral code',
      name: 'enter_referral_code',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR Code`
  String get scan_qr_code {
    return Intl.message(
      'Scan QR Code',
      name: 'scan_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Referral Code (Optional)`
  String get referral_code_optional {
    return Intl.message(
      'Referral Code (Optional)',
      name: 'referral_code_optional',
      desc: '',
      args: [],
    );
  }

  /// `Become Affiliate`
  String get become_affiliate {
    return Intl.message(
      'Become Affiliate',
      name: 'become_affiliate',
      desc: '',
      args: [],
    );
  }

  /// `Affiliate`
  String get affiliate {
    return Intl.message(
      'Affiliate',
      name: 'affiliate',
      desc: '',
      args: [],
    );
  }

  /// `Register Affiliate`
  String get register_affiliate {
    return Intl.message(
      'Register Affiliate',
      name: 'register_affiliate',
      desc: '',
      args: [],
    );
  }

  /// `Total Real Money`
  String get total_real_money {
    return Intl.message(
      'Total Real Money',
      name: 'total_real_money',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message(
      'Withdraw',
      name: 'withdraw',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get income {
    return Intl.message(
      'Income',
      name: 'income',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal`
  String get withdrawal {
    return Intl.message(
      'Withdrawal',
      name: 'withdrawal',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get list {
    return Intl.message(
      'List',
      name: 'list',
      desc: '',
      args: [],
    );
  }

  /// `Total Balance`
  String get total_balance {
    return Intl.message(
      'Total Balance',
      name: 'total_balance',
      desc: '',
      args: [],
    );
  }

  /// `Topup`
  String get topup {
    return Intl.message(
      'Topup',
      name: 'topup',
      desc: '',
      args: [],
    );
  }

  /// `Deduction`
  String get deduction {
    return Intl.message(
      'Deduction',
      name: 'deduction',
      desc: '',
      args: [],
    );
  }

  /// `Topup Amount`
  String get topup_amount {
    return Intl.message(
      'Topup Amount',
      name: 'topup_amount',
      desc: '',
      args: [],
    );
  }

  /// `Minimum deposit`
  String get min_deposit {
    return Intl.message(
      'Minimum deposit',
      name: 'min_deposit',
      desc: '',
      args: [],
    );
  }

  /// `Maximum deposit`
  String get max_deposit {
    return Intl.message(
      'Maximum deposit',
      name: 'max_deposit',
      desc: '',
      args: [],
    );
  }

  /// `Source`
  String get source {
    return Intl.message(
      'Source',
      name: 'source',
      desc: '',
      args: [],
    );
  }

  /// `Select Source`
  String get select_source {
    return Intl.message(
      'Select Source',
      name: 'select_source',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get confirmation {
    return Intl.message(
      'Confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Transaction`
  String get transaction {
    return Intl.message(
      'Transaction',
      name: 'transaction',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Amount`
  String get withdrawal_amount {
    return Intl.message(
      'Withdrawal Amount',
      name: 'withdrawal_amount',
      desc: '',
      args: [],
    );
  }

  /// `Minimum withdrawal`
  String get min_withdrawal {
    return Intl.message(
      'Minimum withdrawal',
      name: 'min_withdrawal',
      desc: '',
      args: [],
    );
  }

  /// `Maximum withdrawal`
  String get max_withdrawal {
    return Intl.message(
      'Maximum withdrawal',
      name: 'max_withdrawal',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `7 Days Ago`
  String get seven_days_ago {
    return Intl.message(
      '7 Days Ago',
      name: 'seven_days_ago',
      desc: '',
      args: [],
    );
  }

  /// `30 Days Ago`
  String get thirty_days_ago {
    return Intl.message(
      '30 Days Ago',
      name: 'thirty_days_ago',
      desc: '',
      args: [],
    );
  }

  /// `90 Days Ago`
  String get ninety_days_ago {
    return Intl.message(
      '90 Days Ago',
      name: 'ninety_days_ago',
      desc: '',
      args: [],
    );
  }

  /// `Total Member`
  String get total_member {
    return Intl.message(
      'Total Member',
      name: 'total_member',
      desc: '',
      args: [],
    );
  }

  /// `Please top up first`
  String get topup_first {
    return Intl.message(
      'Please top up first',
      name: 'topup_first',
      desc: '',
      args: [],
    );
  }

  /// `Referral`
  String get referral {
    return Intl.message(
      'Referral',
      name: 'referral',
      desc: '',
      args: [],
    );
  }

  /// `Show this QR Code to facilitate your affiliate process.`
  String get show_qr_code_to_affiliate {
    return Intl.message(
      'Show this QR Code to facilitate your affiliate process.',
      name: 'show_qr_code_to_affiliate',
      desc: '',
      args: [],
    );
  }

  /// `Share Code`
  String get share_code {
    return Intl.message(
      'Share Code',
      name: 'share_code',
      desc: '',
      args: [],
    );
  }

  /// `Referral code copied`
  String get referral_code_copied {
    return Intl.message(
      'Referral code copied',
      name: 'referral_code_copied',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Share this link to facilitate your affiliate process.`
  String get share_link {
    return Intl.message(
      'Share this link to facilitate your affiliate process.',
      name: 'share_link',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account`
  String get bank_account {
    return Intl.message(
      'Bank Account',
      name: 'bank_account',
      desc: '',
      args: [],
    );
  }

  /// `Bank Name`
  String get bank_name {
    return Intl.message(
      'Bank Name',
      name: 'bank_name',
      desc: '',
      args: [],
    );
  }

  /// `Account Number`
  String get account_number {
    return Intl.message(
      'Account Number',
      name: 'account_number',
      desc: '',
      args: [],
    );
  }

  /// `By clicking "Save", you agree to the terms and conditions`
  String get save_agreement {
    return Intl.message(
      'By clicking "Save", you agree to the terms and conditions',
      name: 'save_agreement',
      desc: '',
      args: [],
    );
  }

  /// `Member Details`
  String get member_details {
    return Intl.message(
      'Member Details',
      name: 'member_details',
      desc: '',
      args: [],
    );
  }

  /// `Select Bank Account`
  String get select_bank_account {
    return Intl.message(
      'Select Bank Account',
      name: 'select_bank_account',
      desc: '',
      args: [],
    );
  }

  /// `Select bank`
  String get select_bank {
    return Intl.message(
      'Select bank',
      name: 'select_bank',
      desc: '',
      args: [],
    );
  }

  /// `Check Account`
  String get check_account {
    return Intl.message(
      'Check Account',
      name: 'check_account',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get member {
    return Intl.message(
      'Member',
      name: 'member',
      desc: '',
      args: [],
    );
  }

  /// `Password successfully changed`
  String get password_changed {
    return Intl.message(
      'Password successfully changed',
      name: 'password_changed',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful`
  String get registration_success {
    return Intl.message(
      'Registration successful',
      name: 'registration_success',
      desc: '',
      args: [],
    );
  }

  /// `This page will close automatically`
  String get close_page_auto {
    return Intl.message(
      'This page will close automatically',
      name: 'close_page_auto',
      desc: '',
      args: [],
    );
  }

  /// `Payment failed, please try again`
  String get payment_failed {
    return Intl.message(
      'Payment failed, please try again',
      name: 'payment_failed',
      desc: '',
      args: [],
    );
  }

  /// `Payment successful`
  String get payment_success {
    return Intl.message(
      'Payment successful',
      name: 'payment_success',
      desc: '',
      args: [],
    );
  }

  /// `Brain Subscription`
  String get brain_subscription {
    return Intl.message(
      'Brain Subscription',
      name: 'brain_subscription',
      desc: '',
      args: [],
    );
  }

  /// `Affiliate Referral Code`
  String get referral_code_affiliate {
    return Intl.message(
      'Affiliate Referral Code',
      name: 'referral_code_affiliate',
      desc: '',
      args: [],
    );
  }

  /// `Brain Activation`
  String get brain_activation {
    return Intl.message(
      'Brain Activation',
      name: 'brain_activation',
      desc: '',
      args: [],
    );
  }

  /// `Coming Soon`
  String get coming_soon {
    return Intl.message(
      'Coming Soon',
      name: 'coming_soon',
      desc: '',
      args: [],
    );
  }

  /// `Merchandise Payment`
  String get merchandise_payment {
    return Intl.message(
      'Merchandise Payment',
      name: 'merchandise_payment',
      desc: '',
      args: [],
    );
  }

  /// `This feature is not available if you are an affiliator`
  String get feature_unavailable_affiliate {
    return Intl.message(
      'This feature is not available if you are an affiliator',
      name: 'feature_unavailable_affiliate',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been disabled, please contact Cool App administrator`
  String get account_disabled_contact_admin {
    return Intl.message(
      'Your account has been disabled, please contact Cool App administrator',
      name: 'account_disabled_contact_admin',
      desc: '',
      args: [],
    );
  }

  /// `Please complete your profile & profiling according to your profile before joining Coolchat`
  String get complete_profile_before_joining {
    return Intl.message(
      'Please complete your profile & profiling according to your profile before joining Coolchat',
      name: 'complete_profile_before_joining',
      desc: '',
      args: [],
    );
  }

  /// `Bank account not found`
  String get bank_account_not_found {
    return Intl.message(
      'Bank account not found',
      name: 'bank_account_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade members to get access to more features`
  String get upgrade_member_to_get_more_feature {
    return Intl.message(
      'Upgrade members to get access to more features',
      name: 'upgrade_member_to_get_more_feature',
      desc: '',
      args: [],
    );
  }

  /// `Member Upgrade Successful`
  String get member_upgrade_successfull {
    return Intl.message(
      'Member Upgrade Successful',
      name: 'member_upgrade_successfull',
      desc: '',
      args: [],
    );
  }

  /// `What is a negative balance(-)?`
  String get what_is_negative_balance {
    return Intl.message(
      'What is a negative balance(-)?',
      name: 'what_is_negative_balance',
      desc: '',
      args: [],
    );
  }

  /// `A negative balance is incurred when a member performs profiling but exceeds the available affiliate balance. This deficit is considered a debt (negative balance). When the affiliate tops up, their balance will automatically be deducted according to the negative balance.`
  String get negative_balance_description {
    return Intl.message(
      'A negative balance is incurred when a member performs profiling but exceeds the available affiliate balance. This deficit is considered a debt (negative balance). When the affiliate tops up, their balance will automatically be deducted according to the negative balance.',
      name: 'negative_balance_description',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions Brain Activation`
  String get terms_conditions_brain_act {
    return Intl.message(
      'Terms and Conditions Brain Activation',
      name: 'terms_conditions_brain_act',
      desc: '',
      args: [],
    );
  }

  /// `Process`
  String get process {
    return Intl.message(
      'Process',
      name: 'process',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Balance`
  String get pindahkan_saldo {
    return Intl.message(
      'Transfer Balance',
      name: 'pindahkan_saldo',
      desc: '',
      args: [],
    );
  }

  /// `The free version can only be listened to for the first 5 minutes. Please subscribe to listen to the entire content.`
  String get free_version_limit {
    return Intl.message(
      'The free version can only be listened to for the first 5 minutes. Please subscribe to listen to the entire content.',
      name: 'free_version_limit',
      desc: '',
      args: [],
    );
  }

  /// `You have reached today's limit of 3 plays`
  String get daily_limit_reached {
    return Intl.message(
      'You have reached today\'s limit of 3 plays',
      name: 'daily_limit_reached',
      desc: '',
      args: [],
    );
  }

  /// `Please listen to the brain according to your character 40 times first. After that, you can subscribe to others.`
  String get listen_brain_40_times {
    return Intl.message(
      'Please listen to the brain according to your character 40 times first. After that, you can subscribe to others.',
      name: 'listen_brain_40_times',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load QR code, please refresh the page`
  String get failed_load_qr_code {
    return Intl.message(
      'Failed to load QR code, please refresh the page',
      name: 'failed_load_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `You have subscribed for this month. Options will be available for the next month`
  String get subscribed_this_month {
    return Intl.message(
      'You have subscribed for this month. Options will be available for the next month',
      name: 'subscribed_this_month',
      desc: '',
      args: [],
    );
  }

  /// `You have not made a deposit fee. Please make a payment first`
  String get no_deposit_fee {
    return Intl.message(
      'You have not made a deposit fee. Please make a payment first',
      name: 'no_deposit_fee',
      desc: '',
      args: [],
    );
  }

  /// `Sharing opportunities, Sharing profits`
  String get sharing_opportunities_sharing_profits {
    return Intl.message(
      'Sharing opportunities, Sharing profits',
      name: 'sharing_opportunities_sharing_profits',
      desc: '',
      args: [],
    );
  }

  /// `Update photo profile success`
  String get update_photo_profile_success {
    return Intl.message(
      'Update photo profile success',
      name: 'update_photo_profile_success',
      desc: '',
      args: [],
    );
  }

  /// `Please upload your profile picture`
  String get please_upload_profile_picture {
    return Intl.message(
      'Please upload your profile picture',
      name: 'please_upload_profile_picture',
      desc: '',
      args: [],
    );
  }

  /// `Your Affiliate Code`
  String get your_affiliate_code {
    return Intl.message(
      'Your Affiliate Code',
      name: 'your_affiliate_code',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get please_enter_a_valid_email_address {
    return Intl.message(
      'Please enter a valid email address',
      name: 'please_enter_a_valid_email_address',
      desc: '',
      args: [],
    );
  }

  /// `Password must include uppercase letters lowercase letters digits and special characters`
  String
      get password_must_include_uppercase_letters_lowercase_letters_digits_and_special_characters {
    return Intl.message(
      'Password must include uppercase letters lowercase letters digits and special characters',
      name:
          'password_must_include_uppercase_letters_lowercase_letters_digits_and_special_characters',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get password_must_be_at_least_8_characters {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'password_must_be_at_least_8_characters',
      desc: '',
      args: [],
    );
  }

//Upload file
  String get uploading_in_progress {
    return Intl.message('Uploading in progress',
        name: 'uploading_in_progress', desc: '', args: []);
  }

  String get please_wait {
    return Intl.message('Please Wait', name: 'please_wait', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'ar', countryCode: 'AR'),
      Locale.fromSubtags(languageCode: 'es', countryCode: 'ES'),
      Locale.fromSubtags(languageCode: 'id', countryCode: 'ID'),
      Locale.fromSubtags(languageCode: 'ms', countryCode: 'MY'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
