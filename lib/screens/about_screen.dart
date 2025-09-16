import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mana_uz/constants/app_colors.dart';
import 'package:mana_uz/constants/app_constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar with Company Name
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            surfaceTintColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Biz haqimizda',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,

                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image with Overlay
                  // Image.network(
                  //   'https://yandex-images.clstorage.net/ce56k0l85/9bc936yI/hgQnw4dX_LdMxWYYAxyrsQaAlVp2JPjQU8QRW9aA6RlmFPEh0GsEl6PdbfkCTBKFN142sRn4_dQ-rBtmXpuMqWMw0kfCI_jXfIX3PJLdj4AGUEFqt0HcMBcxMfvW5f_q0YN2RwedQwWxD5lcYokygbb_UrK_PM0By-x7BM4pmU_nJZeCdVfvAP83VBxTjnhz1fIhyabXLNFVVHCPQZANKgHAVHZ1H2CUQQw4jpE7gGLgfKEzHUjvY6seWAR8OaruR1clALVk7wFMZleMoi6LgQVzU4sUJx5ThMez7lChvFojQHdmJg_jJqFOKj5DOPPQkuwRs12IfwA4fOrFXSm4D_eFVTNER18DfTcXvjPvuNGGMGLotUY-gVS0QkwjgFyrMSOWxnZdAIZhbYhuknrTkbE9c4Eu6YxACH8qFX87i90EBhdx54XPoz0n9F9ynvhz5YMz6kVHP4GmtBGs4rDdOlAC5HX1jLDW8I-6bNPrQFCRnFMTH4lt8ylM6Qdf-ur91MZWcPWkzMF_FnXtogzbkXRQYdrm5C8A1nWzjxCirjgR8vdGVO1ypVFf6E7iC4KCEq7jwkxIrtO6zms2fZparra31NAXZH7QPCVX_ICdOPGXw4N4xXc9MdRUA19gUj-4ocNVZecMsDTSv7pMEimiUwMNcKHP6j0yON9YNTwayM3XJdVT9mRNAz20hc6QrysQdeARWBSnzgGEdGGs47OsmRMwdwakXBMX8PwYXdCpAYMi7DHC32tPQcuOOhacOtiN9UWFc2V2zUDNBkY_4nzYAFZxMMm0hL6zZFSiDNCTrKqBAgSlVOwS9EK_afzT-BOSQM0R0bya3SB7jWkGreoaXiWGB-AkRg6RHAdXzkK8yREHQoHp5DY8QoUkwXzS0jwqcqHXB-ed4XdjbzvP0-vBcVNMErLOGuyACExJV4zJ2r4Xhnegh-d-As9GV03CTSkTN3JjC5Q0_FG1VgMtE0J-Q',
                  //   fit: BoxFit.cover,
                  //   errorBuilder: (context, error, stackTrace) =>
                  //       Container(color: theme.colorScheme.primary),
                  // ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Info
                  _buildSectionTitle('Kompaniya haqida'),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    child: Column(
                      children: [
                        Text(
                          'Roza Electronics - O\'zbekistonda elektronika mahsulotlarini qulay shartlarda va ishonchli xizmat ko\'rsatish asosida sotuvchi yetakchi kompaniyalardan biri. Bizning maqsadimiz - mijozlarimizga eng yaxshi mahsulotlarni qulay shartlarda taqdim etish.',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 12),
                        _buildLegalInfoItem(
                          'Kompaniya nomi',
                          'COMPTECH RESELLER MCHJ',
                        ),
                        const SizedBox(height: 8),
                        _buildLegalInfoItem('STIR (INN)', '310507224'),
                        _buildLegalInfoItem(
                          'Ro\'yxatdan o\'tgan sana',
                          '25.05.2023',
                        ),
                        const SizedBox(height: 16),
                        _buildLegalInfoItem(
                          'Manzil',
                          '12-uy Islam Karimov kochasi Shumanay,\nQoraqalpog\'iston Respublikasi, 230100 O\'zbekiston',
                        ),
                        const SizedBox(height: 8),
                        _buildLegalInfoItem(
                          'Direktor',
                          'Yerejepova Roza Joldasovna',
                        ),
                        _buildLegalInfoItem('Tug\'ilgan sana', '10.05.1965'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Why Choose Us
                  _buildSectionTitle('Nega bizni tanlashadi?'),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    icon: Icons.verified_user_outlined,
                    title: 'Ishonchli mahsulotlar',
                    description:
                        'Barcha mahsulotlarimiz rasmiy kafolat va sertifikatlarga ega',
                  ),
                  _buildFeatureItem(
                    icon: Icons.savings_outlined,
                    title: 'Qulay to\'lov shartlari',
                    description: '12 oygacha muddatli to\'lov imkoniyati',
                  ),
                  _buildFeatureItem(
                    icon: Icons.local_shipping_outlined,
                    title: 'Tez yetkazib berish',
                    description:
                        'Toshkent bo\'yicha 1 kun ichida, viloyatlarga 2-3 ish kunida',
                  ),
                  _buildFeatureItem(
                    icon: Icons.support_agent_outlined,
                    title: 'Qo\'llab-quvvatlash',
                    description: '24/7 mijozlarga yordam ko\'rsatish xizmati',
                  ),

                  const SizedBox(height: 24),

                  // Contact Information
                  _buildSectionTitle('Bog\'lanish'),
                  const SizedBox(height: 12),
                  _buildContactInfo(),

                  // const SizedBox(height: 32),

                  // // Social Media
                  // _buildSectionTitle('Ijtimoiy tarmoqlar'),

                  // const SizedBox(height: 12),
                  // _buildSocialMedia(),

                  // const SizedBox(height: 32),

                  // // Location
                  // _buildSectionTitle('Manzil'),
                  // const SizedBox(height: 12),
                  // _buildLocationCard(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildInfoCard({required Widget child}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.border),
      ),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return _buildInfoCard(
      child: Column(
        children: [
          _buildContactItem(
            icon: Icons.phone_outlined,
            title: 'Telefon',
            value: '+998 90 123 45 67',
            onTap: () => _makePhoneCall('+998901234567'),
          ),
          const Divider(height: 24),
          _buildContactItem(
            icon: Icons.email_outlined,
            title: 'Elektron pochta',
            value: 'info@manauz.uz',
            onTap: () => _sendEmail('info@rozaelectronics.uz'),
          ),
          const Divider(height: 24),
          _buildContactItem(
            icon: Icons.schedule_outlined,
            title: 'Ish vaqti',
            value: 'Dushanbadan - Jumagacha, 09:00 - 18:00',
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textTertiary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openMaps(String query) async {
    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$query',
    );
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    }
  }
}
