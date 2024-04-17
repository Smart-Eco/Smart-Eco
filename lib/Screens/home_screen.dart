import 'package:flutter/material.dart';
import 'package:smarteco2/Screens/device_details.dart';
import 'register_room.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  TextEditingController currentUsageController = TextEditingController();
  TextEditingController predictedUsageController = TextEditingController();

  PageController _pageController = PageController();

  List<String> devices = ['Bulb', 'Fan', 'Motor', 'asd'];

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
                  navigateToAddDeviceScreen();
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
                    'Add Device',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(
                height: 20,
                thickness: 2,
              ),
              SizedBox(height: 10),
              Text(
                'Devices',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              buildDeviceTiles(),
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
                                height: 2.0,
                                width: double.infinity,
                                child: ColoredBox(
                                  color: Color.fromARGB(255, 255, 255, 255),
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
                                      height: 2.0,
                                      width: double.infinity,
                                      child: ColoredBox(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
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
                                height: 2.0,
                                width: double.infinity,
                                child: ColoredBox(
                                  color: Color.fromARGB(255, 255, 255, 255),
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
                                      height: 2.0,
                                      width: double.infinity,
                                      child: ColoredBox(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
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

  Widget buildDeviceTiles() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: (devices.length / 2).ceil(),
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: buildDeviceCard(devices[index * 2]),
            ),
            SizedBox(width: 10),
            Expanded(
              child: (index * 2 + 1 < devices.length)
                  ? buildDeviceCard(devices[index * 2 + 1])
                  : SizedBox(),
            ),
          ],
        );
      },
    );
  }

  Widget buildDeviceCard(String deviceName) {
    return Card(
      child: ListTile(
        title: Text(deviceName),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeviceDetailsScreen(deviceName: deviceName),
            ),
          );
        },
      ),
    );
  }

  void navigateToRegisterRoomScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterRoomScreen(
          numberOfRooms: 0,
        ),
      ),
    );
  }

  void navigateToAddDeviceScreen() async {
    final newDevice = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => AddDeviceScreen()),
    );
    if (newDevice != null) {
      setState(() {
        devices.add(newDevice);
      });
    }
  }
}

class AddDeviceScreen extends StatelessWidget {
  final TextEditingController _deviceNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _deviceNameController,
              decoration: InputDecoration(
                labelText: 'Device Name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final deviceName = _deviceNameController.text.trim();
                if (deviceName.isNotEmpty) {
                  Navigator.pop(context, deviceName);
                }
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
