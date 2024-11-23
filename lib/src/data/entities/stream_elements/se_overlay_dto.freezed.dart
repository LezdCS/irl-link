// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'se_overlay_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SeOverlayDTO _$SeOverlayDTOFromJson(Map<String, dynamic> json) {
  return _SeOverlayDTO.fromJson(json);
}

/// @nodoc
mixin _$SeOverlayDTO {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this SeOverlayDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeOverlayDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeOverlayDTOCopyWith<SeOverlayDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeOverlayDTOCopyWith<$Res> {
  factory $SeOverlayDTOCopyWith(
          SeOverlayDTO value, $Res Function(SeOverlayDTO) then) =
      _$SeOverlayDTOCopyWithImpl<$Res, SeOverlayDTO>;
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String name});
}

/// @nodoc
class _$SeOverlayDTOCopyWithImpl<$Res, $Val extends SeOverlayDTO>
    implements $SeOverlayDTOCopyWith<$Res> {
  _$SeOverlayDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeOverlayDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeOverlayDTOImplCopyWith<$Res>
    implements $SeOverlayDTOCopyWith<$Res> {
  factory _$$SeOverlayDTOImplCopyWith(
          _$SeOverlayDTOImpl value, $Res Function(_$SeOverlayDTOImpl) then) =
      __$$SeOverlayDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String name});
}

/// @nodoc
class __$$SeOverlayDTOImplCopyWithImpl<$Res>
    extends _$SeOverlayDTOCopyWithImpl<$Res, _$SeOverlayDTOImpl>
    implements _$$SeOverlayDTOImplCopyWith<$Res> {
  __$$SeOverlayDTOImplCopyWithImpl(
      _$SeOverlayDTOImpl _value, $Res Function(_$SeOverlayDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of SeOverlayDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$SeOverlayDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SeOverlayDTOImpl implements _SeOverlayDTO {
  const _$SeOverlayDTOImpl(
      {@JsonKey(name: '_id') required this.id, required this.name});

  factory _$SeOverlayDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeOverlayDTOImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'SeOverlayDTO(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeOverlayDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of SeOverlayDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeOverlayDTOImplCopyWith<_$SeOverlayDTOImpl> get copyWith =>
      __$$SeOverlayDTOImplCopyWithImpl<_$SeOverlayDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeOverlayDTOImplToJson(
      this,
    );
  }
}

abstract class _SeOverlayDTO implements SeOverlayDTO {
  const factory _SeOverlayDTO(
      {@JsonKey(name: '_id') required final String id,
      required final String name}) = _$SeOverlayDTOImpl;

  factory _SeOverlayDTO.fromJson(Map<String, dynamic> json) =
      _$SeOverlayDTOImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;

  /// Create a copy of SeOverlayDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeOverlayDTOImplCopyWith<_$SeOverlayDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
