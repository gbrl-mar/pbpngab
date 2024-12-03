import 'package:flutter/material.dart';
import 'detailView.dart'; // Import DetailView

class ViewList extends StatefulWidget {
  const ViewList({Key? key}) : super(key: key);

  @override
  _ViewListState createState() => _ViewListState();
}

class _ViewListState extends State<ViewList> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> gymList = [
    {
      'imageUrl': 'https://images.unsplash.com/photo-1526852331915-de50745e46a5?w=500&h=500',
      'gymName': 'Celebrity Fitness',
      'openingHours': '6:00 AM',
      'closingHours': '10:00 PM',
      'description': 'A great gym for fitness enthusiasts!',
      'latitude': -7.7828341826057805,
      'longitude': 110.39042900126411,
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1517130038641-a774d04afb3c?w=500&h=500',
      'gymName': 'Empire Gym',
      'openingHours': '7:00 AM',
      'closingHours': '9:00 PM',
      'description': 'Best gym for muscle building.',
      'latitude': -7.7473103742155285,
      'longitude': 110.41972806838386,
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1606002828062-acb5eee58ea5?w=500&h=500',
      'gymName': 'Power Gym 3',
      'openingHours': '5:00 AM',
      'closingHours': '11:00 PM',
      'description': 'A gym for all levels.',
      'latitude': 51.5074,
      'longitude': -0.1278,
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1506377295352-e3154d43ea9e?w=500&h=500',
      'gymName': 'Health Gym 4',
      'openingHours': '8:00 AM',
      'closingHours': '8:00 PM',
      'description': 'The best gym for cardio and weights.',
      'latitude': 48.8566,
      'longitude': 2.3522,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gym Locations'),
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              icon: Icon(Icons.tune_rounded),
              onPressed: () {
                // Handle filter button press
                print('Filter button pressed');
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildSearchBar(),
                Expanded(
                  child: ListView.builder(
                    itemCount: gymList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GymCard(
                            imageUrl: gymList[index]['imageUrl'],
                            gymName: gymList[index]['gymName'],
                            openingHours: gymList[index]['openingHours'],
                            closingHours: gymList[index]['closingHours'],
                            description: gymList[index]['description'],
                            latitude: gymList[index]['latitude'],
                            longitude: gymList[index]['longitude'],
                          ),
                          SizedBox(height: 16), // Add spacing between the cards
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search gyms...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GymCard extends StatelessWidget {
  final String imageUrl;
  final String gymName;
  final String openingHours;
  final String closingHours;
  final String description;
  final double latitude;
  final double longitude;

  const GymCard({
    Key? key,
    required this.imageUrl,
    required this.gymName,
    required this.openingHours,
    required this.closingHours,
    required this.description,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailView(
              imageUrl: imageUrl,
              gymName: gymName,
              openingHours: openingHours,
              closingHours: closingHours,
              description: description,
              latitude: latitude,
              longitude: longitude,
            ),
          ),
        );
      },
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    gymName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
