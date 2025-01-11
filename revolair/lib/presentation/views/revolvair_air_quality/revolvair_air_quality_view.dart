import 'package:flutter/material.dart';
import 'package:revolvair/infra/helpers/air_quality_index.dart';
import 'package:revolvair/infra/helpers/map_icon.dart';
import 'package:revolvair/presentation/helpers/color_to_hex.dart';
import 'package:revolvair/presentation/views/revolvair_air_quality/revolvair_air_quality_view_model.dart';
import 'package:stacked/stacked.dart';

class RevolvairAirQualityView extends StatelessWidget {
  final AirQualityIndex apiRoute;
  const RevolvairAirQualityView({super.key, required this.apiRoute});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<RevolvairAirQualityViewModel>.reactive(
          viewModelBuilder: () => RevolvairAirQualityViewModel(),
          onViewModelReady: (viewModel) =>
              viewModel.getRevolvairAirQualityFromRepository(apiRoute),
          builder: (context, viewModel, child) =>
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                viewModel.isBusy
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              final airQuality = viewModel.airQuality;
                              final range = airQuality.ranges[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: ListTile(
                                    key: Key('air_quality_$index'),
                                    trailing: Icon(mapIcon(range.icon)),
                                    onTap: () {
                                      viewModel.navigateToDetail(
                                          range,
                                          airQuality.source,
                                          airQuality.url);
                                    },
                                    leading: Icon(
                                      Icons.circle,
                                      color: getColorFromHex(range.color),
                                      size: 40,
                                    ),
                                    title: Text(range.description,
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic)),
                                    subtitle: Text(
                                        'De ${range.min} à ${range.max} ug/m³',
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ),
                                ),
                              );
                            },
                            itemCount: viewModel.airQuality.ranges.length))
              ])),
    );
  }
}
