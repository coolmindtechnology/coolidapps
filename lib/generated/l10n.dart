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

  /// `Please wait`
  String get please_wait {
    return Intl.message(
      'Please wait',
      name: 'please_wait',
      desc: '',
      args: [],
    );
  }

  /// `Uploading in progress`
  String get uploading_in_progress {
    return Intl.message(
      'Uploading in progress',
      name: 'uploading_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Have you ever used CoolApps?`
  String get have_you_ever_used_coolApps {
    return Intl.message(
      'Have you ever used CoolApps?',
      name: 'have_you_ever_used_coolApps',
      desc: '',
      args: [],
    );
  }

  /// `Yes, I Have`
  String get yes_i_have {
    return Intl.message(
      'Yes, I Have',
      name: 'yes_i_have',
      desc: '',
      args: [],
    );
  }

  /// `No, this is the first time`
  String get no_this_is_the_first_time {
    return Intl.message(
      'No, this is the first time',
      name: 'no_this_is_the_first_time',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get lanjut {
    return Intl.message(
      'Next',
      name: 'lanjut',
      desc: '',
      args: [],
    );
  }

  /// `Get to know yourself`
  String get come_get_to_know_yourself {
    return Intl.message(
      'Get to know yourself',
      name: 'come_get_to_know_yourself',
      desc: '',
      args: [],
    );
  }

  /// `Every human being is unique and has a different combination of brain types. So, what brain type describes you?`
  String get every_human_being_is_unique {
    return Intl.message(
      'Every human being is unique and has a different combination of brain types. So, what brain type describes you?',
      name: 'every_human_being_is_unique',
      desc: '',
      args: [],
    );
  }

  /// `Let's develop ourselves`
  String get lets_develop_ourselves {
    return Intl.message(
      'Let\'s develop ourselves',
      name: 'lets_develop_ourselves',
      desc: '',
      args: [],
    );
  }

  /// `Develop yourself by exploring the available online books. Be a better version of yourself, anytime and anywhere.`
  String get develop_yourself_by_exploring {
    return Intl.message(
      'Develop yourself by exploring the available online books. Be a better version of yourself, anytime and anywhere.',
      name: 'develop_yourself_by_exploring',
      desc: '',
      args: [],
    );
  }

  /// `Start activating brain potential`
  String get start_activating_brain_potential {
    return Intl.message(
      'Start activating brain potential',
      name: 'start_activating_brain_potential',
      desc: '',
      args: [],
    );
  }

  /// `Reach your brain's maximum potential by listening to special audio recordings that stimulate and enhance various cognitive functions. Play them daily for free.`
  String get reach_your_brains_maximum_potential {
    return Intl.message(
      'Reach your brain\'s maximum potential by listening to special audio recordings that stimulate and enhance various cognitive functions. Play them daily for free.',
      name: 'reach_your_brains_maximum_potential',
      desc: '',
      args: [],
    );
  }

  /// `Share your stories and feelings with CoolApp users. May you find many new friends and positive experiences on CoolApp!`
  String get share_your_stories_and_your_heart_with_CoolApp_users {
    return Intl.message(
      'Share your stories and feelings with CoolApp users. May you find many new friends and positive experiences on CoolApp!',
      name: 'share_your_stories_and_your_heart_with_CoolApp_users',
      desc: '',
      args: [],
    );
  }

  /// `Share stories together`
  String get share_stories_together {
    return Intl.message(
      'Share stories together',
      name: 'share_stories_together',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get select_country {
    return Intl.message(
      'Select Country',
      name: 'select_country',
      desc: '',
      args: [],
    );
  }

  /// `Select State`
  String get select_state {
    return Intl.message(
      'Select State',
      name: 'select_state',
      desc: '',
      args: [],
    );
  }

  /// `Select City`
  String get select_city {
    return Intl.message(
      'Select City',
      name: 'select_city',
      desc: '',
      args: [],
    );
  }

  /// `Select District`
  String get select_district {
    return Intl.message(
      'Select District',
      name: 'select_district',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get district {
    return Intl.message(
      'District',
      name: 'district',
      desc: '',
      args: [],
    );
  }

  /// `Use Your Location`
  String get use_your_location {
    return Intl.message(
      'Use Your Location',
      name: 'use_your_location',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Location`
  String get confirm_location {
    return Intl.message(
      'Confirm Location',
      name: 'confirm_location',
      desc: '',
      args: [],
    );
  }

  /// `Healing`
  String get Healing {
    return Intl.message(
      'Healing',
      name: 'Healing',
      desc: '',
      args: [],
    );
  }

  /// `Consultation`
  String get Consultation {
    return Intl.message(
      'Consultation',
      name: 'Consultation',
      desc: '',
      args: [],
    );
  }

  /// `News From COOL`
  String get News_From_COOL {
    return Intl.message(
      'News From COOL',
      name: 'News_From_COOL',
      desc: '',
      args: [],
    );
  }

  /// `My Profiling`
  String get My_Profiling {
    return Intl.message(
      'My Profiling',
      name: 'My_Profiling',
      desc: '',
      args: [],
    );
  }

  /// `Let's get to know yourself!`
  String get Ayo_kenali_diri_anda {
    return Intl.message(
      'Let\'s get to know yourself!',
      name: 'Ayo_kenali_diri_anda',
      desc: '',
      args: [],
    );
  }

  /// `Become Affiliator`
  String get Become_Affiliator {
    return Intl.message(
      'Become Affiliator',
      name: 'Become_Affiliator',
      desc: '',
      args: [],
    );
  }

  /// `Earn money by becoming an affiliator`
  String get Earn_money_by_becoming_an_affiliator {
    return Intl.message(
      'Earn money by becoming an affiliator',
      name: 'Earn_money_by_becoming_an_affiliator',
      desc: '',
      args: [],
    );
  }

  /// `No profiling yet`
  String get no_profiling_yet {
    return Intl.message(
      'No profiling yet',
      name: 'no_profiling_yet',
      desc: '',
      args: [],
    );
  }

  /// `Come on! Fill in your profile so you can enjoy all our features`
  String get Fill_in_your_profile {
    return Intl.message(
      'Come on! Fill in your profile so you can enjoy all our features',
      name: 'Fill_in_your_profile',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get Edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'Edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Emotion In`
  String get Emotion_in {
    return Intl.message(
      'Emotion In',
      name: 'Emotion_in',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get Post {
    return Intl.message(
      'Post',
      name: 'Post',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get Following {
    return Intl.message(
      'Following',
      name: 'Following',
      desc: '',
      args: [],
    );
  }

  /// `Follower`
  String get Follower {
    return Intl.message(
      'Follower',
      name: 'Follower',
      desc: '',
      args: [],
    );
  }

  /// `My Subscription`
  String get My_Subscription {
    return Intl.message(
      'My Subscription',
      name: 'My_Subscription',
      desc: '',
      args: [],
    );
  }

  /// `digital ID`
  String get digital_ID {
    return Intl.message(
      'digital ID',
      name: 'digital_ID',
      desc: '',
      args: [],
    );
  }

  /// `My Profiling Results`
  String get My_Profiling_Results {
    return Intl.message(
      'My Profiling Results',
      name: 'My_Profiling_Results',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get Setting {
    return Intl.message(
      'Setting',
      name: 'Setting',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get Others {
    return Intl.message(
      'Others',
      name: 'Others',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get Account {
    return Intl.message(
      'Account',
      name: 'Account',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get Security {
    return Intl.message(
      'Security',
      name: 'Security',
      desc: '',
      args: [],
    );
  }

  /// `Notification Settings`
  String get Notification_Settings {
    return Intl.message(
      'Notification Settings',
      name: 'Notification_Settings',
      desc: '',
      args: [],
    );
  }

  /// `About Us & Help`
  String get About_Us_And_Help {
    return Intl.message(
      'About Us & Help',
      name: 'About_Us_And_Help',
      desc: '',
      args: [],
    );
  }

  /// `Report Issue Usage`
  String get Report_Issue_Usage {
    return Intl.message(
      'Report Issue Usage',
      name: 'Report_Issue_Usage',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get Help {
    return Intl.message(
      'Help',
      name: 'Help',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get Terms_and_Conditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'Terms_and_Conditions',
      desc: '',
      args: [],
    );
  }

  /// `App Version V2.4.93`
  String get App_Version {
    return Intl.message(
      'App Version V2.4.93',
      name: 'App_Version',
      desc: '',
      args: [],
    );
  }

  /// `Your Old Email`
  String get Old_Email {
    return Intl.message(
      'Your Old Email',
      name: 'Old_Email',
      desc: '',
      args: [],
    );
  }

  /// `Input New Email`
  String get New_Email_Input {
    return Intl.message(
      'Input New Email',
      name: 'New_Email_Input',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get Change_Email {
    return Intl.message(
      'Change Email',
      name: 'Change_Email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get Email_Input {
    return Intl.message(
      'Enter your email',
      name: 'Email_Input',
      desc: '',
      args: [],
    );
  }

  /// `Input OTP Code`
  String get OTP_Code_Input {
    return Intl.message(
      'Input OTP Code',
      name: 'OTP_Code_Input',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verification code sent to your email`
  String get Verification_Code {
    return Intl.message(
      'Enter the verification code sent to your email',
      name: 'Verification_Code',
      desc: '',
      args: [],
    );
  }

  /// `Not You?`
  String get Not_You {
    return Intl.message(
      'Not You?',
      name: 'Not_You',
      desc: '',
      args: [],
    );
  }

  /// `Request Account Deletion`
  String get Request_Account_Deletion {
    return Intl.message(
      'Request Account Deletion',
      name: 'Request_Account_Deletion',
      desc: '',
      args: [],
    );
  }

  /// `Report Issue`
  String get Report_Issue {
    return Intl.message(
      'Report Issue',
      name: 'Report_Issue',
      desc: '',
      args: [],
    );
  }

  /// `What problem are you experiencing?`
  String get What_Problem {
    return Intl.message(
      'What problem are you experiencing?',
      name: 'What_Problem',
      desc: '',
      args: [],
    );
  }

  /// `Tell us!`
  String get Tell_Us {
    return Intl.message(
      'Tell us!',
      name: 'Tell_Us',
      desc: '',
      args: [],
    );
  }

  /// `Tell us here`
  String get Tell_Us_Here {
    return Intl.message(
      'Tell us here',
      name: 'Tell_Us_Here',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get Send {
    return Intl.message(
      'Send',
      name: 'Send',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your report`
  String get Thank_You_For_Your_Report {
    return Intl.message(
      'Thank you for your report',
      name: 'Thank_You_For_Your_Report',
      desc: '',
      args: [],
    );
  }

  /// `We appreciate all feedback and suggestions. We will strive to be better.`
  String get We_Appreciate_Your_Feedback {
    return Intl.message(
      'We appreciate all feedback and suggestions. We will strive to be better.',
      name: 'We_Appreciate_Your_Feedback',
      desc: '',
      args: [],
    );
  }

  /// `I Understand`
  String get I_Understand {
    return Intl.message(
      'I Understand',
      name: 'I_Understand',
      desc: '',
      args: [],
    );
  }

  /// `Current Language`
  String get Current_Language {
    return Intl.message(
      'Current Language',
      name: 'Current_Language',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Language`
  String get Choose_Your_Language {
    return Intl.message(
      'Choose Your Language',
      name: 'Choose_Your_Language',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete your account?`
  String get Do_You_Want_To_Delete_Account {
    return Intl.message(
      'Do you want to delete your account?',
      name: 'Do_You_Want_To_Delete_Account',
      desc: '',
      args: [],
    );
  }

  /// `Please tell us why you want to delete your account`
  String get Please_Tell_Us_Why {
    return Intl.message(
      'Please tell us why you want to delete your account',
      name: 'Please_Tell_Us_Why',
      desc: '',
      args: [],
    );
  }

  /// `Choose your reason`
  String get Choose_Your_Reason {
    return Intl.message(
      'Choose your reason',
      name: 'Choose_Your_Reason',
      desc: '',
      args: [],
    );
  }

  /// `Your story helps us to improve`
  String get Your_Story_Helps {
    return Intl.message(
      'Your story helps us to improve',
      name: 'Your_Story_Helps',
      desc: '',
      args: [],
    );
  }

  /// `Write here`
  String get Write_Here {
    return Intl.message(
      'Write here',
      name: 'Write_Here',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get Delete_Account {
    return Intl.message(
      'Delete Account',
      name: 'Delete_Account',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your identity`
  String get Confirm_Your_Identity {
    return Intl.message(
      'Confirm your identity',
      name: 'Confirm_Your_Identity',
      desc: '',
      args: [],
    );
  }

  /// `Please provide your email or phone number below`
  String get Please_Provide_Email_Phone {
    return Intl.message(
      'Please provide your email or phone number below',
      name: 'Please_Provide_Email_Phone',
      desc: '',
      args: [],
    );
  }

  /// `Your Email`
  String get Your_Email {
    return Intl.message(
      'Your Email',
      name: 'Your_Email',
      desc: '',
      args: [],
    );
  }

  /// `Use phone number`
  String get Use_Phone_Number {
    return Intl.message(
      'Use phone number',
      name: 'Use_Phone_Number',
      desc: '',
      args: [],
    );
  }

  /// `Send verification code`
  String get Send_Verification_Code {
    return Intl.message(
      'Send verification code',
      name: 'Send_Verification_Code',
      desc: '',
      args: [],
    );
  }

  /// `Change phone number`
  String get Change_Phone_Number {
    return Intl.message(
      'Change phone number',
      name: 'Change_Phone_Number',
      desc: '',
      args: [],
    );
  }

  /// `Account Deletion Terms`
  String get Account_Deletion_Terms {
    return Intl.message(
      'Account Deletion Terms',
      name: 'Account_Deletion_Terms',
      desc: '',
      args: [],
    );
  }

  /// `Goodbye`
  String get Goodbye {
    return Intl.message(
      'Goodbye',
      name: 'Goodbye',
      desc: '',
      args: [],
    );
  }

  /// `It was nice knowing you for this short time, we will miss you`
  String get Short_Time {
    return Intl.message(
      'It was nice knowing you for this short time, we will miss you',
      name: 'Short_Time',
      desc: '',
      args: [],
    );
  }

  /// `Use Email`
  String get Use_Email {
    return Intl.message(
      'Use Email',
      name: 'Use_Email',
      desc: '',
      args: [],
    );
  }

  /// `Go test your profiling now & know yourself better`
  String get Go_test_profiling {
    return Intl.message(
      'Go test your profiling now & know yourself better',
      name: 'Go_test_profiling',
      desc: '',
      args: [],
    );
  }

  /// `20% Discount Special for newcomer`
  String get Discount_newcomer {
    return Intl.message(
      '20% Discount Special for newcomer',
      name: 'Discount_newcomer',
      desc: '',
      args: [],
    );
  }

  /// `Knowing yourself is a way to love yourself`
  String get Knowing_yourself {
    return Intl.message(
      'Knowing yourself is a way to love yourself',
      name: 'Knowing_yourself',
      desc: '',
      args: [],
    );
  }

  /// `Know yourself better!`
  String get Know_deeper {
    return Intl.message(
      'Know yourself better!',
      name: 'Know_deeper',
      desc: '',
      args: [],
    );
  }

  /// `Consult based on your personality to become more familiar with yourself`
  String get Consult_based_personality {
    return Intl.message(
      'Consult based on your personality to become more familiar with yourself',
      name: 'Consult_based_personality',
      desc: '',
      args: [],
    );
  }

  /// `Free for 3 times!`
  String get Free_3_times {
    return Intl.message(
      'Free for 3 times!',
      name: 'Free_3_times',
      desc: '',
      args: [],
    );
  }

  /// `Consult for free 3 times in 3 days and maximize your potential`
  String get Free_consult_3_days {
    return Intl.message(
      'Consult for free 3 times in 3 days and maximize your potential',
      name: 'Free_consult_3_days',
      desc: '',
      args: [],
    );
  }

  /// `Open all consultation topics and choose based on your interests`
  String get Open_all_topics {
    return Intl.message(
      'Open all consultation topics and choose based on your interests',
      name: 'Open_all_topics',
      desc: '',
      args: [],
    );
  }

  /// `Open all topics!`
  String get Open_all_topics_now {
    return Intl.message(
      'Open all topics!',
      name: 'Open_all_topics_now',
      desc: '',
      args: [],
    );
  }

  /// `COOLAPP now provides a professional consultation space for you`
  String get Coolapp_consultation_space {
    return Intl.message(
      'COOLAPP now provides a professional consultation space for you',
      name: 'Coolapp_consultation_space',
      desc: '',
      args: [],
    );
  }

  /// `New Consultation Session`
  String get New_consultation_session {
    return Intl.message(
      'New Consultation Session',
      name: 'New_consultation_session',
      desc: '',
      args: [],
    );
  }

  /// `Active Session`
  String get Active_session {
    return Intl.message(
      'Active Session',
      name: 'Active_session',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get Requests {
    return Intl.message(
      'Requests',
      name: 'Requests',
      desc: '',
      args: [],
    );
  }

  /// `Archives`
  String get Archives {
    return Intl.message(
      'Archives',
      name: 'Archives',
      desc: '',
      args: [],
    );
  }

  /// `No sessions`
  String get No_sessions {
    return Intl.message(
      'No sessions',
      name: 'No_sessions',
      desc: '',
      args: [],
    );
  }

  /// `Start consulting now!`
  String get Start_consulting_now {
    return Intl.message(
      'Start consulting now!',
      name: 'Start_consulting_now',
      desc: '',
      args: [],
    );
  }

  /// `Please consult your personality`
  String get Consult_personality {
    return Intl.message(
      'Please consult your personality',
      name: 'Consult_personality',
      desc: '',
      args: [],
    );
  }

  /// `Free consultation once a day!`
  String get Free_once_daily {
    return Intl.message(
      'Free consultation once a day!',
      name: 'Free_once_daily',
      desc: '',
      args: [],
    );
  }

  /// `PERSONALITY`
  String get PERSONALITY {
    return Intl.message(
      'PERSONALITY',
      name: 'PERSONALITY',
      desc: '',
      args: [],
    );
  }

  /// `Description of the previous personality`
  String get PERSONALITY_desc {
    return Intl.message(
      'Description of the previous personality',
      name: 'PERSONALITY_desc',
      desc: '',
      args: [],
    );
  }

  /// `PARENTING`
  String get PARENTING {
    return Intl.message(
      'PARENTING',
      name: 'PARENTING',
      desc: '',
      args: [],
    );
  }

  /// `Description of the previous parenting topic`
  String get PARENTING_desc {
    return Intl.message(
      'Description of the previous parenting topic',
      name: 'PARENTING_desc',
      desc: '',
      args: [],
    );
  }

  /// `BUSINESS`
  String get BUSINESS {
    return Intl.message(
      'BUSINESS',
      name: 'BUSINESS',
      desc: '',
      args: [],
    );
  }

  /// `Description of the previous business topic`
  String get BUSINESS_desc {
    return Intl.message(
      'Description of the previous business topic',
      name: 'BUSINESS_desc',
      desc: '',
      args: [],
    );
  }

  /// `FITNESS`
  String get FITNESS {
    return Intl.message(
      'FITNESS',
      name: 'FITNESS',
      desc: '',
      args: [],
    );
  }

  /// `Choose your session time`
  String get Choose_session_time {
    return Intl.message(
      'Choose your session time',
      name: 'Choose_session_time',
      desc: '',
      args: [],
    );
  }

  /// `You can choose when it's convenient to consult`
  String get Choose_time_consult {
    return Intl.message(
      'You can choose when it\'s convenient to consult',
      name: 'Choose_time_consult',
      desc: '',
      args: [],
    );
  }

  /// `Choose Session Hour`
  String get Choose_session_hour {
    return Intl.message(
      'Choose Session Hour',
      name: 'Choose_session_hour',
      desc: '',
      args: [],
    );
  }

  /// `Each session is limited to 30 minutes`
  String get Only_30_minutes {
    return Intl.message(
      'Each session is limited to 30 minutes',
      name: 'Only_30_minutes',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `Choose your consultant carefully, you will work with them for the next 3 days`
  String get Choose_your_consultant {
    return Intl.message(
      'Choose your consultant carefully, you will work with them for the next 3 days',
      name: 'Choose_your_consultant',
      desc: '',
      args: [],
    );
  }

  /// `Selected Topic:`
  String get Selected_topic {
    return Intl.message(
      'Selected Topic:',
      name: 'Selected_topic',
      desc: '',
      args: [],
    );
  }

  /// `Consultation Time`
  String get Consultation_time {
    return Intl.message(
      'Consultation Time',
      name: 'Consultation_time',
      desc: '',
      args: [],
    );
  }

  /// `CREATIVE`
  String get CREATIVE {
    return Intl.message(
      'CREATIVE',
      name: 'CREATIVE',
      desc: '',
      args: [],
    );
  }

  /// `Achievement`
  String get Achievement {
    return Intl.message(
      'Achievement',
      name: 'Achievement',
      desc: '',
      args: [],
    );
  }

  /// `Share your feelings`
  String get Curhat {
    return Intl.message(
      'Share your feelings',
      name: 'Curhat',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Pick Date`
  String get Pick_Date {
    return Intl.message(
      'Pick Date',
      name: 'Pick_Date',
      desc: '',
      args: [],
    );
  }

  /// `Pick your consultant`
  String get Pick_Consultant {
    return Intl.message(
      'Pick your consultant',
      name: 'Pick_Consultant',
      desc: '',
      args: [],
    );
  }

  /// `Session Completed`
  String get Session_Completed {
    return Intl.message(
      'Session Completed',
      name: 'Session_Completed',
      desc: '',
      args: [],
    );
  }

  /// `Your Explanation`
  String get Your_Explanation {
    return Intl.message(
      'Your Explanation',
      name: 'Your_Explanation',
      desc: '',
      args: [],
    );
  }

  /// `Why do you need a consultant?`
  String get Why_Need_Consultant {
    return Intl.message(
      'Why do you need a consultant?',
      name: 'Why_Need_Consultant',
      desc: '',
      args: [],
    );
  }

  /// `Session Summary`
  String get Session_Summary {
    return Intl.message(
      'Session Summary',
      name: 'Session_Summary',
      desc: '',
      args: [],
    );
  }

  /// `Review your session`
  String get Review_Your_Session {
    return Intl.message(
      'Review your session',
      name: 'Review_Your_Session',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get Price {
    return Intl.message(
      'Price',
      name: 'Price',
      desc: '',
      args: [],
    );
  }

  /// `FREE`
  String get FREE {
    return Intl.message(
      'FREE',
      name: 'FREE',
      desc: '',
      args: [],
    );
  }

  /// `*Payment is made after the request is approved by the consultant`
  String get Payment_After_Approval {
    return Intl.message(
      '*Payment is made after the request is approved by the consultant',
      name: 'Payment_After_Approval',
      desc: '',
      args: [],
    );
  }

  /// `The above information is correct according to the consultation session I want`
  String get Information_Confirmed {
    return Intl.message(
      'The above information is correct according to the consultation session I want',
      name: 'Information_Confirmed',
      desc: '',
      args: [],
    );
  }

  /// `Awaiting consultant's schedule confirmation, please wait`
  String get Awaiting_Confirmation {
    return Intl.message(
      'Awaiting consultant\'s schedule confirmation, please wait',
      name: 'Awaiting_Confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Back to consultation page in 3 seconds`
  String get Back_to_Consultation {
    return Intl.message(
      'Back to consultation page in 3 seconds',
      name: 'Back_to_Consultation',
      desc: '',
      args: [],
    );
  }

  /// `Follow on Coolchat`
  String get Follow_on_Coolchat {
    return Intl.message(
      'Follow on Coolchat',
      name: 'Follow_on_Coolchat',
      desc: '',
      args: [],
    );
  }

  /// `Discuss this`
  String get Discuss_This {
    return Intl.message(
      'Discuss this',
      name: 'Discuss_This',
      desc: '',
      args: [],
    );
  }

  /// `Consultant Profile`
  String get Consultant_Profile {
    return Intl.message(
      'Consultant Profile',
      name: 'Consultant_Profile',
      desc: '',
      args: [],
    );
  }

  /// `Why do you need my consultation?`
  String get Why_Consultation_Needed {
    return Intl.message(
      'Why do you need my consultation?',
      name: 'Why_Consultation_Needed',
      desc: '',
      args: [],
    );
  }

  /// `ACCEPTED`
  String get ACCEPTED {
    return Intl.message(
      'ACCEPTED',
      name: 'ACCEPTED',
      desc: '',
      args: [],
    );
  }

  /// `Continue Payment`
  String get Continue_Payment {
    return Intl.message(
      'Continue Payment',
      name: 'Continue_Payment',
      desc: '',
      args: [],
    );
  }

  /// `Session Status`
  String get Session_Completed_Status {
    return Intl.message(
      'Session Status',
      name: 'Session_Completed_Status',
      desc: '',
      args: [],
    );
  }

  /// `Consultation request accepted`
  String get Consultation_Request_Accepted {
    return Intl.message(
      'Consultation request accepted',
      name: 'Consultation_Request_Accepted',
      desc: '',
      args: [],
    );
  }

  /// `CoolTeam`
  String get CoolTeam {
    return Intl.message(
      'CoolTeam',
      name: 'CoolTeam',
      desc: '',
      args: [],
    );
  }

  /// `Consultant Name`
  String get Consultant_Name {
    return Intl.message(
      'Consultant Name',
      name: 'Consultant_Name',
      desc: '',
      args: [],
    );
  }

  /// `Session starts in`
  String get Session_Begins_In {
    return Intl.message(
      'Session starts in',
      name: 'Session_Begins_In',
      desc: '',
      args: [],
    );
  }

  /// `minutes left`
  String get Minutes_Left {
    return Intl.message(
      'minutes left',
      name: 'Minutes_Left',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get Status {
    return Intl.message(
      'Status',
      name: 'Status',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get Accepted {
    return Intl.message(
      'Accepted',
      name: 'Accepted',
      desc: '',
      args: [],
    );
  }

  /// `Session Details`
  String get Session_Details {
    return Intl.message(
      'Session Details',
      name: 'Session_Details',
      desc: '',
      args: [],
    );
  }

  /// `Start Session?`
  String get Start_Session {
    return Intl.message(
      'Start Session?',
      name: 'Start_Session',
      desc: '',
      args: [],
    );
  }

  /// `You are not allowed to leave the consultation session before it ends`
  String get Cannot_Leave_Session {
    return Intl.message(
      'You are not allowed to leave the consultation session before it ends',
      name: 'Cannot_Leave_Session',
      desc: '',
      args: [],
    );
  }

  /// `Cannot leave the session`
  String get CANNOT_LEAVE_SESSION {
    return Intl.message(
      'Cannot leave the session',
      name: 'CANNOT_LEAVE_SESSION',
      desc: '',
      args: [],
    );
  }

  /// `Please complete your session before leaving`
  String get Complete_Session_First {
    return Intl.message(
      'Please complete your session before leaving',
      name: 'Complete_Session_First',
      desc: '',
      args: [],
    );
  }

  /// `Understood`
  String get Understood {
    return Intl.message(
      'Understood',
      name: 'Understood',
      desc: '',
      args: [],
    );
  }

  /// `Completed On:`
  String get Completed_On {
    return Intl.message(
      'Completed On:',
      name: 'Completed_On',
      desc: '',
      args: [],
    );
  }

  /// `Consultation History`
  String get Consultation_History {
    return Intl.message(
      'Consultation History',
      name: 'Consultation_History',
      desc: '',
      args: [],
    );
  }

  /// `ARCHIVED (COMPLETED)`
  String get Session_Archived {
    return Intl.message(
      'ARCHIVED (COMPLETED)',
      name: 'Session_Archived',
      desc: '',
      args: [],
    );
  }

  /// `Rating Given`
  String get Rating_Given {
    return Intl.message(
      'Rating Given',
      name: 'Rating_Given',
      desc: '',
      args: [],
    );
  }

  /// `View Archive`
  String get View_Archive {
    return Intl.message(
      'View Archive',
      name: 'View_Archive',
      desc: '',
      args: [],
    );
  }

  /// `ARCHIVE`
  String get ARCHIVE {
    return Intl.message(
      'ARCHIVE',
      name: 'ARCHIVE',
      desc: '',
      args: [],
    );
  }

  /// `Give Rating`
  String get Give_Rating {
    return Intl.message(
      'Give Rating',
      name: 'Give_Rating',
      desc: '',
      args: [],
    );
  }

  /// `Share your experience`
  String get Share_Experience {
    return Intl.message(
      'Share your experience',
      name: 'Share_Experience',
      desc: '',
      args: [],
    );
  }

  /// `How was your chat session?`
  String get How_was_Your_Chat_Session {
    return Intl.message(
      'How was your chat session?',
      name: 'How_was_Your_Chat_Session',
      desc: '',
      args: [],
    );
  }

  /// `Add session?`
  String get Add_Session {
    return Intl.message(
      'Add session?',
      name: 'Add_Session',
      desc: '',
      args: [],
    );
  }

  /// `Join on Coolchat`
  String get Join_Coolchat {
    return Intl.message(
      'Join on Coolchat',
      name: 'Join_Coolchat',
      desc: '',
      args: [],
    );
  }

  /// `Related Topics`
  String get Related_Topics {
    return Intl.message(
      'Related Topics',
      name: 'Related_Topics',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get Video {
    return Intl.message(
      'Video',
      name: 'Video',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get Image {
    return Intl.message(
      'Image',
      name: 'Image',
      desc: '',
      args: [],
    );
  }

  /// `Discussing this`
  String get Discussing_This {
    return Intl.message(
      'Discussing this',
      name: 'Discussing_This',
      desc: '',
      args: [],
    );
  }

  /// `Request Accepted`
  String get Request_Accepted {
    return Intl.message(
      'Request Accepted',
      name: 'Request_Accepted',
      desc: '',
      args: [],
    );
  }

  /// `Pay Now`
  String get Pay_Now {
    return Intl.message(
      'Pay Now',
      name: 'Pay_Now',
      desc: '',
      args: [],
    );
  }

  /// `Session closed, you can no longer send messages to your consultant, but the consultant can still respond.`
  String get Session_Closed_Message {
    return Intl.message(
      'Session closed, you can no longer send messages to your consultant, but the consultant can still respond.',
      name: 'Session_Closed_Message',
      desc: '',
      args: [],
    );
  }

  /// `Receipt`
  String get Receipt {
    return Intl.message(
      'Receipt',
      name: 'Receipt',
      desc: '',
      args: [],
    );
  }

  /// `Support Your Preferred Promoter`
  String get Support_Your_Preferred_Promoter {
    return Intl.message(
      'Support Your Preferred Promoter',
      name: 'Support_Your_Preferred_Promoter',
      desc: '',
      args: [],
    );
  }

  /// `Please select the promoter you wish to support.`
  String get Please_select_the_promoter_you_wish_to_support {
    return Intl.message(
      'Please select the promoter you wish to support.',
      name: 'Please_select_the_promoter_you_wish_to_support',
      desc: '',
      args: [],
    );
  }

  /// `Have a promoter you'd like to support? Enter their referral code below!`
  String get Enter_referal_code {
    return Intl.message(
      'Have a promoter you\'d like to support? Enter their referral code below!',
      name: 'Enter_referal_code',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get Or {
    return Intl.message(
      'Or',
      name: 'Or',
      desc: '',
      args: [],
    );
  }

  /// `Total Point`
  String get Total_Point {
    return Intl.message(
      'Total Point',
      name: 'Total_Point',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get Overview {
    return Intl.message(
      'Overview',
      name: 'Overview',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get Balance {
    return Intl.message(
      'Balance',
      name: 'Balance',
      desc: '',
      args: [],
    );
  }

  /// `Real Money`
  String get Real_Money {
    return Intl.message(
      'Real Money',
      name: 'Real_Money',
      desc: '',
      args: [],
    );
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
      Locale.fromSubtags(languageCode: 'ru', countryCode: 'RU'),
      Locale.fromSubtags(languageCode: 'tr', countryCode: 'TR'),
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
