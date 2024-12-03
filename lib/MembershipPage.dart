import 'package:flutter/material.dart';
import 'entity/membership.dart'; // Import the new Membership class
import 'MembershipDetailsPage.dart'; // Import MembershipDetailsPage

class MembershipPage extends StatelessWidget {
  final List<Membership> memberships = [
    Membership(
      packageName: "Basic Plan",
      price: "IDR 150,000/month",
      description: "Access to basic facilities and classes.",
      imageUrl: "https://cdn.franchiseglobal.com/assets/images/posts/2024/10/24/gaya-hidup-sehat-lebih-menyenangkan-dengan-ftl-gym-agq.jpg",
    ),
    Membership(
      packageName: "Premium Plan",
      price: "IDR 300,000/month",
      description: "Access to premium classes, and more.",
      imageUrl: "https://cdn.franchiseglobal.com/assets/images/posts/2024/10/24/gaya-hidup-sehat-lebih-menyenangkan-dengan-ftl-gym-agq.jpg",
    ),
    Membership(
      packageName: "VIP Plan",
      price: "IDR 500,000/month",
      description: "All access including VIP classes and events.",
      imageUrl: "https://cdn.franchiseglobal.com/assets/images/posts/2024/10/24/gaya-hidup-sehat-lebih-menyenangkan-dengan-ftl-gym-agq.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Membership',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Select Your Membership",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            // Generate Membership Cards dynamically
            ...memberships.map((membership) {
              return Column(
                children: [
                  MembershipCard(
                    membership: membership, // Pass the entire Membership object
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MembershipDetailsPage(
                            membership: membership, // Pass Membership object
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class MembershipCard extends StatelessWidget {
  final Membership membership;
  final VoidCallback onPressed;

  MembershipCard({required this.membership, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  membership.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              membership.packageName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              membership.price,
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            Text(
              membership.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              ),
              child: Text(
                "Select Plan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
