import 'package:verifyip2location/src/base_response_whois.dart';
import 'package:verifyip2location/verifyip2location.dart' as verifyip2location;
import 'package:verifyip2location/src/base_response.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    String? codecounrty;
    BaseHttpIkaResponse? ip2loc;

    setUp(() async {
      // Effectuer des opérations asynchrones ici si nécessaire.

      ip2loc = await verifyip2location.getIpgeo(
          "EF3080DDEA1CBF08D4BA41DEE162DE54",
          plan: 0,
          option: "geoip",
          ip: "191.252.201.137");

      codecounrty = ip2loc!.countryCode;
    });

    test('Test if response is a Notnull', () {
      expect(codecounrty, isNotNull);
      print(ip2loc!.as);
      expect(ip2loc!.elevation, isNull);
      print(ip2loc!.elevation);
    });
  });

  group('test whois', () {
    String? codecounrty;
    HttpIkaWhoisService? ip2loc;

    setUp(() async {
      // Effectuer des opérations asynchrones ici si nécessaire.

      ip2loc = await verifyip2location.getDnsWhois(
          "EF3080DDEA1CBF08D4BA41DEE162DE54",
          plan: 0,
          option: "whois",
          domain: "dirkk.tech");
      codecounrty = ip2loc!.registrant.country;
    });

    test('Test if response is a Notnull', () {
      //print(ip2loc);
      if (ip2loc!.errorCode == 10001) {
        print(ip2loc!.errorMessage);
      } else {
        expect(codecounrty, isNotNull);
        print(ip2loc!.nameServer);
      }
    });
  });
}
