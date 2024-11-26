import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hustlehub/routes/routeConstants.dart';
import 'package:hustlehub/users/screens/appliedJobScreen.dart';
import 'package:hustlehub/users/screens/exploreScreen.dart';
import 'package:hustlehub/users/screens/home.dart';
import 'package:hustlehub/users/screens/profileScreen.dart';
import 'package:hustlehub/users/widgets/customBotNavWidget.dart';

// ignore: must_be_immutable
class RootScreen extends StatefulWidget {
  int? index;
  RootScreen({super.key,this.index=0});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {


  
List<Widget> pages =const [
    UserHomeScreen(),
    AppliedJobScreen(),
    ExploreScreen(),
    ProfileScreen()
  ];

  int selectedIndex = 0;
  bool isloading = false;

  Future<void> _navigateToGoogleMapScreen(BuildContext context) async {
    // Check for permission and get the current location
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permission is denied")),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Convert position to LatLng
    LatLng currentLocation = LatLng(position.latitude, position.longitude);

    // Navigate to GoogleMapScreen with current location as argument
    final selectedLocation = await Navigator.pushNamed(
      context,
      AppRoute.userGoogleMapScreen,
      arguments: currentLocation,
    );
     if (selectedLocation != null && selectedLocation is LatLng) {
    // Store the selected location
    LatLng location = selectedLocation;
    
     }
     setState(() {
       isloading = false;
     });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar:  Stack(
            clipBehavior: Clip
                .none, // Ensures the CircleAvatar can overflow outside the Stack
            children: [
              CustomBottomNavWidget(
                selectedIndex: selectedIndex,
                onTap: (value) {

                
             setState(() {
               selectedIndex = value;
             });
           }
                  
                
              ),
              Positioned(
                left: (MediaQuery.of(context).size.width / 2) -
                    30, // Center horizontally,
                bottom: 30,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      isloading = true;
                    });
                    _navigateToGoogleMapScreen(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.greenAccent[700],
                    foregroundColor: const Color.fromARGB(255, 32, 30, 30),  
                    radius: 30,
                    child: isloading?CupertinoActivityIndicator(): Icon(
                      Icons.location_on,
                      size: 35,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: pages[selectedIndex],
    );
  }
}