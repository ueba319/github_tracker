// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'github_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GitHubEventModel _$GitHubEventModelFromJson(Map<String, dynamic> json) {
  return _GitHubEventModel.fromJson(json);
}

/// @nodoc
mixin _$GitHubEventModel {
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this GitHubEventModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GitHubEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GitHubEventModelCopyWith<GitHubEventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GitHubEventModelCopyWith<$Res> {
  factory $GitHubEventModelCopyWith(
          GitHubEventModel value, $Res Function(GitHubEventModel) then) =
      _$GitHubEventModelCopyWithImpl<$Res, GitHubEventModel>;
  @useResult
  $Res call({String type, @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$GitHubEventModelCopyWithImpl<$Res, $Val extends GitHubEventModel>
    implements $GitHubEventModelCopyWith<$Res> {
  _$GitHubEventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GitHubEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GitHubEventModelImplCopyWith<$Res>
    implements $GitHubEventModelCopyWith<$Res> {
  factory _$$GitHubEventModelImplCopyWith(_$GitHubEventModelImpl value,
          $Res Function(_$GitHubEventModelImpl) then) =
      __$$GitHubEventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$GitHubEventModelImplCopyWithImpl<$Res>
    extends _$GitHubEventModelCopyWithImpl<$Res, _$GitHubEventModelImpl>
    implements _$$GitHubEventModelImplCopyWith<$Res> {
  __$$GitHubEventModelImplCopyWithImpl(_$GitHubEventModelImpl _value,
      $Res Function(_$GitHubEventModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GitHubEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? createdAt = null,
  }) {
    return _then(_$GitHubEventModelImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GitHubEventModelImpl extends _GitHubEventModel {
  const _$GitHubEventModelImpl(
      {required this.type,
      @JsonKey(name: 'created_at') required this.createdAt})
      : super._();

  factory _$GitHubEventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GitHubEventModelImplFromJson(json);

  @override
  final String type;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'GitHubEventModel(type: $type, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GitHubEventModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, createdAt);

  /// Create a copy of GitHubEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GitHubEventModelImplCopyWith<_$GitHubEventModelImpl> get copyWith =>
      __$$GitHubEventModelImplCopyWithImpl<_$GitHubEventModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GitHubEventModelImplToJson(
      this,
    );
  }
}

abstract class _GitHubEventModel extends GitHubEventModel {
  const factory _GitHubEventModel(
          {required final String type,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$GitHubEventModelImpl;
  const _GitHubEventModel._() : super._();

  factory _GitHubEventModel.fromJson(Map<String, dynamic> json) =
      _$GitHubEventModelImpl.fromJson;

  @override
  String get type;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of GitHubEventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GitHubEventModelImplCopyWith<_$GitHubEventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
