import 'package:flutter/material.dart';
import 'entity/equipment.dart';
class ReservationPopup extends StatelessWidget {
  final Equipment equipment;
  final DateTime selectedDateTime;

  const ReservationPopup({
    super.key,
    required this.equipment,
    required this.selectedDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Booking Confirmation',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          ListTile(
            leading: Image.network(equipment.imageUrl,
                width: 60, height: 60, fit: BoxFit.cover),
            title: Text(equipment.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${selectedDateTime.toLocal()}'.split('.')[0]),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Confirm Reservation'),
          ),
        ],
      ),
    );
  }
}
