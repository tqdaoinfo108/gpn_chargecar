import 'package:charge_car/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../constants/dimens.dart';
import '../../third_library/search_page/search_page.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.saved_search),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Settings',
            ),
          ],
          currentIndex: controller.pageCurrent.value,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: ColorName.bottomSheetTopIconColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (s) => controller.onChangePageScreen(s),
        ),
        body: [
          HomeChildPageOne(
              pageController: controller.pageController.value,
              controller: controller.mapController.value,
              markers: controller.lstMarkLocaltion),
          Text("data"),
          Text("data"),
          Text("data")
        ][controller.pageCurrent.value],
      ),
    );
  }
}

class HomeChildPageOne extends StatelessWidget {
  const HomeChildPageOne({
    Key? key,
    required this.pageController,
    required this.controller,
    required this.markers,
  }) : super(key: key);

  final PanelController pageController;
  final MapController controller;
  final List<Marker> markers;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: pageController,
      parallaxEnabled: true,
      parallaxOffset: .5,
      panel: const Center(
        child: Text("This is the sliding Widget"),
      ),
      collapsed: Container(
        color: Colors.blueGrey,
        child: const Center(
          child: Text(
            "This is the collapsed Widget",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Stack(children: [
        FlutterMap(
          // mapController: controller,
          options: MapOptions(
              center: LatLng(10.780231, 106.6645121),
              zoom: 15,
              maxZoom: 17,
              minZoom: 4),
          layers: [
            TileLayerOptions(
              urlTemplate:
                  'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayerOptions(markers: markers),
          ],
          nonRotatedChildren: [
            Opacity(
              opacity: 0.5,
              child: AttributionWidget.defaultWidget(
                source: 'GPN (OpenStreetMap)',
                onSourceTapped: () {},
              ),
            ),
          ],
        ),
        //search autoconplete input
        Positioned(
            //search input bar
            top: MediaQuery.of(context).viewPadding.top,
            child: InkWell(
              onTap: () async {
                pageController.open();
                showSearch(
                  context: context,
                  delegate: SearchPage<String>(
                    items: ["1", "2", "3"],
                    searchLabel: 'Search people',
                    suggestion: const Center(
                      child: Text('Filter people by name, surname or age'),
                    ),
                    failure: const Center(
                      child: Text('No person found :('),
                    ),
                    filter: (person) => [],
                    builder: (person) => const ListTile(
                      title: Text('person.name'),
                      subtitle: Text('person.surname'),
                      trailing: Text(' yo'),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(RadiusSize.kDialogCornerRadius),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(),
                      width: MediaQuery.of(context).size.width - 40,
                      child: ListTile(
                        title: const Text(
                          "Search",
                          style: TextStyle(fontSize: 18),
                        ),
                        leading: Image.asset(
                          "assets/icons/icon_charging.png",
                          width: 32,
                        ),
                        trailing: const FittedBox(
                          fit: BoxFit.fill,
                          child: Icon(Icons.search),
                        ),
                      ),
                    )),
              ),
            )),
      ]),
    );
  }
}
