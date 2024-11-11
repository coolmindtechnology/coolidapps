import 'package:coolappflutter/presentation/theme/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TitlePosition { top, left }

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final String? title;
  final TextEditingController? textEditingController;
  final bool? isReadOnly;

  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final String? suffixText;
  final void Function()? onTap;
  final String? Function(String? val)? validator;
  final bool? obscureText;
  final String? obsecureTextHint;

  final Widget? suffixIcon;

  final String? Function(String? val)? onChanged;
  final TextInputAction? textInputAction;
  const CustomInputField(
      {super.key,
      this.hintText,
      this.title,
      this.textEditingController,
      this.isReadOnly,
      this.suffixText,
      this.validator,
      this.onTap,
      this.keyboardType,
      this.inputFormatter,
      this.onChanged,
      this.obscureText,
      this.obsecureTextHint,
      this.textInputAction,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title.toString(),
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
        TextFormField(
          onTap: onTap,
          onChanged: onChanged,
          textInputAction: textInputAction,
          readOnly: isReadOnly ?? false,
          controller: textEditingController,
          keyboardType: keyboardType,
          inputFormatters: inputFormatter,
          validator: validator,
          obscureText: obscureText ?? false,
          obscuringCharacter: obsecureTextHint ?? "*",
          decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon,
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: whiteColor),
                  borderRadius:
                      BorderRadius.circular(10) // Set the border color here
                  ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 1.0,
                ),
              ),
              fillColor: Colors.grey.withOpacity(0.2),
              filled: isReadOnly == true && onTap == null ? true : false),
        ),
      ],
    );
  }
}
