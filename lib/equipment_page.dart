import 'package:flutter/material.dart';
import 'entity/equipment.dart';
import 'bookingEquipment.dart';
class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Equipment> equipmentList = [
      Equipment(
        imageUrl:
            'https://storage.googleapis.com/a1aa/image/0zBdxkSAehXzIStzkU6IXMPSpof0jVWD8vG9hfS37LsziuhnA.jpg',
        name: 'Treadmill',
        description: 'High-quality treadmill for cardio workouts.',
      ),
      Equipment(
        imageUrl:
            'https://storage.googleapis.com/a1aa/image/4UJM3r7bKLo1Ohe87mbx88EQzcUIHPDfgzLM7cefANiiFdDPB.jpg',
        name: 'Dumbbells',
        description: 'Various weights available for strength training.',
      ),
      Equipment(
        imageUrl:
            'https://storage.googleapis.com/a1aa/image/sn2YLiC36ALaBtLCsRpneceMMXZ1cN5PSekff1eGrKDwW0N8E.jpg',
        name: 'Stationary Bike',
        description: 'Perfect for indoor cycling and cardio.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Equipment'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: equipmentList.length,
        itemBuilder: (context, index) {
          final equipment = equipmentList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: equipmentCard(
              equipment: equipment,
              onBookNow: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingPage(equipment: equipment),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget equipmentCard(
      {required Equipment equipment, required VoidCallback onBookNow}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              equipment.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  equipment.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(equipment.description,
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onBookNow,
                  child: const Text('Book Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
