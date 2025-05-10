import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng _selectedPosition = LatLng(-6.200000, 106.816666); // Default Jakarta
  Marker? _marker;
  bool _isLoading = true; // Untuk loading state
  bool _isConfirming = false; // Untuk loading state


  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _selectedPosition = LatLng(position.latitude, position.longitude);
      _marker = Marker(
        markerId: MarkerId("selected"),
        position: _selectedPosition,
      );
      _isLoading = false;
    });

    mapController?.animateCamera(
      CameraUpdate.newLatLng(_selectedPosition),
    );
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedPosition = position;
      _marker = Marker(markerId: MarkerId("selected"), position: position);
    });
  }

  Future<void> _confirmLocation() async {
    setState(() {
      _isConfirming = true;
    });
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _selectedPosition.latitude,
        _selectedPosition.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        Navigator.pop(context, {
          'country': place.country,
          'state': place.administrativeArea,
          'city': (place.subAdministrativeArea != null && place.subAdministrativeArea!.trim().isNotEmpty)
              ? place.subAdministrativeArea
              : place.locality,
          'district': place.locality,
          'longtitude': _selectedPosition.longitude,
          'latitide': _selectedPosition.latitude,
        });
      }
    } catch (e) {
      print("Error getting location name: $e");
    } finally{
      if (mounted){
        setState(() {
          _isConfirming = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void _goToCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng currentLatLng = LatLng(position.latitude, position.longitude);

    mapController?.animateCamera(
      CameraUpdate.newLatLng(currentLatLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pilih Lokasi",style: TextStyle(color: Colors.white),)),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: _selectedPosition, zoom: 15),
            onMapCreated: (controller) => mapController = controller,
            onTap: _onMapTapped,
            markers: _marker != null ? {_marker!} : {},
            myLocationEnabled: true,
            myLocationButtonEnabled: false, // kita pakai button sendiri
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.white,
              onPressed: _isConfirming ? null : _confirmLocation,
              label: _isConfirming
                    ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                    )
                        : Text("Pilih Lokasi"),
              icon:  _isConfirming ? SizedBox.shrink() : Icon(Icons.check),
            ),
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width /10,
            child:  FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: _goToCurrentLocation,
              child: Icon(Icons.my_location),
              tooltip: "Ke Lokasi Saya",
            ),
          ),
        ],
      ),
    );
  }
}
