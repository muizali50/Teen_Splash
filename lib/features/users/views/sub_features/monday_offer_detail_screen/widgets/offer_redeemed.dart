import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';

class OfferRedeemedDialog extends StatefulWidget {
  final VoidCallback dismissOnTap;
  final String code;
  const OfferRedeemedDialog({
    required this.dismissOnTap,
    required this.code,
    super.key,
  });

  @override
  State<OfferRedeemedDialog> createState() => _OfferRedeemedDialogState();
}

class _OfferRedeemedDialogState extends State<OfferRedeemedDialog> {
  void _copyCode() {
    Clipboard.setData(ClipboardData(text: widget.code)).then(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Code copied to clipboard!'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      height: 300,
      width: 386,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Offer Redeemed!',
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
            'Your offer has been redeemed & your code is  given below.',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF999999),
            ),
          ),
          Gaps.hGap10,
          Text(
            widget.code,
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          Gaps.hGap10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Copy this code',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF999999),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              GestureDetector(
                onTap: _copyCode,
                child: Image.asset(
                  'assets/icons/copy.png',
                  width: 16,
                  height: 16,
                ),
              ),
            ],
          ),
          Gaps.hGap15,
          SizedBox(
            height: 50,
            width: 148,
            child: AppPrimaryButton(
              text: 'Dismiss',
              onTap: widget.dismissOnTap,
            ),
          ),
        ],
      ),
    );
  }
}
