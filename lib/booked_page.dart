import 'package:flutter/material.dart';
import 'entity/trainer.dart';
import 'entity/equipment.dart';
import 'trainerdetail_page.dart';
import 'equipmentdetail_page.dart';

class BookedItemsPage extends StatelessWidget {
  final List<Trainer> bookedTrainers;
  final List<Equipment> bookedEquipment;

  const BookedItemsPage({
    Key? key,
    required this.bookedTrainers,
    required this.bookedEquipment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Target"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Booked Trainers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...bookedTrainers.map((trainer) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(trainer.imageUrl),
                  ),
                  title: Text(trainer.name),
                  subtitle: Text(trainer.specialization),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TrainerDetailPage(trainer: trainer),
                      ),
                    );
                  },
                )),
            const SizedBox(height: 20),
            const Text(
              'Booked Equipment',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...bookedEquipment.map((equipment) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(equipment.imageUrl),
                  ),
                  title: Text(equipment.name),
                  subtitle: Text(equipment.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EquipmentDetailPage(equipment: equipment),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
