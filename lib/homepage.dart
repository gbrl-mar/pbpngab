import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'booked_page.dart';
import 'entity/trainer.dart';
import 'entity/equipment.dart';
import 'trainer_page.dart';
import 'equipment_page.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List<Trainer> bookedTrainers = [
      Trainer(
        name: 'John Doe',
        specialization: 'Weight Training',
        rating: 5,
        imageUrl:
            'https://storage.googleapis.com/a1aa/image/e4J888wwp82JPyxFP2kwGXAwFkTRV5wVsIUUpML28S3rob4JA.jpg',
      ),
    ];

    final List<Equipment> bookedEquipment = [
      Equipment(
        name: 'Treadmill',
        description: 'For cardio workouts.',
        imageUrl:
            'https://storage.googleapis.com/a1aa/image/0zBdxkSAehXzIStzkU6IXMPSpof0jVWD8vG9hfS37LsziuhnA.jpg',
      ),
    ];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              const Text(
                'Stefanie',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildBMICard(),
              const SizedBox(height: 20),
              _buildTargetSection(context),
              const SizedBox(height: 30),
              const Text(
                'Our Services',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildServiceList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBMICard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1286B2), Color(0xFFC1ECFC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BMI (Body Mass Index)',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 4),
                const Text(
                  'You have a healthy weight',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('View more',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          CircularPercentIndicator(
            radius: 40.0,
            lineWidth: 8.0,
            percent: 0.7,
            center: const Text(
              "20.1",
              style: TextStyle(
                color: Color(0xFFF66733),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            progressColor: Color(0xFFF66733),
            backgroundColor: Colors.white24,
          ),
        ],
      ),
    );
  }

  Widget _buildTargetSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Today's target",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookedItemsPage(
                    bookedTrainers: bookedTrainers,
                    bookedEquipment: bookedEquipment,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Check', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceList(BuildContext context) {
    return Column(
      children: [
        _buildServiceItem(
          context,
          icon: Icons.person,
          title: 'Personal Trainer',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrainerPage()),
            );
          },
        ),
        _buildServiceItem(
          context,
          icon: Icons.fitness_center,
          title: 'Classes',
          onTap: () {
            // Navigate to classes page
          },
        ),
        _buildServiceItem(
          context,
          icon: Icons.fitness_center,
          title: 'Gym Equipment',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EquipmentPage()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildServiceItem(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, color: Colors.purple, size: 24),
      ),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.purple),
      onTap: onTap,
    );
  }
}
