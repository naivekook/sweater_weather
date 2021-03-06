import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/app_router.dart';
import 'package:sweaterweather/models/city_with_palette.dart';
import 'package:sweaterweather/ui/screens/home/home_controller.dart';
import 'package:sweaterweather/ui/screens/home/location_list_item.dart';
import 'package:sweaterweather/ui/widgets/rainbow_spinner_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LoaderOverlay(
          overlayWidget: Center(
            child: RainbowSpinnerWidget(),
          ),
          overlayColor: Colors.white,
          overlayOpacity: 0.9,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                _TopBarWidget(),
                Expanded(
                  child: _CityListWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 20, right: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'My locations',
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: const Color(0xFF3D3F4E),
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800)),
            ),
          ),
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        'Find location',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: const Color(0xFF3D3F4E),
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text(
                        'Refresh',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: const Color(0xFF3D3F4E),
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Text(
                        'About',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: const Color(0xFF3D3F4E),
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal)),
                      ),
                    ),
                  ],
              onSelected: (value) async {
                switch (value) {
                  case 1:
                    await Navigator.pushNamed(context, AppRouter.ADD_CITY);
                    Provider.of<HomeController>(context, listen: false).refresh(false);
                    break;
                  case 2:
                    Provider.of<HomeController>(context, listen: false).refresh(true);
                    break;
                  case 3:
                    Navigator.pushNamed(context, AppRouter.ABOUT);
                    break;
                }
              }),
        ],
      ),
    );
  }
}

class _CityListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController value, Widget child) {
        if (value.inProgress) {
          context.showLoaderOverlay();
        } else {
          context.hideLoaderOverlay();
        }
        final items = value.weatherTiles;
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          separatorBuilder: (context, index) => Divider(color: Colors.white),
          itemCount: items.length,
          itemBuilder: (context, index) => GestureDetector(
              child: _CityListItemWidget(items[index]),
              onTap: () {
                final arguments = CityWithPalette(items[index].city, items[index].palette);
                Navigator.pushNamed(context, AppRouter.WEATHER, arguments: arguments);
              }),
        );
      },
    );
  }
}

class _CityListItemWidget extends StatelessWidget {
  final LocationListItem data;

  _CityListItemWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      decoration: BoxDecoration(
        color: Color(data.palette.backgroundColor),
        borderRadius: BorderRadius.all(const Radius.circular(8)),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: Image.asset(data.image),
          ),
          Visibility(
            visible: data.isFromLocation,
            child: Container(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset("assets/icons/ic_location.png"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 27.0),
            child: Row(
              children: <Widget>[
                Text(
                  '${data.temp}°',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: Color(data.palette.primaryColor),
                          fontSize: 52,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800)),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data.city.name,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: Color(data.palette.primaryColor),
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w800)),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 150,
                        child: Text(
                          data.weatherDescription,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: Color(data.palette.secondaryColor),
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
