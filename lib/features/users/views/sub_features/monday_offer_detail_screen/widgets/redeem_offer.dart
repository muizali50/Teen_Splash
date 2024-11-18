import 'package:flutter/material.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';

class RedeemOfferPopup extends StatefulWidget {
  final VoidCallback redeemOnTap;
  final VoidCallback cancelOnTap;
  const RedeemOfferPopup({
    required this.redeemOnTap,
    required this.cancelOnTap,
    super.key,
  });

  @override
  State<RedeemOfferPopup> createState() => _RedeemOfferPopupState();
}

class _RedeemOfferPopupState extends State<RedeemOfferPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      // height: 300,
      // width: 386,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            scale: 10,
            'assets/icons/redeem.jpg',
          ),
          Gaps.hGap15,
          Text(
            'Redeem Offer?',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Gaps.hGap10,
          const Text(
            textAlign: TextAlign.center,
            'Do you really want to redeem this offer?',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF999999),
            ),
          ),
          Gaps.hGap15,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 106,
                child: AppPrimaryButton(
                  hintTextColor: Theme.of(context).colorScheme.primary,
                  isBorderColor: Theme.of(context).colorScheme.tertiary,
                  isBorder: true,
                  text: 'Cancel',
                  onTap: widget.cancelOnTap,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                height: 50,
                width: 106,
                child: AppPrimaryButton(
                  text: 'Redeem',
                  onTap: widget.redeemOnTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
