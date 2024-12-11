import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ImageCard extends StatelessWidget {
  final String imageUrl;
  final int id;
  final String date;
  final String type;

  const ImageCard({
    super.key, 
    required this.id,
    required this.imageUrl,
    required this.date,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(date);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: SizedBox(
        height: 220,
        width: 280,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/not_found.jpg',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.fullscreen, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${DateFormat('yyyy-MM-dd').format(dateTime)}\n${DateFormat('hh:mm a').format(dateTime)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(type, style: textTheme.labelSmall,),
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
