import 'package:flutter/material.dart';
import 'package:smarteco2/Screens/device_details.dart';
import 'package:smarteco2/Screens/history_page.dart';
import 'package:smarteco2/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController currentUsageController = TextEditingController();
  TextEditingController predictedUsageController = TextEditingController();
  final TextEditingController _priceLimitController = TextEditingController();
  double priceLimit = 100; // Default value for Price Limit

  final PageController _pageController = PageController();

  List<String> devices = ['Bulb', 'Fan', 'Motor', 'asd'];
  List<String> notifications = [];
  AuthService auth = AuthService();

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
      appBar: AppBar(
        toolbarHeight: 100,
        flexibleSpace: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Hello',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              Text(
                'UserName',
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              SizedBox(
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
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 10),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Usage Stats',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  navigateToAddDeviceScreen();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 10),
                  backgroundColor: const Color.fromRGBO(52, 224, 161, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
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
              const SizedBox(height: 10),
              const Divider(
                height: 20,
                thickness: 2,
              ),
              const SizedBox(height: 10),
              const Text(
                'Devices',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              buildDeviceTiles(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEnergyUsageCard() {
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
              const Text(
                "Energy Usage",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                textAlign: TextAlign.left,
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
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Current Usage",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "${currentUsageController.text} kWh",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 2.0,
                          width: double.infinity,
                          child: ColoredBox(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Predicted Usage",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "${predictedUsageController.text} kWh",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 2.0,
                          width: double.infinity,
                          child: ColoredBox(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )
                      ],
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

  Widget buildPriceCard() {
    double totalPrice = 60; // Placeholder for total price calculation
    bool showNotification = totalPrice > priceLimit * 0.7;
    String notificationMessage =
        "The consumption has reached more than 70% of the price limit set.";

    if (showNotification) {
      // Add notification to the notifications list
      if (!notifications.contains(notificationMessage)) {
        notifications.add(notificationMessage);
      }

      // Show snackbar notification
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
                    "$totalPrice", // Replace with the actual total price value
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
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget buildDeviceTiles() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: (devices.length / 2).ceil(),
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: buildDeviceCard(devices[index * 2]),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: (index * 2 + 1 < devices.length)
                  ? buildDeviceCard(devices[index * 2 + 1])
                  : const SizedBox(),
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

  AddDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _deviceNameController,
              decoration: const InputDecoration(
                labelText: 'Device Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final deviceName = _deviceNameController.text.trim();
                if (deviceName.isNotEmpty) {
                  Navigator.pop(context, deviceName);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
