import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance_app/db_provider/db_provider.dart';
import 'package:flutter_finance_app/theme/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ViewAllBooking extends StatefulWidget {
  final int isappbar;
  const ViewAllBooking({super.key,required this.isappbar});

  @override
  State<ViewAllBooking> createState() => _ViewAllBookingState();
}

class _ViewAllBookingState extends State<ViewAllBooking> {
  TextEditingController teSeach = TextEditingController();
  var allbookings = [];
  var booking = [];
  void filterSeach(String query) async {
    var dummySearchList = allbookings;
    if (query.isNotEmpty) {
      var dummyListData = [];
      dummySearchList.forEach((item) {
        if ((item['name'].toLowerCase().contains(query.toLowerCase()) ||
            item['name'].toUpperCase().contains(query.toUpperCase()))) {
          dummyListData.add(item);
        }
      });
      setState(() {
        booking = [];
        booking.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        booking = [];
        booking = allbookings;
      });
    }
  }
  @override
  void initState() {
    DBProvider.db.getAllBooking().then((book) {
      setState(() {
        allbookings = book;
        booking = allbookings;
      });
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isappbar==1?AppBar(
        backgroundColor: primary,
        title: Text(
          'View All Booking',
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
        actions: [
          IconButton(
            icon: Icon(Icons.delete,color: Colors.red,), // Icon to display
            onPressed: () {
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
                            'Are you sure you want to Delete All Booking?',
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
                                onPressed: () async {
                                  Navigator.of(context).pop(); // Close the dialog
                                  await DBProvider.db.deleteallbooking();
                                  await  DBProvider.db.getAllBooking().then((book) {
                                    setState(() {
                                      allbookings = book;
                                      booking = allbookings;
                                    });
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Delete All Booking Sucessfully",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                },
                                child: Text(
                                  'Delete',
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
            },
          )
        ],
      ):null,
      body: booking.isEmpty?Center(child:   Text(
        'Data Not Found',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),):Column(children: [

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                    // offset: Offset(0,
                    //     3), // changes position of shadow
                  ),
                ]),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filterSeach(value);
                });
              },
              controller: teSeach,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Enter Name Here',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        Expanded(child: ListView.builder(
          itemCount: booking.length,
          itemBuilder: (context, index) {
            final book = booking[index];
            return Card(
              color: book['status']==1?Colors.red[100]:book['status']==2?Colors.green[100]:white,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex:4,
                                child: Text(
                                  'Booking ID# ${book['id']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:6,
                                child: Text(
                                  '${book['name']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(flex:1,child: book['status']==0?IconButton(
                                icon: Icon(Icons.delete,color: Colors.red,), // Icon to display
                                onPressed: () {
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
                                                'Are you sure you want to Delete Booking?',
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
                                                    onPressed: () async {
                                                      Navigator.of(context).pop(); // Close the dialog
                                                     await DBProvider.db.deletebooking(book['id']);
                                                     await  DBProvider.db.getAllBooking().then((book) {
                                                       setState(() {
                                                         allbookings = book;
                                                         booking = allbookings;
                                                       });
                                                     });
                                                      Fluttertoast.showToast(
                                                          msg: "Delete Sucessfully",
                                                          toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM,
                                                          backgroundColor: Colors.black,
                                                          textColor: Colors.white,
                                                          fontSize: 16.0);
                                                    },
                                                    child: Text(
                                                      'Delete',
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
                                },
                              ):Container()
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex:6,
                                child: Text(
                                  'Contact No: ${book['phoneno']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:5,
                                child: Text(
                                  'License Plate: ${book['license']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                flex:7,
                                child: Text(
                                  'Drop Off Details',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(flex:3,child: book['status']==1?GestureDetector(
                                onTap: (){
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
                                                'Are you sure you want to Drop Off?',
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
                                                    onPressed: () async {
                                                      Navigator.of(context).pop(); // Close the dialog
                                                      await DBProvider.db.Updatestatus(book['id'],2);
                                                      await  DBProvider.db.getAllBooking().then((book) {
                                                        setState(() {
                                                          allbookings = book;
                                                          booking = allbookings;
                                                        });
                                                      });
                                                      Fluttertoast.showToast(
                                                          msg: "Drop Off Sucessfully",
                                                          toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM,
                                                          backgroundColor: Colors.black,
                                                          textColor: Colors.white,
                                                          fontSize: 16.0);
                                                    },
                                                    child: Text(
                                                      'Drop Off',
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
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Drop Off",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ):Container(),)
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                flex:3,
                                child: Text(
                                  'FlightNo: ${book['dropflightno']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:3,
                                child: Text(
                                  'Date: ${book['dropdate']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:3,
                                child: Text(
                                  'Time: ${book['droptime']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],

                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                flex:7,
                                child: Text(
                                  'Pick Up Details',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),

                              ),
                              Expanded(flex:3,child: book['status']==0?GestureDetector(
                                onTap: (){
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
                                                'Are you sure you want to Pick Up?',
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
                                                    onPressed: () async {
                                                      Navigator.of(context).pop(); // Close the dialog
                                                      await DBProvider.db.Updatestatus(book['id'],1);
                                                      await  DBProvider.db.getAllBooking().then((book) {
                                                        setState(() {
                                                          allbookings = book;
                                                          booking = allbookings;
                                                        });
                                                      });
                                                      Fluttertoast.showToast(
                                                          msg: "Pick Up Sucessfully",
                                                          toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM,
                                                          backgroundColor: Colors.black,
                                                          textColor: Colors.white,
                                                          fontSize: 16.0);
                                                    },
                                                    child: Text(
                                                      'Pick Up',
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
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Pick Up",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ):Container(),)
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                flex:3,
                                child: Text(
                                  'FlightNo: ${book['pickflightno']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:3,
                                child: Text(
                                  'Date: ${book['pickdate']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:3,
                                child: Text(
                                  'Time: ${book['picktime']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],

                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    // Order Status Indicator

                  ],
                ),
              ),
            );
          },
        ),)
      ],),
    );
  }
}
