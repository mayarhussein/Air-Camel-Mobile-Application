import 'package:flutter/material.dart';

import 'address_bottom_sheet.dart';

class AddressItem extends StatelessWidget {
  final String id;
  final String city;
  final String street;
  final String building;
  final String floor;
  final String apt;

  AddressItem(this.id, this.city, this.street, this.building, this.floor, this.apt);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(street + ', ' + city),
      subtitle: Text('Building Number: ' + building),
      trailing: SizedBox(
        width: 100,
        child: Row(children: <Widget>[
          const Spacer(),
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                AddressBottomSheet.showAddressBottomSheet(context, true, id);
              },
              color: Theme.of(context).primaryColor),
        ]),
      ),
    );
  }
}
