import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_controller.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_list_item.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_list_tile.dart';
import 'package:sweaterweather/utils/debouncer.dart';

class AddCityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => AddCityController(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _TopBarWidget(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
                child: _SearchBarWidget(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 26, top: 20, right: 26, bottom: 0),
                  child: _CityListWidget(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: const Color(0xFF7F808C),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'Add location',
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: const Color(0xFF3D3F4E),
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800)),
        )
      ],
    );
  }
}

class _SearchBarWidget extends StatelessWidget {
  final _debouncer = Debouncer(milliseconds: 500);
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      final text = _controller.text;
      _debouncer.run(() {
        Provider.of<AddCityController>(context, listen: false).findByName(text);
      });
    });
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      autofocus: true,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        prefixIcon: Icon(
          Icons.search,
          color: const Color(0xFF7F808C),
        ),
        suffixIcon: ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, value, child) => Visibility(
            visible: (value as TextEditingValue).text.length > 0,
            child: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: const Color(0xFF7F808C),
                ),
                onPressed: () {
                  _controller.clear();
                }),
          ),
        ),
        hintText: 'Search for location',
        hintStyle: GoogleFonts.inter(
            textStyle: TextStyle(
                color: const Color(0xFF7F808C),
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal)),
        filled: true,
        fillColor: const Color(0xFFF5F6F7),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFFF5F6F7)),
          borderRadius: BorderRadius.circular(9.0),
        ),
      ),
      style: GoogleFonts.inter(
          textStyle: TextStyle(
              color: const Color(0xFF3D3F4E),
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal)),
    );
  }
}

class _CityListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddCityController>(builder: (context, value, child) {
      if (value.isProgress) {
        return Center(child: CircularProgressIndicator());
      } else {
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return false;
          },
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(color: Colors.white),
            itemCount: value.listItems.length,
            itemBuilder: (context, index) => AddCityListTile(
                value.listItems[index],
                (CityListItem item) =>
                    Provider.of<AddCityController>(context, listen: false).itemTapped(item)),
          ),
        );
      }
    });
  }
}
