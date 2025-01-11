import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/infra/helpers/air_quality_index.dart';
import 'package:revolvair/presentation/views/revolvair_air_quality/revolvair_air_quality_view.dart';

class AirQualityView extends StatelessWidget {
  const AirQualityView({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr(LocaleKeys.air_quality_title),
              style: const TextStyle(fontStyle: FontStyle.italic)),
          backgroundColor: Colors.white,
          bottom: TabBar(
            tabs: [
              Tab(
                text: LocaleKeys.air_quality_tabs_revolvair.tr(),
              ),
              Tab(
                text: LocaleKeys.air_quality_tabs_aqhi_canada.tr(),
              ),
              Tab(
                text: LocaleKeys.air_quality_tabs_iqa_epa_us.tr(),
              )
            ],
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: const TabBarView(
          children: [
            RevolvairAirQualityView(apiRoute: AirQualityIndex.revolvair),
            RevolvairAirQualityView(apiRoute: AirQualityIndex.canada),
            RevolvairAirQualityView(apiRoute: AirQualityIndex.epaUs)
          ],
        ),
      ),
    );
  }
}
