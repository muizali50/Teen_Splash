import 'package:flutter/material.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          toolbarHeight: 100,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(      
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
            ),
          ),
          title: Text(
            'Terms & Conditions',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSection("1. Acceptance of Terms",
                          "By downloading, accessing, or using the TeenSplash mobile application (the “App”), you (the “User”) agree to be bound by these Terms and Conditions (the “Terms”). These Terms constitute a legally binding agreement between you and TeenSplash, a Major Minors Entertainment (the “Company”). If you do not agree to these Terms, you must not use the App."),
                      _buildSection("2. Eligibility",
                          "The TeenSplash App is available only to individuals who are at least 13 years old. By registering, accessing, or using the App, you represent and warrant that you are eligible under this requirement and have the legal capacity to enter into this Agreement. Users under the age of 18 must obtain parental consent to use the App."),
                      _buildSection("3. Registration and User Accounts", ''),
                      _buildSubSection("3.1 Account Creation",
                          "In order to use certain features of the App, you may be required to create an account. When creating an account, you agree to provide accurate, current, and complete information."),
                      _buildSubSection("3.2 Account Responsibility",
                          "You are solely responsible for maintaining the confidentiality of your login credentials and for all activities that occur under your account. You must notify the Company immediately if you suspect any unauthorized access to or use of your account."),
                      _buildSubSection("3.3 Account Termination",
                          "The Company reserves the right to suspend or terminate your account at any time, with or without cause, including for violations of these Terms."),
                      _buildSection("4. Discount Program Participation", ''),
                      _buildSubSection("4.1 Overview",
                          "TeenSplash allows users to redeem coupon discounts from participating merchants (“Vendors”). These can only be redeemed according to Vendor-specific terms."),
                      _buildSubSection("4.2 Expiration and Forfeiture",
                          "Coupons may expire after a certain period of inactivity or as determined by the Vendor. The Company is not responsible for expired or forfeited coupons."),
                      _buildSubSection("4.3 Vendor Terms",
                          "Each Vendor may have its own policies for coupons. The Company is not liable for the actions, products, or services of any Vendor."),
                      _buildSection("5. Vendor and Third-Party Services", ''),
                      _buildSubSection("5.1 Independent Vendors",
                          "TeenSplash partners with independent Vendors to provide coupons. The Company does not control and is not responsible for any Vendor's products, services, or business practices."),
                      _buildSubSection("5.2 Third-Party Links",
                          "The App may include links to third-party websites or services. The Company does not endorse or assume any responsibility for third-party content or services."),
                      _buildSection("6. User Conduct",
                          "By using the App, you agree to the following:"),
                      _buildSubSection("●  Compliance",
                          "You will use the App in compliance with all applicable laws and regulations."),
                      _buildSubSection("●  Prohibited Uses",
                          "You will not engage in any illegal, fraudulent, or abusive activity, including but not limited to tampering with the App, collecting other users’ data, or impersonating others."),
                      _buildSubSection("●  Content Submission",
                          "Any content you submit through the App (such as reviews or comments) must not infringe on any third-party rights, including intellectual property or privacy rights."),
                      _buildSection("7. Intellectual Property", ''),
                      _buildSubSection("7.1 App Ownership",
                          "The Company retains all rights, title, and interest in and to the App, including all intellectual property rights. You are granted a limited, non-exclusive, non-transferable, and revocable license to use the App for personal, non-commercial purposes."),
                      _buildSubSection("7.2 User Content",
                          "By submitting any content through the App, you grant the Company a worldwide, royalty-free, perpetual license to use, modify, reproduce, and distribute your content in connection with the App."),
                      _buildSection("8. Privacy",
                          "Your privacy is important to us. Please refer to our [Privacy Policy] for details on how we collect, use, and protect your information."),
                      _buildSection("9. Disclaimer of Warranties", ''),
                      _buildSubSection("9.1 No Warranty",
                          "The App is provided on an “as-is” and “as available” basis, without warranties of any kind, either express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, or non-infringement."),
                      _buildSubSection("9.2 Limitation of Liability",
                          "To the fullest extent permitted by law, the Company is not liable for any direct, indirect, incidental, or consequential damages arising from your use of the App, including but not limited to loss of data, revenue, or profits."),
                      _buildSection("10. Indemnification",
                          "You agree to indemnify and hold harmless the Company, its affiliates, and its employees from any claims, liabilities, or damages arising out of your use of the App, violation of these Terms, orviolation of any third-party rights."),
                      _buildSection("11. Governing Law",
                          "These Terms are governed by and construed in accordance with the laws of Barbados, without regard to its conflict of law principles."),
                      _buildSection("12. Changes to the Terms",
                          "The Company reserves the right to modify these Terms at any time. Any changes will be effective upon posting to the App, and continued use of the App after such changes constitutes your acceptance of the new Terms."),
                      _buildSection("13. Contact Us",
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

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }
}
