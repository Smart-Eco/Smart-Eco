import 'package:flutter/material.dart';
import 'register_room.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String temperatureValue = '';
  String ammoniaValue = '';
  String turbidityValue = '';
  String pHValue = '';

  TextEditingController currentUsageController = TextEditingController();
  TextEditingController predictedUsageController = TextEditingController();

  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    currentUsageController.text = '50';
    predictedUsageController.text = '60';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: AppBar(
          flexibleSpace: FlexibleSpaceBar(),
          automaticallyImplyLeading: false,
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
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'UserName',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 25),
              Container(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return buildEnergyUsageCard();
                    } else {
                      return buildPriceCard();
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  navigateToRegisterRoomScreen();
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
                    'Special Appliance Control',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  navigateToRegisterRoomScreen();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 10),
                  backgroundColor: Color.fromRGBO(52, 224, 161, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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

  Widget buildEnergyUsageCard() {
    return Card(
      color: Color.fromRGBO(52, 224, 161, 1),
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
                          child: Column(
                            children: [
                              Text(
                                "Current Usage",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "60",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 2.0, // Adjust height as needed
                                width: double.infinity, // Expands to full width
                                child: ColoredBox(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), // Set desired color
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Current Usage",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "60",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 2.0, // Adjust height as needed
                                      width: double
                                          .infinity, // Expands to full width
                                      child: ColoredBox(
                                        color: Color.fromARGB(255, 255, 255,
                                            255), // Set desired color
                                      ),
                                    )
                                  ],
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

  Widget buildPriceCard() {
    return Card(
      color: Color.fromRGBO(112, 52, 224, 1),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Current Usage",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "60",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 2.0, // Adjust height as needed
                                width: double.infinity, // Expands to full width
                                child: ColoredBox(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), // Set desired color
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Current Usage",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "60",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 2.0, // Adjust height as needed
                                      width: double
                                          .infinity, // Expands to full width
                                      child: ColoredBox(
                                        color: Color.fromARGB(255, 255, 255,
                                            255), // Set desired color
                                      ),
                                    )
                                  ],
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

  void navigateToRegisterRoomScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RegisterRoomScreen(
                numberOfRooms: 0,
              )),
    );
  }
}
