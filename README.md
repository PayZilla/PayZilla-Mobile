# pay_zilla

This project contains 2 flavors:

- dev
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# dev
$ flutter run --target lib/main_dev.dart

# Production
$ flutter run --target lib/main_production.dart
```

## Build App Bundle\

```sh
$ flutter build appbundle --flavor production --target lib/main_production.dart --release
```

## Build IPA

```sh
$ flutter build ipa --target lib/main_production.dart
```

## Build APK

```sh
$ flutter build apk --debug --target lib/main_dev.dart --split-per-abi --flavor dev
```
