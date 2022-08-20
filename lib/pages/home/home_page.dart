import 'package:charge_car/model/charge_car.dart';
import 'package:charge_car/third_library/button_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../constants/dimens.dart';
import '../../third_library/search_page/search_page.dart';
import '../notification/notification_page.dart';
import '../profile/profile_page.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController>  {
  const HomePage({Key? key}) : super(key: key);

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
          unselectedItemColor: Theme.of(context).colorScheme.primary,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (s) => controller.onChangePageScreen(s),
        ),
        body: [
          HomeChildPageOne(
            pageController: controller.pageController.value,
            mapController: controller.mapController.value,
            markers: controller.lstMarkLocaltion,
            homeController: controller,
          ),
          Text("data"),
          NotificationPage(),
          ProfilePage(),
        ][controller.pageCurrent.value],
      ),
    );
  }
}

class HomeChildPageOne extends StatelessWidget {
  const HomeChildPageOne({
    Key? key,
    required this.pageController,
    required this.mapController,
    required this.markers,
    required this.homeController,
  }) : super(key: key);

  final PanelController pageController;
  final MapController mapController;
  final List<Marker> markers;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Obx(
      () => SlidingUpPanel(
        controller: pageController,
        color: Colors.transparent,
        minHeight: 80,
        maxHeight: 350,
        panel: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(RadiusSize.kDialogCornerRadius),
                    topRight: Radius.circular(RadiusSize.kDialogCornerRadius))),
            child: Column(
              children: [
                const SizedBox(height: Space.small),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.all(
                              Radius.circular(RadiusSize.kDialogCornerRadius))),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(Space.large),
                  child: Column(
                    children: [
                      Text(
                        homeController.markLocaltionCurrent.value?.name ?? "",
                        softWrap: true,
                        style: theme.textTheme.headline5!.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: Space.small),
                      Text(
                        homeController.markLocaltionCurrent.value?.address ??
                            "",
                        style: theme.textTheme.bodyText1!
                            .copyWith(color: theme.colorScheme.primary),
                      ),
                      const SizedBox(height: Space.small),
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                        style: theme.textTheme.bodyText1!
                            .copyWith(color: theme.colorScheme.primary),
                      ),
                      const SizedBox(height: Space.medium),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Số trụ: 8",
                              style: theme.textTheme.bodyText1!
                                  .copyWith(color: theme.colorScheme.primary)),
                          Text("Lỗ sạc còn trống: 8",
                              style: theme.textTheme.bodyText1!
                                  .copyWith(color: theme.colorScheme.primary)),
                        ],
                      ),
                      const SizedBox(height: Space.medium),
                      Row(
                        children: [
                          Expanded(
                              child: DefaultButtonWidthDynamic(
                                backgroundColor:
                                    theme.colorScheme.primary.withOpacity(0.2),
                                widget: Icon(Icons.open_with),
                              ),
                              flex: 3),
                          const SizedBox(width: Space.medium),
                          Expanded(
                              child: DefaultButtonWidthDynamic(
                                backgroundColor: theme.primaryColor,
                                widget: Text("Booking",
                                    style: theme.textTheme.headline6!.copyWith(
                                        color: theme.colorScheme.primary)),
                              ),
                              flex: 12)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        collapsed: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(RadiusSize.kDialogCornerRadius),
                    topRight: Radius.circular(RadiusSize.kDialogCornerRadius))),
            child: Column(
              children: [
                const SizedBox(height: Space.small),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.all(
                              Radius.circular(RadiusSize.kDialogCornerRadius))),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(Space.large),
                  child: Text(
                    homeController.markLocaltionCurrent.value?.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headline5!
                        .copyWith(color: theme.colorScheme.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
                center: LatLng(10.780231, 106.6645121),
                onTap: (tapPosition, point) {
                  homeController.pageController.value.close();
                },
                onLongPress: (tapPosition, point) {
                  homeController.pageController.value.close();
                },
                onPositionChanged: ((position, hasGesture) {
                  homeController.pageController.value.close();
                }),
                zoom: 15,
                maxZoom: 17,
                minZoom: 4),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
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
                  showSearch(
                    context: context,
                    useRootNavigator: true,
                    delegate: SearchPage<ChargeCarModel>(
                      items: ChargeCarModel.getList(),
                      barTheme: Theme.of(context).copyWith(
                          appBarTheme: AppBarTheme(
                        color: Theme.of(context).dividerColor,
                      )),
                      searchLabel: 'Search charge car location ',
                      suggestion: Container(
                        color: Theme.of(context).cardColor,
                        child: const Center(
                          child: Text(
                              'Filter charge car location by name or address'),
                        ),
                      ),
                      failure: Container(
                        color: Theme.of(context).cardColor,
                        child: const Center(
                          child: Text('No charge car location found :('),
                        ),
                      ),
                      filter: (person) => [person.name, person.address],
                      onQueryUpdate: (s) {},
                      builder: (person) => InkWell(
                        onTap: (() {
                          Get.back();
                          homeController.moveLocation(person);
                        }),
                        child: ListTile(
                          title: Text(person.name!),
                          subtitle: Text(person.address!),
                          trailing: Text(person.bettwen!),
                        ),
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
                        borderRadius: BorderRadius.circular(
                            RadiusSize.kDialogCornerRadius),
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
      ),
    );
  }
}
