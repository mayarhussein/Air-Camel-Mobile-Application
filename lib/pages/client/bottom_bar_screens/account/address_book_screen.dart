import 'package:air_camel/constants.dart';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:air_camel/widgets/address_bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../../models/address.dart';
import '../../../../providers/address_provider.dart';
import '../../../../widgets/address_item.dart';
import '../../../launch_app/splash_screen.dart';

class AddressBook extends StatefulWidget {
  AddressBook({Key? key}) : super(key: key);

  @override
  State<AddressBook> createState() => _AddressBookState();
  static const routeName = '/address_book';
}

class _AddressBookState extends State<AddressBook> {
  List<AddressModel>? addressData;

  Future<void> _deleteAddress(String userId, String docId) async {
    final addressData = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('address');

    await addressData.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountsProvider>(context).account!;
    addressData = Provider.of<AddressProvider>(context).address;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Address Book",
          style: headFont1,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: bgColor,
        elevation: 0,
        shadowColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                AddressBottomSheet.showAddressBottomSheet(context, false, '');
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        color: bgColor,
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: addressData!.length,
            itemBuilder: (context, i) {
              return Slidable(
                child: AddressItem(
                    addressData![i].id,
                    addressData![i].city,
                    addressData![i].street,
                    addressData![i].building,
                    addressData![i].floor,
                    addressData![i].apt),
                //key: const ValueKey(0),
                endActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      _deleteAddress(user.id!, addressData![i].id);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ]),
              );
            }),
      ),
    );
  }
}
