import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:cool_app/data/provider/provider_affiliate.dart';
import 'package:cool_app/data/provider/provider_auth.dart';
import 'package:cool_app/data/provider/provider_auth_affiliate.dart';
import 'package:cool_app/data/provider/provider_boarding.dart';
import 'package:cool_app/data/provider/provider_book.dart';
import 'package:cool_app/data/provider/provider_brain_activation.dart';
import 'package:cool_app/data/provider/provider_cool_chat.dart';
import 'package:cool_app/data/provider/provider_payment.dart';
import 'package:cool_app/data/provider/provider_profiling.dart';
import 'package:cool_app/data/provider/provider_transaksi_affiliate.dart';
import 'package:cool_app/data/provider/provider_user.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/splash_screen.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/event_notifier.dart';
import 'package:cool_app/presentation/utils/resources/notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
final EventNotifier eventBalance = EventNotifier();

/// Initializes the Flutter application and initializes Firebase with the appropriate options.
///
/// This function ensures that the Flutter binding is initialized and then checks if the application is running on the web platform.
/// If it is, it initializes Firebase with the provided web options. Otherwise, it initializes Firebase with the default options for the current platform.
///
/// After initializing Firebase, it sets up a callback to record Flutter fatal errors using Firebase Crashlytics.
/// It also requests notification permission if it has been denied.
/// Finally, it initializes local notifications and runs the main application.
///
/// This function does not take any parameters and does not return anything.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    var fbOptions = const FirebaseOptions(
        apiKey: "AIzaSyCgvBMk1EUGk9ujLA0p8lM2vPPOg8ZrolE",
        authDomain: "cool-app-641a1.firebaseapp.com",
        projectId: "cool-app-641a1",
        storageBucket: "cool-app-641a1.appspot.com",
        messagingSenderId: "252404014317",
        appId: "1:252404014317:web:b390ab4aea6fcd035f80e4",
        measurementId: "G-2JY8LGXM4M");

    await Firebase.initializeApp(options: fbOptions);
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  PushNotifications.localNotiInit();
  runApp(const MainApp());
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

  @override
  void initState() {
    super.initState();

    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  // Initializes deep links by setting up the AppLinks instance and subscribing to the uriLinkStream to handle incoming URIs by calling openAppLink.
  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle links
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      print('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  /// Opens the app link by printing the URI and path, and pushing the named route
  /// corresponding to the URI path onto the navigation stack.
  ///
  /// The [uri] parameter is the URI representing the app link to be opened.
  ///
  /// This function does not return anything.
  void openAppLink(Uri uri) {
    print('onAppUri: $uri');
    print('onAppFragment: ${uri.path}');
    navigatorKey.currentState?.pushNamed(uri.path);
  }

  @override
  // Builds the main application widget with multiple ChangeNotifierProviders for different data models and a MaterialApp.
  Widget build(BuildContext context) {
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
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        onGenerateRoute: (RouteSettings settings) {
          // Widget routeWidget = const SplashScreen();
          // print(settings);
          final routeName = settings.name;

          // if (routeName != null) {
          //   if (routeName.contains('/affiliator-referal-code/')) {
          //     // Navigated to /book/:id
          //     List<String> parts = routeName.split('/');
          //     String code = parts.last;
          //     routeWidget = SplashScreen(
          //       codeReferral: code,
          //     );
          //   }
          // }

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
              foregroundColor: primaryColor, // This is a custom color variable
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
          ),
          // dialogTheme: DialogTheme(iconColor: primaryColor),
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,

        // home: const SplashScreen(),
        // home: SplashScreen(providerBoarding: provider),
        // routes: {
        //   "/splash": (context) => const SplashScreen(),
        //   "/login": (context) => const LoginScreen(),
        //    "/": (context) => const NavMenuScreen(),
        // },
      ),
    );
  }
}
