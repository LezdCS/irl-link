// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TwitchUserDTO _$TwitchUserDTOFromJson(Map<String, dynamic> json) {
  return _TwitchUserDTO.fromJson(json);
}

/// @nodoc
mixin _$TwitchUserDTO {
  String get id => throw _privateConstructorUsedError;
  String get login => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'broadcaster_type')
  String get broadcasterType => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_image_url')
  String get profileImageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'view_count', fromJson: _stringToInt)
  int get viewCount => throw _privateConstructorUsedError;

  /// Serializes this TwitchUserDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TwitchUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TwitchUserDTOCopyWith<TwitchUserDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TwitchUserDTOCopyWith<$Res> {
  factory $TwitchUserDTOCopyWith(
          TwitchUserDTO value, $Res Function(TwitchUserDTO) then) =
      _$TwitchUserDTOCopyWithImpl<$Res, TwitchUserDTO>;
  @useResult
  $Res call(
      {String id,
      String login,
      @JsonKey(name: 'display_name') String displayName,
      @JsonKey(name: 'broadcaster_type') String broadcasterType,
      String description,
      @JsonKey(name: 'profile_image_url') String profileImageUrl,
      @JsonKey(name: 'view_count', fromJson: _stringToInt) int viewCount});
}

/// @nodoc
class _$TwitchUserDTOCopyWithImpl<$Res, $Val extends TwitchUserDTO>
    implements $TwitchUserDTOCopyWith<$Res> {
  _$TwitchUserDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TwitchUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? login = null,
    Object? displayName = null,
    Object? broadcasterType = null,
    Object? description = null,
    Object? profileImageUrl = null,
    Object? viewCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      broadcasterType: null == broadcasterType
          ? _value.broadcasterType
          : broadcasterType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TwitchUserDTOImplCopyWith<$Res>
    implements $TwitchUserDTOCopyWith<$Res> {
  factory _$$TwitchUserDTOImplCopyWith(
          _$TwitchUserDTOImpl value, $Res Function(_$TwitchUserDTOImpl) then) =
      __$$TwitchUserDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String login,
      @JsonKey(name: 'display_name') String displayName,
      @JsonKey(name: 'broadcaster_type') String broadcasterType,
      String description,
      @JsonKey(name: 'profile_image_url') String profileImageUrl,
      @JsonKey(name: 'view_count', fromJson: _stringToInt) int viewCount});
}

/// @nodoc
class __$$TwitchUserDTOImplCopyWithImpl<$Res>
    extends _$TwitchUserDTOCopyWithImpl<$Res, _$TwitchUserDTOImpl>
    implements _$$TwitchUserDTOImplCopyWith<$Res> {
  __$$TwitchUserDTOImplCopyWithImpl(
      _$TwitchUserDTOImpl _value, $Res Function(_$TwitchUserDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of TwitchUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? login = null,
    Object? displayName = null,
    Object? broadcasterType = null,
    Object? description = null,
    Object? profileImageUrl = null,
    Object? viewCount = null,
  }) {
    return _then(_$TwitchUserDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      broadcasterType: null == broadcasterType
          ? _value.broadcasterType
          : broadcasterType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TwitchUserDTOImpl implements _TwitchUserDTO {
  const _$TwitchUserDTOImpl(
      {required this.id,
      required this.login,
      @JsonKey(name: 'display_name') required this.displayName,
      @JsonKey(name: 'broadcaster_type') required this.broadcasterType,
      required this.description,
      @JsonKey(name: 'profile_image_url') required this.profileImageUrl,
      @JsonKey(name: 'view_count', fromJson: _stringToInt)
      required this.viewCount});

  factory _$TwitchUserDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$TwitchUserDTOImplFromJson(json);

  @override
  final String id;
  @override
  final String login;
  @override
  @JsonKey(name: 'display_name')
  final String displayName;
  @override
  @JsonKey(name: 'broadcaster_type')
  final String broadcasterType;
  @override
  final String description;
  @override
  @JsonKey(name: 'profile_image_url')
  final String profileImageUrl;
  @override
  @JsonKey(name: 'view_count', fromJson: _stringToInt)
  final int viewCount;

  @override
  String toString() {
    return 'TwitchUserDTO(id: $id, login: $login, displayName: $displayName, broadcasterType: $broadcasterType, description: $description, profileImageUrl: $profileImageUrl, viewCount: $viewCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TwitchUserDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.broadcasterType, broadcasterType) ||
                other.broadcasterType == broadcasterType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, login, displayName,
      broadcasterType, description, profileImageUrl, viewCount);

  /// Create a copy of TwitchUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TwitchUserDTOImplCopyWith<_$TwitchUserDTOImpl> get copyWith =>
      __$$TwitchUserDTOImplCopyWithImpl<_$TwitchUserDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TwitchUserDTOImplToJson(
      this,
    );
  }
}

abstract class _TwitchUserDTO implements TwitchUserDTO {
  const factory _TwitchUserDTO(
      {required final String id,
      required final String login,
      @JsonKey(name: 'display_name') required final String displayName,
      @JsonKey(name: 'broadcaster_type') required final String broadcasterType,
      required final String description,
      @JsonKey(name: 'profile_image_url') required final String profileImageUrl,
      @JsonKey(name: 'view_count', fromJson: _stringToInt)
      required final int viewCount}) = _$TwitchUserDTOImpl;

  factory _TwitchUserDTO.fromJson(Map<String, dynamic> json) =
      _$TwitchUserDTOImpl.fromJson;

  @override
  String get id;
  @override
  String get login;
  @override
  @JsonKey(name: 'display_name')
  String get displayName;
  @override
  @JsonKey(name: 'broadcaster_type')
  String get broadcasterType;
  @override
  String get description;
  @override
  @JsonKey(name: 'profile_image_url')
  String get profileImageUrl;
  @override
  @JsonKey(name: 'view_count', fromJson: _stringToInt)
  int get viewCount;

  /// Create a copy of TwitchUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TwitchUserDTOImplCopyWith<_$TwitchUserDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
