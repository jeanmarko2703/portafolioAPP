
import 'dart:convert';

class Project {
    Project({
        // required this.features,
        required this.id,
        required this.title,
        required this.subtitle,
        required this.imageUrl,
        required this.v,
        required this.description,
        
        required this.url,
    });

    // List<String> features;
    String id;
    String title;
    String subtitle;
    String imageUrl;
    int v;
    String description;
    
    String url;

    factory Project.fromJson(String str) => Project.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Project.fromMap(Map<String, dynamic> json) => Project(
        // features: List<String>.from(json["features"].map((x) => x)),
        id: json["_id"],
        title: json["title"],
        subtitle: json["subtitle"],
        imageUrl: json["imageUrl"],
        v: json["__v"],
        description: json["description"],
        
        url: json["url"] == null ? 'false' : json["url"],
    );

    Map<String, dynamic> toMap() => {
        // "features": List<dynamic>.from(features.map((x) => x)),
        "_id": id,
        "title": title,
        "subtitle": subtitle,
        "imageUrl": imageUrl,
        "__v": v,
        "description": description,
       
        "url": url == null ? null : url,
    };
}
