import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';

final myCardRouter = [
  GoRoute(
    path: 'start-create-card',
    builder: (context, state) => const StartCreateCardScreen(),
  ),
  GoRoute(
    path: 'card-details',
    builder: (context, state) {
      return CardDetailScreen(
        args: argsRegistry<CardDetailScreenArgs>(
          'card-details',
          state.extra,
        )!,
      );
    },
  ),
];
