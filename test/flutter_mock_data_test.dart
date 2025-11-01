import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mock_data/flutter_mock_data.dart';

void main() {
  test('full name generation', () {
    final name = MockData.fullName();
    expect(name.isNotEmpty, true);
    expect(name.contains(' '), true);
  });

  test('email generation', () {
    final mail = MockData.email();
    expect(mail.contains('@'), true);
    expect(mail.split('@').length, 2);
  });

  test('phone generation', () {
    final phone = MockData.phone();
    expect(phone.isNotEmpty, true);
    expect(RegExp(r'^[+ 0-9]+$').hasMatch(phone), true);
  });

  test('lorem length', () {
    final text = MockData.lorem(words: 12);
    expect(text.split(' ').length, 12);
  });

  test('image url', () {
    final url = MockData.image(category: 'people');
    expect(url.startsWith('http'), true);
  });

  test('date within range', () {
    final d = MockData.date(rangeInDays: 10);
    final diff = DateTime.now().difference(d).inDays.abs();
    expect(diff <= 10, true);
  });
}
