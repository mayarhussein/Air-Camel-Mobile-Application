import 'package:air_camel/constants.dart';
import 'package:air_camel/widgets/address_bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:uuid/uuid.dart';

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
 //final _isEdit = true;

  Future<void> _deleteAddress(String userId, String docId) async {
    final addressData = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('address');

    await addressData
        .doc(docId)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference addressData = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('address');
    return ChangeNotifierProvider(
        create: (_) => AddressProvider(),
        child: StreamBuilder<QuerySnapshot>(
            stream: addressData.snapshots(),
            builder: (ctx, addressSanpshot) {
              if (addressSanpshot.data == null) {
                return SplashScreen();
              }
              List<AddressModel> addressList =
                  addressSanpshot.data!.docs.map((item) {
                Timestamp stamp = item['dateTime'];
                return AddressModel(
                    id: item['id'],
                    idAccount: item['idAccount'],
                    dateTime: DateTime.parse(stamp.toDate().toString()),
                    city: item['city'],
                    street: item['street'],
                    building: item['building'],
                    floor: item['floor'],
                    apt: item['apt'],
                    other: item['description']);
              }).toList();
              Provider.of<AddressProvider>(ctx).setAddress(addressList);
              final addressData = Provider.of<AddressProvider>(ctx);

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
                            AddressBottomSheet.showAddressBottomSheet(context,false, ''); },
                        icon: const Icon(Icons.add))
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                      itemCount: addressData.address.length,
                      itemBuilder: (context, i) {
                        return Slidable(
                          child: AddressItem(
                              addressData.address[i].id,
                              addressData.address[i].city,
                              addressData.address[i].street,
                              addressData.address[i].building,
                              addressData.address[i].floor,
                              addressData.address[i].apt),
                          //key: const ValueKey(0),
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    _deleteAddress(
                                        user.uid, addressData.address[i].id);
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
            }));
  }
}
