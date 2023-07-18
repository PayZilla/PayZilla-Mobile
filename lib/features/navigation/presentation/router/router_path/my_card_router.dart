import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';

GoRoute myCardRouter() {
  return GoRoute(
    path: 'start-create-card',
    builder: (context, state) => const StartCreateCardScreen(),
    routes: [
      GoRoute(
        path: 'choose-card-style',
        builder: (context, state) => const ChooseCardStyleScreen(),
        routes: [
          GoRoute(
            path: 'edit-card',
            builder: (context, state) => EditCardScreen(
              args: argsRegistry<EditCardScreenArgs>(
                'edit-card',
                state.extra,
              )!,
            ),
          ),
        ],
      ),
    ],
  );
}
