# zony Project Context

> Read this file before making any changes. It describes the architecture, folder structure, and conventions of this Flutter courier/PUDO delivery app.

---

**App name**: Zony — Courier & PUDO (Pickup/Drop-off point) parcel delivery logistics app
**Package name**: `zony`
**Type**: Flutter (Android + iOS)
**Dart SDK**: `^3.7.2`
**API Base URL**: `https://api.zony.sa` — hardcoded literal in `ApiService._internal()`. No `.env`, no `--dart-define`, no `AppConfig` class, no dev/staging flavors.
**Version**: 1.0.9+10
**Market**: Saudi Arabia (API domain `.sa`, Arabic locale, WhatsApp support link)
**Fonts**: Poppins (default) / Cairo (Arabic) — chosen per-locale in `main.dart` (`locale.languageCode == 'ar' ? AppTheme.arabicTheme : AppTheme.englishTheme`). Each font only has a single `-Regular.ttf` weight registered.
**Languages**: Arabic (ar), Bengali (bn), English (en), Hindi (hi), Urdu (ur) — 5 locales via the legacy `intl_utils`/`flutter_intl` `S` class.

---

## What this app does

Zony is a courier logistics app built around **PUDOs** (Pickup/Drop-off points — physical locations, e.g. shops, that hold parcels for customer pickup). There are two user roles, each with a parallel module tree and its own bottom-tab home:

- **Courier** — role string `"courier"` (`lib/modules/couriers/`) — picks up parcels from a warehouse, delivers them to PUDO locations, and can view assigned PUDOs/parcels on a map. Handles expired-parcel returns. Bottom tabs, in order: **Home, Receiving, Delivering, More** (`CourierMainHomeScreen`).
- **PUDO Responsible** — role string `"responsible"` (`lib/modules/podu/`, folder/class-named "podu" throughout) — receives parcels handed off by couriers, manages inventory/shipments at the PUDO, hands parcels to end customers, and views revenue. Bottom tabs, in order: **Home, Receiving (`ParcelApproveScreen`), Delivering, More** (`PoduMainHomeScreen`).

Shared cross-role flows: QR/barcode scanning to identify a parcel, photo confirmation of delivery/receipt, and bottom-sheet-driven confirmation dialogs for each state transition (received, delivered, wrong location, expired).

`SplashScreen` reads `access_token`/`role` directly from `SharedPreferences` (not through `TokenStorage`), shows a 4-second delay on a yellow (`#FEE901`) background with the splash logo, then routes: `role == "courier"` → `CourierMainHomeScreen`, `role == "responsible"` → `PoduMainHomeScreen`, otherwise → `LoginCubitRoute`. Both role home screens intercept the Android back button: from a non-Home tab it jumps back to the Home tab instead of popping; from the Home tab it requires two back-presses within 2 seconds (with a toast prompt) before actually exiting.

---

## Architecture

**Feature-first, but shallow** — no clean-architecture layering (no repositories/datasources split), no DI container, and almost no Bloc/Cubit despite `flutter_bloc` being a dependency.

```
 Presentation → lib/modules/<role>/.../screens + widgets, lib/views/
 "Business logic" → mostly inline in StatefulWidget/setState; ValueNotifier controllers for tab index
 Data access → lib/services/*.dart (manual singleton service classes calling ApiService directly)
```

- **State management**: almost entirely `StatefulWidget` + `setState`. Bottom-tab index is managed via plain `ValueNotifier`-based controllers in `lib/controllers/` (not Cubits). The **only real Cubit/Bloc pair in the app** is `LoginCubit`/`LoginState` (`lib/modules/auth/cubit/`), provided via `BlocProvider` in `lib/modules/auth/view/widgets/login_cubit_route.dart`.
- **DI**: none. Every service is a manual singleton (private constructor + static `instance` getter), e.g. `ApiService.instance`, `UserService.instance`.
- **HTTP**: `package:http`, wrapped by `ApiService` (which extends `BaseApiService`). Feature service classes (`UserService`, `ParcelsService`, etc.) call `ApiService.instance` directly — no repository abstraction.
- **Navigation**: pure **Navigator 1.0**. No route table, no router package. `AppNavigator` (`lib/services/navigator.services/app_navigator.services.dart`) wraps `MaterialPageRoute` push/pop helpers; `NavigationService` holds a global `navigatorKey` so non-widget code (e.g. `ApiService` on refresh-token failure) can force-navigate to login.
- **Token management**: access/refresh token + role persisted via `TokenStorage` (SharedPreferences). `ApiService._sendRequest` auto-retries once on 401 after calling `refreshAccessToken()`, using a `Completer`-based lock so concurrent 401s share one refresh call.
- **Local storage**: `shared_preferences` only (no sqflite/Hive). `TokenStorage`, `ProfileStorage`, `PudosStorage` each own a JSON-encoded cache key for offline/cache-first reads.
- **Localization**: legacy `intl_utils`/`flutter_intl` codegen (class `S`, generated into `lib/generated/l10n.dart` + `lib/generated/intl/messages_*.dart`) from `.arb` files in `lib/l10n/intl_*.arb`. `main.dart` wires up `S.delegate`. Locale is switched/persisted via `LocaleLanguageService` (`ValueNotifier<Locale>`, key `languageCode`).
- **QR/barcode scanning**: `mobile_scanner`, wrapped in `QRScannerBottomSheet` (`lib/views/widgets/bottom_sheet/qr_scanner.dart`) and the combined scan-or-manual screen `lib/modules/recieve_parcel/screens/scanner_qr_manual.dart`.
- **Camera**: `camera` package via the reusable `CustomCameraScreen` (`lib/views/screens/custom_camera_screen.dart`), used to capture proof-of-delivery/receipt photos, uploaded through `ParcelImageService`'s 3-step signed-URL flow.
- **Maps**: actual map screen (`lib/modules/couriers/pudos&parcels/podus_map.dart`, `MyPUDOsScreen`) uses `flutter_map` + OpenStreetMap tiles with mock/placeholder coordinates — **not** `google_maps_flutter`, even though that package is a declared dependency (see Known Issues).

---

## Dependencies

```yaml
dependencies:
  flutter: sdk
  cupertino_icons: ^1.0.8
  flutter_svg: ^2.1.0
  shared_preferences: ^2.5.3
  path_provider: ^2.1.5
  http: ^1.4.0
  fluttertoast: ^8.2.12
  mobile_scanner: ^7.0.1
  camera: ^0.11.2
  flutter_map: ^8.2.1
  url_launcher: ^6.3.2
  qr_flutter: ^4.1.0
  loading_animation_widget: ^1.3.0
  rename: ^3.1.0
  flutter_launcher_icons: ^0.14.4
  flutter_localization: ^0.3.3   # declared but NOT actually used — see Known Issues
  flutter_bloc: ^9.1.1           # only used for LoginCubit
  google_maps_flutter: ^2.14.0   # declared but NOT actually used — see Known Issues

dev_dependencies:
  flutter_test: sdk
```

Android Gradle build note: Flutter's Gradle plugin now enforces minimum toolchain versions. This project currently pins Gradle 8.14 (`android/gradle/wrapper/gradle-wrapper.properties`), AGP 8.11.1 and Kotlin 2.2.20 (`android/settings.gradle.kts`) — the floor required by the installed Flutter SDK at time of writing. Expect these to need bumping again as Flutter's minimums rise (it currently warns Gradle will soon require 9.1.0+, AGP 9.0.1+, Kotlin 2.3.20+).

---

## Folder & File Summary

```
lib/
├── main.dart                          # Entry point: ensureInitialized → LocaleLanguageService.loadLocale()
│                                       # → runApp(ZonyApp). ZonyApp listens to localeNotifier, rebuilds
│                                       # MaterialApp with navigatorKey: NavigationService.navigatorKey,
│                                       # S.delegate + standard Flutter localization delegates, theme picked
│                                       # by locale (ar → Cairo, else → Poppins), home: SplashScreen.
│                                       # No routes:/onGenerateRoute table — navigation is imperative.
│
├── controllers/                       # Plain ValueNotifier-based tab controllers (NOT Cubits)
│   ├── main_home_base_controller.dart
│   ├── courier_main_home_controller.dart
│   └── pudu_main_home_controller.dart
│
├── generated/                         # Auto-generated by intl_utils (flutter_intl) — do not hand-edit
│   ├── l10n.dart                      # class S — the localization class actually wired up in main.dart
│   └── intl/messages_{all,ar,bn,en,hi,ur}.dart
│
├── l10n/                              # Two parallel localization sets (see Known Issues)
│   ├── intl_{ar,bn,en,hi,ur}.arb      # source arb for the S class (generated/) — this is the live one
│   └── app_localizations*.dart        # flutter gen-l10n output (AppLocalizations class) — NOT wired
│                                       # up in main.dart; appears to be an unused/leftover migration
│
├── models/                            # 19 plain Dart data models, manual fromJson/toJson, no codegen
│   ├── coordinates_model.dart
│   ├── parcel_model.dart / parcel_barcode_model.dart / parcel_barcode_response_model.dart
│   ├── parcel_image_field_model.dart / upload_image_response_model.dart
│   ├── get_parcel_response_model.dart / get_parcels_response_model.dart
│   ├── new_parcel_model.dart / new_parcels_response_model.dart
│   ├── update_parcel_request_model.dart
│   ├── pudo_model.dart / pudo_response_model.dart
│   ├── single_pudo_model.dart / single_pudo_response_model.dart
│   ├── my_pudos_model.dart / my_pudos_response.dart
│   ├── responsible_model.dart         # PUDO responsible person: id, name, phone
│   └── profile_model.dart / profile_response_model.dart
│
├── modules/                           # Feature modules, role-split
│   ├── auth/
│   │   ├── cubit/                     # LoginCubit + LoginState (Initial/Loading/Success(role,message)/Failure)
│   │   │                              # — the only real Bloc/Cubit pair in the app
│   │   └── view/
│   │       ├── screens/               # login, otp, forget/change password, select login role
│   │       └── widgets/               # custom appbar, text fields, language picker,
│   │                                  # login_cubit_route.dart (wraps LoginScreen in BlocProvider)
│   │
│   ├── couriers/                      # Courier-role feature set
│   │   ├── delivering/                # deliver parcels to a PUDO — screens + widgets
│   │   ├── pudos&parcels/             # list/map/detail of assigned PUDOs and parcels
│   │   │                              # (podus_map.dart: flutter_map + OSM, mock coordinates)
│   │   ├── recieve/                   # receive parcels from warehouse
│   │   ├── recieve_expired/           # expired-parcel handling/return flow
│   │   └── views/
│   │       ├── screens/main_home/     # CourierMainHomeScreen: IndexedStack [Home, Receiving,
│   │       │                          # Delivering, More] driven by CourierMainHomeController
│   │       └── widgets/
│   │
│   ├── podu/                          # PUDO-responsible-role feature set (mirrors couriers/)
│   │   ├── Recieve/                   # parcel_approve_screen.dart — approve parcels handed off by a courier
│   │   ├── deliver_customer/          # hand a parcel to the end customer
│   │   ├── inventory/                 # enter shipment, shipment details, expired, ready-to-deliver
│   │   └── views/
│   │       ├── screens/main_home/     # PoduMainHomeScreen: IndexedStack [Home, ParcelApproveScreen,
│   │       │                          # Delivering, More] driven by PuduMainHomeController
│   │       ├── screens/revenue.dart   # revenue summary screen
│   │       └── widgets/
│   │
│   └── recieve_parcel/                # Shared QR/manual scanning screen
│       ├── screens/scanner_qr_manual.dart
│       └── custom_menu_recieve.widget.dart
│
├── services/
│   ├── base_api_service.dart          # BaseApiService — raw dart:io HttpClient impl (get/postJson/
│   │                                  # patchJson/patchMultipart), ApiException, 15s timeout.
│   │                                  # Appears to be an earlier/base implementation — see Known Issues.
│   ├── api_service.dart               # ApiService extends BaseApiService, singleton, overrides
│   │                                  # get/postJson/patchJson to use package:http instead.
│   │                                  # baseUrl = "https://api.zony.sa" (hardcoded).
│   │                                  # Holds accessToken/refreshToken/role state (persisted via
│   │                                  # TokenStorage). login()/logout()/refreshAccessToken().
│   │                                  # _sendRequest: single-flight 401 retry via refreshAccessToken(),
│   │                                  # Completer-locked so concurrent 401s share one refresh call;
│   │                                  # on refresh failure, clears local data and force-navigates to
│   │                                  # LoginCubitRoute via NavigationService.navigatorKey.
│   ├── user_profile_service.dart      # UserService — GET /profile, caches via ProfileStorage
│   ├── get_res_pudos_service.dart     # ResponsiblePudoService — GET /pudos, caches via PudosStorage
│   ├── get_courier_pudos_service.dart # GetCourierPudosService — GET /pudos, GET /pudos/{id},
│   │                                  # GET /pudos?username=
│   ├── parcel_service.dart            # ParcelsService — every "get parcels" endpoint exists in TWO
│   │                                  # response-model flavors, called "old" and "New": e.g.
│   │                                  # getParcelsByPudoId → ParcelsResponse vs. getNewParcelsByPudoId
│   │                                  # → NewParcelsResponse, both hitting the identical
│   │                                  # GET /pudos/{pudoId}/parcels URL. Same pairing for status/barcode
│   │                                  # lookups. Screens call whichever variant they were written
│   │                                  # against — check the call site's model type, not just the method
│   │                                  # name, before assuming which model a screen uses.
│   ├── patch_parcels_status_service.dart  # ParcelStatusService — PATCH .../parcels/{parcelId} {status}
│   ├── upload_parsel_image_service.dart   # ParcelImageService — 3-step upload: POST sign-image-upload
│   │                                  # → PUT bytes to signed Cloudflare URL → PATCH to attach image
│   │                                  # metadata (url/timestamp/lat-lng)
│   ├── patch_update_profile.dart      # profile update endpoint
│   │
│   ├── shered_preferences/            # [sic — "shered", not "shared"]
│   │   ├── token_storage.dart         # TokenStorage — access_token, refresh_token, role
│   │   ├── profile_storage.dart       # ProfileStorage — user_profile (JSON)
│   │   └── pudos_storage.dart         # PudosStorage — pudos_list (JSON), cache-first PUDO list
│   │
│   ├── navigator.services/
│   │   ├── navigation_service.dart    # NavigationService — static navigatorKey (used outside widget tree)
│   │   └── app_navigator.services.dart # AppNavigator — navigateTo/navigateAndRemoveUntil/replaceWith/
│   │                                  # pop/popUntil, all MaterialPageRoute-based
│   │
│   ├── helpers/
│   │   ├── get_phone_number.dart      # phone number formatting for tel:/WhatsApp links
│   │   ├── open_in_google_maps.dart   # openInGoogleMaps({lat,lng}) via url_launcher, null/zero-guarded
│   │   └── dummy_image_provider.dart  # placeholder image provider for pre-load UI states
│   │
│   ├── extensions/
│   │   └── parcel_status_extension.dart  # display label/color mapping for parcel status
│   │
│   ├── enums/
│   │   ├── parcel_status_type.dart    # courierReceived, waitingConfirmation, pudoReceived,
│   │   │                              # customerReceived, expired, expiredReceived, pending
│   │   └── parcel_image_type.dart
│   │
│   ├── external/
│   │   └── technical_support.service.dart  # TechnicalSupportService — opens WhatsApp deep link
│   │                                  # (wa.me/{phone}?text=) via url_launcher, not a real API call
│   │
│   ├── size_config.dart               # SizeConfig — percentage-based responsive sizing helper,
│   │                                  # needs SizeConfig.init(context); adoption is inconsistent
│   │
│   └── locale_language_service.dart   # LocaleLanguageService — ValueNotifier<Locale>, default en,
│                                      # persisted to SharedPreferences key "languageCode"
│
├── theme/
│   ├── app_colors.theme.dart          # AppColors — minimal: zonyPrimary (#49159B), zonyBackground
│   │                                  # (#F4F4F4). Most other colors are inlined as raw hex literals
│   │                                  # across widgets rather than centralized here — see Known Issues.
│   ├── app_languages_theme.dart       # AppTheme.arabicTheme (fontFamily: Cairo) / AppTheme.englishTheme
│   │                                  # (fontFamily: Poppins), both via ColorScheme.fromSeed(zonyPrimary)
│   └── app_text_styles.dart           # AppTextStyles — partial design-system TextStyle constants
│                                      # (textStyle14/16/18/24, bottomSheetTitle/Description, etc.);
│                                      # not fully adopted — many screens still hardcode TextStyle(...)
│
└── views/                             # App-wide shared screens/widgets (not tied to one role)
    ├── screens/
    │   ├── splash_screen.dart         # reads access_token/role from SharedPreferences directly
    │   │                              # (duplicates TokenStorage's key names as literals), warms
    │   │                              # cached profile/PUDOs, then routes via AppNavigator
    │   └── custom_camera_screen.dart  # CustomCameraScreen — reusable full-screen capture widget
    │                                  # with onPictureTaken callback (proof-of-delivery/receipt photos)
    │
    └── widgets/
        ├── bottom_sheet_container.dart        # generic bottom-sheet frame/wrapper
        ├── circler_icon.dart                  # circular icon container
        ├── custom_container_icon.widget.dart  # icon-in-box container
        ├── custom_outline_button.widget.dart  # outlined button style
        ├── custom_parcel_details.dart         # reusable parcel detail rows/card
        ├── custom_zony_logo.dart              # app logo widget
        ├── default_appbar.dart                # AppBarHaveArrow (back+title), HomeAppBar (title only)
        ├── default_button.widget.dart         # primary button style
        ├── default_navigation_bar.widget.dart # bottom nav bar (used by TemplateAppScaffold)
        ├── default_text_filed.dart            # custom text field [sic — "filed"]
        ├── loading.widget.dart                # LoadingWidget — LoadingAnimationWidget in brand purple
        ├── no_data_found.widget.dart           # empty-state widget
        ├── notifacation_item.dart              # [sic] notification list item — see Known Issues (duplicate)
        ├── notification_Item.widget.dart       # notification list item — see Known Issues (duplicate)
        ├── scanner_line.dart                   # animated scan-line for the QR scanner overlay
        ├── successful_screen.widget.dart       # generic "success" confirmation screen/widget
        ├── template_app_scaffold.widget.dart   # TemplateAppScaffold — base Scaffold wrapper
        │                                       # (bg #F4F4F4, optional bottom nav bar)
        ├── toasts.dart                         # showCorrectToast / showErrorToast via fluttertoast
        │
        └── bottom_sheet/                      # feature-specific modal bottom sheets
            ├── choose_way_bottom_sheet.dart         # choose scan-vs-manual entry method
            ├── componants_bottom_sheet.widgets.dart # shared sub-components (e.g. drag-handle header)
            ├── confirm_parcel_bottom_sheet.dart     # confirm parcel action
            ├── delivery_confirmation_bottom_sheet.dart
            ├── language_sheet.dart                  # language picker (pairs with LocaleLanguageService)
            ├── log_out_bottom_sheet.dart             # logout confirmation
            ├── manually_input_bottom_sheet.dart      # manual barcode/code entry fallback
            ├── password_bottom_sheet.widget.dart     # password entry/change
            ├── photo_confirmation_bottom_sheet.dart  # pairs with CustomCameraScreen
            ├── podu_qr_bottom_sheet.dart              # displays a PUDO's own QR code (qr_flutter)
            ├── qr_scanner.dart                       # QRScannerBottomSheet — wraps MobileScanner
            └── wrong_location_bottom_sheet.dart      # flags/handles "wrong location" delivery exception

assets/
├── images/                            # 6 files: zony-logo.png (also launcher icon source), splash_logo.jpg,
│                                       # Parcel.jpg, user.jpg, 2057.jpg, image 13.png
├── svgs/                              # ~49 status/action/nav icons (barcode, qr, approved, pending,
│                                       # expired, receiving, delivering, ready_to_deliver, transfer,
│                                       # location/map icons, home/more/account/logout nav icons, etc.)
│                                       # — a few look like un-renamed Figma exports (Frame 73509*.svg)
└── fonts/
    ├── Poppins/Poppins-Regular.ttf     # single weight only
    └── Cairo/Cairo-Regular.ttf         # single weight only
```

---

## API Endpoints (base URL `https://api.zony.sa`, all inline literals in `lib/services/*.dart`)

### Auth
| Endpoint | Used by |
|----------|---------|
| `POST /auth/login` | `ApiService.login(email, password, rememberMe)` |
| `POST /auth/logout` | `ApiService.logout()` |
| `POST /auth/refresh` | `ApiService.refreshAccessToken()` — `Authorization: Bearer <refreshToken>` |

### Profile
| Endpoint | Used by |
|----------|---------|
| `GET /profile` | `UserService` — cached via `ProfileStorage` |
| (patch) | `patch_update_profile.dart` |

### PUDOs
| Endpoint | Used by |
|----------|---------|
| `GET /pudos` | `ResponsiblePudoService`, `GetCourierPudosService` — cached via `PudosStorage` |
| `GET /pudos/{id}` | `GetCourierPudosService` |
| `GET /pudos?username=` | `GetCourierPudosService` |

### Parcels
| Endpoint | Used by |
|----------|---------|
| `GET /pudos/{pudoId}/parcels` | `getParcelsByPudoId` → `ParcelsResponse` **and** `getNewParcelsByPudoId` → `NewParcelsResponse` (same URL, two model shapes — see folder summary) |
| `GET /pudos/{pudoId}/parcels?status=` | `getParcelsByStatus`/`getNewParcelsByStatus` (same old/new split) |
| `GET /pudos/{pudoId}/parcels?barcode=` | `getParcelByBarcode` → `ParcelsResponse` **and** `getNewParcelByBarcode` → `ParcelByBarcodeResponse` — courier-to-PUDO delivery flow |
| `GET /pudos/{pudoId}/parcels?receiving_code=` | `getParcelByReceivingCode` → `NewParcelsResponse` — PUDO-to-customer delivery flow |
| `GET /pudos/{pudoId}/parcels/{parcelId}` | `getParcelDetails` → `ParcelResponse` |
| `GET /parcels?barcode=` | `getGlobalParcelByBarcode` — search without a `pudoId` |
| `GET /parcels` | `getGlobalAllParcel` |
| `PATCH /pudos/{pudoId}/parcels/{parcelId}` `{status}` | `ParcelStatusService` |
| `POST /parcels/{parcelId}/sign-image-upload` `{image_type, file_ext}` | `ParcelImageService.createSignedUrl` (step 1 of image upload) |
| `PUT <signed Cloudflare upload_url>` | `ParcelImageService.uploadToSignedUrl` (step 2 — raw bytes, direct `http.put`, no auth) |
| `PATCH /pudos/{pudoId}/parcels/{parcelId}` or `PATCH /parcels/{parcelId}` | `ParcelImageService` (step 3 — attach `{status, <imageFieldName>: {url, timestamp, location}}`; three near-duplicate methods exist for this step: `updateParcelWithPudoidAfterUpload`, `updateParcelAfterUploadByCourier`, plus a commented-out `updateParcelAfterUpload`) |

All of `ParcelsService`'s methods pass their path **without** a leading slash except the `/pudos/...` ones, which mostly do include it — `ApiService._sendRequest` builds the URL as `'$baseUrl/$endpoint'`, so a leading slash produces a harmless double slash (`https://api.zony.sa//pudos/...`). Functionally inert, but don't take the presence/absence of a leading `/` as meaningful when reading this code.

---

## Key Patterns & Conventions

### State management
- Default to `StatefulWidget` + `setState` for screen-local state — that is the established pattern everywhere except login.
- If a screen needs shared/cross-widget state, the existing precedent is a `ValueNotifier`-based controller (see `lib/controllers/`), not a new Cubit — `flutter_bloc` is present but only exercised once (`LoginCubit`). Follow the surrounding pattern in a given module rather than introducing a third state-management style.

### Networking
- Add new endpoints as methods on the relevant singleton service in `lib/services/` (or a new one following the same private-constructor/`instance` pattern), calling `ApiService.instance`. Don't reach for `package:http` directly from a screen.
- `ApiService` already handles auth headers and 401-refresh-retry — don't duplicate that logic in a feature service.

### Models
- Plain classes with manual `fromJson`/`toJson`, no `json_serializable`/codegen. Match this style for new models.

### Localization
- The **live** localization class is `S` (`lib/generated/l10n.dart`), sourced from `lib/l10n/intl_*.arb`. Edit those `.arb` files and regenerate via the `flutter_intl`/`intl_utils` tooling (`flutter pub run intl_utils:generate`), not `flutter gen-l10n` — the `AppLocalizations` files under `lib/l10n/` are not wired into `main.dart` and should be treated as inert unless a deliberate migration is undertaken.
- 5 locales: ar, bn, en, hi, ur. Arabic gets the Cairo font automatically via `AppTheme`; no per-locale font logic is needed elsewhere.

### Theming
- Centralize new colors in `AppColors` (`lib/theme/app_colors.theme.dart`) rather than inlining hex literals, even though most existing code does the latter — don't propagate the anti-pattern into new code.
- Prefer `AppTextStyles` constants over ad-hoc `TextStyle(...)` where an existing style fits.

### Navigation
- Use `AppNavigator` (`lib/services/navigator.services/app_navigator.services.dart`) for pushes/pops rather than calling `Navigator.of(context)` directly, to stay consistent with the rest of the app.

---

## Known Issues / Inconsistencies (worth knowing before touching related code)

- **Two parallel localization codegens**: `S` (`flutter_intl`/`intl_utils`, actually used) and `AppLocalizations` (`flutter gen-l10n`, generated but unused/dead). `pubspec.yaml` has both `flutter_intl: enabled: true` and `generate: true`.
- **`google_maps_flutter` is declared but never used.** The actual map screen (`podus_map.dart`) uses `flutter_map` + OpenStreetMap tiles with mock/placeholder coordinates (Washington DC area) instead. `flutter_map`/`latlong2` usage isn't reflected as a direct dependency comment concern beyond `flutter_map` itself being declared.
- **`flutter_localization` package is declared but not actually used** — real localization goes through standard `flutter_localizations` SDK + generated `S` class.
- **Two API client base classes**: `BaseApiService` (raw `dart:io HttpClient`) and `ApiService extends BaseApiService` (overrides everything to use `package:http` instead). The base class's own HTTP implementation is effectively dead code for the overridden methods.
- **Duplicate notification item widgets**: `notifacation_item.dart` and `notification_Item.widget.dart` both exist in `lib/views/widgets/`.
- **No environment/flavor config**: API base URL is a single hardcoded string; there's no dev/staging/prod split.
- **`SplashScreen` bypasses `TokenStorage`**, reading `access_token`/`role` from `SharedPreferences` directly with duplicated key-name literals instead of calling `TokenStorage`'s methods.
- **Folder name contains a literal `&`**: `lib/modules/couriers/pudos&parcels/` — be careful with shell quoting when touching this path.
- **`SizeConfig.init(context)`** is required for `SizeConfig`'s percentage helpers to work but is inconsistently called (seen commented out in `template_app_scaffold.widget.dart`).
- Several SVG assets have un-renamed Figma export names (e.g. `Frame 73509.svg`).
- **`ParcelsService` carries duplicate "old"/"New" method+model pairs** for nearly every read endpoint (e.g. `getParcelsByPudoId`/`ParcelsResponse` vs. `getNewParcelsByPudoId`/`NewParcelsResponse`), hitting identical URLs but decoding into different model classes. This looks like an in-progress API migration where the old methods were never removed — screens are split across both, so don't assume one model covers all parcel-list call sites.
- **Model and service files contain large commented-out code blocks** left in place (e.g. `parcel_model.dart`'s original `Parcel` class, `parcel_status_type.dart`'s original enum+extension, `upload_parsel_image_service.dart`'s `updateParcelAfterUpload`) rather than being deleted — when reading these files, check which version is actually active (uncommented) before reusing a pattern.
- **`ResponsiblePudoService._api` is typed as `BaseApiService`** but constructed with `ApiService.instance` — it works correctly only because Dart dispatches virtually to `ApiService`'s overridden `get()`, not `BaseApiService`'s raw-`HttpClient` implementation. Fragile if `ApiService` ever stops overriding `get()`.
