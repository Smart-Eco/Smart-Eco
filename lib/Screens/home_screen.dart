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

  // Controllers for the text fields
  TextEditingController currentUsageController = TextEditingController();
  TextEditingController predictedUsageController = TextEditingController();

  // Controller for switching between energy usage and price cards
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Sample values for demonstration
    currentUsageController.text = '50';
    predictedUsageController.text = '60';
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
              false, // Set this property to false to remove the back button
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
                height: 200, // Set a fixed height for the energy usage card
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 2, // Energy Usage and Price
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Energy Usage Card
                      return buildEnergyUsageCard();
                    } else {
                      // Price Card
                      return buildPriceCard();
                    }
                  },
                ),
              ),
              SizedBox(height: 10), // Add SizedBox with height 10
              SizedBox(
                height: 10,
                width: double.infinity,
              ),
              SizedBox(height: 10), // Add SizedBox with height 10
              ElevatedButton(
                onPressed: () {
                  // Handle "Special Appliance Control" button press
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 10),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Reduced border radius
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Special Appliance Control',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10), // Add SizedBox with height 10
              ElevatedButton(
                onPressed: () {
                  // Handle "Register Your Room" button press
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 10),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Reduced border radius
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Register Your Room',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build a card displaying energy usage
  Widget buildEnergyUsageCard() {
    return Card(
      color: Color.fromARGB(151, 13, 202, 47),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        constraints: BoxConstraints(minHeight: 200),
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
                    Divider(
                      color: Colors.white,
                      thickness: 1.0,
                      height: 20,
                      indent: 0,
                      endIndent: 0,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: currentUsageController,
                            decoration: InputDecoration(
                              labelText: 'Current Usage',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: predictedUsageController,
                                  decoration: InputDecoration(
                                    labelText: 'Predicted Usage',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build a card displaying price
  Widget buildPriceCard() {
    return Card(
      color: Color.fromARGB(151, 47, 13, 202),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        constraints: BoxConstraints(minHeight: 200),
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
                      "Price",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.0,
                      height: 20,
                      indent: 0,
                      endIndent: 0,
                    ),
                    SizedBox(height: 10),
                    // Add widgets for Price Card
                  ],
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
