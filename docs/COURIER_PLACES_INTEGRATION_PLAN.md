# Plan: Wire PUDOs & Delivery Points screens to `GET /courier/places`

## 0. Key finding — disambiguation

There are **two** "PUDO list" screens in the codebase; only one is real:

- **`AllPODUsScreen`** (`lib/modules/couriers/pudos&parcels/all_podus.dart`) — the **live "PUDOs" card** on Courier Home. Real service (`GetCourierPudosService.getAllPudos()`), real model (`MyPudosResponse`). **This is the screen to rewire.**
- `MyPUDOsScreen` (`podus_map.dart`) — a dead/orphaned map screen with hardcoded mock `MapPoint`s (Washington DC), not reachable from Home, not referenced anywhere else. **Out of scope — do not touch.**

**"Delivery Points"** is `DeliveryPointsScreen` (`lib/modules/couriers/pudos&parcels/delivery_points.dart`). Confusingly, its Home-card title comes from l10n key `myParcels` (value "Delivery Points"), while `AllPODUsScreen`'s title comes from key `podus`. Both are registered in `lib/modules/couriers/views/screens/main_home/screen/courier_home.screen.dart` via `CustomHomeServiceContainer` + `AppNavigator.navigateTo`.

## 1. Current state of each screen

### PUDOs (`AllPODUsScreen`)
- Data: `GetCourierPudosService.instance.getAllPudos()` → `MyPudosResponse` (`GET /pudos`).
- Card: inline `Container` (white, radius 12, shadow) wrapping `NotificationItem` (`lib/views/widgets/notifacation_item.dart`) — shows `pudo.name` as title, `pudo.address` as subtitle, and a **hardcoded** `time: '150 m'` trailing string (not a real field — will be dropped).
- Tap → `AppNavigator.navigateTo(... PudoDetailsAndParceis(pudoId: pudo.id.toString()))`, a 2-tab screen (`PODU Details` / `PODU Parcels`) that itself calls two more existing endpoints (`getSinglePudoById`, `getNewParcelsByPudoId`).
- **Change needed**: replace the `getAllPudos()` call + `MyPudosResponse` with a new Cubit hitting `GET /courier/places?direction=pickup`; replace the detail navigation target with a new lightweight "stop parcels" screen (since the new response already embeds `parcels[]` — no need to re-fetch pudo details/parcels via the old two calls).

### Delivery Points (`DeliveryPointsScreen`)
- Data: `ParcelsService.instance.getGlobalAllParcel()` → `ParcelsResponse` (`GET /parcels`, unfiltered global parcel list — not stop/place-based at all).
- Card: full expanded parcel-info card rendered inline via `Column(... .map())` (not a `ListView`), no tap/navigation — this screen currently *is* a flat parcel list, not a stop list.
- **Change needed**: this becomes a genuine **stop list** (mirroring the new PUDOs screen), driven by `GET /courier/places?direction=deliver`. The existing expanded per-parcel card doesn't fit "one card per stop" — reuse the **`AllPODUsScreen`/`NotificationItem` stop-card pattern** instead (see §4), not `DeliveryPointsScreen`'s current card.

### Reusable parcel-list pattern (for the new detail screen)
`PudoParcels` (`lib/modules/couriers/pudos&parcels/podu_details_and_parcels/podu_parcels.dart`) — `ListView.separated`, each row: `CirclerIcon` + two-line text (name/subtitle) + status dot. This is the "simple parcel-list UI pattern" to replicate for the new stop-detail screen, adapted to the new `parcels[]` fields (barcode/tracking + status, no re-fetch needed).

## 2. New files

### Models — `lib/models/courier_places/` (new subfolder, or flat in `lib/models/` matching existing flat convention — going flat to match convention)
- `courier_place_coordinates_model.dart` → reuse existing `CoordinatesModel` (`lib/models/coordinates_model.dart`) as-is; it already matches `{latitude, longitude}`.
- `courier_stop_place_model.dart` — `CourierStopPlaceModel { name, phoneNumber, address, CoordinatesModel? coordinates }`
- `courier_stop_window_model.dart` — `CourierStopWindowModel { slotCode?, date?, fromTime?, toTime? }`, all nullable, `fromJson` returns `null` if input map is `null`.
- `courier_stop_parcel_model.dart` — `CourierStopParcelModel { source?, id (String, parsed from either String or int), trackingRef?, trackingNumber?, barcode?, status?, recipientName? }`
- `courier_stop_model.dart` — `CourierStopModel { action, placeType, CourierStopPlaceModel place, CourierStopWindowModel? window, parcelCount, List<CourierStopParcelModel> parcels }`
- `courier_places_response_model.dart` — `CourierPlacesResponseModel { status, message, totalStops, List<CourierStopModel> stops }`

All manual `fromJson`/`toJson`, `??` defaults, no codegen — matching `coordinates_model.dart`/`my_pudos_response.dart` style. `id` parsing:
```dart
id: json['id'] is String ? json['id'] as String : json['id']?.toString() ?? '',
```

### Service
Add to **`GetCourierPudosService`** (`lib/services/get_courier_pudos_service.dart`) rather than a new service — reasoning: it's the existing home for courier-role "places/pudos" reads, keeps one place for courier location endpoints, and avoids a near-empty new singleton for one method.
```dart
Future<CourierPlacesResponseModel> getCourierPlaces({String? direction}) async {
  try {
    final response = await ApiService.instance.get(
      '/courier/places',
      queryParameters: direction != null ? {'direction': direction} : null,
    );
    return CourierPlacesResponseModel.fromJson(response);
  } catch (e) {
    rethrow;
  }
}
```
(Uses `ApiService.get`'s existing `queryParameters` param rather than string interpolation, since two call sites need two different values.)

### Cubits — `lib/modules/couriers/pudos&parcels/cubit/` (new subfolder alongside the screens, mirroring `lib/modules/auth/cubit/`)
- `courier_places_state.dart`:
```dart
abstract class CourierPlacesState {}
class CourierPlacesInitial extends CourierPlacesState {}
class CourierPlacesLoading extends CourierPlacesState {}
class CourierPlacesSuccess extends CourierPlacesState {
  final List<CourierStopModel> stops;
  CourierPlacesSuccess(this.stops);
}
class CourierPlacesFailure extends CourierPlacesState {
  final String message;
  CourierPlacesFailure({required this.message});
}
```
- `courier_places_cubit.dart` — one Cubit, parameterized by `direction` at call time (not construction), so the same class serves both screens:
```dart
class CourierPlacesCubit extends Cubit<CourierPlacesState> {
  CourierPlacesCubit() : super(CourierPlacesInitial());
  Future<void> fetchPlaces({required String direction}) async {
    emit(CourierPlacesLoading());
    try {
      final response = await GetCourierPudosService.instance.getCourierPlaces(direction: direction);
      emit(CourierPlacesSuccess(response.stops));
    } catch (e) {
      emit(CourierPlacesFailure(message: 'Failed to load places'));
    }
  }
}
```
Two `BlocProvider`s at the two screens each construct their own `CourierPlacesCubit` and call `fetchPlaces(direction: 'pickup')` / `'deliver'` — one cubit class, no duplication, still matches "each screen has its own Cubit/State pair" (own provider instance + own trigger) per the task's spirit.

### New detail screen
`lib/modules/couriers/pudos&parcels/courier_stop_parcels.screen.dart` — `CourierStopParcelsScreen(CourierStopModel stop)`, no fetch (data already in hand), renders `stop.parcels` with the `PudoParcels` `ListView.separated` card pattern (CirclerIcon + barcode/tracking text + status).

### New stop card widget
`lib/modules/couriers/pudos&parcels/widgets/courier_stop_card.widget.dart` — `CourierStopCard(CourierStopModel stop, VoidCallback onTap)`, built from the `AllPODUsScreen` card chrome (white/radius 12/shadow) + `NotificationItem`-style title/subtitle, plus: parcel count instead of the fake "150 m", a small place-type icon/label (warehouse/customer/pudo), and a time-window row shown only if `stop.window != null`. Shared by both screens since both render the identical "stop card" shape.

## 3. Existing files to modify

- **`lib/modules/couriers/pudos&parcels/all_podus.dart`** (`AllPODUsScreen`): replace `FutureBuilder<MyPudosResponse>` + `GetCourierPudosService.getAllPudos()` with `BlocProvider<CourierPlacesCubit>` + `BlocBuilder`, `fetchPlaces(direction: 'pickup')` in `initState`/provider `create`. Replace per-item `NotificationItem` block with `CourierStopCard`. Tap → `AppNavigator.navigateTo(... CourierStopParcelsScreen(stop))`.
- **`lib/modules/couriers/pudos&parcels/delivery_points.dart`** (`DeliveryPointsScreen`): replace `ParcelsService.getGlobalAllParcel()` flat-parcel rendering with the same Cubit pattern, `direction: 'deliver'`, rendering `CourierStopCard` list + navigation to `CourierStopParcelsScreen`. This is a larger rewrite of this file since its current UI shape (flat expanded parcel cards) doesn't match the new stop-based data at all.
- **`lib/l10n/intl_en.arb`** (+ `ar`, `bn`, `hi`, `ur`): add new keys — e.g. `noStopsFound`, `parcelCount` (or reuse plural pattern already in use), `warehouse`, `customer`, `pudo` (place-type labels), `viewParcels` — checking first for existing reusable keys (`noPodusFound`, `noParcelsFound`, `received` etc. already exist and should be reused where semantics match, e.g. reuse `noAddressAvailable`).
- No changes to `courier_home.screen.dart` — the Home cards already point at `AllPODUsScreen`/`DeliveryPointsScreen`; only their internals change.

## 4. Widget reuse decisions

- **Stop card**: new `CourierStopCard`, but its *chrome* (container shadow/radius) and text hierarchy are lifted directly from `AllPODUsScreen`'s existing inline card + `NotificationItem`, not built from scratch. A genuinely new widget is needed only because `NotificationItem` has no slot for parcel-count/place-type/window — those are new to this response shape.
- **Parcel-list detail**: reuse `PudoParcels`' `ListView.separated` card pattern (CirclerIcon + two-line text + status dot), copied into `CourierStopParcelsScreen` rather than importing `PudoParcels` directly, since `PudoParcels` fetches its own data by `pudoId` and this screen already has `parcels[]` in hand — no fetch needed.
- **`DeliveryPointsScreen`'s current card is dropped**, not reused — it's a flat single-parcel expanded view, structurally mismatched with stop-based data.

## 5. Loading / empty / error handling
Both screens: `BlocBuilder<CourierPlacesCubit, CourierPlacesState>` — `Loading` → `LoadingWidget` (existing, brand purple); `Success` with `stops.isEmpty` (i.e. `total_stops == 0`) → existing `NoDataFoundWidget` (`lib/views/widgets/no_data_found.widget.dart`); `Failure` → existing error-toast pattern (`showErrorToast`) + a retry affordance (reuse whatever `AllPODUsScreen`/other screens already do — likely a centered message + retry button, matching `podu_details.dart`'s `failedToFetchPudoDetails`/`tryAgain` keys).

## 6. Open questions / assumptions
1. **Window rendering**: assuming "hide the whole window row when `window == null`" and, when present, show whichever of `slot_code` vs `date` is non-null alongside `from_time`–`to_time` — no mockup given, so exact layout is my call within existing card style.
2. **Place-type indicator**: assuming a small icon/label (reusing existing SVGs where a fit exists, e.g. warehouse icon) is enough — no existing "place type badge" widget exists to copy, so this is a small new bit of UI, kept minimal per instructions.
3. **`CourierPlacesCubit` shared across both screens** (parameterized by `direction`) vs. two separate cubit classes: I'm proposing one shared cubit class with two independent instances/providers (one per screen) as the pragmatic reading of "own Cubit/State pair" — flag if you'd prefer two fully distinct cubit classes instead.
4. Assuming `GetCourierPudosService` is the right home for the new method rather than a new `CourierPlacesService` — reasoning in §2; flag if you'd rather keep it isolated given the response shape is quite different from the other methods there.
5. Not touching `MyPUDOsScreen`/`podus_map.dart` (dead code) — confirming it's out of scope per the task description (Receiving/Delivering/Expired excluded; this screen isn't reachable at all so treating it as untouched by default).
