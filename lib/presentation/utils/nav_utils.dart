import 'package:cool_app/main.dart';
import 'package:flutter/material.dart';

class Nav {
  /// Navigates to the specified [page] using the [MaterialPageRoute] and returns a [Future] that completes when the route is popped.
  ///
  /// Parameters:
  /// - [page]: The widget to navigate to.
  ///
  /// Returns:
  /// A [Future] that completes when the route is popped.
  static Future<dynamic> to(Widget page) async {
    return await navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }

  /// Navigates to the specified [page] using the [MaterialPageRoute] and removes all previous routes from the navigator.
  ///
  /// Parameters:
  /// - [page]: The widget to navigate to.
  ///
  /// Returns:
  /// A [Future] that completes when the route is pushed and all previous routes are removed.
  static Future<dynamic> toAll(Widget page) async {
    return await navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
      (_) => false,
    );
  }

  /// Replaces the current route in the navigator with the specified [page].
  ///
  /// Parameters:
  /// - [page]: The widget to navigate to.
  ///
  /// Returns:
  /// A [Future] that completes when the route is replaced.
  static Future<dynamic> replace(Widget page) async {
    return await navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }

  /// Navigates back to the previous route in the navigator.
  ///
  /// Parameters:
  /// - [data]: The data to pass back to the previous route.
  ///
  /// Returns:
  /// A [Future] that completes when the route is popped.
  static Future<dynamic> back({dynamic data}) async {
    return navigatorKey.currentState?.pop(data);
  }
}
