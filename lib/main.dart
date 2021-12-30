import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:rightnow/actualite_screen.dart';
import 'package:rightnow/answers_uploader_screen.dart';
import 'package:rightnow/blocs/actualite_bloc.dart';
import 'package:rightnow/blocs/answers_post_bloc.dart';
import 'package:rightnow/blocs/current_user_id.dart';
import 'package:rightnow/blocs/fieldsets_bloc.dart';
import 'package:rightnow/blocs/forms_bloc.dart';
import 'package:rightnow/blocs/hash_bloc.dart';
import 'package:rightnow/blocs/history_bloc.dart';
import 'package:rightnow/blocs/login_bloc.dart';
import 'package:rightnow/blocs/questions_bloc.dart';
import 'package:rightnow/blocs/reclamations_bloc.dart';
import 'package:rightnow/blocs/set_user_profile_bloc.dart';
import 'package:rightnow/components/app_initializer.dart';
import 'package:rightnow/components/db_service.dart';
import 'package:rightnow/components/dependency_injection.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/FCMNotificationsDao.dart';
import 'package:rightnow/fieldsets.dart';
import 'package:rightnow/forms.dart';
import 'package:rightnow/hash_page.dart';
import 'package:rightnow/history_screen.dart';
import 'package:rightnow/login_check.dart';
import 'package:rightnow/login_handler.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/allowed_types.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/blood_group.dart';
import 'package:rightnow/models/branched_conditions.dart';
import 'package:rightnow/models/branched_links.dart';
import 'package:rightnow/models/category.dart' as cat;
import 'package:rightnow/models/choice.dart';
import 'package:rightnow/models/decision_response.dart';
import 'package:rightnow/models/dependent_condition.dart';
import 'package:rightnow/models/disease.dart';
import 'package:rightnow/models/error_model.dart';
import 'package:rightnow/models/fcm_notification.dart';
import 'package:rightnow/models/form_entry.dart';
import 'package:rightnow/models/form_state.dart';
import 'package:rightnow/models/hash.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/models/multiselect_answer.dart';
import 'package:rightnow/models/profile.dart';
import 'package:rightnow/models/province.dart';
import 'package:rightnow/models/reclamations.dart';
import 'package:rightnow/models/super_category.dart';
import 'package:rightnow/models/tag.dart';
import 'package:rightnow/models/user_notification.dart';
import 'package:rightnow/questions_screen.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/upload_profile_screen.dart';
import 'package:rightnow/views/file_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/views/language_switch.dart';
import 'package:rightnow/welcome_screen.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Injector injector = Injector();

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.data}");
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) => max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(tintValue(color.red, factor), tintValue(color.green, factor), tintValue(color.blue, factor), 1);

int shadeValue(int value, double factor) => max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(shadeValue(color.red, factor), shadeValue(color.green, factor), shadeValue(color.blue, factor), 1);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  HttpOverrides.global = new MyHttpOverrides();
  if (!kIsWeb) {
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } else {
    Hive.initFlutter();
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user authorized *************** ");
      String? token = await messaging.getToken(
        vapidKey: "BJeKH98XT41-833LnIfGpe9M_XFxK8XzBj38e28Csfsiaax-p4ZBho7NgS_OMeuNO7Pp0C9F8DdNFpIEPCgFR84",
      );
      print("user authorized *************** $token");
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    }
  }
  Hive.registerAdapter(SuperCategoryAdapter());
  Hive.registerAdapter(LocalUserAdapter());
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(AllowedTypesAdapter());
  Hive.registerAdapter(AnswerAdapter());
  Hive.registerAdapter(AnswerHolderAdapter());
  Hive.registerAdapter(BloodGroupAdapter());
  Hive.registerAdapter(BranchedConditionsAdapter());
  Hive.registerAdapter(BranchedLinksAdapter());
  Hive.registerAdapter(cat.CategoryAdapter());
  Hive.registerAdapter(ChoiceAdapter());
  Hive.registerAdapter(DecisionResponseAdapter());
  Hive.registerAdapter(DependentConditionAdapter());
  Hive.registerAdapter(DiseaseAdapter());
  Hive.registerAdapter(ErrorModelAdapter());
  Hive.registerAdapter(FieldSetAdapter());
  Hive.registerAdapter(FormEntryAdapter());
  Hive.registerAdapter(FormFieldsStateAdapter());
  Hive.registerAdapter(FormFieldsAdapter());
  Hive.registerAdapter(HashesAdapter());
  Hive.registerAdapter(ProvinceAdapter());
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(ReclamationsAdapter());
  Hive.registerAdapter(TagAdapter());
  Hive.registerAdapter(UserNotificationAdapter());
  Hive.registerAdapter(FCMNotificationAdapter());
  Hive.registerAdapter(MultiSelectAnswerAdapter());
  /** End Hive */

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground! Saving data to database');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}, ready to save to db');
      await getDataBase<FCMNotificationsDao>().insertFCMNotification(FCMNotification(
        id: DateTime.now().millisecondsSinceEpoch,
        title: message.notification?.title ?? "",
        message: message.notification?.body ?? "",
        viewed: 0,
      ));
    }
  });

  //await $FloorAppDatabase.databaseBuilder(DB_NAME).build();
  DependencyInjection().initialise(Injector());
  await EasyLocalization.ensureInitialized();

  injector = Injector();
  await AppInitializer().initialise(injector);

  final DbService dbService = injector.get<DbService>();
  await dbService.initDb();

  /*if (kIsWeb) {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }*/

  runApp(
    Phoenix(
      child: EasyLocalization(
        child: MyApp(),
        supportedLocales: [Locale(LANGUAGE_FR), Locale(LANGUAGE_AR, LANGUAGE_AR_CODE)],
        startLocale: Locale(LANGUAGE_FR),
        path: 'assets/translations',
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  static final GlobalKey<FileWidgetState> fileWidgetState = GlobalKey<FileWidgetState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<HashBloc>(
            create: (BuildContext context) {
              return HashBloc();
            },
            child: HashPage()),
        BlocProvider<AnswersPostBloc>(
          create: (BuildContext context) {
            return AnswersPostBloc();
          },
          child: AnswersUploaderPage(),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) {
            return LoginBloc();
          },
          child: LoginHadlerPage(),
        ),
        BlocProvider<QuestionsBloc>(
          create: (BuildContext context) {
            return QuestionsBloc();
          },
          child: QuestionsPage(
            anonymous: false,
            fieldSet: FieldSet.fromJson({}),
          ),
        ),
        BlocProvider<ReclamationsBloc>(
          create: (BuildContext context) {
            return ReclamationsBloc();
          },
          child: HistoryPage(),
        ),
        BlocProvider<CurrentUserIdBloc>(
          create: (BuildContext context) {
            return CurrentUserIdBloc();
          },
          child: LoginCheck(),
        ),
        BlocProvider<FieldsetsBloc>(
          create: (BuildContext context) {
            return FieldsetsBloc();
          },
          child: FieldsSetPage(
            formId: 0,
          ),
        ),
        BlocProvider<SetUserProfileBloc>(
          create: (BuildContext context) {
            return SetUserProfileBloc();
          },
          child: UploadProfilePage(),
        ),
        BlocProvider<FormsBloc>(
          create: (BuildContext context) {
            return FormsBloc();
          },
          child: FormsPage(
            category: cat.Category.fromJson({}),
          ),
        ),
        BlocProvider<ActualiteBloc>(
          create: (BuildContext context) {
            return ActualiteBloc();
          },
          child: ActualitePage(),
        ),
        BlocProvider<HistoryBloc>(
          create: (BuildContext context) {
            return HistoryBloc();
          },
          child: HistoryPage(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Rightnow',
        theme: ThemeData(
            fontFamily: "PoppinsMedium",
            canvasColor: Colors.white,
            cardColor: Colors.white,
            cardTheme: CardTheme(
              color: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.grey.shade50,
            primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(color: COLOR_PRIMARY),
            primaryTextTheme: TextTheme(
              headline6: TextStyle(color: COLOR_PRIMARY),
            ),
            popupMenuTheme: PopupMenuThemeData(
              color: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                padding: EdgeInsets.all(15.0),
                primary: Colors.white,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                backgroundColor: generateMaterialColor(Palette.primary),
              ),
            ),
            accentColor: Colors.white,
            radioTheme: RadioThemeData(
              fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                  return Colors.grey; // Use the component's default.
                },
              ),
            ),
            checkboxTheme: CheckboxThemeData(
              checkColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                  return Colors.grey; // Use the component's default.
                },
              ),
            ),
            /*textSelectionTheme: TextSelectionThemeData(
                selectionColor: Colors.green,
                cursorColor: Colors.amber,
                selectionHandleColor: Colors.red,
              ),*/
            //cursorColor: : Colors.white,
            primaryColor: Colors.white,
            primarySwatch: generateMaterialColor(Palette.primary), //APP_BK_COLOR.shade700,
            dialogBackgroundColor: Colors.white,
            /*tooltipTheme: TooltipThemeData(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),*/

            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: ScreenViewerWidget(
          page: WelcomePage(),
        ), /*SplashScreen()*/
        /*builder: (context, child) {
          print("width xx is " + MediaQuery.of(context).size.width.toString());
          return ScreenViewerWidget(
            page: WelcomePage(),
          );
        },*/
      ),
    );
  }
}

class Palette {
  static const Color primary = COLOR_PRIMARY; //0xFF2F4D7D
}
