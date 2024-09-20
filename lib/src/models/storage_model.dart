class Storage{
  final String id;
  final String url;
  final String filename;

  Storage({required this.id, required this.url, required this.filename});

  factory Storage.fromJson(Map<String,dynamic>json){
    return Storage(
      id: json['_id'], 
      url: json['url'], 
      filename: json['filename']);
  }
}