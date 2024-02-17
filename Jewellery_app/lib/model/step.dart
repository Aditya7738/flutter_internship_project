class ExpansionListItemModel {
  ExpansionListItemModel(
    this.id,
    this.title,
    this.body,
    [this.isExpanded = false]
  );
  String id;
  String title;
  String body;
  bool isExpanded;
}