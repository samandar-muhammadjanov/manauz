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

  Widget _buildImage(String? imageUrl) {
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
    return isHorizontal
        ? _buildHorizontalCard(context, theme)
        : _buildGridCard(context, theme);
  }

  Widget _buildGridCard(BuildContext context, ThemeData theme) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                child: _buildImage(
                  product['images'] is List && product['images'].isNotEmpty
                      ? product['images'][0]
                      : null,
                ),
              ),
            ),
            // Rest of the card content...
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['name'] ?? 'No Name',
                      style: theme.textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Add price and other details here
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
      child: Container(
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
                child: _buildImage(
                  product['images'] is List && product['images'].isNotEmpty
                      ? product['images'][0]
                      : null,
                ),
              ),
            ),
            // Rest of the card content...
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['name'] ?? 'No Name',
                      style: theme.textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Add price and other details here
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
}
