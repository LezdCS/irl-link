// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatSettingsDTO {
  @JsonKey(fromJson: _permanentGroupFromJson)
  ChatGroupDTO get permanentFirstGroup;
  List<ChatGroupDTO> get chatGroups;
  bool get hideDeletedMessages;

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatSettingsDTOCopyWith<ChatSettingsDTO> get copyWith =>
      _$ChatSettingsDTOCopyWithImpl<ChatSettingsDTO>(
          this as ChatSettingsDTO, _$identity);

  /// Serializes this ChatSettingsDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatSettingsDTO &&
            (identical(other.permanentFirstGroup, permanentFirstGroup) ||
                other.permanentFirstGroup == permanentFirstGroup) &&
            const DeepCollectionEquality()
                .equals(other.chatGroups, chatGroups) &&
            (identical(other.hideDeletedMessages, hideDeletedMessages) ||
                other.hideDeletedMessages == hideDeletedMessages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, permanentFirstGroup,
      const DeepCollectionEquality().hash(chatGroups), hideDeletedMessages);

  @override
  String toString() {
    return 'ChatSettingsDTO(permanentFirstGroup: $permanentFirstGroup, chatGroups: $chatGroups, hideDeletedMessages: $hideDeletedMessages)';
  }
}

/// @nodoc
abstract mixin class $ChatSettingsDTOCopyWith<$Res> {
  factory $ChatSettingsDTOCopyWith(
          ChatSettingsDTO value, $Res Function(ChatSettingsDTO) _then) =
      _$ChatSettingsDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _permanentGroupFromJson)
      ChatGroupDTO permanentFirstGroup,
      List<ChatGroupDTO> chatGroups,
      bool hideDeletedMessages});

  $ChatGroupDTOCopyWith<$Res> get permanentFirstGroup;
}

/// @nodoc
class _$ChatSettingsDTOCopyWithImpl<$Res>
    implements $ChatSettingsDTOCopyWith<$Res> {
  _$ChatSettingsDTOCopyWithImpl(this._self, this._then);

  final ChatSettingsDTO _self;
  final $Res Function(ChatSettingsDTO) _then;

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? permanentFirstGroup = null,
    Object? chatGroups = null,
    Object? hideDeletedMessages = null,
  }) {
    return _then(_self.copyWith(
      permanentFirstGroup: null == permanentFirstGroup
          ? _self.permanentFirstGroup
          : permanentFirstGroup // ignore: cast_nullable_to_non_nullable
              as ChatGroupDTO,
      chatGroups: null == chatGroups
          ? _self.chatGroups
          : chatGroups // ignore: cast_nullable_to_non_nullable
              as List<ChatGroupDTO>,
      hideDeletedMessages: null == hideDeletedMessages
          ? _self.hideDeletedMessages
          : hideDeletedMessages // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatGroupDTOCopyWith<$Res> get permanentFirstGroup {
    return $ChatGroupDTOCopyWith<$Res>(_self.permanentFirstGroup, (value) {
      return _then(_self.copyWith(permanentFirstGroup: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ChatSettingsDTO extends ChatSettingsDTO {
  _ChatSettingsDTO(
      {@JsonKey(fromJson: _permanentGroupFromJson) this.permanentFirstGroup =
          const ChatGroupDTO(id: "permanentFirstGroup", channels: []),
      final List<ChatGroupDTO> chatGroups = const [],
      this.hideDeletedMessages = true})
      : _chatGroups = chatGroups,
        super._();
  factory _ChatSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatSettingsDTOFromJson(json);

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

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatSettingsDTOCopyWith<_ChatSettingsDTO> get copyWith =>
      __$ChatSettingsDTOCopyWithImpl<_ChatSettingsDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatSettingsDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatSettingsDTO &&
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

  @override
  String toString() {
    return 'ChatSettingsDTO(permanentFirstGroup: $permanentFirstGroup, chatGroups: $chatGroups, hideDeletedMessages: $hideDeletedMessages)';
  }
}

/// @nodoc
abstract mixin class _$ChatSettingsDTOCopyWith<$Res>
    implements $ChatSettingsDTOCopyWith<$Res> {
  factory _$ChatSettingsDTOCopyWith(
          _ChatSettingsDTO value, $Res Function(_ChatSettingsDTO) _then) =
      __$ChatSettingsDTOCopyWithImpl;
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
class __$ChatSettingsDTOCopyWithImpl<$Res>
    implements _$ChatSettingsDTOCopyWith<$Res> {
  __$ChatSettingsDTOCopyWithImpl(this._self, this._then);

  final _ChatSettingsDTO _self;
  final $Res Function(_ChatSettingsDTO) _then;

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? permanentFirstGroup = null,
    Object? chatGroups = null,
    Object? hideDeletedMessages = null,
  }) {
    return _then(_ChatSettingsDTO(
      permanentFirstGroup: null == permanentFirstGroup
          ? _self.permanentFirstGroup
          : permanentFirstGroup // ignore: cast_nullable_to_non_nullable
              as ChatGroupDTO,
      chatGroups: null == chatGroups
          ? _self._chatGroups
          : chatGroups // ignore: cast_nullable_to_non_nullable
              as List<ChatGroupDTO>,
      hideDeletedMessages: null == hideDeletedMessages
          ? _self.hideDeletedMessages
          : hideDeletedMessages // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of ChatSettingsDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatGroupDTOCopyWith<$Res> get permanentFirstGroup {
    return $ChatGroupDTOCopyWith<$Res>(_self.permanentFirstGroup, (value) {
      return _then(_self.copyWith(permanentFirstGroup: value));
    });
  }
}

/// @nodoc
mixin _$ChatGroupDTO {
  String get id;
  List<ChannelDTO> get channels;

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatGroupDTOCopyWith<ChatGroupDTO> get copyWith =>
      _$ChatGroupDTOCopyWithImpl<ChatGroupDTO>(
          this as ChatGroupDTO, _$identity);

  /// Serializes this ChatGroupDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatGroupDTO &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.channels, channels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(channels));

  @override
  String toString() {
    return 'ChatGroupDTO(id: $id, channels: $channels)';
  }
}

/// @nodoc
abstract mixin class $ChatGroupDTOCopyWith<$Res> {
  factory $ChatGroupDTOCopyWith(
          ChatGroupDTO value, $Res Function(ChatGroupDTO) _then) =
      _$ChatGroupDTOCopyWithImpl;
  @useResult
  $Res call({String id, List<ChannelDTO> channels});
}

/// @nodoc
class _$ChatGroupDTOCopyWithImpl<$Res> implements $ChatGroupDTOCopyWith<$Res> {
  _$ChatGroupDTOCopyWithImpl(this._self, this._then);

  final ChatGroupDTO _self;
  final $Res Function(ChatGroupDTO) _then;

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? channels = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      channels: null == channels
          ? _self.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<ChannelDTO>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ChatGroupDTO implements ChatGroupDTO {
  const _ChatGroupDTO(
      {required this.id, required final List<ChannelDTO> channels})
      : _channels = channels;
  factory _ChatGroupDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatGroupDTOFromJson(json);

  @override
  final String id;
  final List<ChannelDTO> _channels;
  @override
  List<ChannelDTO> get channels {
    if (_channels is EqualUnmodifiableListView) return _channels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channels);
  }

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatGroupDTOCopyWith<_ChatGroupDTO> get copyWith =>
      __$ChatGroupDTOCopyWithImpl<_ChatGroupDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatGroupDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatGroupDTO &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._channels, _channels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_channels));

  @override
  String toString() {
    return 'ChatGroupDTO(id: $id, channels: $channels)';
  }
}

/// @nodoc
abstract mixin class _$ChatGroupDTOCopyWith<$Res>
    implements $ChatGroupDTOCopyWith<$Res> {
  factory _$ChatGroupDTOCopyWith(
          _ChatGroupDTO value, $Res Function(_ChatGroupDTO) _then) =
      __$ChatGroupDTOCopyWithImpl;
  @override
  @useResult
  $Res call({String id, List<ChannelDTO> channels});
}

/// @nodoc
class __$ChatGroupDTOCopyWithImpl<$Res>
    implements _$ChatGroupDTOCopyWith<$Res> {
  __$ChatGroupDTOCopyWithImpl(this._self, this._then);

  final _ChatGroupDTO _self;
  final $Res Function(_ChatGroupDTO) _then;

  /// Create a copy of ChatGroupDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? channels = null,
  }) {
    return _then(_ChatGroupDTO(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      channels: null == channels
          ? _self._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<ChannelDTO>,
    ));
  }
}

/// @nodoc
mixin _$ChannelDTO {
  Platform get platform;
  String get channel;

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChannelDTOCopyWith<ChannelDTO> get copyWith =>
      _$ChannelDTOCopyWithImpl<ChannelDTO>(this as ChannelDTO, _$identity);

  /// Serializes this ChannelDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChannelDTO &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.channel, channel) || other.channel == channel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, platform, channel);

  @override
  String toString() {
    return 'ChannelDTO(platform: $platform, channel: $channel)';
  }
}

/// @nodoc
abstract mixin class $ChannelDTOCopyWith<$Res> {
  factory $ChannelDTOCopyWith(
          ChannelDTO value, $Res Function(ChannelDTO) _then) =
      _$ChannelDTOCopyWithImpl;
  @useResult
  $Res call({Platform platform, String channel});
}

/// @nodoc
class _$ChannelDTOCopyWithImpl<$Res> implements $ChannelDTOCopyWith<$Res> {
  _$ChannelDTOCopyWithImpl(this._self, this._then);

  final ChannelDTO _self;
  final $Res Function(ChannelDTO) _then;

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platform = null,
    Object? channel = null,
  }) {
    return _then(_self.copyWith(
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ChannelDTO implements ChannelDTO {
  const _ChannelDTO({required this.platform, required this.channel});
  factory _ChannelDTO.fromJson(Map<String, dynamic> json) =>
      _$ChannelDTOFromJson(json);

  @override
  final Platform platform;
  @override
  final String channel;

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChannelDTOCopyWith<_ChannelDTO> get copyWith =>
      __$ChannelDTOCopyWithImpl<_ChannelDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChannelDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChannelDTO &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.channel, channel) || other.channel == channel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, platform, channel);

  @override
  String toString() {
    return 'ChannelDTO(platform: $platform, channel: $channel)';
  }
}

/// @nodoc
abstract mixin class _$ChannelDTOCopyWith<$Res>
    implements $ChannelDTOCopyWith<$Res> {
  factory _$ChannelDTOCopyWith(
          _ChannelDTO value, $Res Function(_ChannelDTO) _then) =
      __$ChannelDTOCopyWithImpl;
  @override
  @useResult
  $Res call({Platform platform, String channel});
}

/// @nodoc
class __$ChannelDTOCopyWithImpl<$Res> implements _$ChannelDTOCopyWith<$Res> {
  __$ChannelDTOCopyWithImpl(this._self, this._then);

  final _ChannelDTO _self;
  final $Res Function(_ChannelDTO) _then;

  /// Create a copy of ChannelDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? platform = null,
    Object? channel = null,
  }) {
    return _then(_ChannelDTO(
      platform: null == platform
          ? _self.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as Platform,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
