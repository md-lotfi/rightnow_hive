// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'RegistrationEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RegistrationEventTearOff {
  const _$RegistrationEventTearOff();

  RegisterUser registerUser(LocalUser localUser) {
    return RegisterUser(
      localUser,
    );
  }

  LoginUser loginUser(LocalUser localUser) {
    return LoginUser(
      localUser,
    );
  }

  GetUser getUser() {
    return const GetUser();
  }

  GetUserProfile getUserProfile() {
    return const GetUserProfile();
  }

  SetUserProfile setUserProfile(Profile profile) {
    return SetUserProfile(
      profile,
    );
  }

  Distract distract() {
    return const Distract();
  }
}

/// @nodoc
const $RegistrationEvent = _$RegistrationEventTearOff();

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
      _$RegistrationEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$RegistrationEventCopyWithImpl<$Res>
    implements $RegistrationEventCopyWith<$Res> {
  _$RegistrationEventCopyWithImpl(this._value, this._then);

  final RegistrationEvent _value;
  // ignore: unused_field
  final $Res Function(RegistrationEvent) _then;
}

/// @nodoc
abstract class $RegisterUserCopyWith<$Res> {
  factory $RegisterUserCopyWith(
          RegisterUser value, $Res Function(RegisterUser) then) =
      _$RegisterUserCopyWithImpl<$Res>;
  $Res call({LocalUser localUser});
}

/// @nodoc
class _$RegisterUserCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res>
    implements $RegisterUserCopyWith<$Res> {
  _$RegisterUserCopyWithImpl(
      RegisterUser _value, $Res Function(RegisterUser) _then)
      : super(_value, (v) => _then(v as RegisterUser));

  @override
  RegisterUser get _value => super._value as RegisterUser;

  @override
  $Res call({
    Object? localUser = freezed,
  }) {
    return _then(RegisterUser(
      localUser == freezed
          ? _value.localUser
          : localUser // ignore: cast_nullable_to_non_nullable
              as LocalUser,
    ));
  }
}

/// @nodoc

class _$RegisterUser with DiagnosticableTreeMixin implements RegisterUser {
  const _$RegisterUser(this.localUser);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RegisterUser &&
            (identical(other.localUser, localUser) ||
                const DeepCollectionEquality()
                    .equals(other.localUser, localUser)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(localUser);

  @JsonKey(ignore: true)
  @override
  $RegisterUserCopyWith<RegisterUser> get copyWith =>
      _$RegisterUserCopyWithImpl<RegisterUser>(this, _$identity);

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
  const factory RegisterUser(LocalUser localUser) = _$RegisterUser;

  LocalUser get localUser => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegisterUserCopyWith<RegisterUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginUserCopyWith<$Res> {
  factory $LoginUserCopyWith(LoginUser value, $Res Function(LoginUser) then) =
      _$LoginUserCopyWithImpl<$Res>;
  $Res call({LocalUser localUser});
}

/// @nodoc
class _$LoginUserCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res>
    implements $LoginUserCopyWith<$Res> {
  _$LoginUserCopyWithImpl(LoginUser _value, $Res Function(LoginUser) _then)
      : super(_value, (v) => _then(v as LoginUser));

  @override
  LoginUser get _value => super._value as LoginUser;

  @override
  $Res call({
    Object? localUser = freezed,
  }) {
    return _then(LoginUser(
      localUser == freezed
          ? _value.localUser
          : localUser // ignore: cast_nullable_to_non_nullable
              as LocalUser,
    ));
  }
}

/// @nodoc

class _$LoginUser with DiagnosticableTreeMixin implements LoginUser {
  const _$LoginUser(this.localUser);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoginUser &&
            (identical(other.localUser, localUser) ||
                const DeepCollectionEquality()
                    .equals(other.localUser, localUser)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(localUser);

  @JsonKey(ignore: true)
  @override
  $LoginUserCopyWith<LoginUser> get copyWith =>
      _$LoginUserCopyWithImpl<LoginUser>(this, _$identity);

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
  const factory LoginUser(LocalUser localUser) = _$LoginUser;

  LocalUser get localUser => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginUserCopyWith<LoginUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetUserCopyWith<$Res> {
  factory $GetUserCopyWith(GetUser value, $Res Function(GetUser) then) =
      _$GetUserCopyWithImpl<$Res>;
}

/// @nodoc
class _$GetUserCopyWithImpl<$Res> extends _$RegistrationEventCopyWithImpl<$Res>
    implements $GetUserCopyWith<$Res> {
  _$GetUserCopyWithImpl(GetUser _value, $Res Function(GetUser) _then)
      : super(_value, (v) => _then(v as GetUser));

  @override
  GetUser get _value => super._value as GetUser;
}

/// @nodoc

class _$GetUser with DiagnosticableTreeMixin implements GetUser {
  const _$GetUser();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegistrationEvent.getUser()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'RegistrationEvent.getUser'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is GetUser);
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
  const factory GetUser() = _$GetUser;
}

/// @nodoc
abstract class $GetUserProfileCopyWith<$Res> {
  factory $GetUserProfileCopyWith(
          GetUserProfile value, $Res Function(GetUserProfile) then) =
      _$GetUserProfileCopyWithImpl<$Res>;
}

/// @nodoc
class _$GetUserProfileCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res>
    implements $GetUserProfileCopyWith<$Res> {
  _$GetUserProfileCopyWithImpl(
      GetUserProfile _value, $Res Function(GetUserProfile) _then)
      : super(_value, (v) => _then(v as GetUserProfile));

  @override
  GetUserProfile get _value => super._value as GetUserProfile;
}

/// @nodoc

class _$GetUserProfile with DiagnosticableTreeMixin implements GetUserProfile {
  const _$GetUserProfile();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RegistrationEvent.getUserProfile()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RegistrationEvent.getUserProfile'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is GetUserProfile);
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
  const factory GetUserProfile() = _$GetUserProfile;
}

/// @nodoc
abstract class $SetUserProfileCopyWith<$Res> {
  factory $SetUserProfileCopyWith(
          SetUserProfile value, $Res Function(SetUserProfile) then) =
      _$SetUserProfileCopyWithImpl<$Res>;
  $Res call({Profile profile});
}

/// @nodoc
class _$SetUserProfileCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res>
    implements $SetUserProfileCopyWith<$Res> {
  _$SetUserProfileCopyWithImpl(
      SetUserProfile _value, $Res Function(SetUserProfile) _then)
      : super(_value, (v) => _then(v as SetUserProfile));

  @override
  SetUserProfile get _value => super._value as SetUserProfile;

  @override
  $Res call({
    Object? profile = freezed,
  }) {
    return _then(SetUserProfile(
      profile == freezed
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
    ));
  }
}

/// @nodoc

class _$SetUserProfile with DiagnosticableTreeMixin implements SetUserProfile {
  const _$SetUserProfile(this.profile);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SetUserProfile &&
            (identical(other.profile, profile) ||
                const DeepCollectionEquality().equals(other.profile, profile)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(profile);

  @JsonKey(ignore: true)
  @override
  $SetUserProfileCopyWith<SetUserProfile> get copyWith =>
      _$SetUserProfileCopyWithImpl<SetUserProfile>(this, _$identity);

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
  const factory SetUserProfile(Profile profile) = _$SetUserProfile;

  Profile get profile => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SetUserProfileCopyWith<SetUserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistractCopyWith<$Res> {
  factory $DistractCopyWith(Distract value, $Res Function(Distract) then) =
      _$DistractCopyWithImpl<$Res>;
}

/// @nodoc
class _$DistractCopyWithImpl<$Res> extends _$RegistrationEventCopyWithImpl<$Res>
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
    return 'RegistrationEvent.distract()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'RegistrationEvent.distract'));
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
  const factory Distract() = _$Distract;
}
