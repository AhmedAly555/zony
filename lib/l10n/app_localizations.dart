import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('en'),
    Locale('hi'),
    Locale('ur'),
  ];

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @myPodus.
  ///
  /// In en, this message translates to:
  /// **'My PODUs'**
  String get myPodus;

  /// No description provided for @allParcels.
  ///
  /// In en, this message translates to:
  /// **'All Parcels'**
  String get allParcels;

  /// No description provided for @unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unread;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: '**
  String get error;

  /// No description provided for @noPodusFound.
  ///
  /// In en, this message translates to:
  /// **'No PODUs found'**
  String get noPodusFound;

  /// No description provided for @noAddressAvailable.
  ///
  /// In en, this message translates to:
  /// **'No address available'**
  String get noAddressAvailable;

  /// No description provided for @usernameCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Username copied to clipboard'**
  String get usernameCopiedToClipboard;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @receiving.
  ///
  /// In en, this message translates to:
  /// **'Receiving'**
  String get receiving;

  /// No description provided for @delivering.
  ///
  /// In en, this message translates to:
  /// **'Delivering'**
  String get delivering;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @myParcels.
  ///
  /// In en, this message translates to:
  /// **'My Parcels'**
  String get myParcels;

  /// No description provided for @podus.
  ///
  /// In en, this message translates to:
  /// **'PODUs'**
  String get podus;

  /// No description provided for @pudoParcelsRetrievedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'PUDO parcels retrieved successfully'**
  String get pudoParcelsRetrievedSuccessfully;

  /// No description provided for @noQrCodeDetected.
  ///
  /// In en, this message translates to:
  /// **'⚠️ No QR code detected'**
  String get noQrCodeDetected;

  /// No description provided for @pickupPoint.
  ///
  /// In en, this message translates to:
  /// **'Pickup Point'**
  String get pickupPoint;

  /// No description provided for @qrScanner.
  ///
  /// In en, this message translates to:
  /// **'QR Scanner'**
  String get qrScanner;

  /// No description provided for @enterUsername.
  ///
  /// In en, this message translates to:
  /// **'Enter Username'**
  String get enterUsername;

  /// No description provided for @moreSettings.
  ///
  /// In en, this message translates to:
  /// **'More Settings'**
  String get moreSettings;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @selectedLanguage.
  ///
  /// In en, this message translates to:
  /// **'Selected Language: '**
  String get selectedLanguage;

  /// No description provided for @enterParcel.
  ///
  /// In en, this message translates to:
  /// **'Enter Parcel'**
  String get enterParcel;

  /// No description provided for @individualParcel.
  ///
  /// In en, this message translates to:
  /// **'Individual Parcel'**
  String get individualParcel;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @failedToFetchParcelDetails.
  ///
  /// In en, this message translates to:
  /// **'❌ Failed to fetch parcel details: '**
  String get failedToFetchParcelDetails;

  /// No description provided for @imageUploadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'✅ Image uploaded successfully!'**
  String get imageUploadedSuccessfully;

  /// No description provided for @failedToUploadImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload image: '**
  String get failedToUploadImage;

  /// No description provided for @pleaseUploadImageFirst.
  ///
  /// In en, this message translates to:
  /// **'❗ Please upload image first'**
  String get pleaseUploadImageFirst;

  /// No description provided for @parcelDeliveredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'✅ Parcel Delivered successfully!'**
  String get parcelDeliveredSuccessfully;

  /// No description provided for @failedToUpdateParcel.
  ///
  /// In en, this message translates to:
  /// **'Failed to update parcel: '**
  String get failedToUpdateParcel;

  /// No description provided for @parcelDetails.
  ///
  /// In en, this message translates to:
  /// **'Parcel Details'**
  String get parcelDetails;

  /// No description provided for @productInfo.
  ///
  /// In en, this message translates to:
  /// **'Product info'**
  String get productInfo;

  /// No description provided for @unknownName.
  ///
  /// In en, this message translates to:
  /// **'Unknown name'**
  String get unknownName;

  /// No description provided for @unknownAddress.
  ///
  /// In en, this message translates to:
  /// **'Unknown address'**
  String get unknownAddress;

  /// No description provided for @noPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'No phone number'**
  String get noPhoneNumber;

  /// No description provided for @captureParcel.
  ///
  /// In en, this message translates to:
  /// **'Capture Parcel'**
  String get captureParcel;

  /// No description provided for @noParcelQrDetected.
  ///
  /// In en, this message translates to:
  /// **'⚠️ No Parcel QR detected!'**
  String get noParcelQrDetected;

  /// No description provided for @pickupPointParcels.
  ///
  /// In en, this message translates to:
  /// **'Pickup Point Parcels'**
  String get pickupPointParcels;

  /// No description provided for @searchBy.
  ///
  /// In en, this message translates to:
  /// **'Search By'**
  String get searchBy;

  /// No description provided for @scanBarCode.
  ///
  /// In en, this message translates to:
  /// **'Scan barCode'**
  String get scanBarCode;

  /// No description provided for @codeNumber.
  ///
  /// In en, this message translates to:
  /// **'code Number'**
  String get codeNumber;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// No description provided for @unknownZone.
  ///
  /// In en, this message translates to:
  /// **'Unknown Zone'**
  String get unknownZone;

  /// No description provided for @unknownPhone.
  ///
  /// In en, this message translates to:
  /// **'Unknown Phone'**
  String get unknownPhone;

  /// No description provided for @successfulDeliveringProcess.
  ///
  /// In en, this message translates to:
  /// **'Successful Delivering process'**
  String get successfulDeliveringProcess;

  /// No description provided for @pickupTimeAndLocationRecorded.
  ///
  /// In en, this message translates to:
  /// **'The time and location of the pickup will be recorded automatically.'**
  String get pickupTimeAndLocationRecorded;

  /// No description provided for @deliverNewParcel.
  ///
  /// In en, this message translates to:
  /// **'Deliver New Parcel'**
  String get deliverNewParcel;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back To Home'**
  String get backToHome;

  /// No description provided for @failedToFetchPudoDetails.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch pudo details: '**
  String get failedToFetchPudoDetails;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @pudoInfo.
  ///
  /// In en, this message translates to:
  /// **'PUDO Info'**
  String get pudoInfo;

  /// No description provided for @noAddressFound.
  ///
  /// In en, this message translates to:
  /// **'No Address Found'**
  String get noAddressFound;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @noImage.
  ///
  /// In en, this message translates to:
  /// **'No Image'**
  String get noImage;

  /// No description provided for @poduDetails.
  ///
  /// In en, this message translates to:
  /// **'PODU Details'**
  String get poduDetails;

  /// No description provided for @poduParcels.
  ///
  /// In en, this message translates to:
  /// **'PODU Parcels'**
  String get poduParcels;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **' Something went wrong: '**
  String get somethingWentWrong;

  /// No description provided for @thisPudoHasNoParcelsYet.
  ///
  /// In en, this message translates to:
  /// **'This pudo has no parcels yet'**
  String get thisPudoHasNoParcelsYet;

  /// No description provided for @parcelsRefreshedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Parcels refreshed successfully'**
  String get parcelsRefreshedSuccessfully;

  /// No description provided for @noParcelsFound.
  ///
  /// In en, this message translates to:
  /// **'No parcels found.'**
  String get noParcelsFound;

  /// No description provided for @unknownClient.
  ///
  /// In en, this message translates to:
  /// **'Unknown Client'**
  String get unknownClient;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @unknownCity.
  ///
  /// In en, this message translates to:
  /// **'Unknown City'**
  String get unknownCity;

  /// No description provided for @failedToRetrieveCourierId.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Failed to retrieve courier ID'**
  String get failedToRetrieveCourierId;

  /// No description provided for @parcelReceivedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'✅ Parcel Recieve successfully!'**
  String get parcelReceivedSuccessfully;

  /// No description provided for @successfulReceivingProcess.
  ///
  /// In en, this message translates to:
  /// **'Successful Receiving process'**
  String get successfulReceivingProcess;

  /// No description provided for @receiveNewParcel.
  ///
  /// In en, this message translates to:
  /// **'Receive New Parcel'**
  String get receiveNewParcel;

  /// No description provided for @parcelList.
  ///
  /// In en, this message translates to:
  /// **'Parcel List'**
  String get parcelList;

  /// No description provided for @oneBag.
  ///
  /// In en, this message translates to:
  /// **'1 Bag'**
  String get oneBag;

  /// No description provided for @podoRahmahPharmacy.
  ///
  /// In en, this message translates to:
  /// **'PODU: Rahmah Pharmacy'**
  String get podoRahmahPharmacy;

  /// No description provided for @twoBag.
  ///
  /// In en, this message translates to:
  /// **'2 Bag'**
  String get twoBag;

  /// No description provided for @successfulExpiredReceivingProcess.
  ///
  /// In en, this message translates to:
  /// **'Successful Expired Receiving process'**
  String get successfulExpiredReceivingProcess;

  /// No description provided for @receiveNewExpiredParcel.
  ///
  /// In en, this message translates to:
  /// **'Receive New Expired Parcel'**
  String get receiveNewExpiredParcel;

  /// No description provided for @noPudoFoundInLocalStorage.
  ///
  /// In en, this message translates to:
  /// **'No PUDO found in local storage'**
  String get noPudoFoundInLocalStorage;

  /// No description provided for @failedToLoadParcelData.
  ///
  /// In en, this message translates to:
  /// **'Failed to load parcel data'**
  String get failedToLoadParcelData;

  /// No description provided for @parcelDataNotLoadedYet.
  ///
  /// In en, this message translates to:
  /// **'❗ Parcel data not loaded yet.'**
  String get parcelDataNotLoadedYet;

  /// No description provided for @cameronWilliamson.
  ///
  /// In en, this message translates to:
  /// **'Cameron Williamson'**
  String get cameronWilliamson;

  /// No description provided for @parkerRoadAddress.
  ///
  /// In en, this message translates to:
  /// **'4140 Parker Rd, Allentown, New Mexico'**
  String get parkerRoadAddress;

  /// No description provided for @dummyPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'(205) 555-0100'**
  String get dummyPhoneNumber;

  /// No description provided for @parcelId1.
  ///
  /// In en, this message translates to:
  /// **'# 123456'**
  String get parcelId1;

  /// No description provided for @parcelId2.
  ///
  /// In en, this message translates to:
  /// **'# 568589'**
  String get parcelId2;

  /// No description provided for @inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// No description provided for @totalApproved.
  ///
  /// In en, this message translates to:
  /// **'Total Approved'**
  String get totalApproved;

  /// No description provided for @readyToDeliver.
  ///
  /// In en, this message translates to:
  /// **'Ready to deliver'**
  String get readyToDeliver;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @failedToLoadPudoData.
  ///
  /// In en, this message translates to:
  /// **'Failed to load PUDO data: '**
  String get failedToLoadPudoData;

  /// No description provided for @pudoIdNotLoadedYet.
  ///
  /// In en, this message translates to:
  /// **'PUDO ID not loaded yet'**
  String get pudoIdNotLoadedYet;

  /// No description provided for @expiredParcels.
  ///
  /// In en, this message translates to:
  /// **'Expired Parcels'**
  String get expiredParcels;

  /// No description provided for @parcelApprove.
  ///
  /// In en, this message translates to:
  /// **'Parcel Approve'**
  String get parcelApprove;

  /// No description provided for @parcelConfirmedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Parcel confirmed successfully!'**
  String get parcelConfirmedSuccessfully;

  /// No description provided for @failedToConfirmParcel.
  ///
  /// In en, this message translates to:
  /// **'Failed to confirm parcel. Please try again.'**
  String get failedToConfirmParcel;

  /// No description provided for @confirmParcel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Parcel'**
  String get confirmParcel;

  /// No description provided for @noPudoDataFound.
  ///
  /// In en, this message translates to:
  /// **'No PUDO Data Found'**
  String get noPudoDataFound;

  /// No description provided for @noPudoDataStored.
  ///
  /// In en, this message translates to:
  /// **'No PUDO Data Stored'**
  String get noPudoDataStored;

  /// No description provided for @qrCode.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qrCode;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @waiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get waiting;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @parcelApproveConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Parcel Approve Confirmation'**
  String get parcelApproveConfirmation;

  /// No description provided for @areYouSureYouWantToApprove.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to approve this parcel?(id: #{parcelId})'**
  String areYouSureYouWantToApprove(Object parcelId);

  /// No description provided for @noCancel.
  ///
  /// In en, this message translates to:
  /// **'No, cancel'**
  String get noCancel;

  /// No description provided for @deliveryConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delivery Confirmation'**
  String get deliveryConfirmation;

  /// No description provided for @deliveryConfirmationDescription.
  ///
  /// In en, this message translates to:
  /// **'By confirming, you acknowledge that the parcel has been successfully delivered.'**
  String get deliveryConfirmationDescription;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @loggedOutSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully!'**
  String get loggedOutSuccessfully;

  /// No description provided for @anErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: '**
  String get anErrorOccurred;

  /// No description provided for @areYouSureYouWantToLogOut.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get areYouSureYouWantToLogOut;

  /// No description provided for @logOutDescription.
  ///
  /// In en, this message translates to:
  /// **'You will be returned to the login screen.'**
  String get logOutDescription;

  /// No description provided for @yesImSure.
  ///
  /// In en, this message translates to:
  /// **'Yes, I\'m sure.'**
  String get yesImSure;

  /// No description provided for @enterManually.
  ///
  /// In en, this message translates to:
  /// **'Enter Manually'**
  String get enterManually;

  /// No description provided for @pickupPointUsername.
  ///
  /// In en, this message translates to:
  /// **'Pickup Point Username'**
  String get pickupPointUsername;

  /// No description provided for @pleaseEnterUsernameHere.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Username Here !'**
  String get pleaseEnterUsernameHere;

  /// No description provided for @usernameIsNotValid.
  ///
  /// In en, this message translates to:
  /// **'The username You Entered Is Not Valid'**
  String get usernameIsNotValid;

  /// No description provided for @photoConfirmation.
  ///
  /// In en, this message translates to:
  /// **'PHOTO CONFIRMATION'**
  String get photoConfirmation;

  /// No description provided for @errorFetchingData.
  ///
  /// In en, this message translates to:
  /// **'Error fetching data: '**
  String get errorFetchingData;

  /// No description provided for @noQrData.
  ///
  /// In en, this message translates to:
  /// **'No QR data'**
  String get noQrData;

  /// No description provided for @couldNotGenerateQr.
  ///
  /// In en, this message translates to:
  /// **'Could not generate QR\n'**
  String get couldNotGenerateQr;

  /// No description provided for @scanQrCodeInFrontOfCamera.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code in front of the camera'**
  String get scanQrCodeInFrontOfCamera;

  /// No description provided for @youAreAtWrongLocation.
  ///
  /// In en, this message translates to:
  /// **'YOU ARE AT A WRONG LOCATION'**
  String get youAreAtWrongLocation;

  /// No description provided for @myPickupPoints.
  ///
  /// In en, this message translates to:
  /// **'My Pickup Points'**
  String get myPickupPoints;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @chooseYourLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseYourLanguage;

  /// No description provided for @languageSelectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language. This will update the text throughout the app.'**
  String get languageSelectionDescription;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @bengali.
  ///
  /// In en, this message translates to:
  /// **'Bengali'**
  String get bengali;

  /// No description provided for @urdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get urdu;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to login'**
  String get loginFailed;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @enterYourPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Enter your personal information'**
  String get enterYourPersonalInfo;

  /// No description provided for @usernameOrPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'username or e-mail'**
  String get usernameOrPhoneNumber;

  /// No description provided for @enterUsernameOrPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Username Or e-mail'**
  String get enterUsernameOrPhoneNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @pressBackAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Press back again to exit'**
  String get pressBackAgainToExit;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'bn', 'en', 'hi', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
