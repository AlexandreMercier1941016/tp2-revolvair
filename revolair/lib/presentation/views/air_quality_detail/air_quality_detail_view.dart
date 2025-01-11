import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revolvair/domain/entities/air_quality/air_quality_range.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/map_icon.dart';
import 'package:revolvair/presentation/helpers/color_to_hex.dart';
import 'package:revolvair/presentation/views/air_quality_detail/air_quality_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class AirQualityDetailView extends StatelessWidget {
  final AirQualityRange range;
  final String source;
  final String url;
  const AirQualityDetailView(
      {super.key,
      required this.range,
      required this.source,
      required this.url});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AirQualityDetailViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(LocaleKeys.air_quality_detail_title.tr(),
              style:
                  const TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              
              viewModel.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color:  getColorFromHex(range.color),
                          size: 40,
                        ),
                        const SizedBox(width: 8),
                        Text(range.description,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        const Spacer(),
                        Icon(mapIcon(range.icon))
                      ],
                    ),
                    
              const SizedBox(height: 16),
              Text(LocaleKeys.air_quality_detail_data_type.tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(
                  '${range.min} ${LocaleKeys.air_quality_detail_data_range.tr()} ${range.max}',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
              const SizedBox(height: 16),
              Text(LocaleKeys.air_quality_detail_data_effects.tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(range.healthEffect,
                  style: const TextStyle(fontStyle: FontStyle.italic)),
              const SizedBox(height: 16),
              Text(LocaleKeys.air_quality_detail_data_warning.tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(range.note,
                  style: const TextStyle(fontStyle: FontStyle.italic)),
              const SizedBox(height: 16),
              Text(LocaleKeys.air_quality_detail_data_source.tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.open_in_new),
                title: Text(source),
                onTap: () => viewModel.redirectToWebPage(url),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
