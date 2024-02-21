import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String temperatureValue = ''; // Variable to hold the temperature value
  String ammoniaValue = ''; // Variable to hold the ammonia value
  String turbidityValue = ''; // Variable to hold the turbidity value
  String pHValue = ''; // Variable to hold the pH value

  @override
  void initState() {
    super.initState();
    // You can add any initialization code here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 255, 255, 255), // Set background color to white
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(1.0), // Set height to 1cm
        child: AppBar(
          flexibleSpace: FlexibleSpaceBar(),
          automaticallyImplyLeading:
              false, // Set this property to false to remove back button
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black, // Change text color to black
                ),
              ),
              SizedBox(height: 8),
              Text(
                'UserName',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Change text color to black
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                child: Card(
                  color: Color.fromARGB(151, 13, 202, 47),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 150),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Energy Usage",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Good",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 177, 177, 177),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Realtime Data',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Change text color to black
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: buildSensorCard(
                      "Temperature",
                      temperatureValue,
                      Icons.thermostat,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: buildSensorCard(
                      "Ammonia",
                      ammoniaValue,
                      Icons.opacity,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: buildSensorCard(
                      "Turbidity",
                      turbidityValue,
                      Icons.visibility,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: buildSensorCard(
                      "pH",
                      pHValue,
                      Icons.whatshot,
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

  Widget buildSensorCard(
      String sensorName, String sensorValue, IconData iconData) {
    return Card(
      color: Color.fromARGB(70, 66, 66, 66),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        constraints: BoxConstraints(minHeight: 150),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  iconData,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sensorName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    sensorValue,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 177, 177, 177),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '℃', // Degree Celsius symbol
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 177, 177, 177),
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
}
