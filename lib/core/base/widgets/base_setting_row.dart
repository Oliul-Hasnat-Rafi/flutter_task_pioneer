import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/app_context.dart';
import '../blocs/base_bloc.dart';
import '../blocs/base_event.dart';
import '../blocs/base_state.dart';

class ChangeSetting
    extends
        StatelessWidget {
  const ChangeSetting({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocBuilder<
      BaseBloc,
      BaseState
    >(
      builder: (
        context,
        state,
      ) {
        return Row(
          crossAxisAlignment:
              CrossAxisAlignment.center,
          mainAxisAlignment:
              MainAxisAlignment.end,
          mainAxisSize:
              MainAxisSize.max,
          children: [
            IconButton(
              color:
                  state.themeMode ==
                          ThemeMode.dark
                      ? Theme.of(
                        AppContext.context,
                      ).colorScheme.surface
                      : Theme.of(
                        AppContext.context,
                      ).colorScheme.onSurface,
              onPressed: () {
                context
                    .read<
                      BaseBloc
                    >()
                    .add(
                      ChangeThemeEvent(
                        themeMode:
                            state.themeMode ==
                                    ThemeMode.dark
                                ? ThemeMode.light
                                : ThemeMode.dark,
                      ),
                    );
              },
              icon:
                  state.themeMode ==
                          ThemeMode.dark
                      ? const CircleAvatar(
                        child: Icon(
                          Icons.light_mode_outlined,
                        ),
                      )
                      : const CircleAvatar(
                        child: Icon(
                          Icons.dark_mode,
                        ),
                      ),
            ),
          ],
        );
      },
    );
  }
}
