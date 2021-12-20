class PopularFilterListData {
  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;

  static List<PopularFilterListData> popularFList = <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: 'XXX',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'XXX',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'XXX',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'XXX',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'XXX ',
      isSelected: false,
    ),
  ];

  static List<PopularFilterListData> accomodationList = [
    PopularFilterListData(
      titleTxt: 'XXX',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'XXX',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'XXX',
      isSelected: true,
    ),
  ];
}
