import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:mana_uz/constants/app_colors.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onTap;
  final bool isHorizontal;
  final double? width;
  final double? height;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.isHorizontal = false,
    this.width,
    this.height,
  });

  const ProductCard.horizontal({
    super.key,
    required this.product,
    this.onTap,
    this.width,
    this.height,
  }) : isHorizontal = true;

  Widget _buildImage(String? imageUrl, {bool isHorizontal = false}) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return _buildPlaceholderIcon();
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildPlaceholderIcon(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: AppColors.surface,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderIcon() {
    return Container(
      color: AppColors.surface,
      child: const Icon(
        Icons.photo,
        size: 40,
        color: AppColors.textTertiary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isHorizontal) {
      return _buildHorizontalCard(context, theme);
    }

    return _buildGridCard(context, theme);
  }

  Widget _buildGridCard(BuildContext context, ThemeData theme) {
    return GestureDetector(
      onTap: onTap,
      child:
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      product['images'][0],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.surface,
                        child: const Icon(
                          Icons.photo,
                          size: 40,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: AppColors.surface,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Product Details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Product Name
                        Text(
                          product['name'],
                          style: theme.textTheme.titleLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Original Price
                            Text(
                              '${_formatPrice(product['price'])} so\'m',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),

                            // Installment Price
                            if (product['installmentPrice'] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: RichText(
                                  text: TextSpan(
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                    children: [
                                      const TextSpan(text: 'dan '),
                                      TextSpan(
                                        text:
                                            '${_formatPrice(product['installmentPrice'])} so\'m/oyiga',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
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
                  ),
                ),
              ],
            ),
          ).animate().scale(
            duration: 200.ms,
            begin: const Offset(0.95, 0.95),
            end: const Offset(1, 1),
          ),
    );
  }

  Widget _buildHorizontalCard(BuildContext context, ThemeData theme) {
    return GestureDetector(
      onTap: onTap,
      child:
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(16),
                  ),
                  child: SizedBox(
                    width: 120,
                    height: double.maxFinite,
                    child: Image.network(
                      product['images'][0],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.surface,
                        child: const Icon(
                          Icons.photo,
                          size: 40,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: AppColors.surface,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Product Details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Product Name and Rating
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'],
                              style: theme.textTheme.titleLarge,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            _buildRating(
                              product['rating'] ?? 0,
                              product['reviews'] ?? 0,
                            ),
                          ],
                        ),

                        // Price and Action Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Price
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Original Price
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '${_formatPrice(product['price'])} so\'m',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.primary,
                                          ),
                                    ),
                                  ),

                                  // Installment Price
                                  if (product['installmentPrice'] != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Text(
                                        '${_formatPrice(product['installmentPrice'])} so\'m/oyiga',
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: AppColors.textSecondary,
                                              fontSize: 12,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Order Button
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 80,
                                maxWidth: 100,
                              ),
                              child: ElevatedButton(
                                onPressed: onTap,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Sotib olish',
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).animate().scale(
            duration: 200.ms,
            begin: const Offset(0.98, 0.98),
            end: const Offset(1, 1),
          ),
    );
  }

  Widget _buildRating(double rating, int reviews) {
    return Row(
      children: [
        // Star rating
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
              const SizedBox(width: 2),
              Text(
                rating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),

        // Review count
        const SizedBox(width: 4),
        Text(
          '($reviews)',
          style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
        ),
      ],
    );
  }

  String _formatPrice(num price) {
    final formatter = NumberFormat('#,##0', 'uz_UZ');
    return formatter.format(price);
  }
}
