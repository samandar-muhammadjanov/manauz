import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mana_uz/constants/app_colors.dart';
import 'package:mana_uz/constants/app_constants.dart';
import 'package:mana_uz/widgets/product_card_new.dart' show ProductCard;

class OrderScreen extends StatefulWidget {
  final Map<String, dynamic>? product;

  const OrderScreen({super.key, this.product});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _commentsController = TextEditingController();

  String _selectedPaymentMethod = 'cash';
  int _quantity = 1;
  bool _isSubmitting = false;

  late final Map<String, dynamic> _product;

  @override
  void initState() {
    super.initState();
    // Initialize with default values if needed
    _product = widget.product ?? AppConstants.featuredProducts.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            title: const Text(
              'Buyurtma berish',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: theme.scaffoldBackgroundColor,
            iconTheme: IconThemeData(color: theme.colorScheme.onBackground),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Product Info Card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mahsulot',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ProductCard.horizontal(
                              product: AppConstants.featuredProducts.first,
                              onTap: null,
                            ),
                            const SizedBox(height: 8),
                            // Quantity Selector
                            Row(
                              children: [
                                const Text('Soni:'),
                                const SizedBox(width: 16),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        if (_quantity > 1) {
                                          setState(() => _quantity--);
                                        }
                                      },
                                    ),
                                    Container(
                                      width: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '$_quantity',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        setState(() => _quantity++);
                                      },
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  '${_formatPrice(_product['price'] * _quantity)} so\'m',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Customer Info Card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mijoz ma\'lumotlari',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Name Field
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Ismingiz',
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Iltimos, ismingizni kiriting';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // Phone Field
                            TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Telefon raqamingiz',
                                prefixIcon: Icon(Icons.phone_outlined),
                                hintText: '+998 XX XXX XX XX',
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Iltimos, telefon raqamingizni kiriting';
                                }
                                // Basic phone number validation
                                final phoneRegex = RegExp(r'^\+?[0-9]{9,}$');
                                if (!phoneRegex.hasMatch(
                                  value.replaceAll(RegExp(r'\s+'), ''),
                                )) {
                                  return 'Iltimos, to\'g\'ri telefon raqam kiriting';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // Address Field
                            TextFormField(
                              controller: _addressController,
                              decoration: const InputDecoration(
                                labelText: 'Manzilingiz',
                                prefixIcon: Icon(Icons.location_on_outlined),
                                hintText: 'Shahar, tuman, ko\'cha, uy',
                              ),
                              maxLines: 2,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Iltimos, manzilingizni kiriting';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Payment Method Card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To\'lov usuli',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Payment Method Options
                            _buildPaymentMethodOption(
                              value: 'cash',
                              title: 'Naqd pul',
                              subtitle: 'Yetkazib berish vaqtida to\'lov',
                              icon: Icons.money_off_csred_outlined,
                            ),

                            const Divider(height: 24),

                            _buildPaymentMethodOption(
                              value: 'card',
                              title: 'Karta orqali',
                              subtitle: 'Hozirda to\'lov',
                              icon: Icons.credit_card_outlined,
                            ),

                            const Divider(height: 24),

                            _buildPaymentMethodOption(
                              value: 'installment',
                              title: 'Muddatli to\'lov',
                              subtitle: '${_product['months']} oy muddatga',
                              icon: Icons.calendar_today_outlined,
                              isInstallment: true,
                            ),

                            if (_selectedPaymentMethod == 'installment') ...[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.info_outline,
                                          size: 18,
                                          color: AppColors.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Muddatli to\'lov shartlari',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '• 30% oldindan to\'lov\n• ${_product['months']} oy muddatga\n• Oylik to\'lov: ${_formatPrice(_product['installmentPrice'])} so\'m\n• Jami: ${_formatPrice(_product['price'])} so\'m',
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Comments
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Qo\'shimcha izoh',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _commentsController,
                              decoration: const InputDecoration(
                                hintText:
                                    'Buyurtmangizga oid qo\'shimcha ma\'lumotlar...',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(12),
                              ),
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Order Summary
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            OrderSummaryRow(
                              label: 'Mahsulot narxi',
                              value:
                                  '${_formatPrice(_product['price'])} so\'m x $_quantity',
                            ),
                            const SizedBox(height: 8),
                            const OrderSummaryRow(
                              label: 'Yetkazib berish',
                              value: 'Bepul',
                            ),
                            const Divider(height: 32),
                            OrderSummaryRow(
                              label: 'Jami',
                              value:
                                  '${_formatPrice(_product['price'] * _quantity)} so\'m',
                              isTotal: true,
                            ),
                            if (_selectedPaymentMethod == 'installment')
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Oldindan to\'lov: ${_formatPrice(_product['price'] * 0.3 * _quantity)} so\'m',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Terms and Conditions
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                          activeColor: theme.colorScheme.primary,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        const Expanded(
                          child: Text(
                            'Men foydalanuvchi shartlari va maxfiylik siyosati bilan tanishdim va roziman',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitOrder,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.maxFinite, 60),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Buyurtmani tasdiqlash',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption({
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
    bool isInstallment = false,
  }) {
    final isSelected = _selectedPaymentMethod == value;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : AppColors.textSecondary,
                    ),
                  ),
                  if (isInstallment && isSelected)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Oylik to\'lov: ${_formatPrice(_product['installmentPrice'])} so\'m',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                }
              },
              activeColor: Theme.of(context).colorScheme.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      // Show success dialog
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Icon(Icons.check_circle, color: Colors.green, size: 64),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Buyurtmangiz qabul qilindi!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Tez orada siz bilan bog\'lanamiz. Rahmat!',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/', // Assuming '/' is your home route
                  (route) => false, // This removes all previous routes
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Xatolik yuz berdi. Iltimos, qayta urinib ko\'ring.',
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  String _formatPrice(num price) {
    final formatter = NumberFormat('#,##0', 'uz_UZ');
    return formatter.format(price);
  }
}

// Helper widget for order summary row
class OrderSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const OrderSummaryRow({
    Key? key,
    required this.label,
    required this.value,
    this.isTotal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? AppColors.primary : AppColors.textSecondary,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? AppColors.primary : AppColors.textPrimary,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
