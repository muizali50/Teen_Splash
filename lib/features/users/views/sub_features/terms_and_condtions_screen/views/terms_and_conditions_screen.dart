// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/sub_features/terms_and_condtions_screen/widgets/build_section.dart';
import 'package:teen_splash/features/users/views/sub_features/terms_and_condtions_screen/widgets/build_sub_section.dart';
import 'package:teen_splash/widgets/app_bar.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarWidget(
          isBackIcon: true,
          isTittle: true,
          title: 'Terms & Conditions',
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(-4, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BuildSection(
                          title: "1. Acceptance of Terms",
                          content:
                              "By downloading, accessing, or using the TeenSplash mobile application (the “App”), you (the “User”) agree to be bound by these Terms and Conditions (the “Terms”). These Terms constitute a legally binding agreement between you and TeenSplash, a Major Minors Entertainment (the “Company”). If you do not agree to these Terms, you must not use the App."),
                      const BuildSection(
                          title: "2. Eligibility",
                          content:
                              "The TeenSplash App is available only to individuals who are at least 13 years old. By registering, accessing, or using the App, you represent and warrant that you are eligible under this requirement and have the legal capacity to enter into this Agreement. Users under the age of 18 must obtain parental consent to use the App."),
                      const BuildSection(
                          title: "3. Registration and User Accounts",
                          content: ''),
                      const BuildSubSection(
                          title: "3.1 Account Creation",
                          content:
                              "In order to use certain features of the App, you may be required to create an account. When creating an account, you agree to provide accurate, current, and complete information."),
                      const BuildSubSection(
                          title: "3.2 Account Responsibility",
                          content:
                              "You are solely responsible for maintaining the confidentiality of your login credentials and for all activities that occur under your account. You must notify the Company immediately if you suspect any unauthorized access to or use of your account."),
                      const BuildSubSection(
                          title: "3.3 Account Termination",
                          content:
                              "The Company reserves the right to suspend or terminate your account at any time, with or without cause, including for violations of these Terms."),
                      const BuildSection(
                          title: "4. Discount Program Participation",
                          content: ''),
                      const BuildSubSection(
                          title: "4.1 Overview",
                          content:
                              "TeenSplash allows users to redeem coupon discounts from participating merchants (“Vendors”). These can only be redeemed according to Vendor-specific terms."),
                      const BuildSubSection(
                          title: "4.2 Expiration and Forfeiture",
                          content:
                              "Coupons may expire after a certain period of inactivity or as determined by the Vendor. The Company is not responsible for expired or forfeited coupons."),
                      const BuildSubSection(
                          title: "4.3 Vendor Terms",
                          content:
                              "Each Vendor may have its own policies for coupons. The Company is not liable for the actions, products, or services of any Vendor."),
                      const BuildSection(
                          title: "5. Vendor and Third-Party Services",
                          content: ''),
                      const BuildSubSection(
                          title: "5.1 Independent Vendors",
                          content:
                              "TeenSplash partners with independent Vendors to provide coupons. The Company does not control and is not responsible for any Vendor's products, services, or business practices."),
                      const BuildSubSection(
                          title: "5.2 Third-Party Links",
                          content:
                              "The App may include links to third-party websites or services. The Company does not endorse or assume any responsibility for third-party content or services."),
                      const BuildSection(
                          title: "6. User Conduct",
                          content:
                              "By using the App, you agree to the following:"),
                      const BuildSubSection(
                          title: "●  Compliance",
                          content:
                              "You will use the App in compliance with all applicable laws and regulations."),
                      const BuildSubSection(
                          title: "●  Prohibited Uses",
                          content:
                              "You will not engage in any illegal, fraudulent, or abusive activity, including but not limited to tampering with the App, collecting other users’ data, or impersonating others."),
                      const BuildSubSection(
                          title: "●  Content Submission",
                          content:
                              "Any content you submit through the App (such as reviews or comments) must not infringe on any third-party rights, including intellectual property or privacy rights."),
                      const BuildSection(
                          title: "7. Intellectual Property", content: ''),
                      const BuildSubSection(
                          title: "7.1 App Ownership",
                          content:
                              "The Company retains all rights, title, and interest in and to the App, including all intellectual property rights. You are granted a limited, non-exclusive, non-transferable, and revocable license to use the App for personal, non-commercial purposes."),
                      const BuildSubSection(
                          title: "7.2 User Content",
                          content:
                              "By submitting any content through the App, you grant the Company a worldwide, royalty-free, perpetual license to use, modify, reproduce, and distribute your content in connection with the App."),
                      const BuildSection(
                          title: "8. Privacy",
                          content:
                              "Your privacy is important to us. Please refer to our [Privacy Policy] for details on how we collect, use, and protect your information."),
                      const BuildSection(
                          title: "9. Disclaimer of Warranties", content: ''),
                      const BuildSubSection(
                          title: "9.1 No Warranty",
                          content:
                              "The App is provided on an “as-is” and “as available” basis, without warranties of any kind, either express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, or non-infringement."),
                      BuildSubSection(
                          title: "9.2 Limitation of Liability",
                          content:
                              "To the fullest extent permitted by law, the Company is not liable for any direct, indirect, incidental, or consequential damages arising from your use of the App, including but not limited to loss of data, revenue, or profits."),
                      const BuildSection(
                          title: "10. Indemnification",
                          content:
                              "You agree to indemnify and hold harmless the Company, its affiliates, and its employees from any claims, liabilities, or damages arising out of your use of the App, violation of these Terms, orviolation of any third-party rights."),
                      const BuildSection(
                          title: "11. Governing Law",
                          content:
                              "These Terms are governed by and construed in accordance with the laws of Barbados, without regard to its conflict of law principles."),
                      const BuildSection(
                          title: "12. Changes to the Terms",
                          content:
                              "The Company reserves the right to modify these Terms at any time. Any changes will be effective upon posting to the App, and continued use of the App after such changes constitutes your acceptance of the new Terms."),
                      BuildSection(
                          title: "13. Contact Us",
                          content:
                              "If you have any questions about these Terms, please contact us at info@teensplashevents.com"),
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
