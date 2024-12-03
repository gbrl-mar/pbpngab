import 'package:flutter/material.dart';
import 'entity/equipment.dart';

class EquipmentDetailPage extends StatefulWidget {
  final Equipment equipment;

  const EquipmentDetailPage({Key? key, required this.equipment})
      : super(key: key);

  @override
  _EquipmentDetailPageState createState() => _EquipmentDetailPageState();
}

class _EquipmentDetailPageState extends State<EquipmentDetailPage> {
  double? userRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.equipment.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.equipment.imageUrl),
            ),
            const SizedBox(height: 16),
            Text(
              widget.equipment.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.equipment.description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Rate this Equipment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < (userRating ?? 0) ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      userRating = index + 1.0;
                    });
                  },
                );
              }),
            ),
            if (userRating != null)
              Text(
                  'You rated this equipment: ${userRating!.toStringAsFixed(1)}'),
          ],
        ),
      ),
    );
  }
}
