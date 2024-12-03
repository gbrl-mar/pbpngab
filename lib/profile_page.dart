import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MembershipPage.dart';
import 'entity/user.dart';
import 'EditProfilePage.dart';
import 'auth_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = User(
      username: "Mamang Kesbor",
      email: "kopsekop@gmail.com",
      birthdate: DateTime(1990, 1, 1),
      gender: "Male",
      password: "password123",
      weight: 70.0,
      height: 170.0,
    );
  }

  void _updateUser(User updatedUser) {
    setState(() {
      currentUser = updatedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI(currentUser.weight, currentUser.height);

    // Persentase BMI (dianggap rentang normal adalah 18.5 - 24.9)
    double bmiPercent = (bmi / 40).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isAuthenticated', false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInSignUpPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, color: Colors.grey[600], size: 50),
              ),
              SizedBox(height: 10),
              Text(
                currentUser.username,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                currentUser.email,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final updatedUser = await Navigator.push<User>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(user: currentUser),
                    ),
                  );

                  if (updatedUser != null) {
                    _updateUser(updatedUser);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child:
                    Text("Edit Profile", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${currentUser.weight?.toStringAsFixed(1) ?? "-"} kg",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Weight",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${currentUser.height?.toStringAsFixed(1) ?? "-"} cm",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Height",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircularPercentIndicator(
                            radius: 30.0,
                            lineWidth: 10.0,
                            percent: bmiPercent,
                            center: Text(
                              bmi.toStringAsFixed(1),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            progressColor: Color(0xFFF66733),
                            backgroundColor: Color(0xFFC1ECFC),
                            circularStrokeCap: CircularStrokeCap.round,
                            footer: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "BMI",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Membership",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "No active membership yet",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MembershipPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Activate Membership",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, Color textColor) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(color: textColor, fontSize: 12),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

double calculateBMI(double? weight, double? height) {
  if (weight == null || height == null || height == 0) {
    return 0.0;
  }
  double heightInMeters = height / 100; // Konversi cm ke meter
  return weight / (heightInMeters * heightInMeters);
}
