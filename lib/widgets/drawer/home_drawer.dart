import 'package:air_camel/constants.dart';
import 'package:air_camel/models/account.dart';
import 'package:air_camel/models/drawer/drawer_list.dart';
import 'package:air_camel/resources/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:air_camel/providers/accounts_provider.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.Credit,
        labelName: 'Credit & Payments',
        icon: Icon(Icons.credit_card_rounded),
      ),
      DrawerList(
        index: DrawerIndex.Offers,
        labelName: 'Offers',
        icon: Icon(Icons.wallet_giftcard),
      ),
      DrawerList(
        index: DrawerIndex.Invite,
        labelName: 'Invite Friend',
        icon: Icon(Icons.group),
      ),
      DrawerList(
        index: DrawerIndex.Help,
        labelName: 'Help',
        icon: Icon(Icons.help),
      ),
      DrawerList(
        index: DrawerIndex.About,
        labelName: 'About Us',
        icon: Icon(Icons.info),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Receiving the arguments
    final accountID = ModalRoute.of(context)!.settings.arguments as String;
    print(accountID);

    // LISTENER
    //AccountProvider account = Provider.of<AccountsProvider>(context, listen: false).findById(accountID);

    //print(account);

    Account? account = Provider.of<AccountsProvider>(context).account;

    String firstName = account!.firstName;
    String lastName = account.lastName;
    String? image = account.image;

    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(1.0 -
                            (widget.iconAnimationController!.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController!,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.3,
                            width: MediaQuery.of(context).size.height * 0.16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(60.0)),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                )
                                //Image.asset(image.toString())
                                ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 4),
                    child: Text(
                      firstName + ' ' + lastName,
                      style: headFontBig1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList![index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Sign Out',
                  style: defaultFont1,
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  ;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  void onTapped() {
    print('Doing Something...'); // Print to console.
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color:
                          // widget.screenIndex == listData.index ? Colors.blue :
                          Colors.transparent,
                      borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? Colors.amber.shade600
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color:
                              //  widget.screenIndex == listData.index  ? Colors.blue :
                              AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: defaultFont1,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        // child: Padding(
                        //   padding: EdgeInsets.only(top: 8, bottom: 8),
                        //   child: Container(
                        //     width:
                        //         MediaQuery.of(context).size.width * 0.75 - 64,
                        //     height: 46,
                        //     decoration: BoxDecoration(
                        //       color: Colors.amber.withOpacity(0.2),
                        //       borderRadius: new BorderRadius.only(
                        //         topLeft: Radius.circular(0),
                        //         topRight: Radius.circular(28),
                        //         bottomLeft: Radius.circular(0),
                        //         bottomRight: Radius.circular(28),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}
