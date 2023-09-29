import 'package:verifyip2location/src/base_response.dart';
import 'package:verifyip2location/src/base_response_whois.dart';
import 'package:verifyip2location/src/parse_location.dart';

/// Package to verify personnal connexion
/// by finding the geolacation of the person
/// (City Name), region name, and country name
/// Country Code
/// if is used normal Proxy
/// or tor / vpn
///  you can find the position via latitude and longitude
/// a botnet Malware infected devices.

/// method to make an HTTP GET request [getIpgeo].
Future<BaseHttpIkaResponse> getIpgeo(String ip2token,
        {int? plan, String? option, String? ip, String? domain}) =>
    _ip2location(ip2token, plan: plan, option: option, ip: ip, domain: domain);

/// method to make an HTTP GET request with [getDnsWhois].
Future<HttpIkaWhoisService> getDnsWhois(String ip2token,
        {int? plan, String? option, String? ip, String? domain}) =>
    _ip2whois(ip2token, plan: plan, option: option, domain: domain);

/// Function to make an HTTP GET request and fund the response [_ip2location].
Future<BaseHttpIkaResponse> _ip2location(String ip2token,
    {int? plan, String? option, String? ip, String? domain}) async {
  var parseLocation = ParseLocation();

  /// Put default value (free plan)
  plan ??= 0;

  assert(option != null,
      "Expected option, but null was returned [geoip] or [whois]");
    var ip2loc = parseLocation.parseHttp(ip2token,
        chp: plan, option: option, ip: ip);

  return ip2loc;
}


/// Function to make an HTTP GET request and fund the response [_ip2location].
Future<HttpIkaWhoisService> _ip2whois(String ip2token,
    {int? plan, String? option, String? domain}) async {
  var parseLocation = ParseLocation();

  /// Put default value (free plan)
  plan ??= 0;

  assert(option != null,
      "Expected option, but null was returned [geoip] or [whois]");
    var ip2loc = parseLocation.domainWhois(ip2token, chp: plan, option: option, domain: domain);

  return ip2loc;
}
