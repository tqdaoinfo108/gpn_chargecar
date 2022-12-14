import 'package:charge_car/pages/home/profile/language_page.dart';
import 'package:charge_car/pages/qr/qr_scanner_controller.dart';
import 'package:charge_car/services/model/parking.dart';
import 'package:charge_car/third_library/button_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
// ignore: library_prefixes
import 'package:map_launcher/map_launcher.dart' as MapLauncher;

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/dimens.dart';
import '../../third_library/search_page/search_page.dart';
import '../charging/charging_controller.dart';
import 'history_page.dart';
import 'notification_page.dart';
import 'profile/profile_page.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.history),
              label: 'history'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications),
              label: 'notification'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'setting'.tr,
            ),
          ],
          currentIndex: controller.pageCurrent.value,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).colorScheme.primary,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (s) => controller.onChangePageScreen(s),
          type: BottomNavigationBarType.fixed,
        ),
        body: [
          homeChildPageOne(
            context,
            controller,
          ),
          historyPage(context, controller),
          notificationPage(context, controller),
          profilePage(context, controller),
        ][controller.pageCurrent.value],
      ),
    );
  }
}

Widget homeChildPageOne(BuildContext context, HomeController controller) {
  var theme = Theme.of(context);

  return Obx(
    () => Stack(
      children: [
        SlidingUpPanel(
          renderPanelSheet: true,
          controller: controller.pageController.value,
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          color: Colors.transparent,
          minHeight: controller.markLocaltionCurrent.value == null ? 0 : 81,
          maxHeight: 251,
          onPanelSlide: ((position) {
            controller.fabHeight.value = position *
                    (251 -
                        (controller.markLocaltionCurrent.value == null
                            ? 0
                            : 81)) +
                100;
          }),
          panel: controller.markLocaltionCurrent.value == null
              ? const SizedBox()
              : MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.only(
                            topLeft:
                                Radius.circular(RadiusSize.kDialogCornerRadius),
                            topRight: Radius.circular(
                                RadiusSize.kDialogCornerRadius))),
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
                                      Radius.circular(
                                          RadiusSize.kDialogCornerRadius))),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(Space.large),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.markLocaltionCurrent.value
                                        ?.nameParking ??
                                    "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.headline5!.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: Space.large),
                              Text(
                                  controller.markLocaltionCurrent.value
                                          ?.addressParking ??
                                      "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyText1!.copyWith(
                                      color: theme.colorScheme.primary)),
                              const SizedBox(height: Space.medium),
                              Text(
                                "${'Phone'.tr}: ${controller.markLocaltionCurrent.value!.phoneParking}",
                                style: theme.textTheme.bodyText1!
                                    .copyWith(color: theme.colorScheme.primary),
                              ),
                              const SizedBox(height: Space.medium),
                              Text(
                                  "${'power_socket_available'.tr}: ${controller.markLocaltionCurrent.value!.powerSocketAvailable}",
                                  style: theme.textTheme.bodyText1!.copyWith(
                                      color: theme.colorScheme.primary)),
                              const SizedBox(height: Space.medium),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: DefaultButtonWidthDynamic(
                                      backgroundColor: theme.colorScheme.primary
                                          .withOpacity(0.2),
                                      widget: const Icon(Icons.open_with),
                                      press: () async {
                                        final availableMaps = await MapLauncher
                                            .MapLauncher.installedMaps;
                                        if (availableMaps.isEmpty) {
                                          EasyLoading.showToast(
                                              'maps_app_not_found'.tr);
                                          return;
                                        }
                                        await availableMaps.first.showMarker(
                                          coords: MapLauncher.Coords(
                                              controller.markLocaltionCurrent
                                                  .value!.getLatLng.latitude,
                                              controller.markLocaltionCurrent
                                                  .value!.getLatLng.longitude),
                                          title: controller.markLocaltionCurrent
                                              .value!.nameParking!,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: Space.medium),
                                  Expanded(
                                    flex: 3,
                                    child: DefaultButtonWidthDynamic(
                                      press: () async {
                                        final Uri launchUri = Uri(
                                            scheme: 'tel',
                                            path: controller
                                                .markLocaltionCurrent
                                                .value!
                                                .phoneParking);
                                        await launchUrl(launchUri);
                                      },
                                      backgroundColor: theme.colorScheme.primary
                                          .withOpacity(0.2),
                                      widget: const Icon(Icons.phone),
                                    ),
                                  ),
                                  const SizedBox(width: Space.medium),
                                  Expanded(
                                      flex: 12,
                                      child: DefaultButtonWidthDynamic(
                                        backgroundColor: theme.primaryColor,
                                        press: () async {
                                          var result = await Get.toNamed("/qr",
                                              arguments: {
                                                "parkingID": controller
                                                    .markLocaltionCurrent
                                                    .value!
                                                    .parkingID
                                              });
                                          if (result != null) {
                                            await Get.delete<
                                                QRScannerPageController>();
                                            var result2 = await Get.toNamed(
                                                "/charging",
                                                arguments: result);
                                            if (result2 != null) {
                                              if (result2["page"] != null &&
                                                  result2["page"] != "") {
                                                EasyLoading.show();
                                                controller.onChangePageScreen(
                                                    int.parse(
                                                        result2["page"]!));
                                                await controller
                                                    .getListBookingDetail();
                                                EasyLoading.dismiss();
                                              }
                                            }
                                          }
                                        },
                                        widget: Text('booking'.tr,
                                            style: theme.textTheme.headline6!
                                                .copyWith(color: Colors.white)),
                                      ))
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
                      topRight:
                          Radius.circular(RadiusSize.kDialogCornerRadius))),
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
                                Radius.circular(
                                    RadiusSize.kDialogCornerRadius))),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Space.large),
                    child: Text(
                      controller.markLocaltionCurrent.value?.nameParking ?? "",
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
              mapController: controller.mapController.value,
              options: MapOptions(
                  keepAlive: true,
                  center: controller.lstMarkLocaltion.length > 0
                      ? controller.lstMarkLocaltion[0].point
                      : LatLng(0, 0),
                  onTap: (tapPosition, point) {
                    controller.pageController.value.close();
                  },
                  onLongPress: (tapPosition, point) {
                    controller.pageController.value.close();
                  },
                  onPositionChanged: ((position, hasGesture) {
                    controller.pageController.value.close();
                  }),
                  zoom: 15,
                  maxZoom: 17,
                  minZoom: 4),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/tranquocdao108/cl7ej62u7000015mt54hc1a1c/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidHJhbnF1b2NkYW8xMDgiLCJhIjoiY2swZjQ2dWxzMDcwNTNtbXh1OXVwbGwyayJ9.zd_7KBxex95xUOMBJl7ISA",
                ),
                MarkerLayerOptions(markers: controller.lstMarkLocaltion),
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
                      delegate: SearchPage<ParkingModel>(
                        showItemsOnEmpty: true,
                        items: controller.homeData.value.listParking ?? [],
                        barTheme: Theme.of(context).copyWith(
                            appBarTheme: AppBarTheme(
                          color: Theme.of(context).dividerColor,
                        )),
                        searchLabel: 'search'.tr,
                        suggestion: Container(
                          color: Theme.of(context).cardColor,
                          child: Center(
                            child: Text('filter_name_or_address'.tr),
                          ),
                        ),
                        failure: Container(
                          color: Theme.of(context).cardColor,
                          child: Center(
                            child: Text('data_not_found'.tr),
                          ),
                        ),
                        filter: (parking) =>
                            [parking.nameParking, parking.addressParking],
                        onQueryUpdate: (s) {},
                        builder: (parking) => InkWell(
                          onTap: (() {
                            Get.back();
                            controller.moveLocation(parking);
                          }),
                          child: ListTile(
                            title: Text(parking.nameParking!),
                            subtitle: Text(parking.addressParking!),
                            trailing: Text("${parking.distance} km"),
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
                            title: Text(
                              'search'.tr,
                              style: Theme.of(context).textTheme.bodyText1,
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
        // the fab
        Positioned(
          right: 20.0,
          bottom: controller.markLocaltionCurrent.value == null ? 20 : controller.fabHeight.value,
          child: FloatingActionButton(
            // ignore: sort_child_properties_last
            child: Icon(
              Icons.qr_code_scanner,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () async {
              var result =
                  await Get.toNamed("/qr", arguments: {"parkingID": -100});
              if (result != null) {
                await Get.delete<QRScannerPageController>();
                await Get.delete<ChargingPageController>();
                var result2 = await Get.toNamed("/charging", arguments: result);
                if (result2 != null) {
                  if (result2["page"] != null && result2["page"] != "") {
                    EasyLoading.show();
                    controller.onChangePageScreen(int.parse(result2["page"]!));
                    await controller.getListBookingDetail();
                    EasyLoading.dismiss();
                  }
                }
              }
            },
            backgroundColor: theme.scaffoldBackgroundColor,
          ),
        ),
      ],
    ),
  );
}
