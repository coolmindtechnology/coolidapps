import 'package:cool_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
    this.withParamsAdd = true,
  }) : super(key: key);

  final bool withParamsAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "images/no_profiling.png",
              width: 70,
              height: 70,
            ),
          ),
          Text(
            S.of(context).no_data,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          if (withParamsAdd) ...[
            Text(
              S.of(context).add_data_first,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ],
        ],
      ),
    );
  }
}
