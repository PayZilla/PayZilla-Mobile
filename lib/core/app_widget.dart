import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
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
    return OverlaySupport.global(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MultiProvider(
          providers: providers,
          child: MaterialApp(
            title: 'PayZilla',
            theme: AppTheme.defaultTheme(context),
            debugShowCheckedModeBanner: false,
            home: Builder(
              builder: (context) {
                final media = MediaQuery.of(context);
                Dims.setSize(media);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 1,
                  ),
                  child: Router(
                    routerDelegate: router.routerDelegate,
                    routeInformationParser: router.routeInformationParser,
                    backButtonDispatcher: RootBackButtonDispatcher(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
