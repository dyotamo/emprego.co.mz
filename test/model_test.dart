import 'package:flutter_test/flutter_test.dart';
import 'package:prov/model.dart';

void main() {
  test('Must return phone', () {
    var company = CompanyModel.fromJson(
        {'address_phone': '3991 Avenida 24 Julho +258 86 163 9134'});
    expect('+258 86 163 9134', company.phone);
  });

  test('Must return address and phone', () {
    var company = CompanyModel.fromJson(
        {'address_phone': '3991 Avenida 24 Julho (+258) 86 163 9134'});
    expect('3991 Avenida 24 Julho', company.address);
    expect('(+258) 86 163 9134', company.phone);
  });

  test('Must return only city subtitle', () {
    var company = CompanyModel.fromJson(
        {'address_phone': '+258 86 163 9134', 'place': 'Beira'});
    expect('Beira', company.addressOrCity);
  });

  test('Must return only address subtile', () {
    var company = CompanyModel.fromJson(
        {'address_phone': '3991 Avenida 24 Julho +258 86 163 9134'});
    expect('3991 Avenida 24 Julho', company.addressOrCity);
  });

  test('Must return empty subtitle', () {
    var company = CompanyModel.fromJson({'address_phone': '+258 86 163 9134'});
    expect('', company.addressOrCity);
  });

  test('Must return empty subtitle', () {
    var company = CompanyModel.fromJson({});
    expect('', company.addressOrCity);
  });
}
