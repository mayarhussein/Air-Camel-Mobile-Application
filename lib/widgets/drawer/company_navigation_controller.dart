import 'package:air_camel/models/bottom_navigation/bottom_bar_model.dart';
import 'package:air_camel/models/drawer/drawer_list.dart';
import 'package:air_camel/widgets/drawer/home_drawer.dart';
import 'package:air_camel/resources/app_theme.dart';
import 'package:flutter/material.dart';

class CompanyNavigationController extends StatefulWidget {
  const CompanyNavigationController({
    Key? key,
    this.drawerWidth = 250,
    this.onDrawerCall,
    this.screenView,
    this.animatedIconData = AnimatedIcons.arrow_menu,
    this.menuView,
    this.drawerIsOpen,
    this.screenIndex,
  }) : super(key: key);

  final double drawerWidth;
  final Function(DrawerIndex)? onDrawerCall;
  final Widget? screenView;
  final Function(bool)? drawerIsOpen;
  final AnimatedIconData? animatedIconData;
  final Widget? menuView;
  final DrawerIndex? screenIndex;

  @override
  _CompanyNavigationControllerState createState() =>
      _CompanyNavigationControllerState();
}

class _CompanyNavigationControllerState
    extends State<CompanyNavigationController> with TickerProviderStateMixin {
  ScrollController? scrollController;
  AnimationController? iconAnimationController;
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  double scrolloffset = 0.0;
  // List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    iconAnimationController?.animateTo(1.0,
        duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController!.addListener(() {
      if (scrollController!.offset <= 0) {
        if (scrolloffset != 1.0) {
          setState(() {
            scrolloffset = 1.0;
            try {
              widget.drawerIsOpen!(true);
            } catch (_) {}
          });
        }
        iconAnimationController?.animateTo(0.0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      } else if (scrollController!.offset > 0 &&
          scrollController!.offset < widget.drawerWidth.floor()) {
        iconAnimationController?.animateTo(
            (scrollController!.offset * 100 / (widget.drawerWidth)) / 100,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      } else {
        if (scrolloffset != 0.0) {
          setState(() {
            scrolloffset = 0.0;
            try {
              widget.drawerIsOpen!(false);
            } catch (_) {}
          });
        }
        iconAnimationController?.animateTo(1.0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      }
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) => getInitState());
    super.initState();
  }

  Future<bool> getInitState() async {
    scrollController?.jumpTo(
      widget.drawerWidth,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          //we use with as screen width and add drawerWidth (from navigation_home_screen)
          child: Row(
            children: <Widget>[
              SizedBox(
                width: widget.drawerWidth,
                //we divided first drawer Width with HomeDrawer and second full-screen Width with all home screen, we called screen View
                height: MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: iconAnimationController!,
                  builder: (BuildContext context, Widget? child) {
                    return HomeDrawer(
                      screenIndex: widget.screenIndex == null
                          ? DrawerIndex.HOME
                          : widget.screenIndex,
                      iconAnimationController: iconAnimationController,
                      callBackIndex: (DrawerIndex indexType) {
                        onDrawerClick();
                        try {
                          widget.onDrawerCall!(indexType);
                        } catch (e) {}
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                //full-screen Width with widget.screenView
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.6),
                          blurRadius: 24),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      //this IgnorePointer we use as touch(user Interface) widget.screen View, for example scrolloffset == 1 means drawer is close we just allow touching all widget.screen View
                      //alternative touch(user Interface) for widget.screen, for example, drawer is close we need to tap on a few home screen area and close the drawer
                      if (scrolloffset == 1.0)
                        InkWell(
                          onTap: () {
                            onDrawerClick();
                          },
                        ),
                      // this just menu and arrow icon animation
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 8,
                            left: 8),
                        child: SizedBox(
                          width: AppBar().preferredSize.height - 8,
                          height: AppBar().preferredSize.height - 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                  AppBar().preferredSize.height),
                              child: Center(
                                // if you use your own menu view UI you add form initialization
                                child: widget.menuView != null
                                    ? widget.menuView
                                    : AnimatedIcon(
                                        icon: widget.animatedIconData ??
                                            AnimatedIcons.arrow_menu,
                                        progress: iconAnimationController!),
                              ),
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                onDrawerClick();
                              },
                            ),
                          ),
                        ),
                      ),
                      IgnorePointer(
                        ignoring: scrolloffset == 1,
                        child: widget.screenView,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget bottomBar() {
  //   return Column(
  //     children: <Widget>[
  //       const Expanded(
  //         child: SizedBox(),
  //       ),
  //       BottomBarView(
  //         tabIconsList: tabIconsList,
  //         addClick: () {},
  //         changeIndex: (int index) {
  //           if (index == 0 || index == 2) {
  //             animationController?.reverse().then<dynamic>((data) {
  //               if (!mounted) {
  //                 return;
  //               }
  //               setState(() {
  //                 // tabBody =
  //                 //     MyDiaryScreen(animationController: animationController);
  //               });
  //             });
  //           } else if (index == 1 || index == 3) {
  //             animationController?.reverse().then<dynamic>((data) {
  //               if (!mounted) {
  //                 return;
  //               }
  //               setState(() {
  //                 // tabBody =
  //                 //     TrainingScreen(animationController: animationController);
  //               });
  //             });
  //           }
  //         },
  //       ),
  //     ],
  //   );
  // }

  void onDrawerClick() {
    //if scrollcontroller.offset != 0.0 then we set to closed the drawer(with animation to offset zero position) if is not 1 then open the drawer
    if (scrollController!.offset != 0.0) {
      scrollController?.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController?.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
