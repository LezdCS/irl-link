// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twitch_decoded_idtoken_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TwitchDecodedIdTokenDTO _$TwitchDecodedIdTokenDTOFromJson(
    Map<String, dynamic> json) {
  return _TwitchDecodedIdTokenDTO.fromJson(json);
}

/// @nodoc
mixin _$TwitchDecodedIdTokenDTO {
  String get preferredUsername => throw _privateConstructorUsedError;
  String get profilePicture => throw _privateConstructorUsedError;

  /// Serializes this TwitchDecodedIdTokenDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TwitchDecodedIdTokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TwitchDecodedIdTokenDTOCopyWith<TwitchDecodedIdTokenDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TwitchDecodedIdTokenDTOCopyWith<$Res> {
  factory $TwitchDecodedIdTokenDTOCopyWith(TwitchDecodedIdTokenDTO value,
          $Res Function(TwitchDecodedIdTokenDTO) then) =
      _$TwitchDecodedIdTokenDTOCopyWithImpl<$Res, TwitchDecodedIdTokenDTO>;
  @useResult
  $Res call({String preferredUsername, String profilePicture});
}

/// @nodoc
class _$TwitchDecodedIdTokenDTOCopyWithImpl<$Res,
        $Val extends TwitchDecodedIdTokenDTO>
    implements $TwitchDecodedIdTokenDTOCopyWith<$Res> {
  _$TwitchDecodedIdTokenDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TwitchDecodedIdTokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferredUsername = null,
    Object? profilePicture = null,
  }) {
    return _then(_value.copyWith(
      preferredUsername: null == preferredUsername
          ? _value.preferredUsername
          : preferredUsername // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TwitchDecodedIdTokenDTOImplCopyWith<$Res>
    implements $TwitchDecodedIdTokenDTOCopyWith<$Res> {
  factory _$$TwitchDecodedIdTokenDTOImplCopyWith(
          _$TwitchDecodedIdTokenDTOImpl value,
          $Res Function(_$TwitchDecodedIdTokenDTOImpl) then) =
      __$$TwitchDecodedIdTokenDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String preferredUsername, String profilePicture});
}

/// @nodoc
class __$$TwitchDecodedIdTokenDTOImplCopyWithImpl<$Res>
    extends _$TwitchDecodedIdTokenDTOCopyWithImpl<$Res,
        _$TwitchDecodedIdTokenDTOImpl>
    implements _$$TwitchDecodedIdTokenDTOImplCopyWith<$Res> {
  __$$TwitchDecodedIdTokenDTOImplCopyWithImpl(
      _$TwitchDecodedIdTokenDTOImpl _value,
      $Res Function(_$TwitchDecodedIdTokenDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of TwitchDecodedIdTokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferredUsername = null,
    Object? profilePicture = null,
  }) {
    return _then(_$TwitchDecodedIdTokenDTOImpl(
      preferredUsername: null == preferredUsername
          ? _value.preferredUsername
          : preferredUsername // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TwitchDecodedIdTokenDTOImpl implements _TwitchDecodedIdTokenDTO {
  const _$TwitchDecodedIdTokenDTOImpl(
      {required this.preferredUsername, required this.profilePicture});

  factory _$TwitchDecodedIdTokenDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$TwitchDecodedIdTokenDTOImplFromJson(json);

  @override
  final String preferredUsername;
  @override
  final String profilePicture;

  @override
  String toString() {
    return 'TwitchDecodedIdTokenDTO(preferredUsername: $preferredUsername, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TwitchDecodedIdTokenDTOImpl &&
            (identical(other.preferredUsername, preferredUsername) ||
                other.preferredUsername == preferredUsername) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, preferredUsername, profilePicture);

  /// Create a copy of TwitchDecodedIdTokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TwitchDecodedIdTokenDTOImplCopyWith<_$TwitchDecodedIdTokenDTOImpl>
      get copyWith => __$$TwitchDecodedIdTokenDTOImplCopyWithImpl<
          _$TwitchDecodedIdTokenDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TwitchDecodedIdTokenDTOImplToJson(
      this,
    );
  }
}

abstract class _TwitchDecodedIdTokenDTO implements TwitchDecodedIdTokenDTO {
  const factory _TwitchDecodedIdTokenDTO(
      {required final String preferredUsername,
      required final String profilePicture}) = _$TwitchDecodedIdTokenDTOImpl;

  factory _TwitchDecodedIdTokenDTO.fromJson(Map<String, dynamic> json) =
      _$TwitchDecodedIdTokenDTOImpl.fromJson;

  @override
  String get preferredUsername;
  @override
  String get profilePicture;

  /// Create a copy of TwitchDecodedIdTokenDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TwitchDecodedIdTokenDTOImplCopyWith<_$TwitchDecodedIdTokenDTOImpl>
      get copyWith => throw _privateConstructorUsedError;
}
