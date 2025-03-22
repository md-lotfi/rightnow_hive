// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'UpdateProfileEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdateProfileEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> profile) saveProfile,
    required TResult Function() distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> profile)? saveProfile,
    TResult? Function()? distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> profile)? saveProfile,
    TResult Function()? distract,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SaveProfile value) saveProfile,
    required TResult Function(Distract value) distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SaveProfile value)? saveProfile,
    TResult? Function(Distract value)? distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SaveProfile value)? saveProfile,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProfileEventCopyWith<$Res> {
  factory $UpdateProfileEventCopyWith(
          UpdateProfileEvent value, $Res Function(UpdateProfileEvent) then) =
      _$UpdateProfileEventCopyWithImpl<$Res, UpdateProfileEvent>;
}

/// @nodoc
class _$UpdateProfileEventCopyWithImpl<$Res, $Val extends UpdateProfileEvent>
    implements $UpdateProfileEventCopyWith<$Res> {
  _$UpdateProfileEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SaveProfileImplCopyWith<$Res> {
  factory _$$SaveProfileImplCopyWith(
          _$SaveProfileImpl value, $Res Function(_$SaveProfileImpl) then) =
      __$$SaveProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> profile});
}

/// @nodoc
class __$$SaveProfileImplCopyWithImpl<$Res>
    extends _$UpdateProfileEventCopyWithImpl<$Res, _$SaveProfileImpl>
    implements _$$SaveProfileImplCopyWith<$Res> {
  __$$SaveProfileImplCopyWithImpl(
      _$SaveProfileImpl _value, $Res Function(_$SaveProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
  }) {
    return _then(_$SaveProfileImpl(
      null == profile
          ? _value._profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$SaveProfileImpl with DiagnosticableTreeMixin implements SaveProfile {
  const _$SaveProfileImpl(final Map<String, dynamic> profile)
      : _profile = profile;

  final Map<String, dynamic> _profile;
  @override
  Map<String, dynamic> get profile {
    if (_profile is EqualUnmodifiableMapView) return _profile;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_profile);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UpdateProfileEvent.saveProfile(profile: $profile)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UpdateProfileEvent.saveProfile'))
      ..add(DiagnosticsProperty('profile', profile));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveProfileImpl &&
            const DeepCollectionEquality().equals(other._profile, _profile));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_profile));

  /// Create a copy of UpdateProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveProfileImplCopyWith<_$SaveProfileImpl> get copyWith =>
      __$$SaveProfileImplCopyWithImpl<_$SaveProfileImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> profile) saveProfile,
    required TResult Function() distract,
  }) {
    return saveProfile(profile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> profile)? saveProfile,
    TResult? Function()? distract,
  }) {
    return saveProfile?.call(profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> profile)? saveProfile,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (saveProfile != null) {
      return saveProfile(profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SaveProfile value) saveProfile,
    required TResult Function(Distract value) distract,
  }) {
    return saveProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SaveProfile value)? saveProfile,
    TResult? Function(Distract value)? distract,
  }) {
    return saveProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SaveProfile value)? saveProfile,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (saveProfile != null) {
      return saveProfile(this);
    }
    return orElse();
  }
}

abstract class SaveProfile implements UpdateProfileEvent {
  const factory SaveProfile(final Map<String, dynamic> profile) =
      _$SaveProfileImpl;

  Map<String, dynamic> get profile;

  /// Create a copy of UpdateProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveProfileImplCopyWith<_$SaveProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DistractImplCopyWith<$Res> {
  factory _$$DistractImplCopyWith(
          _$DistractImpl value, $Res Function(_$DistractImpl) then) =
      __$$DistractImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DistractImplCopyWithImpl<$Res>
    extends _$UpdateProfileEventCopyWithImpl<$Res, _$DistractImpl>
    implements _$$DistractImplCopyWith<$Res> {
  __$$DistractImplCopyWithImpl(
      _$DistractImpl _value, $Res Function(_$DistractImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DistractImpl with DiagnosticableTreeMixin implements Distract {
  const _$DistractImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UpdateProfileEvent.distract()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'UpdateProfileEvent.distract'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DistractImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> profile) saveProfile,
    required TResult Function() distract,
  }) {
    return distract();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> profile)? saveProfile,
    TResult? Function()? distract,
  }) {
    return distract?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> profile)? saveProfile,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (distract != null) {
      return distract();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SaveProfile value) saveProfile,
    required TResult Function(Distract value) distract,
  }) {
    return distract(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SaveProfile value)? saveProfile,
    TResult? Function(Distract value)? distract,
  }) {
    return distract?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SaveProfile value)? saveProfile,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (distract != null) {
      return distract(this);
    }
    return orElse();
  }
}

abstract class Distract implements UpdateProfileEvent {
  const factory Distract() = _$DistractImpl;
}
