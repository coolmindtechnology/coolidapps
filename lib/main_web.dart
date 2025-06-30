import 'package:coolappflutter/data/provider/provider_profiling.dart';
import 'package:coolappflutter/presentation/pages/profiling/profiling%20dashboard.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:coolappflutter/generated/l10n.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderProfiling()),
      ],
      child: const MyWebApp(),
    ),
  );
}

class MyWebApp extends StatelessWidget {
  const MyWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profiling',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const ProfilingDashboard(),
    );
  }
}
