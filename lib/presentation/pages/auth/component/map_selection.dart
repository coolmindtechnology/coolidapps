import 'dart:async';

import 'package:coolappflutter/presentation/pages/auth/component/location_provider.dart';
import 'package:coolappflutter/presentation/pages/auth/register_screen.dart';
import 'package:coolappflutter/presentation/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';

class MapSelectionScreen extends StatefulWidget {
  final LatLng initialPosition;

  const MapSelectionScreen({super.key, required this.initialPosition});

  @override
  _MapSelectionScreenState createState() => _MapSelectionScreenState();
}

class _MapSelectionScreenState extends State<MapSelectionScreen> {
  late GoogleMapController mapController;
  late LatLng selectedPosition;

  @override
  void initState() {
    super.initState();
    // selectedPosition = widget.initialPosition;
    // setState(() {});
    selectedPosition = const LatLng(-6.2088, 106.8456);
    Timer(const Duration(seconds: 2), () {
      getLocation();
    });

    setState(() {});
  }

  getLocation() {
    final locationProvider = Provider.of<LocationProvider>(context);
    selectedPosition = LatLng(locationProvider.latitude!.toDouble(),
        locationProvider.longitude!.toDouble());
  }

  // Fungsi untuk menangani ketika peta ditekan
  void _onMapTapped(LatLng latLng) {
    setState(() {
      selectedPosition = latLng; // Menyimpan posisi yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: const Text('Select Location on Map')),
        body: Column(
          children: [
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: selectedPosition,
                  zoom: 14,
                ),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                onTap: _onMapTapped, // Menangani tap pada map
                markers: {
                  Marker(
                    markerId: const MarkerId('selected_position'),
                    position: selectedPosition,
                  ),
                },
                myLocationEnabled: true,
                compassEnabled: true,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.white.withOpacity()
                  ),
              onPressed: () {
                debugPrint("val tes $selectedPosition");
                // Mendapatkan latitude dan longitude
                double latitude = selectedPosition.latitude;
                double longitude = selectedPosition.longitude;
                // Navigator.pop(context, selectedPosition);
                locationProvider.fetchLocationData(latitude, longitude);
                Nav.back();
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             const RegisterScreen())); // Kembali ke halaman sebelumnya dengan posisi yang dipilih
              },
              child: Text(S.of(context).confirm_location),
            ),
          ],
        ),
      ),
    );
  }
}
