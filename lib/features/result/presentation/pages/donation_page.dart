import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nu_result/core/utils/utils.dart';

import '../../../../core/constants/constant.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 100,
        title: const Text('Donation'),
        actions: [
          Image.asset(
            NU_LOGO_ICON,
            width: 40,
            height: 40,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'কিছু কথা - ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                DONATION_SUBTITLE,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              const Text(
                'সাহায্য পাঠাতে:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // bKash Section
              _buildDonationCard(
                context,
                'bKash',
                'assets/svg/bkash.svg',
                '017350-69723',
              ),
              const SizedBox(height: 16),
              // Nagad Section
              _buildDonationCard(
                context,
                'Nagad',
                'assets/svg/nagad.svg',
                '017350-69723',
              ),

              const SizedBox(height: 32),
              // Contact Section
              const Text(
                'যেকোনো প্রশ্ন/সহায়তার জন্য আমাদের ফেসবুক পেজে message করুন বা ইমেল করুন:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // Facebook Section
              GestureDetector(
                onTap: () async {
                  launchURL('https://www.facebook.com/decodersfamily');
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    'deCoders Family',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor, // Matches UI theme
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  await EasyLauncher.email(
                    email: "shamsuzzaman15-4031@diu.edu.bd",
                    subject: "Donation Inquiry",
                    body: "Hello,\n NU Result Team,\n",
                  );
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'shamsuzzaman15-4031@diu.edu.bd',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor, // Matches UI theme
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDonationCard(
      BuildContext context, String title, String imagePath, String number) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Match with your UI color scheme
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SvgPicture.asset(
            imagePath,
            width: 48,
            height: 48,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        number,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: number));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Copied to clipboard')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
