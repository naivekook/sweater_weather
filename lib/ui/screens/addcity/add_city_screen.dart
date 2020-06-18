import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweaterweather/ui/screens/addcity/add_city_controller.dart';
import 'package:sweaterweather/utils/debouncer.dart';

class AddCityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => AddCityController(),
          child: Column(
            children: <Widget>[_SearchBarWidget(), Expanded(child: _CityListWidget())],
          ),
        ),
      ),
    );
  }
}

class _SearchBarWidget extends StatelessWidget {
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: TextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            autofocus: true,
            maxLines: 1,
            decoration: const InputDecoration(
              hintText: 'Enter city name',
            ),
            onChanged: (text) {
              _debouncer.run(() {
                Provider.of<AddCityController>(context, listen: false).findByName(text);
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.my_location),
          onPressed: () {
            Provider.of<AddCityController>(context, listen: false).findByCurrentLocation();
          },
        )
      ],
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
