abstract class IConverter<T> {
  T fromMap(Map<String, dynamic> map);
  T fromJson(String jsonData);

  Map<String, dynamic> toMap(T meal);
  String toJson(T meal);
  
  List<T> getList(List<dynamic> data);
}
