import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../flavors/build_config.dart';

enum AppStatus { initial, loading, failed, success }

class BaseState extends Equatable {
  final AppStatus? status;
  final ThemeMode? themeMode;

  const BaseState({this.status, this.themeMode});

  BaseState.initial()
      : status = AppStatus.initial,
        themeMode = BuildConfig.instance.config.themeMode
       ;

  BaseState copyWith(
      {AppStatus? appStatus, ThemeMode? themeMode, Locale? locale}) {
    return BaseState(
        status: status ?? status,
        themeMode: themeMode ?? this.themeMode,
       );
  }

  @override
  List<Object?> get props => [status, themeMode];
}
