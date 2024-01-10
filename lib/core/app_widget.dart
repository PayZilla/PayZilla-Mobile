import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/presentation/router/base_router.dart';
import 'package:pay_zilla/providers.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final router = getBaseRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiProvider(
        providers: providers,
        child: MaterialApp.router(
          title: 'PayZilla',
          theme: AppTheme.defaultTheme(context),
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          builder: (context, child) {
            final media = MediaQuery.of(context);
            Dims.setSize(media);
            return child!;
          },
        ),
      ),
    );
  }
}
