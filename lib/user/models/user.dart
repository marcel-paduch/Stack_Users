import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User extends Equatable {
  const User(
      {required this.id,
      required this.name,
      required this.avatar,
      required this.location,
      required this.age,
      this.isLiked = false});

  @JsonKey(name: 'account_id')
  final int id;
  @JsonKey(name: 'display_name')
  final String name;
  @JsonKey(name: 'profile_image')
  final String avatar;
  @JsonKey(name: 'location')
  final String location;
  @JsonKey(name: 'age')
  final int age;
  final bool isLiked;

  User copyWith({
    int? id,
    String? name,
    String? avatar,
    String? location,
    int? age,
    bool? isLiked,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      location: location ?? this.location,
      age: age ?? this.age,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  @override
  List<Object> get props => [id, name, avatar, location, age, isLiked];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static User _$UserFromJson(Map<String, dynamic> json) => User(
        id: json['account_id'] as int,
        name: json['display_name'] as String,
        avatar: json['profile_image'] as String,
        location: json['location'] == null ? "" : json['location'] as String,
        age: json['age'] == null ? 0 : json['age'] as int,
      );

  Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
        'account_id': instance.id,
        'display_name': instance.name,
        'profile_image': instance.avatar,
        'location': instance.location,
        'age': instance.age,
      };
}
