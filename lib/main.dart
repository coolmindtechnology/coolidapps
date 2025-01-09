import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app_links/app_links.dart'; // for mobile deep linking
import 'package:coolappflutter/data/provider/provider_affiliate.dart';
import 'package:coolappflutter/data/provider/provider_auth.dart';
import 'package:coolappflutter/data/provider/provider_auth_affiliate.dart';
import 'package:coolappflutter/data/provider/provider_boarding.dart';
import 'package:coolappflutter/data/provider/provider_book.dart';
import 'package:coolappflutter/data/provider/provider_brain_activation.dart';
import 'package:coolappflutter/data/provider/provider_cool_chat.dart';
import 'package:coolappflutter/data/provider/provider_payment.dart';
import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/data/provider/provider_transaksi_affiliate.dart';
import 'package:coolappflutter/data/provider/provider_user.dart';
import 'package:coolappflutter/data/provider/proviider_notification.dart';

import 'package:coolappflutter/generated/l10n.dart';
import 'package:coolappflutter/presentation/pages/auth/component/location_provider.dart';
import 'package:coolappflutter/presentation/pages/auth/register_screen.dart';
import 'package:coolappflutter/presentation/pages/notification/notification_screen.dart';
import 'package:coolappflutter/presentation/splash_screen.dart';
import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:coolappflutter/presentation/utils/event_notifier.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:coolappflutter/presentation/utils/resources/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart'; // for web

import 'package:android_intent_plus/android_intent.dart';

import 'presentation/pages/auth/component/country_state_city_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
final EventNotifier eventBalance = EventNotifier();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// void _showNotification(RemoteMessage message) async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails('channel_id', 'channel_name',
//           importance: Importance.max, priority: Priority.high);
//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);

//   await flutterLocalNotificationsPlugin.show(
//     0,
//     message.notification?.title,
//     message.notification?.body,
//     platformChannelSpecifics,
//     payload:
//         'navigate_to_notification_screen', // Add payload to identify navigation
//   );
// }

// Callback to handle notification taps
void onDidReceiveNotificationResponse(NotificationResponse response) {
  if (response.payload == 'navigate_to_notification_screen') {
    Nav.to(const NotificationScreen());
    // navigatorKey.currentState?.pushNamed('/notification_screen');
  }
}

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  //   var fbOptions = const FirebaseOptions(
  //     apiKey: 'AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk',
  //     appId: '1:460609975158:android:4368eef2b9acf8efb38057',
  //     messagingSenderId: '460609975158',
  //     projectId: 'my-cool-id',
  //     storageBucket: 'my-cool-id.firebaseio.com',

  //     // authDomain: "cool-app-641a1.firebaseapp.com",

  //     // measurementId: "G-2JY8LGXM4M"
  //   );

  //   await Firebase.initializeApp(options: fbOptions);
  // } else {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await FirebaseMessangingRemoteDatasource().initialize();
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(); // Inisialisasi hanya sekali
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Konfigurasi local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  if (!kIsWeb) {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
    PushNotifications.localNotiInit();
  }
  // Configure `onDidReceiveNotificationResponse` for navigation
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
  );
  runApp(const MainApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  _showNotification(message);
}

void _showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('channel_id', 'channel_name',
          importance: Importance.max, priority: Priority.high);
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title,
    message.notification?.body,
    platformChannelSpecifics,
    payload:
        'navigate_to_notification_screen', // Add payload to identify navigation
  );
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late AppLinks _appLinks;

  StreamSubscription<Uri>? _linkSubscription;
  StreamSubscription? sub;
  String? deepLinkUrl;
  late Widget currentPage;
  bool isDeepLinkActivated = false;
  @override
  void initState() {
    super.initState();
    getFcmToken();
    // Listener ketika notifikasi diterima saat app terbuka
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Pesan saat app terbuka: ${message.notification?.title}');
      _showNotification(message);
    });
    Timer(const Duration(seconds: 2), () {
      checkDeepLinkStatus();
    });
    initDeepLinkListener();
    if (!kIsWeb) {
      initDeepLinks();
    }
  }

  Future<String?> getFcmToken() async {
    if (Platform.isIOS) {
      String? fcmKey = await FirebaseMessaging.instance.getToken();
      return fcmKey;
    }
    String? fcmKey = await FirebaseMessaging.instance.getToken();

    log("fcm tokenss $fcmKey");
    return fcmKey;
  }

  Future<void> checkDeepLinkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Membaca status deep linking, jika 1 berarti sudah diaktifkan
    setState(() {
      isDeepLinkActivated = prefs.getInt('deepLinkStatus') == 1;
    });

    if (!isDeepLinkActivated) {
      // Tampilkan popup jika deep linking belum diaktifkan
      showSettingsDialog();
    } else {
      // Lakukan tindakan jika deep linking sudah diaktifkan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deep linking sudah diaktifkan!')),
      );
    }
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      // print('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  Future<void> initDeepLinkListener() async {
    try {
      // Untuk mendapatkan deep link ketika aplikasi sedang berjalan
      sub = _appLinks.uriLinkStream.listen((Uri? uri) async {
        if (uri != null) {
          // await handleDeepLink(uri.path);
          setState(() {
            deepLinkUrl = uri.toString();
            // Cek path di deep link dan navigasi sesuai
            if (uri.path == "/mobile") {
              currentPage =
                  const SplashScreen(); // Buka halaman MyApp jika path '/myapp' diterima
            } else {
              currentPage = const SplashScreen(); // Halaman default
            }
          });
        }
      });
    } on PlatformException {
      // print('Failed to get deep link.');
    }
  }

  // Future<void> handleDeepLink(String link) async {
  //   if (link.contains("/mobile")) {
  //     // Contoh: jika deeplink URL mengarah ke "/mobile"
  //     PermissionStatus status = await Permission.location.request();

  //     if (status.isGranted) {
  //       // Izin diberikan, arahkan ke halaman terkait
  //       Navigator.pushNamed(context, '/mobile');
  //     } else if (status.isPermanentlyDenied) {
  //       // Jika izin ditolak permanen, arahkan ke halaman pengaturan
  //       openAppSettings();
  //     }
  //   }
  // }

  void openAppLink(Uri uri) {
    // print('onAppUri: $uri');
    // print('onAppFragment: ${uri.path}');
    if (kIsWeb) {
      // Handle web deep link by launching URL in Chrome
      launchInBrowser(uri.toString());
    } else {
      navigatorKey.currentState?.pushNamed(uri.path);
    }
  }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Future<void> handleDeepLink() async {
  //   // Contoh: jika deeplink URL mengarah ke "/mobile"
  //   PermissionStatus status = await Permission.location.request();

  //   if (status.isDenied) {
  //     Timer(const Duration(seconds: 4), () {
  //       showSettingsDialog();
  //     });
  //   } else if (status.isPermanentlyDenied) {
  //     // Jika izin ditolak permanen, arahkan ke halaman pengaturan
  //     // openAppSettingss();
  //   }
  // }
  Future<void> setDeepLinkActivated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Menyimpan nilai 1 yang berarti deep linking sudah diaktifkan
    await prefs.setInt('deepLinkStatus', 1);
  }

  void showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pengaturan Diperlukan"),
          content: const Text(
              "Untuk mengakses fitur deeplink, silakan izinkan akses Set as default lalu berikan izin pada supported web addresses."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                setDeepLinkActivated();
                openAppSettingss();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void openAppSettingss() {
    const AndroidIntent intent = AndroidIntent(
      action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
      data: 'package:mycool.tech.com', // Sesuaikan dengan package aplikasi kamu
    );
    intent.launch().catchError((error) {
      print("Error membuka pengaturan aplikasi: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        enableScaleWH: () => true,
        enableScaleText: () => true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ProviderAuth>(
                create: (context) => ProviderAuth(),
              ),
              ChangeNotifierProvider<ProviderUser>(
                create: (context) => ProviderUser(),
              ),
              ChangeNotifierProvider<ProviderBoarding>(
                create: (context) => ProviderBoarding(),
              ),
              ChangeNotifierProvider<ProviderCoolChat>(
                create: (context) => ProviderCoolChat(),
              ),
              ChangeNotifierProvider<ProviderProfiling>(
                create: (context) => ProviderProfiling(),
              ),
              ChangeNotifierProvider<ProviderBrainActivation>(
                create: (context) => ProviderBrainActivation(),
              ),
              ChangeNotifierProvider<ProviderBook>(
                create: (context) => ProviderBook(),
              ),
              ChangeNotifierProvider(
                  create: (context) => ProviderTransaksiAffiliate()),
              ChangeNotifierProvider(
                create: (context) => ProviderAuthAffiliate(),
              ),
              ChangeNotifierProvider(
                create: (context) => ProviderPayment(),
              ),
              ChangeNotifierProvider(
                create: (context) => ProviderAffiliate(),
              ),
              ChangeNotifierProvider(
                create: (context) => NotificationProvider(),
              ),
              ChangeNotifierProvider(create: (_) => LocationProvider()),
              ChangeNotifierProvider(
                create: (_) => CountryStateCityProvider(),
              ),
            ],
            child: MaterialApp(
              navigatorKey: navigatorKey,
              scaffoldMessengerKey: scaffoldMessengerKey,
              debugShowCheckedModeBanner: false,
              initialRoute: "/",
              onGenerateRoute: (RouteSettings settings) {
                final routeName = settings.name;
                Widget routeWidget = const SplashScreen();

                if (routeName != null) {
                  if (routeName.startsWith('/mobile')) {
                    // Navigated to /book/:id
                    routeWidget = const RegisterScreen();
                  } else if (routeName == '/mobile') {
                    // Navigated to /book without other parameters
                    routeWidget = const RegisterScreen();
                  }
                }
                return MaterialPageRoute(
                  builder: (context) => SplashScreen(codeReferral: routeName),
                  settings: settings,
                  fullscreenDialog: true,
                );
              },
              theme: ThemeData(
                fontFamily: "Poppins",
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                  ),
                ),
                appBarTheme: AppBarTheme(
                  backgroundColor: primaryColor,
                  iconTheme: const IconThemeData(color: Colors.white),
                  centerTitle: true,
                ),
              ),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
            ),
          );
        });
  }
}

///old code
// import 'dart:async';
// import 'dart:developer';

// import 'package:app_links/app_links.dart';
// import 'package:coolappflutter/data/provider/provider_affiliate.dart';
// import 'package:coolappflutter/data/provider/provider_auth.dart';
// import 'package:coolappflutter/data/provider/provider_auth_affiliate.dart';
// import 'package:coolappflutter/data/provider/provider_boarding.dart';
// import 'package:coolappflutter/data/provider/provider_book.dart';
// import 'package:coolappflutter/data/provider/provider_brain_activation.dart';
// import 'package:coolappflutter/data/provider/provider_cool_chat.dart';
// import 'package:coolappflutter/data/provider/provider_payment.dart';
// import 'package:coolappflutter/data/provider/provider_profiling.dart';
// import 'package:coolappflutter/data/provider/provider_transaksi_affiliate.dart';
// import 'package:coolappflutter/data/provider/provider_user.dart';
// import 'package:coolappflutter/generated/l10n.dart';
// import 'package:coolappflutter/presentation/splash_screen.dart';
// import 'package:coolappflutter/presentation/theme/color_utils.dart';
// import 'package:coolappflutter/presentation/utils/event_notifier.dart';
// import 'package:coolappflutter/presentation/utils/resources/notification.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';

// import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
// final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
// final EventNotifier eventBalance = EventNotifier();

// /// Initializes the Flutter application and initializes Firebase with the appropriate options.
// ///
// /// This function ensures that the Flutter binding is initialized and then checks if the application is running on the web platform.
// /// If it is, it initializes Firebase with the provided web options. Otherwise, it initializes Firebase with the default options for the current platform.
// ///
// /// After initializing Firebase, it sets up a callback to record Flutter fatal errors using Firebase Crashlytics.
// /// It also requests notification permission if it has been denied.
// /// Finally, it initializes local notifications and runs the main application.
// ///
// /// This function does not take any parameters and does not return anything.
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   if (kIsWeb) {
//     var fbOptions = const FirebaseOptions(
//         apiKey: "AIzaSyCgvBMk1EUGk9ujLA0p8lM2vPPOg8ZrolE",
//         authDomain: "cool-app-641a1.firebaseapp.com",
//         projectId: "cool-app-641a1",
//         storageBucket: "cool-app-641a1.appspot.com",
//         messagingSenderId: "252404014317",
//         appId: "1:252404014317:web:b390ab4aea6fcd035f80e4",
//         measurementId: "G-2JY8LGXM4M");

//     await Firebase.initializeApp(options: fbOptions);
//   } else {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   }

//   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

//   await Permission.notification.isDenied.then((value) {
//     if (value) {
//       Permission.notification.request();
//     }
//   });
//   PushNotifications.localNotiInit();
//   runApp(const MainApp());
// }

// class MainApp extends StatefulWidget {
//   const MainApp({
//     super.key,
//   });

//   @override
//   State<MainApp> createState() => _MainAppState();
// }

// class _MainAppState extends State<MainApp> {
//   late AppLinks _appLinks;

//   StreamSubscription<Uri>? _linkSubscription;

//   @override
//   void initState() {
//     super.initState();

//     initDeepLinks();
//   }

//   @override
//   void dispose() {
//     _linkSubscription?.cancel();

//     super.dispose();
//   }

//   // Initializes deep links by setting up the AppLinks instance and subscribing to the uriLinkStream to handle incoming URIs by calling openAppLink.
//   Future<void> initDeepLinks() async {
//     _appLinks = AppLinks();

//     // Handle links
//     _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
//       print('onAppLink: $uri');
//       openAppLink(uri);
//     });
//   }

//   /// Opens the app link by printing the URI and path, and pushing the named route
//   /// corresponding to the URI path onto the navigation stack.
//   ///
//   /// The [uri] parameter is the URI representing the app link to be opened.
//   ///
//   /// This function does not return anything.
//   void openAppLink(Uri uri) {
//     print('onAppUri: $uri');
//     print('onAppFragment: ${uri.path}');
//     navigatorKey.currentState?.pushNamed(uri.path);
//   }

//   @override
//   // Builds the main application widget with multiple ChangeNotifierProviders for different data models and a MaterialApp.
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<ProviderAuth>(
//           create: (context) => ProviderAuth(),
//         ),
//         ChangeNotifierProvider<ProviderUser>(
//           create: (context) => ProviderUser(),
//         ),
//         ChangeNotifierProvider<ProviderBoarding>(
//           create: (context) => ProviderBoarding(),
//         ),
//         ChangeNotifierProvider<ProviderCoolChat>(
//           create: (context) => ProviderCoolChat(),
//         ),
//         ChangeNotifierProvider<ProviderProfiling>(
//           create: (context) => ProviderProfiling(),
//         ),
//         ChangeNotifierProvider<ProviderBrainActivation>(
//           create: (context) => ProviderBrainActivation(),
//         ),
//         ChangeNotifierProvider<ProviderBook>(
//           create: (context) => ProviderBook(),
//         ),
//         ChangeNotifierProvider(
//             create: (context) => ProviderTransaksiAffiliate()),
//         ChangeNotifierProvider(
//           create: (context) => ProviderAuthAffiliate(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => ProviderPayment(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => ProviderAffiliate(),
//         ),
//       ],
//       child: MaterialApp(
//         navigatorKey: navigatorKey,
//         scaffoldMessengerKey: scaffoldMessengerKey,
//         debugShowCheckedModeBanner: false,
//         initialRoute: "/",
//         onGenerateRoute: (RouteSettings settings) {
//           // Widget routeWidget = const SplashScreen();
//           // print(settings);
//           final routeName = settings.name;

//           // if (routeName != null) {
//           //   if (routeName.contains('/affiliator-referal-code/')) {
//           //     // Navigated to /book/:id
//           //     List<String> parts = routeName.split('/');
//           //     String code = parts.last;
//           //     routeWidget = SplashScreen(
//           //       codeReferral: code,
//           //     );
//           //   }
//           // }

//           return MaterialPageRoute(
//             builder: (context) => SplashScreen(codeReferral: routeName),
//             settings: settings,
//             fullscreenDialog: true,
//           );
//         },
//         theme: ThemeData(
//           fontFamily: "Poppins",
//           textButtonTheme: TextButtonThemeData(
//             style: TextButton.styleFrom(
//               foregroundColor: primaryColor, // This is a custom color variable
//             ),
//           ),
//           appBarTheme: AppBarTheme(
//             backgroundColor: primaryColor,
//             iconTheme: const IconThemeData(color: Colors.white),
//             centerTitle: true,
//           ),
//           // dialogTheme: DialogTheme(iconColor: primaryColor),
//         ),
//         localizationsDelegates: const [
//           S.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ],
//         supportedLocales: S.delegate.supportedLocales,

//         // home: const SplashScreen(),
//         // home: SplashScreen(providerBoarding: provider),
//         // routes: {
//         //   "/splash": (context) => const SplashScreen(),
//         //   "/login": (context) => const LoginScreen(),
//         //    "/": (context) => const NavMenuScreen(),
//         // },
//       ),
//     );
//   }
// }
