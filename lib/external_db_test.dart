import 'package:external_db_test/core/di/service_locator.dart';
import 'package:external_db_test/core/theme/app_theme.dart';
import 'package:external_db_test/presentation/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExternalDbTest extends StatelessWidget {
  const ExternalDbTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ServiceLocator.getItemCubit()),
      ],
      child: MaterialApp(
        title: 'External DB Test',
        theme: AppTheme.lightTheme,
        home: const HomePage(),
      ),
    );
  }
}
