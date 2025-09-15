import 'package:flutter/material.dart';

class CustomRatingBar extends StatelessWidget {
  final double rating;
  final double itemSize;
  final bool ignoreGestures;
  final bool allowHalfRating;
  final ValueChanged<double>? onRatingUpdate;
  final Color? color;
  final Color? borderColor;
  final double spacing;

  const CustomRatingBar({
    super.key,
    this.rating = 0.0,
    this.itemSize = 20.0,
    this.ignoreGestures = false,
    this.allowHalfRating = false,
    this.onRatingUpdate,
    this.color,
    this.borderColor,
    this.spacing = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = color ?? theme.colorScheme.primary;
    final inactiveColor = theme.disabledColor;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        double ratingValue = (index + 1) * 1.0;
        bool isHalfStar = false;
        
        if (allowHalfRating) {
          isHalfStar = rating > index.toDouble() && rating < ratingValue;
        }
        
        return GestureDetector(
          onTap: () {
            if (!ignoreGestures && onRatingUpdate != null) {
              onRatingUpdate!(ratingValue);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(right: index < 4 ? spacing : 0),
            child: allowHalfRating && isHalfStar
                ? _buildHalfStar(activeColor, inactiveColor)
                : _buildStar(
                    rating >= ratingValue ? activeColor : inactiveColor,
                    borderColor,
                  ),
          ),
        );
      }),
    );
  }

  Widget _buildStar(Color? color, Color? borderColor) {
    return Icon(
      Icons.star_rounded,
      size: itemSize,
      color: color,
      shadows: [
        if (borderColor != null)
          Shadow(
            color: borderColor,
            blurRadius: 1.0,
            offset: const Offset(0, 0.5),
          ),
      ],
    );
  }

  Widget _buildHalfStar(Color activeColor, Color inactiveColor) {
    return SizedBox(
      width: itemSize,
      height: itemSize,
      child: Stack(
        children: [
          _buildStar(inactiveColor, null),
          ClipRect(
            clipper: _HalfClipper(),
            child: _buildStar(activeColor, null),
          ),
        ],
      ),
    );
  }
}

class _HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width / 2, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
