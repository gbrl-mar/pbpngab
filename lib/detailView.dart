import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class DetailView extends StatefulWidget {
  final String imageUrl;
  final String gymName;
  final String openingHours;
  final String closingHours;
  final String description;
  final double latitude;
  final double longitude;

  const DetailView({
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
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  double? _currentLatitude;
  double? _currentLongitude;
  String _distance = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Meminta izin lokasi dan mendapatkan lokasi saat ini
  }

  Future<void> _getCurrentLocation() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation,);
      setState(() {
        _currentLatitude = position.latitude;
        _currentLongitude = position.longitude;
        _calculateDistance(); // Menghitung jarak setelah mendapatkan lokasi
      });
    } else {
      // Jika izin ditolak, tampilkan pesan
      setState(() {
        _distance = 'Location permission is denied.';
      });
    }
  }

  void _calculateDistance() {
  if (_currentLatitude != null && _currentLongitude != null) {
    // Improve accuracy by using bestForNavigation
    double distanceInMeters = Geolocator.distanceBetween(
      _currentLatitude!,
      _currentLongitude!,
      widget.latitude,
      widget.longitude,
    );
    setState(() {
      _distance = '${(distanceInMeters / 1000).toStringAsFixed(2)} km'; // Display distance in kilometers
    });
  }
}

  void _openGoogleMaps() async {
  final Uri url = Uri.parse('https://www.google.com/maps/search/?q=${widget.latitude},${widget.longitude}');

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not open the map')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gymName),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gym Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.imageUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),

              // Gym Name
              Text(
                widget.gymName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),

              // Opening and Closing hours
              Text(
                'Open: ${widget.openingHours} - Close: ${widget.closingHours}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),

              // Gym Description
              Text(
                widget.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              // Display Distance
              Text(
                _distance.isEmpty ? 'Getting your location...' : 'Distance: $_distance',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              // Open Google Maps Button
              ElevatedButton(
                onPressed: _openGoogleMaps,
                child: Text('Open in Google Maps'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
