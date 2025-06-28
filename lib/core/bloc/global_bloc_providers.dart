import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/di/injection_container.dart' as di;
import '../base/blocs/base_bloc.dart';
import 'package:flutter_task/features/home/presentation/bloc/home_bloc.dart';

class GlobalBlocProviders {
  dynamic providers = [
    BlocProvider(create: (_) => di.sl<BaseBloc>()),
    BlocProvider(create: (_) => di.sl<HomeBloc>()),
  ];
}
