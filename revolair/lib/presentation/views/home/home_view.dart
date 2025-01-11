import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revolvair/generated/locale_keys.g.dart';
import 'package:revolvair/presentation/views/home/home_view_model.dart';
import 'package:revolvair/presentation/views/map/map_view.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) async => {},
      builder: (context, viewModel, child) => Scaffold(
        body: const MapView(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(LocaleKeys.home_title.tr(),
              style: const TextStyle(fontStyle: FontStyle.italic)),
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: ListTile(
                  title: Text(LocaleKeys.home_title.tr(),
                      style: const TextStyle(fontStyle: FontStyle.italic)),
                  onTap: () {
                    Navigator.pop(context);
                    viewModel.navigateToHomePage();
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.air),
                title: Text(LocaleKeys.air_quality_title.tr(),
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.navigateToAirQuality();
                },
              ),
              ListTile(
                leading: FutureBuilder<String?>(
                  future: viewModel.getTextByState(),
                  builder: (context, snapshot) {
                    if(snapshot.data == "Deconnexion"){
                      return const Icon(Icons.logout);
                    }
                    else{
                      return const Icon(Icons.login);
                    }
                  },
                ),
                title: FutureBuilder<String?>(
                  future: viewModel.getTextByState(),
                  builder: (context, snapshot) {
                    return Text(snapshot.data ?? "Connexion");
                  },
                ),
                onTap: () async {
                  Navigator.pop(context);
                  await viewModel.onTapByState();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
