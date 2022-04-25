import 'dart:io';

import 'package:air_camel/models/account.dart';
import 'package:air_camel/providers/companies_provider.dart';
import 'package:air_camel/resources/app_theme.dart';
import 'package:air_camel/widgets/home/app_bar.dart';
import 'package:air_camel/widgets/new_shipment/filter_bar.dart';
import 'package:air_camel/widgets/new_shipment/list_view.dart';
import 'package:air_camel/widgets/new_shipment/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/new_shipment/package_image_picker.dart';
import 'filters_screen.dart';

class NewShipmentMenu extends StatefulWidget {
  @override
  _NewShipmentMenuState createState() => _NewShipmentMenuState();

  static const routeName = "/new-shipment-menu";
}

class _NewShipmentMenuState extends State<NewShipmentMenu>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  late List<Account> companyList;
  final ScrollController _scrollController = ScrollController();
  String date = "";
  DateTime selectedDate = DateTime.now();
  var result;

  File? _packageImageFile;

  @override
  void initState() {
    final companiesData =
        Provider.of<CompaniesProvider>(context, listen: false);
    companyList = companiesData.companiesList;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  void _pickedImage(File image) {
    _packageImageFile = image;
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    HomeAppBar(),
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    PackageImagePicker(_pickedImage),
                                    HomeSearchBar('Choose pickup location '),
                                    HomeSearchBar(
                                        'Choose destination location'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {
                                            _selectDate(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.amber),
                                          child: const Text("Pick Date"),
                                        ),
                                        const Icon(Icons.date_range),
                                        Text(
                                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                                      ],
                                    ),
                                    const Divider(),
                                    //HomeTimeDate(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: ContestTabHeader(
                                  //FilterBar(companyList.length),
                                  filterBar()),
                            ),
                          ];
                        },
                        body: Container(
                          color: AppTheme.buildLightTheme().backgroundColor,
                          child: ListView.builder(
                            itemCount: companyList.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final int count = companyList.length > 10
                                  ? 10
                                  : companyList.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                              animationController?.forward();

                              return HomeListView(
                                callback: () {
                                  print(companyList[index].firstName);
                                },
                                companyData: companyList[index],
                                animation: animation,
                                animationController: animationController!,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filterBar() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: AppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: AppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ' ${companyList.length} companies found',
                      style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () async {
                      // Navigator.push returns a Future that completes after calling Navigator.pop on the Filters Screen.
                      FocusScope.of(context).requestFocus(FocusNode());
                      result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FiltersScreen(),
                              fullscreenDialog: true));
                      setState(() {
                        companyList = Provider.of<CompaniesProvider>(context,
                                listen: false)
                            .setFilter(result);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          const Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.sort,
                              color: Colors.amber.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  Widget getCompanyViewList() {
    final List<Widget> companyListViews = <Widget>[];
    for (int i = 0; i < companyList.length; i++) {
      final int count = companyList.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      companyListViews.add(
        HomeListView(
          callback: () {},
          companyData: companyList[i],
          animation: animation,
          animationController: animationController!,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: companyListViews,
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
