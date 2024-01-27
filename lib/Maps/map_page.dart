import 'dart:async';


import 'package:buytime/constants.dart';
import 'package:buytime/gigs.dart';
import 'package:buytime/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsPage extends StatefulWidget {
  final cLocation currentGigLocation;

  const MapsPage({super.key, required this.currentGigLocation});


  @override
  State<MapsPage> createState() => _MapPageState();
}


class _MapPageState extends State<MapsPage> {
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController = Completer<
      GoogleMapController>();


  static const LatLng _pGooglePlex = LatLng(-1.930482, 30.152918);
  static const LatLng _pApplePart = LatLng(-1.930399, 30.153290);

  LatLng? _currentP = null;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then((value) =>
        getPolylinePoints().then((coordinates) =>
            generatePolyLineFromPoints(coordinates),));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.currentGigLocation.place),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          ); // This line will navigate back to the previous screen
        },
      ),
        ),
        body: Stack(
            children: <Widget>[
            _currentP == null
            ? const Center(child: Text("Loading.."))
            : GoogleMap(
          onMapCreated: ((GoogleMapController controller) =>
              _mapController.complete(controller)),
          initialCameraPosition: CameraPosition(
            target: _pGooglePlex,
            zoom: 13,
          ),
          markers: {
            Marker(
              markerId: MarkerId("_currentLocation"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              position: _currentP!,
            ),
            Marker(
                markerId: MarkerId("_sourceLocation"),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure),
                position: _pGooglePlex),
            Marker(
                markerId: MarkerId("_destinationLocation"),
                icon: BitmapDescriptor.defaultMarker,
                position: _pApplePart)
          },
          polylines: Set<Polyline>.of(polylines.values),),
              Positioned(
                bottom: 50.0,
                left: 20.0,
                right: 20.0,
                child: _buildFloatingCard(),
              ),

        ]
      ),),
    );


  }


  Widget _buildFloatingCard() {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card wrap its content
          children: <Widget>[
            Text(
              'Start Your Gig!',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              widget.currentGigLocation.name,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10),
            Text(
              'Price: ${widget.currentGigLocation.price}', // Price display
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement your action
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }




    Future<void> _cameraToPosition(LatLng pos) async {
      final GoogleMapController controller = await _mapController.future;
      CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(_newCameraPosition),);
    }


    Future<void> getLocationUpdates() async {
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      _serviceEnabled = await _locationController.serviceEnabled();
      if (_serviceEnabled) {
        _serviceEnabled = await _locationController.requestService();
      } else {
        return;
      }

      _permissionGranted = await _locationController.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _locationController.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationController.onLocationChanged
          .listen((LocationData currentLocation) {
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          setState(() {
            _currentP =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
            _cameraToPosition(_currentP!);
          });
        }
      });
    }

    Future<List<LatLng>> getPolylinePoints() async {
      List<LatLng> polylineCoordinates = [];
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          GOOGLE_MAPS_API_KEY,
          PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
          PointLatLng(_pApplePart.latitude, _pApplePart.longitude),
          travelMode: TravelMode.walking);

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      } else {
        print(result.errorMessage);
      }
      return polylineCoordinates;
    }

    void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
      PolylineId id = PolylineId("poly");
      Polyline polyline = Polyline(polylineId: id,
          color: Colors.blue,
          points: polylineCoordinates,
          width: 8);
      setState(() {
        polylines[id] = polyline;
      });
    }
  }

