// ignore: depend_on_referenced_packages
import 'package:coolappflutter/data/apps/app_sizes.dart';
import 'package:flutter/material.dart';

const noBorder = OutlineInputBorder(
  borderSide: BorderSide.none,
);

final primaryEnable = OutlineInputBorder(
  borderRadius: BorderRadius.circular(Sizes.p50),
  borderSide: const BorderSide(
    color: Colors.grey,
  ),
);

OutlineInputBorder primaryBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(Sizes.p50),
  borderSide: const BorderSide(
    color: Colors.grey,
    // width: 2,
  ),
);
OutlineInputBorder primaryFocused = OutlineInputBorder(
  borderRadius: BorderRadius.circular(Sizes.p50),
  borderSide: const BorderSide(
    color: Colors.grey,
    // width: 2,
  ),
);
