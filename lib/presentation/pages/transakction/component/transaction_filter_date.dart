// ignore_for_file: library_private_types_in_public_api

import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';

import '../../../theme/color_utils.dart';
import '../../../widgets/button_primary.dart';

class TransactionFilterDialog extends StatefulWidget {
  const TransactionFilterDialog({super.key});

  @override
  _TransactionFilterDialogState createState() =>
      _TransactionFilterDialogState();
}

class _TransactionFilterDialogState extends State<TransactionFilterDialog> {
  List<String> options = [
    S.current.yesterday,
    S.current.today,
    S.current.seven_days_ago,
    S.current.thirty_days_ago,
    S.current.ninety_days_ago,
  ];
  // Selected value (initially null)
  String? _selectedValue;

  getFilterType() {
    switch (_selectedValue) {
      case "Kemarin" || "Yesterday":
        return "yesterday";
      case "Hari Ini" || "Today":
        return "today";
      case "7 Hari yang lalu" || "7 Days Ago":
        return "7";
      case "30 Hari yang lalu" || "30 Days Ago":
        return "30";
      case "90 Hari yang lalu" || "90 Days Ago":
        return "90";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filter",
                ),
                GestureDetector(
                  child: const Icon(Icons.close),
                  onTap: () {
                    Nav.back();
                  },
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: DropdownButtonFormField<String>(
                value: _selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                },
                items: options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: S.of(context).select,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: greyColor),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 1.0, color: greyColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 1.0, color: greyColor),
                  ),
                  fillColor: Colors.grey.withOpacity(0.2),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 54,
                  child: ButtonPrimary(
                    S.of(context).save,
                    onPress: () {
                      Nav.back(
                        data: getFilterType(),
                      );
                    },
                    radius: 10,
                    elevation: 0.0,
                  ),
                )),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: SizedBox(
                  height: 54,
                  child: ButtonPrimary(
                    "Reset",
                    onPress: () {
                      setState(() {
                        _selectedValue = null;
                      });
                      Nav.back(
                        data: getFilterType(),
                      );
                    },
                    radius: 10,
                    elevation: 0.0,
                    negativeColor: true,
                    borderColor: primaryColor,
                    border: 1.0,
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
