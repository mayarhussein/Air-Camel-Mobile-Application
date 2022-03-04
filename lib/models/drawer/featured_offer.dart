class FeaturedOfferModel {
  String? id;
  int idCompany;
  DateTime dateTime;
  DateTime expireTime;
  String offerMsg;

  FeaturedOfferModel({
    this.id,
    required this.idCompany,
    required this.dateTime,
    required this.expireTime,
    required this.offerMsg,
  });

  static List<FeaturedOfferModel> featuredOffersList = <FeaturedOfferModel>[
    FeaturedOfferModel(
      idCompany: 0,
      dateTime: DateTime.now().subtract(Duration(days: 5)),
      expireTime: DateTime.now().subtract(Duration(days: 5)),
      offerMsg: "Featured Offer 1",
    ),
    FeaturedOfferModel(
      idCompany: 0,
      dateTime: DateTime.now().subtract(Duration(days: 3)),
      expireTime: DateTime.now().subtract(Duration(days: 3)),
      offerMsg: "Featured Offer 2",
    ),
    FeaturedOfferModel(
      idCompany: 0,
      dateTime: DateTime.now().subtract(Duration(days: 1)),
      expireTime: DateTime.now().subtract(Duration(days: 1)),
      offerMsg: "Featured Offer 3",
    ),
    FeaturedOfferModel(
      idCompany: 0,
      dateTime: DateTime.now(),
      expireTime: DateTime.now(),
      offerMsg: "Featured Offer 4",
    ),
    FeaturedOfferModel(
      idCompany: 0,
      dateTime: DateTime.now().subtract(Duration(days: 9)),
      expireTime: DateTime.now().subtract(Duration(days: 9)),
      offerMsg: "Featured Offer 5",
    ),
  ];
}
