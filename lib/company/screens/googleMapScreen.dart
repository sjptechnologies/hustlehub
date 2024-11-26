import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({
    super.key,
    required this.latlong,
  });
  final LatLng latlong;

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;
  String? _currentAddress; // This will store the location name
  LatLng? _selectedPosition; // Store the selected position

  @override
  void initState() {
    super.initState();
    _selectedPosition = widget.latlong;
    _getAddressFromLatLng(_selectedPosition!);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Function to fetch the address using reverse geocoding
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

  // Function to handle tap on the map and update the selected position
  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedPosition = position;
    });
    _getAddressFromLatLng(position); // Get the address for the new location
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
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
              markers: {
                if (_selectedPosition != null)
                  Marker(
                    markerId: const MarkerId('selectedMarker'),
                    position: _selectedPosition!,
                    infoWindow: InfoWindow(
                      title: _currentAddress ?? '',
                    ),
                  ),
              },
              onTap: _onMapTapped, // Detect taps on the map
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Pass the selected location back to the previous screen
                  Navigator.pop(context, _selectedPosition);
                },
                child: const Text('Select this location'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
