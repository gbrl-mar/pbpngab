import 'package:flutter/material.dart';
import 'entity/trainer.dart';
import 'bookingTrainer_page.dart';
class TrainerPage extends StatelessWidget {
  const TrainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Trainers'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          trainerCard(
            context,
            trainer: Trainer(
              imageUrl:
                  'https://storage.googleapis.com/a1aa/image/e4J888wwp82JPyxFP2kwGXAwFkTRV5wVsIUUpML28S3rob4JA.jpg',
              name: 'John Doe',
              rating: 5,
              specialization:
                  'Specializes in weight training and bodybuilding.',
            ),
          ),
          const SizedBox(height: 16),
          trainerCard(
            context,
            trainer: Trainer(
              imageUrl:
                  'https://storage.googleapis.com/a1aa/image/szqZGnmX3PrCD5COccntOuaDeLvSzDFSE5xelCoEm8hdR3wTA.jpg',
              name: 'Jane Smith',
              rating: 4.8,
              specialization: 'Expert in yoga and pilates.',
            ),
          ),
          const SizedBox(height: 16),
          trainerCard(
            context,
            trainer: Trainer(
              imageUrl:
                  'https://storage.googleapis.com/a1aa/image/C5fdsJljKd3kMSNvbzwPDZ9cPRigW00MG8qDS8aOOv2pob4JA.jpg',
              name: 'Mike Johnson',
              rating: 4.0,
              specialization: 'Focuses on cardio and endurance training.',
            ),
          ),
        ],
      ),
    );
  }

  Widget trainerCard(BuildContext context, {required Trainer trainer}) {
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
            child: Image.network(trainer.imageUrl,
                height: 200, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trainer.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < trainer.rating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      trainer.rating.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(trainer.specialization,
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingPage(trainer: trainer),
                      ),
                    );
                  },
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
