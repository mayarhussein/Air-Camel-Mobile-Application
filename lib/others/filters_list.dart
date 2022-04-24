class FilterListData {
  String titleTxt;
  bool isSelected;

  FilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  static List<FilterListData> filtersList = <FilterListData>[
    FilterListData(
      titleTxt: 'Regular',
      isSelected: false,
    ),
    FilterListData(
      titleTxt: 'Fragile',
      isSelected: false,
    ),
    FilterListData(
      titleTxt: 'Large',
      isSelected: false,
    ),
    FilterListData(
      titleTxt: 'Medecine',
      isSelected: false,
    ),
    FilterListData(
      titleTxt: 'Food',
      isSelected: false,
    ),
  ];
}
