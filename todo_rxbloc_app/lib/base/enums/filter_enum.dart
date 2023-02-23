enum FilterEnum {
  showAll(null),
  showActive(false),
  showCompleted(true);

  const FilterEnum(this.value);
  final bool? value;
}
