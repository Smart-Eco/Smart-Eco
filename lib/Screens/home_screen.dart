import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarteco2/Devices/bulb.dart';
import 'package:smarteco2/Screens/device_details.dart';
import 'package:smarteco2/Devices/fan.dart';
import 'package:smarteco2/Devices/plug.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smarteco2/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController currentUsageController = TextEditingController();
  TextEditingController predictedUsageController = TextEditingController();
  final TextEditingController _priceLimitController = TextEditingController();
  double priceLimit = 100; // Default value for Price Limit

  final PageController _pageController = PageController();

  List<String> notifications = [];
  AuthService auth = AuthService();
  String? userName; // Variable to store user's name

  DatabaseReference db = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _fetchAndSetCurrentUsage();
    predictedUsageController.text =
        '60'; // Placeholder value for predicted usage
    // Fetch and set user's name when HomeScreen initializes
    fetchUserName();
  }

  // Function to fetch user's name from Firestore
  void fetchUserName() async {
    // Get current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Query Firestore for user's document
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        // Set userName to user's name from Firestore
        setState(() {
          userName = snapshot['name'];
        });
      }
    }
  }

  // Function to fetch current usage data and update the text controller
  void _fetchAndSetCurrentUsage() {
    db.child('MiniIot/Devices/Device1/energy').onValue.listen((event) {
      if (event.snapshot.value != null &&
          event.snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> energyData =
            event.snapshot.value as Map<dynamic, dynamic>;
        int sum = 0;
        energyData.forEach((key, value) {
          // Check if the value is actually a number (int or double)
          if (value is num) {
            sum += value.toInt(); // Convert value to int if it's a double
          }
        });
        setState(() {
          currentUsageController.text = sum.toString();
          // Store the sum value in the realtime database
          db.child('MiniIot/Devices/Device1/Tenergy').set(sum.toString());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: StreamBuilder(
        stream: db.child('MiniIot/Devices/Device1/Tenergy').onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data.snapshot.value == null) {
            return Center(child: Text('No data available for current usage'));
          } else {
            int currentUsage = int.parse(snapshot.data.snapshot.value);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Hello',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            // Display user's name if available, otherwise display 'Username'
                            userName ?? 'Username',
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return buildEnergyUsageCard(currentUsage);
                          } else {
                            return buildPriceCard();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 10),
                        foregroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'DEVICE : FAN',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BulbScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            elevation: 5,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'DEVICE : BULB',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlugScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            elevation: 5,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'DEVICE : PLUG',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: 40,
          height: 40,
          child: FloatingActionButton(
            onPressed: _fetchAndSetCurrentUsage,
            child: Icon(Icons.refresh, size: 20),
            backgroundColor: const Color.fromARGB(
                255, 255, 255, 255), // Adjust color as needed
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Widget buildEnergyUsageCard(int currentUsage) {
    return Card(
      color: const Color.fromRGBO(52, 224, 161, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        constraints: const BoxConstraints(minHeight: 200),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const Text(
                  "Energy Usage",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 1.0,
                height: 20,
                indent: 0,
                endIndent: 0,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the content horizontally
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "POWER",
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content horizontally
                          children: [
                            Text(
                              "${currentUsage.toString()}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            const SizedBox(
                                width: 5), // Add spacing between value and unit
                            Text(
                              "Wh", // Unit for power
                              style: const TextStyle(
                                fontSize: 20, // Adjust font size for unit
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 2.0,
                          width: double.infinity,
                          child: ColoredBox(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPriceCard() {
    return StreamBuilder(
      stream: db.child('MiniIot/Devices/Device1/Tenergy').onValue,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data.snapshot.value == null) {
          return Text('No data available for energy usage');
        } else {
          int tenergy = int.parse(snapshot.data.snapshot.value.toString());
          double totalPrice = (tenergy / 3600) * 6.5;
          String totalPriceString = totalPrice.toStringAsFixed(4);

          bool showNotification = totalPrice > priceLimit * 0.7;
          String notificationMessage =
              "The consumption has reached more than 70% of the price limit set.";

          if (showNotification) {
            if (!notifications.contains(notificationMessage)) {
              notifications.add(notificationMessage);
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(notificationMessage),
                ),
              );
            });
          }
          return Card(
            color: const Color.fromRGBO(112, 52, 224, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              constraints: const BoxConstraints(minHeight: 200),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          color: Colors.white,
                          onPressed: () {
                            _showEditPriceLimitPopup(context);
                          },
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                      height: 20,
                      indent: 0,
                      endIndent: 0,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Price",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Text(
                          "${totalPriceString}", // Display the multiplied value
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Price Limit",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Text(
                          "$priceLimit", // Display the Price Limit value
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _showEditPriceLimitPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Price Limit'),
          content: TextField(
            controller: _priceLimitController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Price Limit'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Update the Price Limit in the main screen
                setState(() {
                  // Update the Price Limit value in the main screen state
                  priceLimit = double.parse(_priceLimitController.text);
                });

                // Store the updated Price Limit value in the Firebase Realtime Database
                db
                    .child('MiniIot/Devices/Device1/PriceLimit')
                    .set(double.parse(_priceLimitController.text).toString());

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
