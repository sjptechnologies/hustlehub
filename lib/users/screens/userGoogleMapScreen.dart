import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hustlehub/services/firestoreDataBase.dart';

class UserGoogleMapScreen extends StatefulWidget {
  const UserGoogleMapScreen({super.key, required this.latlong});
  final LatLng latlong;

  @override
  State<UserGoogleMapScreen> createState() => _UserGoogleMapScreenState();
}

class _UserGoogleMapScreenState extends State<UserGoogleMapScreen> {
  late GoogleMapController mapController;
  String? _currentAddress;
  LatLng? _selectedPosition;
  final Set<Marker> _markers = {}; // Store markers for jobs

  @override
  void initState(){
    super.initState();
    _selectedPosition = widget.latlong;
    initializeData();
  }

  void initializeData() async{
    await _getAddressFromLatLng(_selectedPosition!);
    _loadNearbyJobs();
    _addUserMarker();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred while fetching location: $e')),
      );
    }
  }

  void _addUserMarker() {
    if (_currentAddress == null) return; 
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_currentAddress!),
          position: _selectedPosition!,
          infoWindow: InfoWindow(
            title: _currentAddress,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // Red color for user's location
        ),
      );
    });
  }

  Future<void> _loadNearbyJobs() async {
    try {
      List<Map<String, dynamic>> allJobs = await FirestoreServices().fetchAllJobs();
      const double searchRadius = 50.0; // Example radius in kilometers

      for (var job in allJobs) {
        Map<String, dynamic>? jobLocation = job['jobDetails']['latlng'];
        
        if (jobLocation != null) {
          LatLng jobLatLng = LatLng(jobLocation['latitude'], jobLocation['longitude']);
          double distance = calculateDistance(widget.latlong, jobLatLng);

          if (distance <= searchRadius) {
            _addJobMarker(jobLatLng, job['jobTitle'], job['companyName'], job['companyEmail']);
          }
        }
      }
    } catch (e) {
      print("Error loading jobs: $e");
    }
  }

  // Function to calculate distance between two LatLng points

double calculateDistance(LatLng start, LatLng end) {
  const double radiusOfEarth = 6371; // Radius of Earth in kilometers

  // Convert latitude and longitude from degrees to radians
  double dLat = (end.latitude - start.latitude) * (pi / 180);
  double dLon = (end.longitude - start.longitude) * (pi / 180);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(start.latitude * (pi / 180)) * cos(end.latitude * (pi / 180)) *
      sin(dLon / 2) * sin(dLon / 2);
  
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return radiusOfEarth * c; // Distance in kilometers
}


  // Function to add a marker for a job
void _addJobMarker(LatLng position, String jobTitle, String companyName, String companyEmail) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(jobTitle),
          position: position,
          infoWindow: InfoWindow(
            title: jobTitle,
            snippet: "$companyName\n$companyEmail",
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Blue color for job locations
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locate Nearby Jobs'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              mapType: MapType.normal,
              trafficEnabled: false,
              buildingsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: _selectedPosition!,
                zoom: 10.0,
              ),
              markers: _markers, // Display job markers
            ),
          ),
        ],
      ),
    );
  }
}
