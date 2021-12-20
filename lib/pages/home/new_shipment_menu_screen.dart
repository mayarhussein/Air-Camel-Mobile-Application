import 'package:air_camel/models/company_data_list.dart';
import 'package:air_camel/resources/app_theme.dart';
import 'package:air_camel/widgets/home/home_app_bar.dart';
import 'package:air_camel/widgets/home/home_filter_bar.dart';
import 'package:air_camel/widgets/home/home_list_view.dart';
import 'package:air_camel/widgets/home/home_search_bar.dart';
import 'package:air_camel/widgets/home/home_time_date.dart';
import 'package:flutter/material.dart';

class NewShipmentMenu extends StatefulWidget {
  @override
  _NewShipmentMenuState createState() => _NewShipmentMenuState();

  static const routeName = "/new-shipment-menu";
}

class _NewShipmentMenuState extends State<NewShipmentMenu>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<CompanyDataList> companyList = CompanyDataList.companyList;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
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
                                    HomeSearchBar(),
                                    HomeTimeDate(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: ContestTabHeader(
                                HomeFilterBar(),
                              ),
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
                                callback: () {},
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
