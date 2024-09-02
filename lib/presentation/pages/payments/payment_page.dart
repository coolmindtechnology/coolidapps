import 'package:cool_app/data/models/data_checkout_transaction.dart';
import 'package:cool_app/generated/l10n.dart';
import 'package:cool_app/presentation/pages/payments/payment_success.dart';
import 'package:cool_app/presentation/theme/color_utils.dart';
import 'package:cool_app/presentation/utils/nav_utils.dart';

import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String? total;
  final DataCheckoutTransaction? dataCheckoutTransaction;
  const PaymentPage({super.key, this.total, this.dataCheckoutTransaction});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).order_id,
                          style: TextStyle(color: greyColor),
                        ),
                        Text(
                          "1234567890",
                          style: TextStyle(color: greyColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).items,
                          style: TextStyle(color: greyColor),
                        ),
                        Text(
                          "Paket Premium",
                          style: TextStyle(color: greyColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).total,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        Text(
                          "\$${widget.total ?? "120,000"}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                S.of(context).select_payment_method,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              itemPaymentMethod(
                image: "assets/images/image_visa.png",
                title: S.of(context).credit_card,
                subtitle: S.of(context).credit_card,
                onTap: () {
                  Nav.to(const PaymentSuccess());
                },
              ),
              const Divider(),
              itemPaymentMethod(
                image: "assets/images/image_atmbersama.png",
                title: "ATM/Bank Transfer",
                subtitle: S.of(context).debit_card,
                onTap: () {},
              ),
              const Divider(),
              itemPaymentMethod(
                image: "assets/images/image_bca.png",
                title: "BCA Klik Pay",
                subtitle: "BCA Kli kPay",
                onTap: () {},
              ),
              const Divider(),
              itemPaymentMethod(
                image: "assets/images/image_tcash.png",
                title: "Telkomsel Cash",
                subtitle: "Telkomsel Cash",
                onTap: () {},
              ),
              const Divider(),
              itemPaymentMethod(
                image: "assets/images/image_mandiri.png",
                title: "Mandiri Klik Pay",
                subtitle: "Mandiri Klik Pay",
                onTap: () {},
              ),
              const Divider(),
              itemPaymentMethod(
                image: "assets/images/image_epaybri.png",
                title: "e-Pay BRI",
                subtitle: "e-Pay BRI",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell itemPaymentMethod(
      {String? image,
      String? title,
      String? subtitle,
      void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              "$image",
              height: 40,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$title",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  Text(
                    "${S.of(context).pay_with} $subtitle",
                    style: TextStyle(color: greyColor, fontSize: 12),
                  )
                ],
              ),
            ),
            Image.asset(
              "assets/icons/arrow_right.png",
              width: 12,
            )
          ],
        ),
      ),
    );
  }
}
