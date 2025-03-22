// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'RegistrationEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegistrationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LocalUser localUser) registerUser,
    required TResult Function(LocalUser localUser) loginUser,
    required TResult Function() getUser,
    required TResult Function() getUserProfile,
    required TResult Function(Profile profile) setUserProfile,
    required TResult Function() distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LocalUser localUser)? registerUser,
    TResult? Function(LocalUser localUser)? loginUser,
    TResult? Function()? getUser,
    TResult? Function()? getUserProfile,
    TResult? Function(Profile profile)? setUserProfile,
    TResult? Function()? distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LocalUser localUser)? registerUser,
    TResult Function(LocalUser localUser)? loginUser,
    TResult Function()? getUser,
    TResult Function()? getUserProfile,
    TResult Function(Profile profile)? setUserProfile,
    TResult Function()? distract,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) registerUser,
    required TResult Function(LoginUser value) loginUser,
    required TResult Function(GetUser value) getUser,
    required TResult Function(GetUserProfile value) getUserProfile,
    required TResult Function(SetUserProfile value) setUserProfile,
    required TResult Function(Distract value) distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? registerUser,
    TResult? Function(LoginUser value)? loginUser,
    TResult? Function(GetUser value)? getUser,
    TResult? Function(GetUserProfile value)? getUserProfile,
    TResult? Function(SetUserProfile value)? setUserProfile,
    TResult? Function(Distract value)? distract,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? registerUser,
    TResult Function(LoginUser value)? loginUser,
    TResult Function(GetUser value)? getUser,
    TResult Function(GetUserProfile value)? getUserProfile,
    TResult Function(SetUserProfile value)? setUserProfile,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationEventCopyWith<$Res> {
  factory $RegistrationEventCopyWith(
          RegistrationEvent value, $Res Function(RegistrationEvent) then) =
      _$RegistrationEventCopyWithImpl<$Res, RegistrationEvent>;
}

/// @nodoc
class _$RegistrationEventCopyWithImpl<$Res, $Val extends RegistrationEvent>
    implements $RegistrationEventCopyWith<$Res> {
  _$RegistrationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RegisterUserImplCopyWith<$Res> {
  factory _$$RegisterUserImplCopyWith(
          _$RegisterUserImpl value, $Res Function(_$RegisterUserImpl) then) =
      __$$RegisterUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LocalUser localUser});
}

/// @nodoc
class __$$RegisterUserImplCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res, _$RegisterUserImpl>
    implements _$$RegisterUserImplCopyWith<$Res> {
  __$$RegisterUserImplCopyWithImpl(
      _$RegisterUserImpl _value, $Res Function(_$RegisterUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localUser = null,
  }) {
    return _then(_$RegisterUserImpl(
      null == localUser
          ? _value.localUser
          : localUser // ignore: cast_nullable_to_non_nullable
              as LocalUser,
    ));
  }
}

/// @nodoc

class _$RegisterUserImpl with DiagnosticableTreeMixin implements RegisterUser {
  const _$RegisterUserImpl(this.localUser);

  @override
  final LocalUser localUser;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegistrationEvent.registerUser(localUser: $localUser)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegistrationEvent.registerUser'))
      ..add(DiagnosticsProperty('localUser', localUser));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterUserImpl &&
            (identical(other.localUser, localUser) ||
                other.localUser == localUser));
  }

  @override
  int get hashCode => Object.hash(runtimeType, localUser);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterUserImplCopyWith<_$RegisterUserImpl> get copyWith =>
      __$$RegisterUserImplCopyWithImpl<_$RegisterUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LocalUser localUser) registerUser,
    required TResult Function(LocalUser localUser) loginUser,
    required TResult Function() getUser,
    required TResult Function() getUserProfile,
    required TResult Function(Profile profile) setUserProfile,
    required TResult Function() distract,
  }) {
    return registerUser(localUser);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LocalUser localUser)? registerUser,
    TResult? Function(LocalUser localUser)? loginUser,
    TResult? Function()? getUser,
    TResult? Function()? getUserProfile,
    TResult? Function(Profile profile)? setUserProfile,
    TResult? Function()? distract,
  }) {
    return registerUser?.call(localUser);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LocalUser localUser)? registerUser,
    TResult Function(LocalUser localUser)? loginUser,
    TResult Function()? getUser,
    TResult Function()? getUserProfile,
    TResult Function(Profile profile)? setUserProfile,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (registerUser != null) {
      return registerUser(localUser);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) registerUser,
    required TResult Function(LoginUser value) loginUser,
    required TResult Function(GetUser value) getUser,
    required TResult Function(GetUserProfile value) getUserProfile,
    required TResult Function(SetUserProfile value) setUserProfile,
    required TResult Function(Distract value) distract,
  }) {
    return registerUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? registerUser,
    TResult? Function(LoginUser value)? loginUser,
    TResult? Function(GetUser value)? getUser,
    TResult? Function(GetUserProfile value)? getUserProfile,
    TResult? Function(SetUserProfile value)? setUserProfile,
    TResult? Function(Distract value)? distract,
  }) {
    return registerUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? registerUser,
    TResult Function(LoginUser value)? loginUser,
    TResult Function(GetUser value)? getUser,
    TResult Function(GetUserProfile value)? getUserProfile,
    TResult Function(SetUserProfile value)? setUserProfile,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (registerUser != null) {
      return registerUser(this);
    }
    return orElse();
  }
}

abstract class RegisterUser implements RegistrationEvent {
  const factory RegisterUser(final LocalUser localUser) = _$RegisterUserImpl;

  LocalUser get localUser;

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterUserImplCopyWith<_$RegisterUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginUserImplCopyWith<$Res> {
  factory _$$LoginUserImplCopyWith(
          _$LoginUserImpl value, $Res Function(_$LoginUserImpl) then) =
      __$$LoginUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LocalUser localUser});
}

/// @nodoc
class __$$LoginUserImplCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res, _$LoginUserImpl>
    implements _$$LoginUserImplCopyWith<$Res> {
  __$$LoginUserImplCopyWithImpl(
      _$LoginUserImpl _value, $Res Function(_$LoginUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localUser = null,
  }) {
    return _then(_$LoginUserImpl(
      null == localUser
          ? _value.localUser
          : localUser // ignore: cast_nullable_to_non_nullable
              as LocalUser,
    ));
  }
}

/// @nodoc

class _$LoginUserImpl with DiagnosticableTreeMixin implements LoginUser {
  const _$LoginUserImpl(this.localUser);

  @override
  final LocalUser localUser;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegistrationEvent.loginUser(localUser: $localUser)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegistrationEvent.loginUser'))
      ..add(DiagnosticsProperty('localUser', localUser));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginUserImpl &&
            (identical(other.localUser, localUser) ||
                other.localUser == localUser));
  }

  @override
  int get hashCode => Object.hash(runtimeType, localUser);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginUserImplCopyWith<_$LoginUserImpl> get copyWith =>
      __$$LoginUserImplCopyWithImpl<_$LoginUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LocalUser localUser) registerUser,
    required TResult Function(LocalUser localUser) loginUser,
    required TResult Function() getUser,
    required TResult Function() getUserProfile,
    required TResult Function(Profile profile) setUserProfile,
    required TResult Function() distract,
  }) {
    return loginUser(localUser);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LocalUser localUser)? registerUser,
    TResult? Function(LocalUser localUser)? loginUser,
    TResult? Function()? getUser,
    TResult? Function()? getUserProfile,
    TResult? Function(Profile profile)? setUserProfile,
    TResult? Function()? distract,
  }) {
    return loginUser?.call(localUser);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LocalUser localUser)? registerUser,
    TResult Function(LocalUser localUser)? loginUser,
    TResult Function()? getUser,
    TResult Function()? getUserProfile,
    TResult Function(Profile profile)? setUserProfile,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (loginUser != null) {
      return loginUser(localUser);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) registerUser,
    required TResult Function(LoginUser value) loginUser,
    required TResult Function(GetUser value) getUser,
    required TResult Function(GetUserProfile value) getUserProfile,
    required TResult Function(SetUserProfile value) setUserProfile,
    required TResult Function(Distract value) distract,
  }) {
    return loginUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? registerUser,
    TResult? Function(LoginUser value)? loginUser,
    TResult? Function(GetUser value)? getUser,
    TResult? Function(GetUserProfile value)? getUserProfile,
    TResult? Function(SetUserProfile value)? setUserProfile,
    TResult? Function(Distract value)? distract,
  }) {
    return loginUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? registerUser,
    TResult Function(LoginUser value)? loginUser,
    TResult Function(GetUser value)? getUser,
    TResult Function(GetUserProfile value)? getUserProfile,
    TResult Function(SetUserProfile value)? setUserProfile,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (loginUser != null) {
      return loginUser(this);
    }
    return orElse();
  }
}

abstract class LoginUser implements RegistrationEvent {
  const factory LoginUser(final LocalUser localUser) = _$LoginUserImpl;

  LocalUser get localUser;

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginUserImplCopyWith<_$LoginUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetUserImplCopyWith<$Res> {
  factory _$$GetUserImplCopyWith(
          _$GetUserImpl value, $Res Function(_$GetUserImpl) then) =
      __$$GetUserImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetUserImplCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res, _$GetUserImpl>
    implements _$$GetUserImplCopyWith<$Res> {
  __$$GetUserImplCopyWithImpl(
      _$GetUserImpl _value, $Res Function(_$GetUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetUserImpl with DiagnosticableTreeMixin implements GetUser {
  const _$GetUserImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegistrationEvent.getUser()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'RegistrationEvent.getUser'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetUserImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LocalUser localUser) registerUser,
    required TResult Function(LocalUser localUser) loginUser,
    required TResult Function() getUser,
    required TResult Function() getUserProfile,
    required TResult Function(Profile profile) setUserProfile,
    required TResult Function() distract,
  }) {
    return getUser();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LocalUser localUser)? registerUser,
    TResult? Function(LocalUser localUser)? loginUser,
    TResult? Function()? getUser,
    TResult? Function()? getUserProfile,
    TResult? Function(Profile profile)? setUserProfile,
    TResult? Function()? distract,
  }) {
    return getUser?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LocalUser localUser)? registerUser,
    TResult Function(LocalUser localUser)? loginUser,
    TResult Function()? getUser,
    TResult Function()? getUserProfile,
    TResult Function(Profile profile)? setUserProfile,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (getUser != null) {
      return getUser();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) registerUser,
    required TResult Function(LoginUser value) loginUser,
    required TResult Function(GetUser value) getUser,
    required TResult Function(GetUserProfile value) getUserProfile,
    required TResult Function(SetUserProfile value) setUserProfile,
    required TResult Function(Distract value) distract,
  }) {
    return getUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? registerUser,
    TResult? Function(LoginUser value)? loginUser,
    TResult? Function(GetUser value)? getUser,
    TResult? Function(GetUserProfile value)? getUserProfile,
    TResult? Function(SetUserProfile value)? setUserProfile,
    TResult? Function(Distract value)? distract,
  }) {
    return getUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? registerUser,
    TResult Function(LoginUser value)? loginUser,
    TResult Function(GetUser value)? getUser,
    TResult Function(GetUserProfile value)? getUserProfile,
    TResult Function(SetUserProfile value)? setUserProfile,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (getUser != null) {
      return getUser(this);
    }
    return orElse();
  }
}

abstract class GetUser implements RegistrationEvent {
  const factory GetUser() = _$GetUserImpl;
}

/// @nodoc
abstract class _$$GetUserProfileImplCopyWith<$Res> {
  factory _$$GetUserProfileImplCopyWith(_$GetUserProfileImpl value,
          $Res Function(_$GetUserProfileImpl) then) =
      __$$GetUserProfileImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetUserProfileImplCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res, _$GetUserProfileImpl>
    implements _$$GetUserProfileImplCopyWith<$Res> {
  __$$GetUserProfileImplCopyWithImpl(
      _$GetUserProfileImpl _value, $Res Function(_$GetUserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetUserProfileImpl
    with DiagnosticableTreeMixin
    implements GetUserProfile {
  const _$GetUserProfileImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegistrationEvent.getUserProfile()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'RegistrationEvent.getUserProfile'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetUserProfileImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LocalUser localUser) registerUser,
    required TResult Function(LocalUser localUser) loginUser,
    required TResult Function() getUser,
    required TResult Function() getUserProfile,
    required TResult Function(Profile profile) setUserProfile,
    required TResult Function() distract,
  }) {
    return getUserProfile();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LocalUser localUser)? registerUser,
    TResult? Function(LocalUser localUser)? loginUser,
    TResult? Function()? getUser,
    TResult? Function()? getUserProfile,
    TResult? Function(Profile profile)? setUserProfile,
    TResult? Function()? distract,
  }) {
    return getUserProfile?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LocalUser localUser)? registerUser,
    TResult Function(LocalUser localUser)? loginUser,
    TResult Function()? getUser,
    TResult Function()? getUserProfile,
    TResult Function(Profile profile)? setUserProfile,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (getUserProfile != null) {
      return getUserProfile();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) registerUser,
    required TResult Function(LoginUser value) loginUser,
    required TResult Function(GetUser value) getUser,
    required TResult Function(GetUserProfile value) getUserProfile,
    required TResult Function(SetUserProfile value) setUserProfile,
    required TResult Function(Distract value) distract,
  }) {
    return getUserProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? registerUser,
    TResult? Function(LoginUser value)? loginUser,
    TResult? Function(GetUser value)? getUser,
    TResult? Function(GetUserProfile value)? getUserProfile,
    TResult? Function(SetUserProfile value)? setUserProfile,
    TResult? Function(Distract value)? distract,
  }) {
    return getUserProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? registerUser,
    TResult Function(LoginUser value)? loginUser,
    TResult Function(GetUser value)? getUser,
    TResult Function(GetUserProfile value)? getUserProfile,
    TResult Function(SetUserProfile value)? setUserProfile,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (getUserProfile != null) {
      return getUserProfile(this);
    }
    return orElse();
  }
}

abstract class GetUserProfile implements RegistrationEvent {
  const factory GetUserProfile() = _$GetUserProfileImpl;
}

/// @nodoc
abstract class _$$SetUserProfileImplCopyWith<$Res> {
  factory _$$SetUserProfileImplCopyWith(_$SetUserProfileImpl value,
          $Res Function(_$SetUserProfileImpl) then) =
      __$$SetUserProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Profile profile});
}

/// @nodoc
class __$$SetUserProfileImplCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res, _$SetUserProfileImpl>
    implements _$$SetUserProfileImplCopyWith<$Res> {
  __$$SetUserProfileImplCopyWithImpl(
      _$SetUserProfileImpl _value, $Res Function(_$SetUserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
  }) {
    return _then(_$SetUserProfileImpl(
      null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
    ));
  }
}

/// @nodoc

class _$SetUserProfileImpl
    with DiagnosticableTreeMixin
    implements SetUserProfile {
  const _$SetUserProfileImpl(this.profile);

  @override
  final Profile profile;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegistrationEvent.setUserProfile(profile: $profile)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegistrationEvent.setUserProfile'))
      ..add(DiagnosticsProperty('profile', profile));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetUserProfileImpl &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetUserProfileImplCopyWith<_$SetUserProfileImpl> get copyWith =>
      __$$SetUserProfileImplCopyWithImpl<_$SetUserProfileImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LocalUser localUser) registerUser,
    required TResult Function(LocalUser localUser) loginUser,
    required TResult Function() getUser,
    required TResult Function() getUserProfile,
    required TResult Function(Profile profile) setUserProfile,
    required TResult Function() distract,
  }) {
    return setUserProfile(profile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LocalUser localUser)? registerUser,
    TResult? Function(LocalUser localUser)? loginUser,
    TResult? Function()? getUser,
    TResult? Function()? getUserProfile,
    TResult? Function(Profile profile)? setUserProfile,
    TResult? Function()? distract,
  }) {
    return setUserProfile?.call(profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LocalUser localUser)? registerUser,
    TResult Function(LocalUser localUser)? loginUser,
    TResult Function()? getUser,
    TResult Function()? getUserProfile,
    TResult Function(Profile profile)? setUserProfile,
    TResult Function()? distract,
    required TResult orElse(),
  }) {
    if (setUserProfile != null) {
      return setUserProfile(profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) registerUser,
    required TResult Function(LoginUser value) loginUser,
    required TResult Function(GetUser value) getUser,
    required TResult Function(GetUserProfile value) getUserProfile,
    required TResult Function(SetUserProfile value) setUserProfile,
    required TResult Function(Distract value) distract,
  }) {
    return setUserProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? registerUser,
    TResult? Function(LoginUser value)? loginUser,
    TResult? Function(GetUser value)? getUser,
    TResult? Function(GetUserProfile value)? getUserProfile,
    TResult? Function(SetUserProfile value)? setUserProfile,
    TResult? Function(Distract value)? distract,
  }) {
    return setUserProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? registerUser,
    TResult Function(LoginUser value)? loginUser,
    TResult Function(GetUser value)? getUser,
    TResult Function(GetUserProfile value)? getUserProfile,
    TResult Function(SetUserProfile value)? setUserProfile,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (setUserProfile != null) {
      return setUserProfile(this);
    }
    return orElse();
  }
}

abstract class SetUserProfile implements RegistrationEvent {
  const factory SetUserProfile(final Profile profile) = _$SetUserProfileImpl;

  Profile get profile;

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetUserProfileImplCopyWith<_$SetUserProfileImpl> get copyWith =>
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
    extends _$RegistrationEventCopyWithImpl<$Res, _$DistractImpl>
    implements _$$DistractImplCopyWith<$Res> {
  __$$DistractImplCopyWithImpl(
      _$DistractImpl _value, $Res Function(_$DistractImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DistractImpl with DiagnosticableTreeMixin implements Distract {
  const _$DistractImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegistrationEvent.distract()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'RegistrationEvent.distract'));
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
    required TResult Function(LocalUser localUser) registerUser,
    required TResult Function(LocalUser localUser) loginUser,
    required TResult Function() getUser,
    required TResult Function() getUserProfile,
    required TResult Function(Profile profile) setUserProfile,
    required TResult Function() distract,
  }) {
    return distract();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LocalUser localUser)? registerUser,
    TResult? Function(LocalUser localUser)? loginUser,
    TResult? Function()? getUser,
    TResult? Function()? getUserProfile,
    TResult? Function(Profile profile)? setUserProfile,
    TResult? Function()? distract,
  }) {
    return distract?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LocalUser localUser)? registerUser,
    TResult Function(LocalUser localUser)? loginUser,
    TResult Function()? getUser,
    TResult Function()? getUserProfile,
    TResult Function(Profile profile)? setUserProfile,
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
    required TResult Function(RegisterUser value) registerUser,
    required TResult Function(LoginUser value) loginUser,
    required TResult Function(GetUser value) getUser,
    required TResult Function(GetUserProfile value) getUserProfile,
    required TResult Function(SetUserProfile value) setUserProfile,
    required TResult Function(Distract value) distract,
  }) {
    return distract(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? registerUser,
    TResult? Function(LoginUser value)? loginUser,
    TResult? Function(GetUser value)? getUser,
    TResult? Function(GetUserProfile value)? getUserProfile,
    TResult? Function(SetUserProfile value)? setUserProfile,
    TResult? Function(Distract value)? distract,
  }) {
    return distract?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? registerUser,
    TResult Function(LoginUser value)? loginUser,
    TResult Function(GetUser value)? getUser,
    TResult Function(GetUserProfile value)? getUserProfile,
    TResult Function(SetUserProfile value)? setUserProfile,
    TResult Function(Distract value)? distract,
    required TResult orElse(),
  }) {
    if (distract != null) {
      return distract(this);
    }
    return orElse();
  }
}

abstract class Distract implements RegistrationEvent {
  const factory Distract() = _$DistractImpl;
}
