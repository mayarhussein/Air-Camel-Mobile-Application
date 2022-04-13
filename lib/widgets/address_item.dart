import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  final String city;
  final String street;
  final String building;
  final String floor;
  final String apt;
  Function showMenu;

  AddressItem(this.showMenu, this.city, this.street, this.building, this.floor,
      this.apt);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(street + ', '+ city),
      subtitle: Text('Building Number: ' + building ),
      trailing: SizedBox(
        width: 100,
        child: Row(children: <Widget>[
          const Spacer(),
          IconButton(
              icon:const Icon(Icons.edit),
              onPressed: () {
                showMenu();
              },
              color: Theme.of(context).primaryColor),
        ]),
      ),
    );
  }
}
