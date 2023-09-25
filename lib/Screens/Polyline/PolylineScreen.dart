import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_sharing/Components/User/UserComponent.dart';
import 'package:food_sharing/Screens/Polyline/beforepolyline.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../utils/constans.dart';
import '../../Api/configAPI.dart';
import '../../Response/Polylineresponse.dart';
import '../User/HomeUserScreen.dart';

class PolylineScreen extends StatefulWidget {
  static var routeName = '/polyline_lokasi';

  const PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  var dataTransaksi;
  Response? response;
  var dio = Dio();
  static const CameraPosition initialPosition =
      CameraPosition(target: LatLng(37.4260647, -122.094297), zoom: 14);

  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = <Marker>{};
  late GoogleMapController googleMapController;

  String totalDistance = "";
  String totalTime = "";

  LatLng origin = const LatLng(0, 0);
  LatLng destination = const LatLng(0, 0);

  String apiKey = "";

  PolylineResponse polylineResponse = PolylineResponse();

  Set<Polyline> polylinePoints = {};

  @override
  Widget build(BuildContext context) {
    String lokasi = beforePolyline.dataTransaksi['dataBarang']['lokasi'];

    RegExp latitudePattern = RegExp(r'Latitude: (.*?),');
    RegExp longitudePattern = RegExp(r'Longitude: (.*?)$');

    double latitude =
        double.parse(latitudePattern.firstMatch(lokasi)?.group(1) ?? '0');
    double longitude =
        double.parse(longitudePattern.firstMatch(lokasi)?.group(1) ?? '0');

    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.0,
    );

    Marker redMarker = Marker(
      markerId: MarkerId('redMarker'),
      position: LatLng(latitude, longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    markers.add(redMarker);
    origin = redMarker.position;
    print(beforePolyline.dataTransaksi);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            polylines: polylinePoints,
            markers: markers,
            zoomControlsEnabled: false,
            initialCameraPosition: initialCameraPosition,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
              markers.clear();
            },
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton.extended(
              onPressed: () async {
                Position position = await _determinePosition();

                googleMapController
                    .animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 14,
                  ),
                ));

                Marker blueMarker = Marker(
                  markerId: MarkerId('LokasiSekarang'),
                  position: LatLng(position.latitude, position.longitude),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure),
                );
                markers.add(blueMarker);
                destination = blueMarker.position;

                setState(() {});
              },
              label: const Text("Your Current Location"),
              icon: const Icon(Icons.location_history),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Total Distance: " + totalDistance),
                Text("Total Time: " + totalTime),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          drawPolyline();
        },
        child: const Icon(Icons.directions),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disable');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location services are disable');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  void drawPolyline() async {
    var response = await http.post(Uri.parse(
        "https://maps.googleapis.com/maps/api/directions/json?key=" +
            apiKey +
            "&units=metric&origin=" +
            origin.latitude.toString() +
            "," +
            origin.longitude.toString() +
            "&destination=" +
            destination.latitude.toString() +
            "," +
            destination.longitude.toString() +
            "&mode=driving"));

    print(response.body);

    polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));

    totalDistance = polylineResponse.routes![0].legs![0].distance!.text!;
    totalTime = polylineResponse.routes![0].legs![0].duration!.text!;

    for (int i = 0;
        i < polylineResponse.routes![0].legs![0].steps!.length;
        i++) {
      polylinePoints.add(Polyline(
          polylineId: PolylineId(
              polylineResponse.routes![0].legs![0].steps![i].polyline!.points!),
          points: [
            LatLng(
                polylineResponse
                    .routes![0].legs![0].steps![i].startLocation!.lat!,
                polylineResponse
                    .routes![0].legs![0].steps![i].startLocation!.lng!),
            LatLng(
                polylineResponse
                    .routes![0].legs![0].steps![i].endLocation!.lat!,
                polylineResponse
                    .routes![0].legs![0].steps![i].endLocation!.lng!),
          ],
          width: 5,
          color: Colors.blue));
    }
    setState(() {});
  }
}
