// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'se_me_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SeMeDTO _$SeMeDTOFromJson(Map<String, dynamic> json) {
  return _SeMeDTO.fromJson(json);
}

/// @nodoc
mixin _$SeMeDTO {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;

  /// Serializes this SeMeDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeMeDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeMeDTOCopyWith<SeMeDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeMeDTOCopyWith<$Res> {
  factory $SeMeDTOCopyWith(SeMeDTO value, $Res Function(SeMeDTO) then) =
      _$SeMeDTOCopyWithImpl<$Res, SeMeDTO>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String avatar,
      String username,
      String displayName});
}

/// @nodoc
class _$SeMeDTOCopyWithImpl<$Res, $Val extends SeMeDTO>
    implements $SeMeDTOCopyWith<$Res> {
  _$SeMeDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeMeDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? avatar = null,
    Object? username = null,
    Object? displayName = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeMeDTOImplCopyWith<$Res> implements $SeMeDTOCopyWith<$Res> {
  factory _$$SeMeDTOImplCopyWith(
          _$SeMeDTOImpl value, $Res Function(_$SeMeDTOImpl) then) =
      __$$SeMeDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String avatar,
      String username,
      String displayName});
}

/// @nodoc
class __$$SeMeDTOImplCopyWithImpl<$Res>
    extends _$SeMeDTOCopyWithImpl<$Res, _$SeMeDTOImpl>
    implements _$$SeMeDTOImplCopyWith<$Res> {
  __$$SeMeDTOImplCopyWithImpl(
      _$SeMeDTOImpl _value, $Res Function(_$SeMeDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of SeMeDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? avatar = null,
    Object? username = null,
    Object? displayName = null,
  }) {
    return _then(_$SeMeDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SeMeDTOImpl implements _SeMeDTO {
  const _$SeMeDTOImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.avatar,
      required this.username,
      required this.displayName});

  factory _$SeMeDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeMeDTOImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String avatar;
  @override
  final String username;
  @override
  final String displayName;

  @override
  String toString() {
    return 'SeMeDTO(id: $id, avatar: $avatar, username: $username, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeMeDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, avatar, username, displayName);

  /// Create a copy of SeMeDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeMeDTOImplCopyWith<_$SeMeDTOImpl> get copyWith =>
      __$$SeMeDTOImplCopyWithImpl<_$SeMeDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeMeDTOImplToJson(
      this,
    );
  }
}

abstract class _SeMeDTO implements SeMeDTO {
  const factory _SeMeDTO(
      {@JsonKey(name: '_id') required final String id,
      required final String avatar,
      required final String username,
      required final String displayName}) = _$SeMeDTOImpl;

  factory _SeMeDTO.fromJson(Map<String, dynamic> json) = _$SeMeDTOImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get avatar;
  @override
  String get username;
  @override
  String get displayName;

  /// Create a copy of SeMeDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeMeDTOImplCopyWith<_$SeMeDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
