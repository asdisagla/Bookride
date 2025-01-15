import 'package:flutter/material.dart';
import 'package:flutter_finance_app/db_provider/db_provider.dart';
import 'package:flutter_finance_app/theme/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Booking extends StatefulWidget {

  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  TextEditingController name = TextEditingController();
  TextEditingController contactno = TextEditingController();
  TextEditingController lincplate = TextEditingController();
  TextEditingController flightController = TextEditingController();
  TextEditingController pickflightController = TextEditingController();
  String? selectedDate;
  String? selectedTime;
  String? pickselectedDate;
  String? pickselectedTime;

  // Function to show date picker and update selectedDate
  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2101);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != initialDate) {
      setState(() {
        selectedDate = "${picked.toLocal()}".split(' ')[0]; // Format date to string
      });
    }
  }

  // Function to show time picker and update selectedTime
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked.format(context); // Format time to string
      });
    }
  }
  // Function to show date picker and update selectedDate
  Future<void> _selectDatepick(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2101);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != initialDate) {
      setState(() {
        pickselectedDate = "${picked.toLocal()}".split(' ')[0]; // Format date to string
      });
    }
  }

  // Function to show time picker and update selectedTime
  Future<void> _selectTimepick(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        pickselectedTime = picked.format(context); // Format time to string
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          backgroundColor: primary,
          title: Text(
            'Book a Ride',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: white),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 37,
              width: 37,
              padding: EdgeInsets.only(right: 3),
              child: Center(
                child: Image.asset(
                  "assets/icons/back_arrow.png",
                  height: 20,
                  width: 20,
                  color: white,
                ),
              ),
            ),
          ),

        ),
      body: Container(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,  // Center items
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            width: 150,
                            child: Image.asset(
                              'assets/logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Name TextField
                        TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                            labelText: 'Enter Name',
                            labelStyle: TextStyle(color: Colors.black),  // Set label color to black
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Contact Number TextField
                        TextFormField(
                          controller: contactno,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Contact No',
                            labelStyle: TextStyle(color: Colors.black),  // Set label color to black
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // License Plate TextField
                        TextFormField(
                          controller: lincplate,
                          decoration: InputDecoration(
                            labelText: 'License Plate',
                            labelStyle: TextStyle(color: Colors.black),  // Set label color to black
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Drop Off",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,  // Set title color to black
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: flightController,
                          decoration: InputDecoration(
                            labelText: 'Enter Drop Off Flight No',
                            labelStyle: TextStyle(color: Colors.black),  // Set label color to black
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Date Picker
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  selectedDate ?? 'Select Date',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                _selectTime(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  selectedTime ?? 'Select Time',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),


                        // Time Picker


                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Pick Up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,  // Set title color to black
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: pickflightController,
                          decoration: InputDecoration(
                            labelText: 'Enter Pick Up Flight No',
                            labelStyle: TextStyle(color: Colors.black),  // Set label color to black
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Date Picker
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _selectDatepick(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  pickselectedDate ?? 'Select Date',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                _selectTimepick(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  pickselectedTime ?? 'Select Time',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Sign Up Button
                        GestureDetector(
                          onTap: () {
                         if(name.text.isEmpty||contactno.text.isEmpty||lincplate.text.isEmpty||flightController.text.isEmpty||selectedDate!.isEmpty||selectedTime!.isEmpty||pickflightController.text.isEmpty||pickselectedDate!.isEmpty||pickselectedTime!.isEmpty){
                           Fluttertoast.showToast(
                               msg: "Kindly Fill All Information",
                               toastLength: Toast.LENGTH_LONG,
                               gravity: ToastGravity.BOTTOM,
                               backgroundColor: Colors.black,
                               textColor: Colors.white,
                               fontSize: 16.0);
                         }
                         else{
                           showDialog(
                             context: context,
                             barrierDismissible: false, // Prevent dismissing by tapping outside
                             builder: (BuildContext context) {
                               return AlertDialog(
                                 // Setting content padding to 0 for full control
                                 contentPadding: EdgeInsets.all(0),
                                 // Customizing the background of the dialog using a container
                                 backgroundColor: Colors.transparent,  // Set background to transparent to show gradient
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Optional: Rounded corners
                                 content: Container(
                                   decoration: BoxDecoration(
                                     gradient: LinearGradient(
                                       begin: Alignment.topLeft,
                                       end: Alignment.bottomRight,
                                       colors: [
                                         black,
                                         primary,
                                       ],
                                     ),
                                     borderRadius: BorderRadius.circular(15), // Rounded corners for the dialog content
                                   ),
                                   padding: EdgeInsets.all(20),
                                   child: Column(
                                     mainAxisSize: MainAxisSize.min,  // Adjust size to the content
                                     children: [
                                       Text(
                                         'Are you sure you want to Save Booking?',
                                         style: TextStyle(
                                           color: white,
                                           fontSize: 18,
                                           fontWeight: FontWeight.bold,
                                         ),
                                         textAlign: TextAlign.center,
                                       ),
                                       const SizedBox(height: 20),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: <Widget>[
                                           TextButton(
                                             onPressed: () {
                                               Navigator.of(context).pop(); // Close the dialog
                                             },
                                             child: Text(
                                               'Cancel',
                                               style: TextStyle(color: white),
                                             ),
                                           ),
                                           SizedBox(width: 20),
                                           TextButton(
                                             onPressed: () {
                                               Navigator.of(context).pop(); // Close the dialog
                                               DBProvider.db.insertbooking(name.text.toString(), contactno.text.toString(), lincplate.text.toString(), flightController.text.toString(), selectedDate!, selectedTime!,pickflightController.text.toString(), pickselectedDate!, pickselectedTime!,0);
                                               Fluttertoast.showToast(
                                                   msg: "Data Save Sucessfully",
                                                   toastLength: Toast.LENGTH_LONG,
                                                   gravity: ToastGravity.BOTTOM,
                                                   backgroundColor: Colors.black,
                                                   textColor: Colors.white,
                                                   fontSize: 16.0);
                                               Navigator.of(context).pop();
                                             },
                                             child: Text(
                                               'Submit',
                                               style: TextStyle(color:white),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ],
                                   ),
                                 ),
                               );
                             },
                           );

                         }
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                                color: primary, borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
