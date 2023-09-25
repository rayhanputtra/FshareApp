import 'package:dcdg/dcdg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_sharing/Api/configApi.dart';
import 'package:food_sharing/Screens/Polyline/PolylineScreen.dart';
import 'package:food_sharing/Screens/Polyline/beforepolyline.dart';
import 'package:food_sharing/Screens/User/Transaksi/DataTransaksi.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Screens/User/HomeUserScreen.dart';
import '../../Screens/User/Makanan/DataMakananScreen.dart';
import '../../Screens/User/Transaksi/TransaksiScreen.dart';
import '../../size_config.dart';
import '../../utils/constans.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeUserComponent extends StatefulWidget {
  const HomeUserComponent({Key? key}) : super(key: key);

  @override
  _HomeUserComponent createState() => _HomeUserComponent();
}

class _HomeUserComponent extends State<HomeUserComponent> {
  // double rating = 0;
  var dataTransaksi;
  Response? response;
  late GoogleMapController googleMapController;
  Set<Marker> markers = <Marker>{};
  var dio = Dio();
  var dataMakanan;
  CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(
        -6.1753924, 106.8271528), // Set initial location to Jakarta, Indonesia
    zoom: 14.0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataGitar();
    getDataTransaksi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Service",
                    style: mTitleStyle,
                  ),
                ),
                menuLayanan(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Nearby Food Locations",
                    style: mTitleStyle,
                  ),
                ),
                SizedBox(
                  width: 350,
                  height: 350,
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: initialCameraPosition,
                        markers: markers,
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        onMapCreated: (GoogleMapController controller) {
                          googleMapController = controller;
                          Container(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:
                                  dataMakanan == null ? 0 : dataMakanan.length,
                              itemBuilder: (BuildContext context, int index) {},
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: FloatingActionButton.extended(
                          onPressed: () async {
                            Position position = await _determinePosition();

                            googleMapController
                                .animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                    position.latitude, position.longitude),
                                zoom: 14,
                              ),
                            ));

                            Marker blueMarker = Marker(
                              markerId: MarkerId('LokasiSekarang'),
                              position:
                                  LatLng(position.latitude, position.longitude),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueAzure),
                            );
                            markers.add(blueMarker);

                            setState(() {});
                          },
                          label: const Text("Your Current Location"),
                          icon: const Icon(Icons.location_history),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dataTransaksi == null ? 0 : dataTransaksi.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cardTransaksi(dataTransaksi[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addMarker(data) {
    // Check if the "verifikasi" field is present and its value is 1
    if (data['verifikasi'] != null && data['verifikasi'] == 1) {
      String lokasi = data['lokasi'];

      RegExp latitudePattern = RegExp(r'Latitude: (.*?),');
      RegExp longitudePattern = RegExp(r'Longitude: (.*?)$');

      double latitude = 0.0;
      double longitude = 0.0;

      Match? latitudeMatch = latitudePattern.firstMatch(lokasi);
      Match? longitudeMatch = longitudePattern.firstMatch(lokasi);

      if (latitudeMatch != null && longitudeMatch != null) {
        latitude = double.parse(latitudeMatch.group(1) ?? '0');
        longitude = double.parse(longitudeMatch.group(1) ?? '0');

        Marker marker = Marker(
          markerId:
              MarkerId(data['lokasi'].toString()), // Unique ID for the marker
          position: LatLng(latitude, longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: data['nama'], snippet: data['porsi'],
            // Display the name in the InfoWindow title
            // Add additional content here if needed
          ),
        );
        markers.add(marker);
      } else {
        // Handle the case when the pattern doesn't match or values are null
        // You can provide default coordinates or display an error message
      }
    } else {
      // If "verifikasi" is not 1, do not add the marker to the map
    }
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

  Widget menuLayanan() {
    return SizedBox(
      height: 70,
      child: Column(children: [
        Row(children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DataMakananScreen.routeName);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              padding: const EdgeInsets.only(left: 16),
              height: 64,
              decoration: BoxDecoration(
                  color: mFillColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: mBorderColor, width: 1)),
              child: Row(
                children: [
                  Image.asset('assets/images/grocery.png'),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Food",
                          style: mServiceTitleStyle,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Food List",
                          style: mServiceSubtitleStyle,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
          Expanded(
              child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DataTransaksiScreen.routeName);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              padding: const EdgeInsets.only(left: 10),
              height: 64,
              decoration: BoxDecoration(
                  color: mFillColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: mBorderColor, width: 1)),
              child: Row(
                children: [
                  Image.asset('assets/images/food.png'),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Transaction",
                          style: mServiceTitleStyle,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Information",
                          style: mServiceSubtitleStyle,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))
        ])
      ]),
    );
  }

  void getDataGitar() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.get(getAllMobil);

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        setState(() {
          dataMakanan = response!.data['data'];
          for (var item in dataMakanan) {
            addMarker(item);
          }
          print(dataMakanan);
        });
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            title: 'Disclaimer',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
            }).show();
      }
    } catch (e) {
      print(e);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'An Error Occurred On The Server',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }

  Widget cardTransaksi(data) {
    var status = data['status'];
    String statusText = '';
    Color statusColor = mTitleColor;
    bool showLocationIcon = false;

    if (status == 0) {
      statusText = 'Waiting for Photo Upload';
      statusColor =
          Color.fromARGB(255, 255, 123, 0); // Warna oranye untuk status 0
    } else if (status == 1) {
      statusText = 'Request Accepted';
      statusColor = Colors.green; // Warna hijau untuk status 1
      showLocationIcon = true;
    } else if (status == 2) {
      statusText = 'Waiting for approval';
      statusColor =
          Color.fromARGB(255, 226, 204, 3); // Warna biru untuk status 2
    } else if (status == 3) {
      statusText = 'Request Rejected';
      statusColor = Colors.red; // Warna merah untuk status 3
    } else if (status == 4) {
      statusText = 'Done Taken';
      statusColor =
          Color.fromARGB(255, 45, 117, 47); // Warna merah untuk status 3
    }

    return GestureDetector(
      onTap: status == 1
          ? () {
              Navigator.pushNamed(context, beforePolyline.routeName,
                  arguments: data);
            }
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 3.0, color: Colors.white24),
                image: DecorationImage(
                  image:
                      NetworkImage('$baseUrl/${data['dataBarang']['gambar']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${data['dataBarang']['nama']}",
                    style: const TextStyle(
                      color: mTitleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Donors Address",
                        style: const TextStyle(
                          color: mTitleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${data['dataBarang']['alamat']}",
                      ),
                    ],
                  ),
                  if (status == 1) // Show these fields only when status is 1
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Donors Phone Number",
                          style: const TextStyle(
                            color: mTitleColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${data['dataBarang']['tlpadmin']}",
                        ),
                      ],
                    ),
                  const SizedBox(height: 5),
                  Text(
                    "Status",
                    style: const TextStyle(
                      color: mTitleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                if (showLocationIcon)
                  Icon(
                    Icons.location_on_sharp,
                    color: Color.fromARGB(255, 75, 165, 78),
                    size: 40.0,
                  ),
                const SizedBox(width: 5),
                if (showLocationIcon)
                  Text(
                    'Route',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void getDataTransaksi() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio
          .get('$getByIdUserLimit/${HomeUserScreen.dataUserLogin['_id']}');

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        setState(() {
          dataTransaksi = response!.data['data'];
          print(dataTransaksi);
        });
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            title: 'Disclaimer',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
            }).show();
      }
    } catch (e) {
      print(e);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Disclaimer',
          desc: 'An Error Occurred On The Server',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
