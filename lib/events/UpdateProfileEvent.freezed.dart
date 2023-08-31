// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'UpdateProfileEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UpdateProfileEventTearOff {
  const _$UpdateProfileEventTearOff();

  SaveProfile saveProfile(Map<String, dynamic> profile) {
    return SaveProfile(
      profile,
    );
  }

  Distract distract() {
    return const Distract();
  }
}

/// @nodoc
const $UpdateProfileEvent = _$UpdateProfileEventTearOff();

/// @nodoc
mixin _$UpdateProfileEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> profile) saveProfile,
    required TResult Function() distract,
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
      _$UpdateProfileEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$UpdateProfileEventCopyWithImpl<$Res>
    implements $UpdateProfileEventCopyWith<$Res> {
  _$UpdateProfileEventCopyWithImpl(this._value, this._then);

  final UpdateProfileEvent _value;
  // ignore: unused_field
  final $Res Function(UpdateProfileEvent) _then;
}

/// @nodoc
abstract class $SaveProfileCopyWith<$Res> {
  factory $SaveProfileCopyWith(
          SaveProfile value, $Res Function(SaveProfile) then) =
      _$SaveProfileCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic> profile});
}

/// @nodoc
class _$SaveProfileCopyWithImpl<$Res>
    extends _$UpdateProfileEventCopyWithImpl<$Res>
    implements $SaveProfileCopyWith<$Res> {
  _$SaveProfileCopyWithImpl(
      SaveProfile _value, $Res Function(SaveProfile) _then)
      : super(_value, (v) => _then(v as SaveProfile));

  @override
  SaveProfile get _value => super._value as SaveProfile;

  @override
  $Res call({
    Object? profile = freezed,
  }) {
    return _then(SaveProfile(
      profile == freezed
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$SaveProfile with DiagnosticableTreeMixin implements SaveProfile {
  const _$SaveProfile(this.profile);

  @override
  final Map<String, dynamic> profile;

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SaveProfile &&
            (identical(other.profile, profile) ||
                const DeepCollectionEquality().equals(other.profile, profile)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(profile);

  @JsonKey(ignore: true)
  @override
  $SaveProfileCopyWith<SaveProfile> get copyWith =>
      _$SaveProfileCopyWithImpl<SaveProfile>(this, _$identity);

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
  const factory SaveProfile(Map<String, dynamic> profile) = _$SaveProfile;

  Map<String, dynamic> get profile => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SaveProfileCopyWith<SaveProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistractCopyWith<$Res> {
  factory $DistractCopyWith(Distract value, $Res Function(Distract) then) =
      _$DistractCopyWithImpl<$Res>;
}

/// @nodoc
class _$DistractCopyWithImpl<$Res>
    extends _$UpdateProfileEventCopyWithImpl<$Res>
    implements $DistractCopyWith<$Res> {
  _$DistractCopyWithImpl(Distract _value, $Res Function(Distract) _then)
      : super(_value, (v) => _then(v as Distract));

  @override
  Distract get _value => super._value as Distract;
}

/// @nodoc

class _$Distract with DiagnosticableTreeMixin implements Distract {
  const _$Distract();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UpdateProfileEvent.distract()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'UpdateProfileEvent.distract'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Distract);
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
  const factory Distract() = _$Distract;
}
