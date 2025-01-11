import 'package:flutter/material.dart';
import 'package:revolvair/presentation/helpers/format_date.dart';
import 'package:revolvair/presentation/helpers/icon_from_color.dart';
import 'package:revolvair/presentation/helpers/latest_mesure.dart';
import 'package:stacked/stacked.dart';
import 'station_view_model.dart';

class StationView extends StatelessWidget {
  final String slug;
  final Color color;
  const StationView({super.key, required this.slug, required this.color});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StationViewModel>.reactive(
      viewModelBuilder: () => StationViewModel(),
      onViewModelReady: (viewModel) async {
        await viewModel.getLivesMeasuresStation(slug);
        await viewModel.getLatestMeasuresStation(slug);
        await viewModel.getStationInfos(slug);
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              slug.isNotEmpty ? slug : "Chargement...",
              style: const TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: viewModel.isBusy
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildCard(
                            viewModel.livesMeasuresStation.value,
                            "Valeur actuelle",
                          ),
                          const SizedBox(width: 16),
                          _buildCard(viewModel.latestMeasuresStation.value,
                              "Moyenne sur 24h"),
                        ],
                      ),
                      Text(getLatestMesureText(viewModel.stationInfos.latestStats?.averageLatestStats)),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                               getFormattedDate(
                                  viewModel.livesMeasuresStation.date),
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart),
                label: "Statistiques",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.warning),
                label: "Alertes",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCard(String value, String label) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.grey[900],
        elevation: 4, 
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                16),
            border: Border.all(
              color: color, 
              width: 2, 
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 32,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Icon(getEmojiForColor(color.value.toRadixString(16)),
                    color: color, size: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
