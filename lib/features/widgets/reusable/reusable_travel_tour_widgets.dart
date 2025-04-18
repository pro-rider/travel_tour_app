import 'package:flutter/material.dart';

class TourPackageCard extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? location;
  final double? rating;
  final double? price;
  final VoidCallback? onTap;

  // Optional
  final int? durationDays;
  final bool isFavorite;
  final String? tag;
  final List<String>? features;
  final String? description;
  final String? discountLabel;
  final bool showRating;
  final double? imageHeight;
  final BoxFit? imageFit;

  const TourPackageCard({
    super.key,
    this.imageUrl,
    this.title,
    this.location,
    this.rating,
    this.price,
    this.onTap,
    this.durationDays,
    this.isFavorite = false,
    this.tag,
    this.features,
    this.description,
    this.discountLabel,
    this.showRating = true,
    this.imageHeight,
    this.imageFit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE with TAG & FAVORITE
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          height: imageHeight ?? 180,
                          fit: imageFit ?? BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Center(child: Icon(Icons.broken_image, size: 50)),
                          loadingBuilder: (context, child, loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : const Center(child: CircularProgressIndicator()),
                        )
                      : Container(
                          color: Colors.grey[300],
                          height: imageHeight ?? 180,
                          child: const Center(child: Icon(Icons.image, size: 60, color: Colors.grey)),
                        ),
                ),
                if (tag != null)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(tag!, style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
                if (isFavorite)
                  const Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(Icons.favorite, color: Colors.red),
                  ),
              ],
            ),

            // CONTENT
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? 'Untitled Package',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location ?? 'Unknown location',
                          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (durationDays != null)
                        Text(
                          '${durationDays!} days',
                          style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                        ),
                    ],
                  ),
                  if (description != null && description!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      description!,
                      style: theme.textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),

                  // RATING & PRICE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (showRating && rating != null)
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              rating!.toStringAsFixed(1),
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          if (discountLabel != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                discountLabel!,
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          Text(
                            price != null ? '\$${price!.toStringAsFixed(2)}' : 'Free',
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Features
                  if (features != null && features!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: -4,
                      children: features!
                          .map((feature) => Chip(
                                label: Text(feature, style: const TextStyle(fontSize: 12)),
                                backgroundColor: Colors.grey.shade200,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                              ))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
