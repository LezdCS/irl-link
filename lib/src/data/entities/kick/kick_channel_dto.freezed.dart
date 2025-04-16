// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kick_channel_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KickChannelDto {
  @JsonKey(name: 'banner_picture')
  String get bannerPicture;
  @JsonKey(name: 'broadcaster_user_id')
  int get broadcasterUserId;
  KickCategoryDTO get category;
  @JsonKey(name: 'channel_description')
  String get channelDescription;
  String get slug;
  KickChannelStreamDto get stream;
  @JsonKey(name: 'stream_title')
  String get streamTitle;

  /// Create a copy of KickChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KickChannelDtoCopyWith<KickChannelDto> get copyWith =>
      _$KickChannelDtoCopyWithImpl<KickChannelDto>(
          this as KickChannelDto, _$identity);

  /// Serializes this KickChannelDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KickChannelDto &&
            (identical(other.bannerPicture, bannerPicture) ||
                other.bannerPicture == bannerPicture) &&
            (identical(other.broadcasterUserId, broadcasterUserId) ||
                other.broadcasterUserId == broadcasterUserId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.channelDescription, channelDescription) ||
                other.channelDescription == channelDescription) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.stream, stream) || other.stream == stream) &&
            (identical(other.streamTitle, streamTitle) ||
                other.streamTitle == streamTitle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bannerPicture, broadcasterUserId,
      category, channelDescription, slug, stream, streamTitle);

  @override
  String toString() {
    return 'KickChannelDto(bannerPicture: $bannerPicture, broadcasterUserId: $broadcasterUserId, category: $category, channelDescription: $channelDescription, slug: $slug, stream: $stream, streamTitle: $streamTitle)';
  }
}

/// @nodoc
abstract mixin class $KickChannelDtoCopyWith<$Res> {
  factory $KickChannelDtoCopyWith(
          KickChannelDto value, $Res Function(KickChannelDto) _then) =
      _$KickChannelDtoCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'banner_picture') String bannerPicture,
      @JsonKey(name: 'broadcaster_user_id') int broadcasterUserId,
      KickCategoryDTO category,
      @JsonKey(name: 'channel_description') String channelDescription,
      String slug,
      KickChannelStreamDto stream,
      @JsonKey(name: 'stream_title') String streamTitle});

  $KickCategoryDTOCopyWith<$Res> get category;
  $KickChannelStreamDtoCopyWith<$Res> get stream;
}

/// @nodoc
class _$KickChannelDtoCopyWithImpl<$Res>
    implements $KickChannelDtoCopyWith<$Res> {
  _$KickChannelDtoCopyWithImpl(this._self, this._then);

  final KickChannelDto _self;
  final $Res Function(KickChannelDto) _then;

  /// Create a copy of KickChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bannerPicture = null,
    Object? broadcasterUserId = null,
    Object? category = null,
    Object? channelDescription = null,
    Object? slug = null,
    Object? stream = null,
    Object? streamTitle = null,
  }) {
    return _then(_self.copyWith(
      bannerPicture: null == bannerPicture
          ? _self.bannerPicture
          : bannerPicture // ignore: cast_nullable_to_non_nullable
              as String,
      broadcasterUserId: null == broadcasterUserId
          ? _self.broadcasterUserId
          : broadcasterUserId // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as KickCategoryDTO,
      channelDescription: null == channelDescription
          ? _self.channelDescription
          : channelDescription // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      stream: null == stream
          ? _self.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as KickChannelStreamDto,
      streamTitle: null == streamTitle
          ? _self.streamTitle
          : streamTitle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of KickChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KickCategoryDTOCopyWith<$Res> get category {
    return $KickCategoryDTOCopyWith<$Res>(_self.category, (value) {
      return _then(_self.copyWith(category: value));
    });
  }

  /// Create a copy of KickChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KickChannelStreamDtoCopyWith<$Res> get stream {
    return $KickChannelStreamDtoCopyWith<$Res>(_self.stream, (value) {
      return _then(_self.copyWith(stream: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _KickChannelDto implements KickChannelDto {
  const _KickChannelDto(
      {@JsonKey(name: 'banner_picture') required this.bannerPicture,
      @JsonKey(name: 'broadcaster_user_id') required this.broadcasterUserId,
      required this.category,
      @JsonKey(name: 'channel_description') required this.channelDescription,
      required this.slug,
      required this.stream,
      @JsonKey(name: 'stream_title') required this.streamTitle});
  factory _KickChannelDto.fromJson(Map<String, dynamic> json) =>
      _$KickChannelDtoFromJson(json);

  @override
  @JsonKey(name: 'banner_picture')
  final String bannerPicture;
  @override
  @JsonKey(name: 'broadcaster_user_id')
  final int broadcasterUserId;
  @override
  final KickCategoryDTO category;
  @override
  @JsonKey(name: 'channel_description')
  final String channelDescription;
  @override
  final String slug;
  @override
  final KickChannelStreamDto stream;
  @override
  @JsonKey(name: 'stream_title')
  final String streamTitle;

  /// Create a copy of KickChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KickChannelDtoCopyWith<_KickChannelDto> get copyWith =>
      __$KickChannelDtoCopyWithImpl<_KickChannelDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KickChannelDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KickChannelDto &&
            (identical(other.bannerPicture, bannerPicture) ||
                other.bannerPicture == bannerPicture) &&
            (identical(other.broadcasterUserId, broadcasterUserId) ||
                other.broadcasterUserId == broadcasterUserId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.channelDescription, channelDescription) ||
                other.channelDescription == channelDescription) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.stream, stream) || other.stream == stream) &&
            (identical(other.streamTitle, streamTitle) ||
                other.streamTitle == streamTitle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bannerPicture, broadcasterUserId,
      category, channelDescription, slug, stream, streamTitle);

  @override
  String toString() {
    return 'KickChannelDto(bannerPicture: $bannerPicture, broadcasterUserId: $broadcasterUserId, category: $category, channelDescription: $channelDescription, slug: $slug, stream: $stream, streamTitle: $streamTitle)';
  }
}

/// @nodoc
abstract mixin class _$KickChannelDtoCopyWith<$Res>
    implements $KickChannelDtoCopyWith<$Res> {
  factory _$KickChannelDtoCopyWith(
          _KickChannelDto value, $Res Function(_KickChannelDto) _then) =
      __$KickChannelDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'banner_picture') String bannerPicture,
      @JsonKey(name: 'broadcaster_user_id') int broadcasterUserId,
      KickCategoryDTO category,
      @JsonKey(name: 'channel_description') String channelDescription,
      String slug,
      KickChannelStreamDto stream,
      @JsonKey(name: 'stream_title') String streamTitle});

  @override
  $KickCategoryDTOCopyWith<$Res> get category;
  @override
  $KickChannelStreamDtoCopyWith<$Res> get stream;
}

/// @nodoc
class __$KickChannelDtoCopyWithImpl<$Res>
    implements _$KickChannelDtoCopyWith<$Res> {
  __$KickChannelDtoCopyWithImpl(this._self, this._then);

  final _KickChannelDto _self;
  final $Res Function(_KickChannelDto) _then;

  /// Create a copy of KickChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? bannerPicture = null,
    Object? broadcasterUserId = null,
    Object? category = null,
    Object? channelDescription = null,
    Object? slug = null,
    Object? stream = null,
    Object? streamTitle = null,
  }) {
    return _then(_KickChannelDto(
      bannerPicture: null == bannerPicture
          ? _self.bannerPicture
          : bannerPicture // ignore: cast_nullable_to_non_nullable
              as String,
      broadcasterUserId: null == broadcasterUserId
          ? _self.broadcasterUserId
          : broadcasterUserId // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as KickCategoryDTO,
      channelDescription: null == channelDescription
          ? _self.channelDescription
          : channelDescription // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      stream: null == stream
          ? _self.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as KickChannelStreamDto,
      streamTitle: null == streamTitle
          ? _self.streamTitle
          : streamTitle // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of KickChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KickCategoryDTOCopyWith<$Res> get category {
    return $KickCategoryDTOCopyWith<$Res>(_self.category, (value) {
      return _then(_self.copyWith(category: value));
    });
  }

  /// Create a copy of KickChannelDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KickChannelStreamDtoCopyWith<$Res> get stream {
    return $KickChannelStreamDtoCopyWith<$Res>(_self.stream, (value) {
      return _then(_self.copyWith(stream: value));
    });
  }
}

/// @nodoc
mixin _$KickChannelStreamDto {
  @JsonKey(name: 'is_live')
  bool get isLive;
  @JsonKey(name: 'is_mature')
  bool get isMature;
  String get key;
  String get language;
  @JsonKey(name: 'start_time')
  String get startTime;
  String get thumbnail;
  String get url;
  @JsonKey(name: 'viewer_count')
  int get viewerCount;

  /// Create a copy of KickChannelStreamDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KickChannelStreamDtoCopyWith<KickChannelStreamDto> get copyWith =>
      _$KickChannelStreamDtoCopyWithImpl<KickChannelStreamDto>(
          this as KickChannelStreamDto, _$identity);

  /// Serializes this KickChannelStreamDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KickChannelStreamDto &&
            (identical(other.isLive, isLive) || other.isLive == isLive) &&
            (identical(other.isMature, isMature) ||
                other.isMature == isMature) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.viewerCount, viewerCount) ||
                other.viewerCount == viewerCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isLive, isMature, key, language,
      startTime, thumbnail, url, viewerCount);

  @override
  String toString() {
    return 'KickChannelStreamDto(isLive: $isLive, isMature: $isMature, key: $key, language: $language, startTime: $startTime, thumbnail: $thumbnail, url: $url, viewerCount: $viewerCount)';
  }
}

/// @nodoc
abstract mixin class $KickChannelStreamDtoCopyWith<$Res> {
  factory $KickChannelStreamDtoCopyWith(KickChannelStreamDto value,
          $Res Function(KickChannelStreamDto) _then) =
      _$KickChannelStreamDtoCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'is_live') bool isLive,
      @JsonKey(name: 'is_mature') bool isMature,
      String key,
      String language,
      @JsonKey(name: 'start_time') String startTime,
      String thumbnail,
      String url,
      @JsonKey(name: 'viewer_count') int viewerCount});
}

/// @nodoc
class _$KickChannelStreamDtoCopyWithImpl<$Res>
    implements $KickChannelStreamDtoCopyWith<$Res> {
  _$KickChannelStreamDtoCopyWithImpl(this._self, this._then);

  final KickChannelStreamDto _self;
  final $Res Function(KickChannelStreamDto) _then;

  /// Create a copy of KickChannelStreamDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLive = null,
    Object? isMature = null,
    Object? key = null,
    Object? language = null,
    Object? startTime = null,
    Object? thumbnail = null,
    Object? url = null,
    Object? viewerCount = null,
  }) {
    return _then(_self.copyWith(
      isLive: null == isLive
          ? _self.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool,
      isMature: null == isMature
          ? _self.isMature
          : isMature // ignore: cast_nullable_to_non_nullable
              as bool,
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      viewerCount: null == viewerCount
          ? _self.viewerCount
          : viewerCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _KickChannelStreamDto implements KickChannelStreamDto {
  const _KickChannelStreamDto(
      {@JsonKey(name: 'is_live') required this.isLive,
      @JsonKey(name: 'is_mature') required this.isMature,
      required this.key,
      required this.language,
      @JsonKey(name: 'start_time') required this.startTime,
      required this.thumbnail,
      required this.url,
      @JsonKey(name: 'viewer_count') required this.viewerCount});
  factory _KickChannelStreamDto.fromJson(Map<String, dynamic> json) =>
      _$KickChannelStreamDtoFromJson(json);

  @override
  @JsonKey(name: 'is_live')
  final bool isLive;
  @override
  @JsonKey(name: 'is_mature')
  final bool isMature;
  @override
  final String key;
  @override
  final String language;
  @override
  @JsonKey(name: 'start_time')
  final String startTime;
  @override
  final String thumbnail;
  @override
  final String url;
  @override
  @JsonKey(name: 'viewer_count')
  final int viewerCount;

  /// Create a copy of KickChannelStreamDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KickChannelStreamDtoCopyWith<_KickChannelStreamDto> get copyWith =>
      __$KickChannelStreamDtoCopyWithImpl<_KickChannelStreamDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KickChannelStreamDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KickChannelStreamDto &&
            (identical(other.isLive, isLive) || other.isLive == isLive) &&
            (identical(other.isMature, isMature) ||
                other.isMature == isMature) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.viewerCount, viewerCount) ||
                other.viewerCount == viewerCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isLive, isMature, key, language,
      startTime, thumbnail, url, viewerCount);

  @override
  String toString() {
    return 'KickChannelStreamDto(isLive: $isLive, isMature: $isMature, key: $key, language: $language, startTime: $startTime, thumbnail: $thumbnail, url: $url, viewerCount: $viewerCount)';
  }
}

/// @nodoc
abstract mixin class _$KickChannelStreamDtoCopyWith<$Res>
    implements $KickChannelStreamDtoCopyWith<$Res> {
  factory _$KickChannelStreamDtoCopyWith(_KickChannelStreamDto value,
          $Res Function(_KickChannelStreamDto) _then) =
      __$KickChannelStreamDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'is_live') bool isLive,
      @JsonKey(name: 'is_mature') bool isMature,
      String key,
      String language,
      @JsonKey(name: 'start_time') String startTime,
      String thumbnail,
      String url,
      @JsonKey(name: 'viewer_count') int viewerCount});
}

/// @nodoc
class __$KickChannelStreamDtoCopyWithImpl<$Res>
    implements _$KickChannelStreamDtoCopyWith<$Res> {
  __$KickChannelStreamDtoCopyWithImpl(this._self, this._then);

  final _KickChannelStreamDto _self;
  final $Res Function(_KickChannelStreamDto) _then;

  /// Create a copy of KickChannelStreamDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLive = null,
    Object? isMature = null,
    Object? key = null,
    Object? language = null,
    Object? startTime = null,
    Object? thumbnail = null,
    Object? url = null,
    Object? viewerCount = null,
  }) {
    return _then(_KickChannelStreamDto(
      isLive: null == isLive
          ? _self.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool,
      isMature: null == isMature
          ? _self.isMature
          : isMature // ignore: cast_nullable_to_non_nullable
              as bool,
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      viewerCount: null == viewerCount
          ? _self.viewerCount
          : viewerCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
