import 'package:rightnow/db/AnswerDao.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/ChoicesDao.dart';
import 'package:rightnow/db/ErrorModelDao.dart';
import 'package:rightnow/db/FCMNotificationsDao.dart';
import 'package:rightnow/db/FieldSetsDao.dart';
import 'package:rightnow/db/FormEntryDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/db/FormStateDao.dart';
import 'package:rightnow/db/HashDao.dart';
import 'package:rightnow/db/LocalUserDao.dart';
import 'package:rightnow/db/MultiSelectAnswersDao.dart';
import 'package:rightnow/db/OrganisationDao.dart';
import 'package:rightnow/db/ProfileDao.dart';
import 'package:rightnow/db/ProvinceDao.dart';
import 'package:rightnow/db/ProvincesDao.dart';
import 'package:rightnow/db/QuestionsDao.dart';
import 'package:rightnow/db/ReclamationsDao.dart';
import 'package:rightnow/db/TagsDao.dart';
import 'package:rightnow/db/UserNotificationsDao.dart';
import 'package:rightnow/db/allowed_types_Dao.dart';
import 'package:rightnow/db/blood_group_dao.dart';
import 'package:rightnow/db/branched_cond_Dao.dart';
import 'package:rightnow/db/branched_links_Dao.dart';
import 'package:rightnow/db/category_dao.dart';
import 'package:rightnow/db/decision_response_dao.dart';
import 'package:rightnow/db/dependent_cond_Dao.dart';
import 'package:rightnow/db/disease_dao.dart';
import 'package:rightnow/db/sub_category_dao.dart';
import 'package:rightnow/db/super_category_dao.dart';
import 'package:rightnow/main.dart';
import 'package:flutter/rendering.dart';

const String DB_NAME = "axxa.db";

const String AUTH_KEY = "Authorization";

const GPS_SEPARRATOR = ";";

const HEADER_HEIGHT = 180.0;

const Color COLOR_PRIMARY = Color(0xFFF00008f);

const String HASH_TYPE_CATEGORIES = "HASH_TYPE_CATEGORIES";
const String HASH_TYPE_CATEGORIES_LOADED = "HASH_TYPE_CATEGORIES_LOADED";
const String HASH_TYPE_CATEGORIES_RESTORED = "HASH_TYPE_CATEGORIES_RESTORED";
//const String HASH_TYPE_FORMS = "HASH_TYPE_FORMS";
//const String HASH_TYPE_FORM_FIELDS = "HASH_TYPE_FORM_FIELDS";

const String DROPDOWN_UNIQUE_CHOICE = "Dropdown unique chocie";
const String DROPDOWN_MULTIPLE_CHOICE = "Dropdow multiple choice";
const String CHECKBOX_UNIQUE_CHOICE = "Check-box unique choice";
const String CHECKBOX_MULTIPLE_CHOICE = "Check-Box multiple choice";

const String SCANNER_QUESTION = "ScannerQuestion";
const String SOUND_QUESTION = "SoundQuestion";
const String SIGNATURE_QUESTION = "SignatureQuestion";
const String SHORT_TEXT_QUESTION = "ShortTextQuestion";
const String BOOLEAN_QUESTION = "BooleanQuestion";
const String EMAIL_QUESTION = "EmailQuestion";
const String FREE_TEXT_QUESTION = "FreeTextQuestion";
const String FLOAT_QUESTION = "FloatQuestion";
const String INTEGER_QUESTION = "IntegerQuestion";
const String DATE_QUESTION = "DateQuestion";
const String FILE_QUESTION = "FileQuestion";
const String SELECT_QUESTION = "SelectQuestion";
const String GEO_QUESTION = "GeolocationQuestion";
const String PHONE_QUESTION = "PhoneNumberQuestion";
const String TIME_QUESTION = "TimeQuestion";

const String SCANNER_RESPONSE = "ScannerResponse";
const String SOUND_RESPONSE = "SoundResponse";
const String SIGNATURE_RESPONSE = "SignResponse";
const String SHORT_TEXT_RESPONSE = "ShortTextResponse";
const String BOOLEAN_RESPONSE = "BooleanResponse";
const String EMAIL_RESPONSE = "EmailResponse";
const String FREE_TEXT_RESPONSE = "FreeTextResponse";
const String FLOAT_RESPONSE = "FloatResponse";
const String INTEGER_RESPONSE = "IntegerResponse";
const String DATE_RESPONSE = "DateResponse";
const String FILE_RESPONSE = "FileResponse";
const String SELECT_RESPONSE = "SelectResponse";
const String GEO_RESPONSE = "GeolocationResponse";
const String PHONE_RESPONSE = "PhoneNumberResponse";
const String TIME_RESPONSE = "TimeResponse";

const String BOOLEAN_BRANCH = "BooleanBranch";
const String CHOICES_BRANCH = "ChoicesBranch";
const String Float_BRANCH = "FloatBranch";
const String INTEGER_BRANCH = "IntegerBranch";
const String DATE_BRANCH = "DateBranch";
const String TIME_BRANCH = "TimeBranch";

const String BRANCH_CONDITION_EMPTY = "is empty";
const String BRANCH_CONDITION_NOT_EMPTY = "is not empty";
const String BRANCH_CONDITION_CHOICES_CONTAINS = "Contains";
const String BRANCH_CONDITION_CHOICES_IN_CHOICES = "In Choices";
const String BRANCH_CONDITION_EQUAL_TO = "equal to";
const String BRANCH_CONDITION_NOT_EQUAL_TO = "not equal to";
const String BRANCH_CONDITION_GREATER_THAN = "greater than";
const String BRANCH_CONDITION_LESS_THAN = "less than";

String transtypeResourceType(String? questionResource) {
  switch (questionResource) {
    case SCANNER_QUESTION:
      return SCANNER_RESPONSE;
    case SOUND_QUESTION:
      return SOUND_RESPONSE;
    case SIGNATURE_QUESTION:
      return SIGNATURE_RESPONSE;
    case SHORT_TEXT_QUESTION:
      return SHORT_TEXT_RESPONSE;
    case BOOLEAN_QUESTION:
      return BOOLEAN_RESPONSE;
    case EMAIL_QUESTION:
      return EMAIL_RESPONSE;
    case FREE_TEXT_QUESTION:
      return FREE_TEXT_RESPONSE;
    case FLOAT_QUESTION:
      return FLOAT_RESPONSE;
    case INTEGER_QUESTION:
      return INTEGER_RESPONSE;
    case DATE_QUESTION:
      return DATE_RESPONSE;
    case FILE_QUESTION:
      return FILE_RESPONSE;
    case SELECT_QUESTION:
      return SELECT_RESPONSE;
    case GEO_QUESTION:
      return GEO_RESPONSE;
    case PHONE_QUESTION:
      return PHONE_RESPONSE;
    case TIME_QUESTION:
      return TIME_RESPONSE;
  }
  return "";
}

const String SIGNATURE_FILENAME = "rightnow_signatureXYZ.png";
const String SIGNATURE_FILENAME_EXT = ".png";
const String PICTURE_FILENAME = "picture";
const String MAP_FILENAME = "map";

const String FORM_CHECKBOX_NOT_SELECTED = "At least one checkbox must be selected";
const String FORM_LIST_NOT_SELECTED = "At least one list item must be selected";
const String FORM_RADIO_NOT_SELECTED = "At least one radio item must be selected";
const String FORM_SELECT_DATE = "Must select a date";
const String FORM_SELECT_TIME = "Must select a time";
const String FORM_SELECT_PICTURE = "Must select a picture";
const String FORM_SELECT_PICTURE_NOT_UPLOADED = "Could not upload picture";
const String FORM_SELECT_FILE = "Must select a file";
const String FORM_SELECT_FILE_NOT_UPLOADED = "Could not upload the file";
const String FORM_SELECT_FILE_GRETAER = "The selected file is greater than ";
const String FORM_SELECT_FILE_LESS = "The selected file is less than ";
const String FORM_SELECT_GPS = "Must select a GPS position";
const String FORM_SELECT_QR = "Must select a QR code";
const String FORM_SELECT_SIGNATURE = "Must select a signature";
const String FORM_RECORD_SOUND = "Must record a sound";
const String FORM_INVALID_EMAIL = "Email non valid";
const String FORM_MESSAGES_REQUIRED = "Le champ ne doit pas ètre vide.";
const String FORM_VALUE_MAX_EXCEEDED = "Saisir une Valeur inferieur a ";
const String FORM_VALUE_MIN_EXCEEDED = "Saisir une valeur superieur a ";
const String FORM_VALUE_NUMERIC_ONLY = "Must be numerice value";
const String FORM_PHONE_ERROR = "Your phone number must start with country code (+213) followed by 10 digits.";

T getDataBase<T>() {
  switch (T) {
    case OrganisationDao:
      return new OrganisationDao() as T;
    case SuperCategoryDao:
      return new SuperCategoryDao() as T;
    case FCMNotificationsDao:
      return new FCMNotificationsDao() as T;
    case UserNotificationsDao:
      return new UserNotificationsDao() as T;
    case AnswerHolderDao:
      return new AnswerHolderDao() as T;
    case QuestionsDao:
      return new QuestionsDao() as T;
    case AllowedTypesDao:
      return new AllowedTypesDao() as T;
    case AnswersDao:
      return new AnswersDao() as T;
    case BloodGroupDao:
      return new BloodGroupDao() as T;
    case BranchedConditionsDao:
      return new BranchedConditionsDao() as T;
    case BranchedLinksDao:
      return new BranchedLinksDao() as T;
    case CategoryDao:
      return new CategoryDao() as T;
    case ChoicesDao:
      return new ChoicesDao() as T;
    case DecisionResponseDao:
      return new DecisionResponseDao() as T;
    case DependentConditionsDao:
      return new DependentConditionsDao() as T;
    case DiseaseDao:
      return new DiseaseDao() as T;
    case ErrorModelDao:
      return new ErrorModelDao() as T;
    case FieldSetsDao:
      return new FieldSetsDao() as T;
    case FormEntryDao:
      return new FormEntryDao() as T;
    case FormFieldsDao:
      return new FormFieldsDao() as T;
    case FormStateDao:
      return new FormStateDao() as T;
    case HashDao:
      return new HashDao() as T;
    case LocalUserDao:
      return new LocalUserDao() as T;
    case MultiSelectAnswersDao:
      return new MultiSelectAnswersDao() as T;
    case ProfileDao:
      return new ProfileDao() as T;
    case ProvinceDao:
      return new ProvinceDao() as T;
    case ProvincesDao:
      return new ProvincesDao() as T;
    case QuestionsDao:
      return new QuestionsDao() as T;
    case ReclamationsDao:
      return new ReclamationsDao() as T;
    case TagsDao:
      return new TagsDao() as T;
    case SubCategoryDao:
      return new SubCategoryDao() as T;
    default:
      throw new Exception("Method not found");
  }
  //final DbService dbService = injector.get<DbService>();
  //return dbService.appDatabase!;
}
