import 'package:flutter/material.dart';
import 'package:teen_splash/model/teen_business_model.dart';
import 'package:teen_splash/utils/gaps.dart';
import 'package:teen_splash/widgets/app_primary_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TeenBusinessDetailsScreen extends StatefulWidget {
  final TeenBusinessModel teenBusiness;
  const TeenBusinessDetailsScreen({
    required this.teenBusiness,
    super.key,
  });

  @override
  State<TeenBusinessDetailsScreen> createState() =>
      _TeenBusinessDetailsScreenState();
}

class _TeenBusinessDetailsScreenState extends State<TeenBusinessDetailsScreen> {
  Future<void> _launchWebsite(String? url, BuildContext context) async {
    if (url != null && await launchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not launch the link.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 227,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.teenBusiness.image.toString(),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 65,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: ImageIcon(
                                color: Theme.of(context).colorScheme.secondary,
                                const AssetImage(
                                  'assets/icons/back.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        // const Spacer(),
                        // InkWell(
                        //   onTap: () {},
                        //   child: Container(
                        //     height: 40,
                        //     width: 40,
                        //     decoration: BoxDecoration(
                        //       color: const Color(0xFFF4F4F4),
                        //       borderRadius: BorderRadius.circular(10.0),
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(6.0),
                        //       child: Icon(
                        //         size: 27,
                        //         Icons.favorite,
                        //         color: Theme.of(context).colorScheme.secondary,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          32.0,
                        ),
                        topRight: Radius.circular(
                          32.0,
                        ),
                      ),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.teenBusiness.businessLogo.toString(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            widget.teenBusiness.businessName.toString(),
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Gaps.hGap20,
                      Text(
                        'Details',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Gaps.hGap10,
                      Text(
                        'About',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Gaps.hGap15,
                      Text(
                        widget.teenBusiness.details.toString(),
                        style: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF999999),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      AppPrimaryButton(
                        text: 'Link to Business',
                        onTap: () => _launchWebsite(
                          widget.teenBusiness.websiteLink.toString(),
                          context,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
