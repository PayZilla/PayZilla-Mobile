import 'package:get_it/get_it.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/onboarding/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider<OnboardingProvider>(
    create: (_) => GetIt.I<OnboardingProvider>(),
  ),
  ChangeNotifierProvider<AuthProvider>(
    create: (_) => GetIt.I<AuthProvider>(),
  ),
];
