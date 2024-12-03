import 'package:flutter/material.dart';
import 'entity/trainer.dart';

class TrainerDetailPage extends StatefulWidget {
  final Trainer trainer;

  const TrainerDetailPage({Key? key, required this.trainer}) : super(key: key);

  @override
  _TrainerDetailPageState createState() => _TrainerDetailPageState();
}

class _TrainerDetailPageState extends State<TrainerDetailPage> {
  double? userRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trainer.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.trainer.imageUrl),
            ),
            const SizedBox(height: 16),
            Text(
              widget.trainer.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.trainer.specialization,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Rate this Trainer',
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
              Text('You rated this trainer: ${userRating!.toStringAsFixed(1)}'),
          ],
        ),
      ),
    );
  }
}
