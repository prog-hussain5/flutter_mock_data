// ignore_for_file: unnecessary_library_name


import 'dart:math';

/// Locale options supported by MockData
enum MockLocale { en, ar }

/// MockData: Generate realistic mock data for apps without hitting real APIs.
///
/// Features:
/// - Names (Arabic and English)
/// - Emails, Phones
/// - Cities, Countries, Addresses
/// - Images (people, nature, tech, animals, food)
/// - Products (name, price, description)
/// - Dates
/// - Text (Lorem in EN/AR)
/// - Mock API response (JSON-like Map)
///
/// Usage:
///   MockData.setLocale(MockLocale.ar);
///   final name = MockData.fullName();
///   final email = MockData.email();
///   final img = MockData.image(category: 'people');
class MockData {
  MockData._();

  static final Random _rand = Random();

  static MockLocale _locale = MockLocale.en;

  /// Get current default locale
  static MockLocale get locale => _locale;

  /// Set default locale for all generators
  static void setLocale(MockLocale locale) => _locale = locale;

  /// Ensure a possibly empty value is filled using a generator.
  /// If [value] is null or considered empty (String empty), returns [orElse()].
  static T ensure<T>(T? value, T Function() orElse) {
    if (value == null) return orElse();
    if (value is String && value.trim().isEmpty) return orElse();
    return value;
  }

  // ----------------------- Names -----------------------
  static final List<String> _firstNamesEn = [
    'Liam', 'Olivia', 'Noah', 'Emma', 'Ava', 'Sophia', 'James', 'Isabella',
    'Mia', 'Benjamin', 'Lucas', 'Ethan', 'Amelia', 'Harper', 'Alexander'
  ];
  static final List<String> _lastNamesEn = [
    'Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Miller', 'Davis',
    'Garcia', 'Rodriguez', 'Wilson', 'Martinez', 'Anderson', 'Taylor'
  ];

  static final List<String> _firstNamesAr = [
    'محمد', 'أحمد', 'علي', 'يوسف', 'عمر', 'عبدالله', 'فاطمة', 'زينب', 'نور',
    'سارة', 'خالد', 'حسن', 'حسين', 'ليلى', 'مريم'
  ];
  static final List<String> _lastNamesAr = [
    'الهاشمي', 'الأنصاري', 'المصري', 'السعودي', 'الأنسي', 'العتيبي', 'الشريف',
    'الخطيب', 'الكاظمي', 'البغدادي', 'القحطاني'
  ];

  static T _pick<T>(List<T> items) => items[_rand.nextInt(items.length)];

  /// Returns a first name according to [locale] (default: current [MockData.locale]).
  static String firstName({MockLocale? locale}) {
    final loc = locale ?? _locale;
    return loc == MockLocale.ar ? _pick(_firstNamesAr) : _pick(_firstNamesEn);
  }

  /// Returns a last name according to [locale] (default: current [MockData.locale]).
  static String lastName({MockLocale? locale}) {
    final loc = locale ?? _locale;
    return loc == MockLocale.ar ? _pick(_lastNamesAr) : _pick(_lastNamesEn);
  }

  /// Returns a full name according to [locale].
  static String fullName({MockLocale? locale}) {
    return '${firstName(locale: locale)} ${lastName(locale: locale)}';
  }

  // ----------------------- Email -----------------------
  static final List<String> _domains = [
    'example.com', 'mail.com', 'gmail.com', 'outlook.com', 'yahoo.com'
  ];

  /// Generate email address.
  /// If [domain] is not provided, picks a popular one.
  static String email({String? domain, MockLocale? locale}) {
    final loc = locale ?? _locale;
    final fn = firstName(locale: loc).toLowerCase();
    final ln = lastName(locale: loc).toLowerCase();
    final token = _rand.nextInt(9999).toString().padLeft(2, '0');
  String safe(String s) {
    return s
      .replaceAll(RegExp('[^a-z0-9]+'), '_')
      .replaceAll(RegExp('_+'), '_')
      .replaceAll(RegExp(r'^_|_+$'), '');
  }
    final user = safe('$fn.$ln$token');
    final dom = ensure(domain, () => _pick(_domains));
    return '$user@$dom';
  }

  // ----------------------- Phone -----------------------
  /// Generate a fake phone number. Default [countryCode] depends on locale.
  static String phone({String? countryCode, MockLocale? locale}) {
    final loc = locale ?? _locale;
    final cc = ensure(countryCode, () => loc == MockLocale.ar ? '+966' : '+1');
    // generate 9-10 digits
    final len = 9 + _rand.nextInt(2);
    final digits = List.generate(len, (_) => _rand.nextInt(10)).join();
    return '$cc $digits';
  }

  // ----------------------- Locations -----------------------
  static final List<String> _countriesEn = [
    'United States', 'United Kingdom', 'Germany', 'France', 'Canada', 'Italy',
    'Spain', 'Netherlands', 'Japan', 'Australia'
  ];
  static final List<String> _countriesAr = [
    'السعودية', 'الإمارات', 'مصر', 'العراق', 'الأردن', 'فلسطين', 'المغرب',
    'الجزائر', 'تونس', 'البحرين'
  ];
  static final List<String> _citiesEn = [
    'New York', 'London', 'Berlin', 'Paris', 'Toronto', 'Rome', 'Madrid',
    'Amsterdam', 'Tokyo', 'Sydney'
  ];
  static final List<String> _citiesAr = [
    'الرياض', 'دبي', 'القاهرة', 'بغداد', 'عمان', 'الدوحة', 'جدة', 'الدار البيضاء',
    'الجزائر', 'تونس'
  ];
  static final List<String> _streetNamesEn = [
    'Main', 'Oak', 'Pine', 'Cedar', 'Maple', 'Elm', 'Walnut', 'Sunset'
  ];
  static final List<String> _streetNamesAr = [
    'الملك', 'السلام', 'النخيل', 'الورود', 'النصر', 'الوحدة', 'السعادة'
  ];

  static String country({MockLocale? locale}) {
    final loc = locale ?? _locale;
    return loc == MockLocale.ar ? _pick(_countriesAr) : _pick(_countriesEn);
  }

  static String city({MockLocale? locale}) {
    final loc = locale ?? _locale;
    return loc == MockLocale.ar ? _pick(_citiesAr) : _pick(_citiesEn);
  }

  static String address({MockLocale? locale}) {
    final loc = locale ?? _locale;
    final num = 1 + _rand.nextInt(199);
    final street = loc == MockLocale.ar ? _pick(_streetNamesAr) : _pick(_streetNamesEn);
    final c = city(locale: loc);
    final cnt = country(locale: loc);
    return loc == MockLocale.ar
        ? 'شارع $street، رقم $num، $c، $cnt'
        : '$num $street St, $c, $cnt';
  }

  // ----------------------- Images -----------------------
  /// Get a placeholder image URL.
  /// Categories: people, nature, tech, animals, food, any (default)
  static String image({String? category, int width = 400, int height = 300}) {
    final cat = (category ?? 'any').toLowerCase();
    final seed = _rand.nextInt(100000);
    switch (cat) {
      case 'people':
        final id = 1 + _rand.nextInt(70);
        return 'https://i.pravatar.cc/${width}x$height?img=$id&seed=$seed';
      case 'animals':
        return 'https://placebear.com/$width/$height?seed=$seed';
      case 'tech':
  return 'https://placehold.co/${width}x$height/0d6efd/ffffff?text=Tech%20$seed';
      case 'food':
        return 'https://loremflickr.com/$width/$height/food?lock=$seed';
      case 'nature':
        return 'https://picsum.photos/seed/$seed/$width/$height';
      default:
        return 'https://picsum.photos/seed/$seed/$width/$height';
    }
  }

  // ----------------------- Products -----------------------
  static final List<String> _adjectivesEn = [
    'Smart', 'Eco', 'Portable', 'Premium', 'Ultra', 'Classic', 'Modern'
  ];
  static final List<String> _nounsEn = [
    'Headphones', 'Backpack', 'Bottle', 'Chair', 'Lamp', 'Watch', 'Shoes'
  ];
  static final List<String> _adjectivesAr = [
    'ذكي', 'بيئي', 'محمول', 'فاخر', 'بريموم', 'كلاسيكي', 'حديث'
  ];
  static final List<String> _nounsAr = [
    'سماعات', 'حقيبة', 'قارورة', 'كرسي', 'مصباح', 'ساعة', 'حذاء'
  ];

  static String productName({MockLocale? locale}) {
    final loc = locale ?? _locale;
    if (loc == MockLocale.ar) {
      return '${_pick(_adjectivesAr)} ${_pick(_nounsAr)}';
    }
    return '${_pick(_adjectivesEn)} ${_pick(_nounsEn)}';
  }

  static double price({double min = 5, double max = 999, int decimals = 2}) {
    assert(min >= 0 && max > min);
    final value = min + _rand.nextDouble() * (max - min);
    final factor = pow(10, decimals).toDouble();
    return (value * factor).round() / factor;
  }

  static String description({int sentences = 2, MockLocale? locale}) {
    final loc = locale ?? _locale;
    final builder = <String>[];
    for (var i = 0; i < sentences; i++) {
      final words = loc == MockLocale.ar
          ? arabicLorem(words: 8 + _rand.nextInt(6))
          : lorem(words: 8 + _rand.nextInt(6));
  final s = '${words[0].toUpperCase()}${words.substring(1)}.';
      builder.add(s);
    }
    return builder.join(' ');
  }

  // ----------------------- Dates -----------------------
  /// Generate a date within a range of days from now.
  static DateTime date({int rangeInDays = 365, bool inFuture = false}) {
    final delta = _rand.nextInt(rangeInDays + 1);
    final sign = inFuture ? 1 : -1;
    return DateTime.now().add(Duration(days: sign * delta, minutes: _rand.nextInt(1440)));
  }

  // ----------------------- Text -----------------------
  static final List<String> _loremWordsEn = (
    'lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua '
    'ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat '
    'duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur '
    'excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum'
  ).split(' ');

  static final List<String> _loremWordsAr = (
    'لوريم ايبسوم نص شكلي يستخدم في صناعة المطابع والتنضيد كان لوريم ايبسوم النص القياسي منذ القرن الخامس عشر '
    'حين قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي لصنع كتاب عينات '
    'لقد صمد ليس فقط خمسة قرون بل قفز ايضا الى التنضيد الالكتروني'
  ).split(' ');

  /// English lorem ipsum text with [words] count.
  static String lorem({int words = 10}) {
    final b = <String>[];
    for (var i = 0; i < words; i++) {
      b.add(_pick(_loremWordsEn));
    }
    return b.join(' ');
  }

  /// Arabic lorem ipsum text with [words] count.
  static String arabicLorem({int words = 10}) {
    final b = <String>[];
    for (var i = 0; i < words; i++) {
      b.add(_pick(_loremWordsAr));
    }
    return b.join(' ');
  }

  // ----------------------- Mock API -----------------------
  /// Returns a JSON-like map representing a typical API response for a user.
  static Map<String, dynamic> mockApiResponse({MockLocale? locale}) {
    final loc = locale ?? _locale;
    final id = 1000 + _rand.nextInt(900000);
    return {
      'id': id,
      'name': fullName(locale: loc),
      'email': email(locale: loc),
      'phone': phone(locale: loc),
      'address': {
        'country': country(locale: loc),
        'city': city(locale: loc),
        'line1': address(locale: loc),
      },
      'avatar': image(category: 'people'),
      'createdAt': date(rangeInDays: 400).toIso8601String(),
      'meta': {
        'locale': loc.name,
        'product': {
          'name': productName(locale: loc),
          'price': price(),
          'description': description(locale: loc),
          'image': image(category: 'tech', width: 600, height: 400),
        }
      }
    };
  }
}

