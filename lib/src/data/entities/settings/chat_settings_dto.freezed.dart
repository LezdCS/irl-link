// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatSettingsDTO _$ChatSettingsDTOFromJson(Map<String, dynamic> json) {
  return _ChatSettingsDTO.fromJson(json);
}

/// @nodoc
mixin _$ChatSettingsDTO {
  @JsonKey(fromJson: _permanentGroupFromJson)
  ChatGroupDTO get permanentFirstGroup => throw _privateConstructorUsedError;
  List<ChatGroupDTO> get chatGroups => throw _privateConstructorUsedError;
  bool get hideDeletedMessages => throw _privateConstructorUsedError;

  /// Serializes this ChatSettingsDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatSettingsDTOCopyWith<ChatSettingsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatSettingsDTOCopyWith<$Res> {
  factory $ChatSettingsDTOCopyWith(
          ChatSettingsDTO value, $Res Function(ChatSettingsDTO) then) =
      _$ChatSettingsDTOCopyWithImpl<$Res, ChatSettingsDTO>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _permanentGroupFromJson)
      ChatGroupDTO permanentFirstGroup,
      List<ChatGroupDTO> chatGroups,
      bool hideDeletedMessages});

  $ChatGroupDTOCopyWith<$Res> get permanentFirstGroup;
}

/// @nodoc
class _$ChatSettingsDTOCopyWithImpl<$Res, $Val extends ChatSettingsDTO>
    implements $ChatSettingsDTOCopyWith<$Res> {
  _$ChatSettingsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? permanentFirstGroup = null,
    Object? chatGroups = null,
    Object? hideDeletedMessages = null,
  }) {
    return _then(_value.copyWith(
      permanentFirstGroup: null == permanentFirstGroup
          ? _value.permanentFirstGroup
          : permanentFirstGroup // ignore: cast_nullable_to_non_nullable
              as ChatGroupDTO,
      chatGroups: null == chatGroups
          ? _value.chatGroups
          : chatGroups // ignore: cast_nullable_to_non_nullable
              as List<ChatGroupDTO>,
      hideDeletedMessages: null == hideDeletedMessages
          ? _value.hideDeletedMessages
          : hideDeletedMessages // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatGroupDTOCopyWith<$Res> get permanentFirstGroup {
    return $ChatGroupDTOCopyWith<$Res>(_value.permanentFirstGroup, (value) {
      return _then(_value.copyWith(permanentFirstGroup: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatSettingsDTOImplCopyWith<$Res>
    implements $ChatSettingsDTOCopyWith<$Res> {
  factory _$$ChatSettingsDTOImplCopyWith(_$ChatSettingsDTOImpl value,
          $Res Function(_$ChatSettingsDTOImpl) then) =
      __$$ChatSettingsDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _permanentGroupFromJson)
      ChatGroupDTO permanentFirstGroup,
      List<ChatGroupDTO> chatGroups,
      bool hideDeletedMessages});

  @override
  $ChatGroupDTOCopyWith<$Res> get permanentFirstGroup;
}

/// @nodoc
class __$$ChatSettingsDTOImplCopyWithImpl<$Res>
    extends _$ChatSettingsDTOCopyWithImpl<$Res, _$ChatSettingsDTOImpl>
    implements _$$ChatSettingsDTOImplCopyWith<$Res> {
  __$$ChatSettingsDTOImplCopyWithImpl(
      _$ChatSettingsDTOImpl _value, $Res Function(_$ChatSettingsDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? permanentFirstGroup = null,
    Object? chatGroups = null,
    Object? hideDeletedMessages = null,
  }) {
    return _then(_$ChatSettingsDTOImpl(
      permanentFirstGroup: null == permanentFirstGroup
          ? _value.permanentFirstGroup
          : permanentFirstGroup // ignore: cast_nullable_to_non_nullable
              as ChatGroupDTO,
      chatGroups: null == chatGroups
          ? _value._chatGroups
          : chatGroups // ignore: cast_nullable_to_non_nullable
              as List<ChatGroupDTO>,
      hideDeletedMessages: null == hideDeletedMessages
          ? _value.hideDeletedMessages
          : hideDeletedMessages // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatSettingsDTOImpl extends _ChatSettingsDTO {
  _$ChatSettingsDTOImpl(
      {@JsonKey(fromJson: _permanentGroupFromJson) this.permanentFirstGroup =
          const ChatGroupDTO(id: "permanentFirstGroup", channels: []),
      final List<ChatGroupDTO> chatGroups = const [],
      this.hideDeletedMessages = true})
      : _chatGroups = chatGroups,
        super._();

  factory _$ChatSettingsDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatSettingsDTOImplFromJson(json);

  @override
  @JsonKey(fromJson: _permanentGroupFromJson)
  final ChatGroupDTO permanentFirstGroup;
  final List<ChatGroupDTO> _chatGroups;
  @override
  @JsonKey()
  List<ChatGroupDTO> get chatGroups {
    if (_chatGroups is EqualUnmodifiableListView) return _chatGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatGroups);
  }

  @override
  @JsonKey()
  final bool hideDeletedMessages;

  @override
  String toString() {
    return 'ChatSettingsDTO(permanentFirstGroup: $permanentFirstGroup, chatGroups: $chatGroups, hideDeletedMessages: $hideDeletedMessages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatSettingsDTOImpl &&
            (identical(other.permanentFirstGroup, permanentFirstGroup) ||
                other.permanentFirstGroup == permanentFirstGroup) &&
            const DeepCollectionEquality()
                .equals(other._chatGroups, _chatGroups) &&
            (identical(other.hideDeletedMessages, hideDeletedMessages) ||
                other.hideDeletedMessages == hideDeletedMessages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, permanentFirstGroup,
      const DeepCollectionEquality().hash(_chatGroups), hideDeletedMessages);

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatSettingsDTOImplCopyWith<_$ChatSettingsDTOImpl> get copyWith =>
      __$$ChatSettingsDTOImplCopyWithImpl<_$ChatSettingsDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatSettingsDTOImplToJson(
      this,
    );
  }
}

abstract class _ChatSettingsDTO extends ChatSettingsDTO {
  factory _ChatSettingsDTO(
      {@JsonKey(fromJson: _permanentGroupFromJson)
      final ChatGroupDTO permanentFirstGroup,
      final List<ChatGroupDTO> chatGroups,
      final bool hideDeletedMessages}) = _$ChatSettingsDTOImpl;
  _ChatSettingsDTO._() : super._();

  factory _ChatSettingsDTO.fromJson(Map<String, dynamic> json) =
      _$ChatSettingsDTOImpl.fromJson;

  @override
  @JsonKey(fromJson: _permanentGroupFromJson)
  ChatGroupDTO get permanentFirstGroup;
  @override
  List<ChatGroupDTO> get chatGroups;
  @override
  bool get hideDeletedMessages;

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatSettingsDTOImplCopyWith<_$ChatSettingsDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatGroupDTO _$ChatGroupDTOFromJson(Map<String, dynamic> json) {
  return _ChatGroupDTO.fromJson(json);
}

/// @nodoc
mixin _$ChatGroupDTO {
  String get id => throw _privateConstructorUsedError;
  List<ChannelDTO> get channels => throw _privateConstructorUsedError;

  /// Serializes this ChatGroupDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatGroupDTOCopyWith<ChatGroupDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatGroupDTOCopyWith<$Res> {
  factory $ChatGroupDTOCopyWith(
          ChatGroupDTO value, $Res Function(ChatGroupDTO) then) =
      _$ChatGroupDTOCopyWithImpl<$Res, ChatGroupDTO>;
  @useResult
  $Res call({String id, List<ChannelDTO> channels});
}

/// @nodoc
class _$ChatGroupDTOCopyWithImpl<$Res, $Val extends ChatGroupDTO>
    implements $ChatGroupDTOCopyWith<$Res> {
  _$ChatGroupDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channels = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      channels: null == channels
          ? _value.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<ChannelDTO>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatGroupDTOImplCopyWith<$Res>
    implements $ChatGroupDTOCopyWith<$Res> {
  factory _$$ChatGroupDTOImplCopyWith(
          _$ChatGroupDTOImpl value, $Res Function(_$ChatGroupDTOImpl) then) =
      __$$ChatGroupDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, List<ChannelDTO> channels});
}

/// @nodoc
class __$$ChatGroupDTOImplCopyWithImpl<$Res>
    extends _$ChatGroupDTOCopyWithImpl<$Res, _$ChatGroupDTOImpl>
    implements _$$ChatGroupDTOImplCopyWith<$Res> {
  __$$ChatGroupDTOImplCopyWithImpl(
      _$ChatGroupDTOImpl _value, $Res Function(_$ChatGroupDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channels = null,
  }) {
    return _then(_$ChatGroupDTOImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      channels: null == channels
          ? _value._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<ChannelDTO>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatGroupDTOImpl implements _ChatGroupDTO {
  const _$ChatGroupDTOImpl(
      {required this.id, required final List<ChannelDTO> channels})
      : _channels = channels;

  factory _$ChatGroupDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatGroupDTOImplFromJson(json);

  @override
  final String id;
  final List<ChannelDTO> _channels;
  @override
  List<ChannelDTO> get channels {
    if (_channels is EqualUnmodifiableListView) return _channels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channels);
  }

  @override
  String toString() {
    return 'ChatGroupDTO(id: $id, channels: $channels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatGroupDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._channels, _channels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_channels));

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatGroupDTOImplCopyWith<_$ChatGroupDTOImpl> get copyWith =>
      __$$ChatGroupDTOImplCopyWithImpl<_$ChatGroupDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatGroupDTOImplToJson(
      this,
    );
  }
}

abstract class _ChatGroupDTO implements ChatGroupDTO {
  const factory _ChatGroupDTO(
      {required final String id,
      required final List<ChannelDTO> channels}) = _$ChatGroupDTOImpl;

  factory _ChatGroupDTO.fromJson(Map<String, dynamic> json) =
      _$ChatGroupDTOImpl.fromJson;

  @override
  String get id;
  @override
  List<ChannelDTO> get channels;

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatGroupDTOImplCopyWith<_$ChatGroupDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChannelDTO _$ChannelDTOFromJson(Map<String, dynamic> json) {
  return _ChannelDTO.fromJson(json);
}

/// @nodoc
mixin _$ChannelDTO {
  Platform get platform => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;

  /// Serializes this ChannelDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChannelDTOCopyWith<ChannelDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelDTOCopyWith<$Res> {
  factory $ChannelDTOCopyWith(
          ChannelDTO value, $Res Function(ChannelDTO) then) =
      _$ChannelDTOCopyWithImpl<$Res, ChannelDTO>;
  @useResult
  $Res call({Platform platform, String channel, bool enabled});
}

/// @nodoc
class _$ChannelDTOCopyWithImpl<$Res, $Val extends ChannelDTO>
    implements $ChannelDTOCopyWith<$Res> {
  _$ChannelDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platform = null,
    Object? channel = null,
    Object? enabled = null,
  }) {
    return _then(_value.copyWith(
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChannelDTOImplCopyWith<$Res>
    implements $ChannelDTOCopyWith<$Res> {
  factory _$$ChannelDTOImplCopyWith(
          _$ChannelDTOImpl value, $Res Function(_$ChannelDTOImpl) then) =
      __$$ChannelDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Platform platform, String channel, bool enabled});
}

/// @nodoc
class __$$ChannelDTOImplCopyWithImpl<$Res>
    extends _$ChannelDTOCopyWithImpl<$Res, _$ChannelDTOImpl>
    implements _$$ChannelDTOImplCopyWith<$Res> {
  __$$ChannelDTOImplCopyWithImpl(
      _$ChannelDTOImpl _value, $Res Function(_$ChannelDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platform = null,
    Object? channel = null,
    Object? enabled = null,
  }) {
    return _then(_$ChannelDTOImpl(
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChannelDTOImpl implements _ChannelDTO {
  const _$ChannelDTOImpl(
      {required this.platform, required this.channel, required this.enabled});

  factory _$ChannelDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChannelDTOImplFromJson(json);

  @override
  final Platform platform;
  @override
  final String channel;
  @override
  final bool enabled;

  @override
  String toString() {
    return 'ChannelDTO(platform: $platform, channel: $channel, enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChannelDTOImpl &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, platform, channel, enabled);

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChannelDTOImplCopyWith<_$ChannelDTOImpl> get copyWith =>
      __$$ChannelDTOImplCopyWithImpl<_$ChannelDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChannelDTOImplToJson(
      this,
    );
  }
}

abstract class _ChannelDTO implements ChannelDTO {
  const factory _ChannelDTO(
      {required final Platform platform,
      required final String channel,
      required final bool enabled}) = _$ChannelDTOImpl;

  factory _ChannelDTO.fromJson(Map<String, dynamic> json) =
      _$ChannelDTOImpl.fromJson;

  @override
  Platform get platform;
  @override
  String get channel;
  @override
  bool get enabled;

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChannelDTOImplCopyWith<_$ChannelDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
