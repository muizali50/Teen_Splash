import 'package:flutter/material.dart';
import 'package:teen_splash/utils/gaps.dart';

class SelectGenderPopup extends StatefulWidget {
  final VoidCallback maleOnTap;
  final VoidCallback femaleOnTap;
  const SelectGenderPopup({
    required this.maleOnTap,
    required this.femaleOnTap,
    super.key,
  });

  @override
  State<SelectGenderPopup> createState() => _SelectGenderPopupState();
}

class _SelectGenderPopupState extends State<SelectGenderPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 256,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Gender',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Gaps.hGap15,
          const Text(
            'Lorem ipsum dolor sit amet.',
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF999999)),
          ),
          Gaps.hGap40,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: widget.maleOnTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 41,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF999999),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/male.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Male',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: widget.femaleOnTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 41,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/male.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Female',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
