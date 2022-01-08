import 'package:air_camel/others/tab_clipper.dart';
import 'package:air_camel/resources/app_theme.dart';
import 'package:air_camel/widgets/bottom_bar/tab_icons.dart';
import 'package:flutter/material.dart';
import 'package:air_camel/models/bottom_navigation/bottom_bar_model.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView(
      {Key? key, this.tabIconsList, this.changeIndex, this.addClick})
      : super(key: key);

  final Function(int index)? changeIndex;
  final Function()? addClick;
  final List<TabIconData>? tabIconsList;
  @override
  _BottomBarViewState createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1),
    );
    animationController?.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return PhysicalShape(
              color: AppTheme.white,
              elevation: 16.0,
              clipper: TabClipper(
                  radius: Tween<double>(begin: 0.0, end: 1.0)
                          .animate(CurvedAnimation(
                              parent: animationController!,
                              curve: Curves.fastOutSlowIn))
                          .value *
                      38.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 62,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TabIcons(
                                tabIconData: widget.tabIconsList?[0],
                                removeAllSelect: () {
                                  setRemoveAllSelection(
                                      widget.tabIconsList?[0]);
                                  widget.changeIndex!(0);
                                }),
                          ),
                          Expanded(
                            child: TabIcons(
                                tabIconData: widget.tabIconsList?[1],
                                removeAllSelect: () {
                                  setRemoveAllSelection(
                                      widget.tabIconsList?[1]);
                                  widget.changeIndex!(1);
                                }),
                          ),
                          SizedBox(
                            width: Tween<double>(begin: 0.0, end: 1.0)
                                    .animate(CurvedAnimation(
                                        parent: animationController!,
                                        curve: Curves.fastOutSlowIn))
                                    .value *
                                64.0,
                          ),
                          Expanded(
                            child: TabIcons(
                                tabIconData: widget.tabIconsList?[2],
                                removeAllSelect: () {
                                  setRemoveAllSelection(
                                      widget.tabIconsList?[2]);
                                  widget.changeIndex!(2);
                                }),
                          ),
                          Expanded(
                            child: TabIcons(
                                tabIconData: widget.tabIconsList?[3],
                                removeAllSelect: () {
                                  setRemoveAllSelection(
                                      widget.tabIconsList?[3]);
                                  widget.changeIndex!(3);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  )
                ],
              ),
            );
          },
        ),
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: SizedBox(
            width: 38 * 2.0,
            height: 38 + 62.0,
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.transparent,
              child: SizedBox(
                width: 38 * 2.0,
                height: 38 * 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // alignment: Alignment.center,s
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      gradient: LinearGradient(colors: [
                        Colors.white,
                        Colors.amber,
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.amber.withOpacity(0.4),
                            offset: const Offset(8.0, 16.0),
                            blurRadius: 16.0),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.white.withOpacity(0.1),
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: widget.addClick,
                        child: Icon(
                          Icons.add,
                          color: AppTheme.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void setRemoveAllSelection(TabIconData? tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList?.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData!.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}
