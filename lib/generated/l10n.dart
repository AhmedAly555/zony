// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `My PODUs`
  String get myPodus {
    return Intl.message('My PODUs', name: 'myPodus', desc: '', args: []);
  }

  /// `All Parcels`
  String get allParcels {
    return Intl.message('All Parcels', name: 'allParcels', desc: '', args: []);
  }

  /// `Unread`
  String get unread {
    return Intl.message('Unread', name: 'unread', desc: '', args: []);
  }

  /// `Error: `
  String get error {
    return Intl.message('Error: ', name: 'error', desc: '', args: []);
  }

  /// `No PODUs found`
  String get noPodusFound {
    return Intl.message(
      'No PODUs found',
      name: 'noPodusFound',
      desc: '',
      args: [],
    );
  }

  /// `No address available`
  String get noAddressAvailable {
    return Intl.message(
      'No address available',
      name: 'noAddressAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Username copied to clipboard`
  String get usernameCopiedToClipboard {
    return Intl.message(
      'Username copied to clipboard',
      name: 'usernameCopiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get noData {
    return Intl.message('No Data', name: 'noData', desc: '', args: []);
  }

  /// `Services`
  String get services {
    return Intl.message('Services', name: 'services', desc: '', args: []);
  }

  /// `Receiving`
  String get receiving {
    return Intl.message('Receiving', name: 'receiving', desc: '', args: []);
  }

  /// `Delivering`
  String get delivering {
    return Intl.message('Delivering', name: 'delivering', desc: '', args: []);
  }

  /// `Expired`
  String get expired {
    return Intl.message('Expired', name: 'expired', desc: '', args: []);
  }

  /// `My Parcels`
  String get myParcels {
    return Intl.message('My Parcels', name: 'myParcels', desc: '', args: []);
  }

  /// `PODUs`
  String get podus {
    return Intl.message('PODUs', name: 'podus', desc: '', args: []);
  }

  /// `PUDO parcels retrieved successfully`
  String get pudoParcelsRetrievedSuccessfully {
    return Intl.message(
      'PUDO parcels retrieved successfully',
      name: 'pudoParcelsRetrievedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `⚠️ No QR code detected`
  String get noQrCodeDetected {
    return Intl.message(
      '⚠️ No QR code detected',
      name: 'noQrCodeDetected',
      desc: '',
      args: [],
    );
  }

  /// `Pickup Point`
  String get pickupPoint {
    return Intl.message(
      'Pickup Point',
      name: 'pickupPoint',
      desc: '',
      args: [],
    );
  }

  /// `QR Scanner`
  String get qrScanner {
    return Intl.message('QR Scanner', name: 'qrScanner', desc: '', args: []);
  }

  /// `Enter Username`
  String get enterUsername {
    return Intl.message(
      'Enter Username',
      name: 'enterUsername',
      desc: '',
      args: [],
    );
  }

  /// `More Settings`
  String get moreSettings {
    return Intl.message(
      'More Settings',
      name: 'moreSettings',
      desc: '',
      args: [],
    );
  }

  /// `Account Settings`
  String get accountSettings {
    return Intl.message(
      'Account Settings',
      name: 'accountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Selected Language: `
  String get selectedLanguage {
    return Intl.message(
      'Selected Language: ',
      name: 'selectedLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Enter Parcel`
  String get enterParcel {
    return Intl.message(
      'Enter Parcel',
      name: 'enterParcel',
      desc: '',
      args: [],
    );
  }

  /// `Individual Parcel`
  String get individualParcel {
    return Intl.message(
      'Individual Parcel',
      name: 'individualParcel',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `❌ Failed to fetch parcel details: `
  String get failedToFetchParcelDetails {
    return Intl.message(
      '❌ Failed to fetch parcel details: ',
      name: 'failedToFetchParcelDetails',
      desc: '',
      args: [],
    );
  }

  /// `✅ Image uploaded successfully!`
  String get imageUploadedSuccessfully {
    return Intl.message(
      '✅ Image uploaded successfully!',
      name: 'imageUploadedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to upload image: `
  String get failedToUploadImage {
    return Intl.message(
      'Failed to upload image: ',
      name: 'failedToUploadImage',
      desc: '',
      args: [],
    );
  }

  /// `❗ Please upload image first`
  String get pleaseUploadImageFirst {
    return Intl.message(
      '❗ Please upload image first',
      name: 'pleaseUploadImageFirst',
      desc: '',
      args: [],
    );
  }

  /// `✅ Parcel Delivered successfully!`
  String get parcelDeliveredSuccessfully {
    return Intl.message(
      '✅ Parcel Delivered successfully!',
      name: 'parcelDeliveredSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update parcel: `
  String get failedToUpdateParcel {
    return Intl.message(
      'Failed to update parcel: ',
      name: 'failedToUpdateParcel',
      desc: '',
      args: [],
    );
  }

  /// `Parcel Details`
  String get parcelDetails {
    return Intl.message(
      'Parcel Details',
      name: 'parcelDetails',
      desc: '',
      args: [],
    );
  }

  /// `Product info`
  String get productInfo {
    return Intl.message(
      'Product info',
      name: 'productInfo',
      desc: '',
      args: [],
    );
  }

  /// `Unknown name`
  String get unknownName {
    return Intl.message(
      'Unknown name',
      name: 'unknownName',
      desc: '',
      args: [],
    );
  }

  /// `Unknown address`
  String get unknownAddress {
    return Intl.message(
      'Unknown address',
      name: 'unknownAddress',
      desc: '',
      args: [],
    );
  }

  /// `No phone number`
  String get noPhoneNumber {
    return Intl.message(
      'No phone number',
      name: 'noPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Capture Parcel`
  String get captureParcel {
    return Intl.message(
      'Capture Parcel',
      name: 'captureParcel',
      desc: '',
      args: [],
    );
  }

  /// `⚠️ No Parcel QR detected!`
  String get noParcelQrDetected {
    return Intl.message(
      '⚠️ No Parcel QR detected!',
      name: 'noParcelQrDetected',
      desc: '',
      args: [],
    );
  }

  /// `Pickup Point Parcels`
  String get pickupPointParcels {
    return Intl.message(
      'Pickup Point Parcels',
      name: 'pickupPointParcels',
      desc: '',
      args: [],
    );
  }

  /// `Search By`
  String get searchBy {
    return Intl.message('Search By', name: 'searchBy', desc: '', args: []);
  }

  /// `Scan barCode`
  String get scanBarCode {
    return Intl.message(
      'Scan barCode',
      name: 'scanBarCode',
      desc: '',
      args: [],
    );
  }

  /// `code Number`
  String get codeNumber {
    return Intl.message('code Number', name: 'codeNumber', desc: '', args: []);
  }

  /// `Received`
  String get received {
    return Intl.message('Received', name: 'received', desc: '', args: []);
  }

  /// `Unknown Zone`
  String get unknownZone {
    return Intl.message(
      'Unknown Zone',
      name: 'unknownZone',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Phone`
  String get unknownPhone {
    return Intl.message(
      'Unknown Phone',
      name: 'unknownPhone',
      desc: '',
      args: [],
    );
  }

  /// `Successful Delivering process`
  String get successfulDeliveringProcess {
    return Intl.message(
      'Successful Delivering process',
      name: 'successfulDeliveringProcess',
      desc: '',
      args: [],
    );
  }

  /// `The time and location of the pickup will be recorded automatically.`
  String get pickupTimeAndLocationRecorded {
    return Intl.message(
      'The time and location of the pickup will be recorded automatically.',
      name: 'pickupTimeAndLocationRecorded',
      desc: '',
      args: [],
    );
  }

  /// `Deliver New Parcel`
  String get deliverNewParcel {
    return Intl.message(
      'Deliver New Parcel',
      name: 'deliverNewParcel',
      desc: '',
      args: [],
    );
  }

  /// `Back To Home`
  String get backToHome {
    return Intl.message('Back To Home', name: 'backToHome', desc: '', args: []);
  }

  /// `Failed to fetch pudo details: `
  String get failedToFetchPudoDetails {
    return Intl.message(
      'Failed to fetch pudo details: ',
      name: 'failedToFetchPudoDetails',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `PUDO Info`
  String get pudoInfo {
    return Intl.message('PUDO Info', name: 'pudoInfo', desc: '', args: []);
  }

  /// `No Address Found`
  String get noAddressFound {
    return Intl.message(
      'No Address Found',
      name: 'noAddressFound',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `No Image`
  String get noImage {
    return Intl.message('No Image', name: 'noImage', desc: '', args: []);
  }

  /// `PODU Details`
  String get poduDetails {
    return Intl.message(
      'PODU Details',
      name: 'poduDetails',
      desc: '',
      args: [],
    );
  }

  /// `PODU Parcels`
  String get poduParcels {
    return Intl.message(
      'PODU Parcels',
      name: 'poduParcels',
      desc: '',
      args: [],
    );
  }

  /// ` Something went wrong: `
  String get somethingWentWrong {
    return Intl.message(
      ' Something went wrong: ',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `This pudo has no parcels yet`
  String get thisPudoHasNoParcelsYet {
    return Intl.message(
      'This pudo has no parcels yet',
      name: 'thisPudoHasNoParcelsYet',
      desc: '',
      args: [],
    );
  }

  /// `Parcels refreshed successfully`
  String get parcelsRefreshedSuccessfully {
    return Intl.message(
      'Parcels refreshed successfully',
      name: 'parcelsRefreshedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No parcels found.`
  String get noParcelsFound {
    return Intl.message(
      'No parcels found.',
      name: 'noParcelsFound',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Client`
  String get unknownClient {
    return Intl.message(
      'Unknown Client',
      name: 'unknownClient',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `Unknown City`
  String get unknownCity {
    return Intl.message(
      'Unknown City',
      name: 'unknownCity',
      desc: '',
      args: [],
    );
  }

  /// `⚠️ Failed to retrieve courier ID`
  String get failedToRetrieveCourierId {
    return Intl.message(
      '⚠️ Failed to retrieve courier ID',
      name: 'failedToRetrieveCourierId',
      desc: '',
      args: [],
    );
  }

  /// `✅ Parcel Recieve successfully!`
  String get parcelReceivedSuccessfully {
    return Intl.message(
      '✅ Parcel Recieve successfully!',
      name: 'parcelReceivedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Successful Receiving process`
  String get successfulReceivingProcess {
    return Intl.message(
      'Successful Receiving process',
      name: 'successfulReceivingProcess',
      desc: '',
      args: [],
    );
  }

  /// `Receive New Parcel`
  String get receiveNewParcel {
    return Intl.message(
      'Receive New Parcel',
      name: 'receiveNewParcel',
      desc: '',
      args: [],
    );
  }

  /// `Parcel List`
  String get parcelList {
    return Intl.message('Parcel List', name: 'parcelList', desc: '', args: []);
  }

  /// `1 Bag`
  String get oneBag {
    return Intl.message('1 Bag', name: 'oneBag', desc: '', args: []);
  }

  /// `PODU: Rahmah Pharmacy`
  String get podoRahmahPharmacy {
    return Intl.message(
      'PODU: Rahmah Pharmacy',
      name: 'podoRahmahPharmacy',
      desc: '',
      args: [],
    );
  }

  /// `2 Bag`
  String get twoBag {
    return Intl.message('2 Bag', name: 'twoBag', desc: '', args: []);
  }

  /// `Successful Expired Receiving process`
  String get successfulExpiredReceivingProcess {
    return Intl.message(
      'Successful Expired Receiving process',
      name: 'successfulExpiredReceivingProcess',
      desc: '',
      args: [],
    );
  }

  /// `Receive New Expired Parcel`
  String get receiveNewExpiredParcel {
    return Intl.message(
      'Receive New Expired Parcel',
      name: 'receiveNewExpiredParcel',
      desc: '',
      args: [],
    );
  }

  /// `No PUDO found in local storage`
  String get noPudoFoundInLocalStorage {
    return Intl.message(
      'No PUDO found in local storage',
      name: 'noPudoFoundInLocalStorage',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load parcel data`
  String get failedToLoadParcelData {
    return Intl.message(
      'Failed to load parcel data',
      name: 'failedToLoadParcelData',
      desc: '',
      args: [],
    );
  }

  /// `❗ Parcel data not loaded yet.`
  String get parcelDataNotLoadedYet {
    return Intl.message(
      '❗ Parcel data not loaded yet.',
      name: 'parcelDataNotLoadedYet',
      desc: '',
      args: [],
    );
  }

  /// `Cameron Williamson`
  String get cameronWilliamson {
    return Intl.message(
      'Cameron Williamson',
      name: 'cameronWilliamson',
      desc: '',
      args: [],
    );
  }

  /// `4140 Parker Rd, Allentown, New Mexico`
  String get parkerRoadAddress {
    return Intl.message(
      '4140 Parker Rd, Allentown, New Mexico',
      name: 'parkerRoadAddress',
      desc: '',
      args: [],
    );
  }

  /// `(205) 555-0100`
  String get dummyPhoneNumber {
    return Intl.message(
      '(205) 555-0100',
      name: 'dummyPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `# 123456`
  String get parcelId1 {
    return Intl.message('# 123456', name: 'parcelId1', desc: '', args: []);
  }

  /// `# 568589`
  String get parcelId2 {
    return Intl.message('# 568589', name: 'parcelId2', desc: '', args: []);
  }

  /// `Inventory`
  String get inventory {
    return Intl.message('Inventory', name: 'inventory', desc: '', args: []);
  }

  /// `Total Approved`
  String get totalApproved {
    return Intl.message(
      'Total Approved',
      name: 'totalApproved',
      desc: '',
      args: [],
    );
  }

  /// `Ready to deliver`
  String get readyToDeliver {
    return Intl.message(
      'Ready to deliver',
      name: 'readyToDeliver',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message('Transfer', name: 'transfer', desc: '', args: []);
  }

  /// `Failed to load PUDO data: `
  String get failedToLoadPudoData {
    return Intl.message(
      'Failed to load PUDO data: ',
      name: 'failedToLoadPudoData',
      desc: '',
      args: [],
    );
  }

  /// `PUDO ID not loaded yet`
  String get pudoIdNotLoadedYet {
    return Intl.message(
      'PUDO ID not loaded yet',
      name: 'pudoIdNotLoadedYet',
      desc: '',
      args: [],
    );
  }

  /// `Expired Parcels`
  String get expiredParcels {
    return Intl.message(
      'Expired Parcels',
      name: 'expiredParcels',
      desc: '',
      args: [],
    );
  }

  /// `Parcel Approve`
  String get parcelApprove {
    return Intl.message(
      'Parcel Approve',
      name: 'parcelApprove',
      desc: '',
      args: [],
    );
  }

  /// `Parcel confirmed successfully!`
  String get parcelConfirmedSuccessfully {
    return Intl.message(
      'Parcel confirmed successfully!',
      name: 'parcelConfirmedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to confirm parcel. Please try again.`
  String get failedToConfirmParcel {
    return Intl.message(
      'Failed to confirm parcel. Please try again.',
      name: 'failedToConfirmParcel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Parcel`
  String get confirmParcel {
    return Intl.message(
      'Confirm Parcel',
      name: 'confirmParcel',
      desc: '',
      args: [],
    );
  }

  /// `No PUDO Data Found`
  String get noPudoDataFound {
    return Intl.message(
      'No PUDO Data Found',
      name: 'noPudoDataFound',
      desc: '',
      args: [],
    );
  }

  /// `No PUDO Data Stored`
  String get noPudoDataStored {
    return Intl.message(
      'No PUDO Data Stored',
      name: 'noPudoDataStored',
      desc: '',
      args: [],
    );
  }

  /// `QR Code`
  String get qrCode {
    return Intl.message('QR Code', name: 'qrCode', desc: '', args: []);
  }

  /// `Approved`
  String get approved {
    return Intl.message('Approved', name: 'approved', desc: '', args: []);
  }

  /// `Waiting`
  String get waiting {
    return Intl.message('Waiting', name: 'waiting', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Parcel Approve Confirmation`
  String get parcelApproveConfirmation {
    return Intl.message(
      'Parcel Approve Confirmation',
      name: 'parcelApproveConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to approve this parcel?(id: #{parcelId})`
  String areYouSureYouWantToApprove(Object parcelId) {
    return Intl.message(
      'Are you sure you want to approve this parcel?(id: #$parcelId)',
      name: 'areYouSureYouWantToApprove',
      desc: '',
      args: [parcelId],
    );
  }

  /// `No, cancel`
  String get noCancel {
    return Intl.message('No, cancel', name: 'noCancel', desc: '', args: []);
  }

  /// `Delivery Confirmation`
  String get deliveryConfirmation {
    return Intl.message(
      'Delivery Confirmation',
      name: 'deliveryConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `By confirming, you acknowledge that the parcel has been successfully delivered.`
  String get deliveryConfirmationDescription {
    return Intl.message(
      'By confirming, you acknowledge that the parcel has been successfully delivered.',
      name: 'deliveryConfirmationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Logged out successfully!`
  String get loggedOutSuccessfully {
    return Intl.message(
      'Logged out successfully!',
      name: 'loggedOutSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred: `
  String get anErrorOccurred {
    return Intl.message(
      'An error occurred: ',
      name: 'anErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get areYouSureYouWantToLogOut {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'areYouSureYouWantToLogOut',
      desc: '',
      args: [],
    );
  }

  /// `You will be returned to the login screen.`
  String get logOutDescription {
    return Intl.message(
      'You will be returned to the login screen.',
      name: 'logOutDescription',
      desc: '',
      args: [],
    );
  }

  /// `Yes, I'm sure.`
  String get yesImSure {
    return Intl.message(
      'Yes, I\'m sure.',
      name: 'yesImSure',
      desc: '',
      args: [],
    );
  }

  /// `Enter Manually`
  String get enterManually {
    return Intl.message(
      'Enter Manually',
      name: 'enterManually',
      desc: '',
      args: [],
    );
  }

  /// `Pickup Point Username`
  String get pickupPointUsername {
    return Intl.message(
      'Pickup Point Username',
      name: 'pickupPointUsername',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Username Here !`
  String get pleaseEnterUsernameHere {
    return Intl.message(
      'Please Enter Username Here !',
      name: 'pleaseEnterUsernameHere',
      desc: '',
      args: [],
    );
  }

  /// `The username You Entered Is Not Valid`
  String get usernameIsNotValid {
    return Intl.message(
      'The username You Entered Is Not Valid',
      name: 'usernameIsNotValid',
      desc: '',
      args: [],
    );
  }

  /// `PHOTO CONFIRMATION`
  String get photoConfirmation {
    return Intl.message(
      'PHOTO CONFIRMATION',
      name: 'photoConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching data: `
  String get errorFetchingData {
    return Intl.message(
      'Error fetching data: ',
      name: 'errorFetchingData',
      desc: '',
      args: [],
    );
  }

  /// `No QR data`
  String get noQrData {
    return Intl.message('No QR data', name: 'noQrData', desc: '', args: []);
  }

  /// `Could not generate QR\n`
  String get couldNotGenerateQr {
    return Intl.message(
      'Could not generate QR\n',
      name: 'couldNotGenerateQr',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR code in front of the camera`
  String get scanQrCodeInFrontOfCamera {
    return Intl.message(
      'Scan QR code in front of the camera',
      name: 'scanQrCodeInFrontOfCamera',
      desc: '',
      args: [],
    );
  }

  /// `YOU ARE AT A WRONG LOCATION`
  String get youAreAtWrongLocation {
    return Intl.message(
      'YOU ARE AT A WRONG LOCATION',
      name: 'youAreAtWrongLocation',
      desc: '',
      args: [],
    );
  }

  /// `My Pickup Points`
  String get myPickupPoints {
    return Intl.message(
      'My Pickup Points',
      name: 'myPickupPoints',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `More`
  String get more {
    return Intl.message('More', name: 'more', desc: '', args: []);
  }

  /// `Choose your language`
  String get chooseYourLanguage {
    return Intl.message(
      'Choose your language',
      name: 'chooseYourLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select your preferred language.`
  String get languageSelectionDescription {
    return Intl.message(
      'Select your preferred language.',
      name: 'languageSelectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Hindi`
  String get hindi {
    return Intl.message('Hindi', name: 'hindi', desc: '', args: []);
  }

  /// `Bengali`
  String get bengali {
    return Intl.message('Bengali', name: 'bengali', desc: '', args: []);
  }

  /// `Urdu`
  String get urdu {
    return Intl.message('Urdu', name: 'urdu', desc: '', args: []);
  }

  /// `Failed to login`
  String get loginFailed {
    return Intl.message(
      'Failed to login',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message('Log in', name: 'logIn', desc: '', args: []);
  }

  /// `Enter your personal information`
  String get enterYourPersonalInfo {
    return Intl.message(
      'Enter your personal information',
      name: 'enterYourPersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `username or e-mail`
  String get usernameOrPhoneNumber {
    return Intl.message(
      'username or e-mail',
      name: 'usernameOrPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter Username Or e-mail`
  String get enterUsernameOrPhoneNumber {
    return Intl.message(
      'Enter Username Or e-mail',
      name: 'enterUsernameOrPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter Password`
  String get enterPassword {
    return Intl.message(
      'Enter Password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message('Remember me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Press back again to exit`
  String get pressBackAgainToExit {
    return Intl.message(
      'Press back again to exit',
      name: 'pressBackAgainToExit',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'ur'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
