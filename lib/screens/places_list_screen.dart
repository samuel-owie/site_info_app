import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/great_places.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
          },
        )
      ],),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
        ? Center(child: CircularProgressIndicator(),)
        : Consumer<GreatPlaces>(
          child: Center(child: const Text('Got not places yet, start adding some!'),
          ),
          builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
          ? ch
          : ListView.builder(
            itemCount: greatPlaces.items.length,
            itemBuilder: (ctx, index) => ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(greatPlaces.items[index].image),
              ),
              title: Text(greatPlaces.items[index].title),
              onTap: () {
                //to detail page
              },
            ),
          ),
        ),
      ),
    );
  }
}