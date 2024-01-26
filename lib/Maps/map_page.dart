import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {

  final LocationData initialLocation;

  const MapPage({super.key, required this.initialLocation});

  @override
  _MapPageState createState() => _MapPageState();

}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  late LocationData currentLocation;
  Location location = Location();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    currentLocation = await location.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0),
              zoom: 15.0,
            ),
            markers: {
              Marker(
                markerId: MarkerId('Current location'),
                position: LatLng(currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure), // Custom icon here
              ),
            },
          ),
          const Positioned(
            bottom: 50,
            left: 10,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text('Price: \$100', style: TextStyle(fontSize: 16)),
                    Text('Location: Your Location', style: TextStyle(fontSize: 16)),
                    // Add more info here
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}