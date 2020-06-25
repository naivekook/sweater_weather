import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_controller.dart';
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
              _TopBarWidget(),
              _SearchBarWidget(),
              Expanded(child: _CityListWidget())
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
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 0.0, left: 20.0, right: 20.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
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
      ),
    );
  }
}

class _SearchBarWidget extends StatelessWidget {
  final _debouncer = Debouncer(milliseconds: 500);
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 0.0, left: 20.0, right: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              autofocus: true,
              maxLines: 1,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: const Color(0xFF7F808C),
                ),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: const Color(0xFF7F808C),
                    ),
                    onPressed: () {
                      _controller.clear();
                    }),
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
              onChanged: (text) {
                _debouncer.run(() {
                  Provider.of<AddCityController>(context, listen: false)
                      .findByName(text);
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              Provider.of<AddCityController>(context, listen: false)
                  .findByCurrentLocation();
            },
          )
        ],
      ),
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
        final items = value.cityListItems();
        return ListView.separated(
          separatorBuilder: (context, index) => Divider(color: Colors.grey),
          itemCount: items.length,
          itemBuilder: (context, index) => ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(items[index].iconUrl),
              ],
            ),
            title: Text(items[index].title),
            onTap: () {
              Provider.of<AddCityController>(context, listen: false)
                  .addNewCity(items[index].city)
                  .then((value) => Navigator.pop(context));
            },
          ),
        );
      }
    });
  }
}
