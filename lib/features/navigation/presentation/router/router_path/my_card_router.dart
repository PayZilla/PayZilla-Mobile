import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/card/card.dart';

GoRoute myCardRouter() {
  return GoRoute(
    path: 'start-create-card',
    builder: (context, state) => const StartCreateCardScreen(),
  );
}
