import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:revolvair/presentation/views/map/map_view_model.dart';
import 'package:stacked/stacked.dart';
class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.reactive(
      viewModelBuilder: () => MapViewModel(),
      onViewModelReady: (viewModel) async {
      viewModel.initLocation();
      await viewModel.setAirQualityRanges();
      await viewModel.getAllActiveStations();
      await viewModel.updateLatestStations();
        },
      builder: (context, viewModel, child) {
        return Scaffold(
          body: FlutterMap(
            mapController: viewModel.mapController,
            options: MapOptions(
              center: viewModel.currentLatLng,
              zoom: 15.5,
              onPositionChanged: (position, hasGesture) {
                if (hasGesture) {
                  viewModel.setNotCentered();
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: viewModel.currentLatLng,
                    builder: (context) => Icon(
                      Icons.adjust_outlined,
                      size: 40,
                      color: viewModel.positionFound
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
              
              MarkerLayer(
              markers: viewModel.stations.stations.map((station)  {   
                return Marker(
                  point: LatLng(double.parse(station.lat), double.parse(station.long)),
                  width: 60,
                  height: 60,
                  builder: (context) => GestureDetector(
                    onTap: () => viewModel.navigateToStation(station.slug, station.color ?? Colors.black),
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 4),
                          Icon (
                            Icons.place_outlined,
                            size: 30,
                            color: station.color,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
              if (viewModel.isBusy)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
  
          ),
          floatingActionButton: FloatingActionButton(
            onPressed:
                viewModel.locationEnabled ? viewModel.recenterMap : null,
            child: Icon(
              !viewModel.locationEnabled
                  ? Icons.gps_off_outlined
                  : (viewModel.isCentered
                      ? Icons.gps_fixed_outlined
                      : Icons.gps_not_fixed_outlined),
            ),
          ),
        );
      },
    );
  }
}
