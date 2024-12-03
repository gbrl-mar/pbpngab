import 'package:flutter/material.dart';
import 'ReceiptPage.dart'; // Import the ReceiptPage

class PaymentPopup extends StatelessWidget {
  final String packageName;
  final String price;

  PaymentPopup({required this.packageName, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Confirmation',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            'Package: $packageName',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Price: $price',
            style: TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
          SizedBox(height: 20),
          Text(
            'Select Payment Method:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            items: [
              DropdownMenuItem(
                value: 'Credit Card',
                child: Text('Credit Card'),
              ),
              DropdownMenuItem(
                value: 'Bank Transfer',
                child: Text('Bank Transfer'),
              ),
              DropdownMenuItem(
                value: 'PayPal',
                child: Text('PayPal'),
              ),
            ],
            onChanged: (value) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Pass current date while navigating to ReceiptPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReceiptPage(
                        packageName: packageName,
                        price: price,
                        date: DateTime.now().toString(), // Generate current date
                      ),
                    ),
                  );
                },
                child: Text('Pay Now'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
