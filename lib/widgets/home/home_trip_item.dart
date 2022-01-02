import 'package:air_camel/pages/home/trip_detail_screen.dart';
import 'package:air_camel/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:air_camel/models/company_data_list.dart';
import 'package:air_camel/widgets/home/home_list_view.dart';

class HomeTripItem extends StatelessWidget {
  final CompanyDataList? companyData;

  HomeTripItem(this.companyData);

  @override
  Widget build(BuildContext context) {
    return InkWell(
       onTap: () => Navigator.of(context).pushNamed(TripDetailsScreen.routeName),
       splashColor: Colors.red,
              highlightColor: Colors.white.withOpacity(0.2),

      child: Container(
        color: AppTheme.buildLightTheme().backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "xx",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "xx",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'xx',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: <Widget>[
                            RatingBar(
                              initialRating: companyData!.rating,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 24,
                              ratingWidget: RatingWidget(
                                full: Icon(
                                  Icons.star_rate_rounded,
                                  color: AppTheme.buildLightTheme().primaryColor,
                                ),
                                half: Icon(
                                  Icons.star_half_rounded,
                                  color: AppTheme.buildLightTheme().primaryColor,
                                ),
                                empty: Icon(
                                  Icons.star_border_rounded,
                                  color: AppTheme.buildLightTheme().primaryColor,
                                ),
                              ),
                              itemPadding: EdgeInsets.zero,
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "xx",
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
