// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get onboarding_1_title => 'خصص تجربتك';

  @override
  String get onboarding_1_content =>
      'اختر السمة واللغة المفضلة لديك للبدء بتجربة مريحة ومخصصة تناسب أسلوبك.';

  @override
  String get onboarding_1_language => 'اللغة';

  @override
  String get onboarding_1_theme => 'السمة';

  @override
  String get onboarding_1_button => 'لنبدأ';

  @override
  String get onboarding_2_title => 'اكتشف فعاليات تلهمك';

  @override
  String get onboarding_2_content =>
      'انغمس في عالم من الفعاليات المصممة لتناسب اهتماماتك الفريدة. سواء كنت من محبي الموسيقى الحية أو ورش العمل الفنية أو اللقاءات المهنية أو اكتشاف تجارب جديدة، لدينا ما يناسب الجميع. توصياتنا المنسقة ستساعدك على الاستكشاف والتواصل والاستفادة القصوى من كل فرصة حولك.';

  @override
  String get onboarding_3_title => 'تخطيط الفعاليات بسهولة';

  @override
  String get onboarding_3_content =>
      'تخلص من عناء تنظيم الفعاليات باستخدام أدوات التخطيط الشاملة لدينا. من إرسال الدعوات وإدارة الحضور إلى جدولة التذكيرات وتنسيق التفاصيل، نحن هنا لمساعدتك. خطط بسهولة وركز على الأهم – خلق تجربة لا تُنسى لك ولضيوفك.';

  @override
  String get onboarding_4_title => 'تواصل مع الأصدقاء وشارك اللحظات';

  @override
  String get onboarding_4_content =>
      'اجعل كل فعالية لا تُنسى بمشاركتها مع الآخرين. منصتنا تتيح لك دعوة الأصدقاء، وإبقائهم على اطلاع، والاحتفال سوياً. التقط اللحظات وشاركها مع شبكتك لتستعيد الذكريات الجميلة وتحتفظ بها.';

  @override
  String get onboarding_back => 'السابق';

  @override
  String get onboarding_next => 'التالي';

  @override
  String get onboarding_skip => 'تخطي';

  @override
  String get onboarding_finish => 'انتهاء';

  @override
  String get login_email => 'البريد الإلكتروني';

  @override
  String get login_password => 'كلمة المرور';

  @override
  String get login_forget => 'نسيت كلمة المرور؟';

  @override
  String get login_button => 'تسجيل الدخول';

  @override
  String get login_account => 'لا تملك حساباً؟';

  @override
  String get login_create => 'إنشاء حساب';

  @override
  String get login_or => 'أو';

  @override
  String get login_google => 'تسجيل الدخول باستخدام Google';

  @override
  String get login_empty_email => 'يرجى ادخال البريد الالكتروني';

  @override
  String get login_valid_email => 'يرجى ادخال بريد الكتروني صالح';

  @override
  String get login_empty_password => 'يرجى ادخال كلمة المرور';

  @override
  String get login_6_characters =>
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get loading_login => 'جارٍ تسجيل الدخول...';

  @override
  String get loading_google => 'جارٍ تسجيل الدخول عبر Google...';

  @override
  String get login_success => 'تم تسجيل الدخول بنجاح';

  @override
  String get login_success_title => 'نجاح';

  @override
  String get login_success_action => 'موافق';

  @override
  String get google_login_success => 'تم تسجيل الدخول عبر Google بنجاح';

  @override
  String get google_login_cancelled =>
      'تم إلغاء تسجيل الدخول عبر Google أو فشل.';

  @override
  String get error_title => 'خطأ';

  @override
  String get error_invalid_credential =>
      'بيانات الدخول غير صحيحة أو منتهية أو بها مشكلة.';

  @override
  String get error_no_internet => 'لا يوجد اتصال بالإنترنت';

  @override
  String get error_firebase => 'حدث خطأ في Firebase';

  @override
  String get register_Title => 'إنشاء حساب';

  @override
  String get register_name => 'الاسم';

  @override
  String get register_email => 'البريد الإلكتروني';

  @override
  String get register_password => 'كلمة المرور';

  @override
  String get register_rePassword => 'تأكيد كلمة المرور';

  @override
  String get register_button => 'إنشاء حساب';

  @override
  String get register_have => 'لديك حساب بالفعل؟';

  @override
  String get register_login => 'تسجيل الدخول';

  @override
  String get register_empty_name => 'يرجى إدخال اسمك';

  @override
  String get register_empty_repassword => 'يرجى إعادة إدخال كلمة المرور';

  @override
  String get register_password_not_match => 'كلمات المرور غير متطابقة';

  @override
  String get register_loading => 'جاري التسجيل...';

  @override
  String get register_success => 'تم التسجيل بنجاح';

  @override
  String get register_success_title => 'نجاح';

  @override
  String get register_success_ok => 'حسنًا';

  @override
  String get register_email_exists =>
      'يوجد حساب بالفعل بهذا البريد الإلكتروني. الرجاء تسجيل الدخول';

  @override
  String get register_error_title => 'خطأ';

  @override
  String get register_no_internet => 'لا يوجد اتصال بالإنترنت';

  @override
  String get register_weak_password => 'كلمة المرور المقدمة ضعيفة جدًا.';

  @override
  String get forgetPassword_title => 'نسيت كلمة المرور';

  @override
  String get forgetPassword_button => 'إعادة تعيين كلمة المرور';

  @override
  String get home_welcome => '✨ مرحباً بعودتك';

  @override
  String get home_all => 'الكل';

  @override
  String get home_sport => 'رياضة';

  @override
  String get home_birthday => 'عيد ميلاد';

  @override
  String get love_search => 'ابحث عن فعالية';

  @override
  String get profile_language => 'اللغة';

  @override
  String get profile_english => 'الإنجليزية';

  @override
  String get profile_arabic => 'العربية';

  @override
  String get profile_theme => 'السمة';

  @override
  String get profile_light => 'فاتح';

  @override
  String get profile_dark => 'داكن';

  @override
  String get profile_logout => 'تسجيل الخروج';

  @override
  String get home => 'الرئيسية';

  @override
  String get profile => 'الحساب';

  @override
  String get love => 'المفضله';

  @override
  String get map => 'الخريطة';

  @override
  String get category_all => 'الكل';

  @override
  String get category_sport => 'رياضة';

  @override
  String get category_birthday => 'عيد ميلاد';

  @override
  String get category_meeting => 'اجتماع';

  @override
  String get category_gaming => 'ألعاب';

  @override
  String get category_workshop => 'ورشة عمل';

  @override
  String get category_bookclub => 'نادي الكتاب';

  @override
  String get category_exhibition => 'معرض';

  @override
  String get category_holiday => 'عطلة';

  @override
  String get category_eating => 'تناول الطعام';
}
