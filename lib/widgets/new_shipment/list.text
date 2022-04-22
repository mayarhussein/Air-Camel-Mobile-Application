// import 'package:air_camel/resources/app_theme.dart';
// import 'package:air_camel/widgets/new_shipment/list_view.dart';
// import 'package:flutter/material.dart';

// class HomeList extends StatefulWidget {
//   @override
//   State<HomeList> createState() => _HomeListState();
// }

// class _HomeListState extends State<HomeList> with TickerProviderStateMixin {
//   List<CompanyDataList> companyList = CompanyDataList.companyList;

//   AnimationController? animationController;

//   @override
//   void initState() {
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 1000), vsync: this);
//   }

//   @override
//   void dispose() {
//     animationController?.dispose();
//   }

//   Future<bool> getData() async {
//     await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppTheme.buildLightTheme().backgroundColor,
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               offset: const Offset(0, -2),
//               blurRadius: 8.0),
//         ],
//       ),
//       child: Column(
//         children: <Widget>[
//           Container(
//             height: MediaQuery.of(context).size.height - 156 - 50,
//             child: FutureBuilder<bool>(
//               future: getData(),
//               builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//                 if (!snapshot.hasData) {
//                   return const SizedBox();
//                 } else {
//                   return ListView.builder(
//                     itemCount: companyList.length,
//                     scrollDirection: Axis.vertical,
//                     itemBuilder: (BuildContext context, int index) {
//                       final int count =
//                           companyList.length > 10 ? 10 : companyList.length;
//                       final Animation<double> animation =
//                           Tween<double>(begin: 0.0, end: 1.0).animate(
//                               CurvedAnimation(
//                                   parent: animationController!,
//                                   curve: Interval((1 / count) * index, 1.0,
//                                       curve: Curves.fastOutSlowIn)));
//                       animationController?.forward();

//                       return HomeListView(
//                         callback: () {},
//                         companyData: companyList[index],
//                         animation: animation,
//                         animationController: animationController!,
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
