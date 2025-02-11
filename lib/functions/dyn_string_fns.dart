List<String> stringListFromDynamic(List<dynamic>? list) {
  if (list == null) return [];
  return list.map((e) => e.toString()).toList();
}
