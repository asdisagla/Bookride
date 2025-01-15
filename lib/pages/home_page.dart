import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance_app/pages/booking.dart';
import 'package:flutter_finance_app/pages/viewAll_booking.dart';
import 'package:flutter_finance_app/theme/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book A Ride',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: white),
        ),
        centerTitle: true,
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the column items
          children: [
            // First Smaller Card with Icon - "Book a Ride"
            Center( // Center the card horizontally
              child: SizedBox(
                width: 300, // Set a specific width for the card
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Booking(),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 8,  // Shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),  // Rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 120, // Smaller height for the card
                        color: primary,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions_car,  // Icon for "Book a Ride"
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(width: 10), // Space between icon and text
                              Text(
                                'Book a Ride',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Space between cards
            // Second Smaller Card with Icon - "Booking Name with Image"
            Center( // Center the card horizontally
              child: SizedBox(
                width: 300, // Set a specific width for the card
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAllBooking(isappbar: 1,),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 8,  // Shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),  // Rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 120, // Smaller height for the card
                        color: primary,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_month,  // Icon for "Book a Ride"
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(width: 10), // Space between icon and text
                              Text(
                                'View Bookings',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
