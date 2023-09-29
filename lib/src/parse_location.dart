import 'dart:convert';

import 'package:verifyip2location/src/base_response.dart';
import 'package:verifyip2location/src/base_response_whois.dart';
import 'package:verifyip2location/src/ip2config.dart';
import 'package:http/http.dart' as http;

class ParseLocation extends ConfigIP {
  /// Retreive data from [ip2loc]
  Map<String, dynamic>? ip2loc;

  Future<BaseHttpIkaResponse> parseHttp(String token,
    {String? option, String? ip, String? domain, int? chp}) async {
  var data = BaseHttpIkaResponse(
      isProxy: false,
      continent: Continent(),
      country: Country(),
      region: Region(),
      city: City(),
      timeZoneInfo: TimeZoneInfo(),
      geotargeting: Geotargeting());

  apikey = token.toUpperCase();

  assert(chp != null, "Expected plan, but null was returned");
  String? plan = super.choosePlan(chp!);

  /// check if plan is null or not
  assert(plan != null, "Expected plan, but null was returned");

  /// add option to use ip2location or whois domain
  /// default value is [geoip]
  option ??= "geoip";

  assert(ip != null, "Expected ip, but null was returned");

  /// Assign the good url
  final finalUrl = "${url}key=${apikey!}&ip=$ip&format=json";

  try {
    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      ip2loc = jsonDecode(response.body);

      data.as = ip2loc!["as"];
      data.asn = ip2loc!["asn"];
      data.cityName = ip2loc!["city_name"];
      data.countryCode = ip2loc!["country_code"];
      data.countryName = ip2loc!["country_name"];
      data.isProxy = ip2loc!["is_proxy"];
      data.latitude = ip2loc!["latitude"];
      data.longitude = ip2loc!["longitude"];
      data.regionName = ip2loc!["region_name"];
      data.resIp = ip2loc!["ip"];
      data.timeZone = ip2loc!["time_zone"];
      data.zipCode = ip2loc!["zip_code"];

      // Common data extraction for all plans
      if (plan == "starter" || plan == "plus" || plan == "security") {
        data.isp = ip2loc!["isp"];
        data.domain = ip2loc!["domain"];
        data.netSpeed = ip2loc!["net_speed"];
        data.iddCode = ip2loc!["idd_code"];
        data.areaCode = ip2loc!["area_code"];
        data.weatherStationCode = ip2loc!["weather_station_code"];
        data.weatherStationName = ip2loc!["weather_station_name"];
        data.elevation = ip2loc!["elevation"];
        data.usageType = ip2loc!["usage_type"];
      }

      if (plan == "plus" || plan == "security") {
        data.mcc = ip2loc!["mcc"];
        data.mnc = ip2loc!["mnc"];
        data.mobileBrand = ip2loc!["mobile_brand"];
        data.addressType = ip2loc!["address_type"];

        // Extract continent data
      data.continent.name = ip2loc!["continent"]["name"];
      data.continent.code = ip2loc!["continent"]["code"];
      data.continent.hemisphere =
          List<String>.from(ip2loc!["continent"]["hemisphere"]);
      data.continent.translation.lang =
          ip2loc!["continent"]["translation"]["lang"];
      data.continent.translation.value =
          ip2loc!["continent"]["translation"]["value"];

      // Extract country data
      data.country.name = ip2loc!["country"]["name"];
      data.country.alpha3Code = ip2loc!["country"]["alpha3_code"];
      data.country.numericCode = ip2loc!["country"]["numeric_code"];
      data.country.demonym = ip2loc!["country"]["demonym"];
      data.country.flag = ip2loc!["country"]["flag"];
      data.country.capital = ip2loc!["country"]["capital"];
      data.country.totalArea = ip2loc!["country"]["total_area"];
      data.country.population = ip2loc!["country"]["population"];
      data.country.currency.code = ip2loc!["country"]["currency"]["code"];
      data.country.currency.name = ip2loc!["country"]["currency"]["name"];
      data.country.currency.symbol = ip2loc!["country"]["currency"]["symbol"];
      data.country.language.code = ip2loc!["country"]["language"]["code"];
      data.country.language.name = ip2loc!["country"]["language"]["name"];
      data.country.tld = ip2loc!["country"]["tld"];
      data.country.translation.lang =
          ip2loc!["country"]["translation"]["lang"];
      data.country.translation.value =
          ip2loc!["country"]["translation"]["value"];

      // Extract region data
      data.region.name = ip2loc!["region"]["name"];
      data.region.code = ip2loc!["region"]["code"];
      data.region.translation.lang = ip2loc!["region"]["translation"]["lang"];
      data.region.translation.value = ip2loc!["region"]["translation"]["value"];

      // Extract city data
      data.city.name = ip2loc!["city"]["name"];

      // Extract timeZoneInfo data
      data.timeZoneInfo.olson = ip2loc!["time_zone_info"]["olson"];
      data.timeZoneInfo.currentTime = ip2loc!["time_zone_info"]["current_time"];
      data.timeZoneInfo.gmtOffset = ip2loc!["time_zone_info"]["gmt_offset"];
      data.timeZoneInfo.isDst = ip2loc!["time_zone_info"]["is_dst"];
      data.timeZoneInfo.sunrise = ip2loc!["time_zone_info"]["sunrise"];
      data.timeZoneInfo.sunset = ip2loc!["time_zone_info"]["sunset"];

      // Extract geotargeting data
      data.geotargeting.metro = ip2loc!["geotargeting"]["metro"];
      }

      if (plan == "security") {
        data.adsCategory = ip2loc!["ads_category"];
        data.district = ip2loc!["district"];

        // Extract proxy data
        data.proxy.lastSeen = ip2loc!["proxy"]["last_seen"];
        data.proxy.proxyType = ip2loc!["proxy"]["proxy_type"];
        data.proxy.threat = ip2loc!["proxy"]["threat"];
        data.proxy.provider = ip2loc!["proxy"]["provider"];
        data.proxy.isVpn = ip2loc!["proxy"]["is_vpn"];
        data.proxy.isTor = ip2loc!["proxy"]["is_tor"];
        data.proxy.isDataCenter = ip2loc!["proxy"]["is_data_center"];
        data.proxy.isPublicProxy = ip2loc!["proxy"]["is_public_proxy"];
        data.proxy.isWebProxy = ip2loc!["proxy"]["is_web_proxy"];
        data.proxy.isWebCrawler = ip2loc!["proxy"]["is_web_crawler"];
        data.proxy.isResidentialProxy = ip2loc!["proxy"]["is_residential_proxy"];
        data.proxy.isSpammer = ip2loc!["proxy"]["is_spammer"];
        data.proxy.isScanner = ip2loc!["proxy"]["is_scanner"];
        data.proxy.isBotnet = ip2loc!["proxy"]["is_botnet"];
      }

      
    } else {
      print(response.body);
      throw 'La requête a retourné un code d\'état ${response.statusCode}';
    }

    return data;
  } catch (e) {
    throw 'Une erreur s\'est produite lors de la requête : $e';
  }
}

  /*Future<BaseHttpIkaResponse> parseHttp(String token,
      {String? option, String? ip, String? domain, int? chp}) async {
    var data = BaseHttpIkaResponse(
        isProxy: false,
        continent: Continent(),
        country: Country(),
        region: Region(),
        city: City(),
        timeZoneInfo: TimeZoneInfo(),
        geotargeting: Geotargeting());

    apikey = token.toUpperCase();

    assert(chp != null, "Expected plan, but null was returned");

    String? plan = super.choosePlan(chp!);

    /// check if plan is null or not
    assert(plan != null, "Expected plan, but null was returned");

    /// add option to use ip2location or whois domain
    /// default value is [geoip]
    option ??= "geoip";

    assert(ip != null, "Expected ip, but null was returned");

    /// Assign the good url
    final finalUrl = "${url}key=${apikey!}&ip=$ip&format=json";

    try {
      final response = await http.get(Uri.parse(finalUrl));

      switch (plan) {
        case "free":
          if (response.statusCode == 200) {
            ip2loc = jsonDecode(response.body);

            data.as = ip2loc!["as"];
            data.asn = ip2loc!["asn"];
            data.cityName = ip2loc!["city_name"];
            data.countryCode = ip2loc!["country_code"];
            data.countryName = ip2loc!["country_name"];
            data.isProxy = ip2loc!["is_proxy"];
            data.latitude = ip2loc!["latitude"];
            data.longitude = ip2loc!["longitude"];
            data.regionName = ip2loc!["region_name"];
            data.resIp = ip2loc!["ip"];
            data.timeZone = ip2loc!["time_zone"];
            data.zipCode = ip2loc!["zip_code"];
          } else {
            print(response.body);
            throw 'La requête a retourné un code d\'état ${response.statusCode}';
          }
          break;
        case "starter":
          if (response.statusCode == 200) {
            ip2loc = jsonDecode(response.body);

            data.as = ip2loc!["as"];
            data.asn = ip2loc!["asn"];
            data.cityName = ip2loc!["city_name"];
            data.countryCode = ip2loc!["country_code"];
            data.countryName = ip2loc!["country_name"];
            data.isProxy = ip2loc!["is_proxy"];
            data.latitude = ip2loc!["latitude"];
            data.longitude = ip2loc!["longitude"];
            data.regionName = ip2loc!["region_name"];
            data.resIp = ip2loc!["ip"];
            data.timeZone = ip2loc!["time_zone"];
            data.zipCode = ip2loc!["zip_code"];
            data.isp = ip2loc!["isp"];
            data.domain = ip2loc!["domain"];
            data.netSpeed = ip2loc!["net_speed"];
            data.iddCode = ip2loc!["idd_code"];
            data.areaCode = ip2loc!["area_code"];
            data.weatherStationCode = ip2loc!["weather_station_code"];
            data.weatherStationName = ip2loc!["weather_station_name"];
            data.elevation = ip2loc!["elevation"];
            data.usageType = ip2loc!["usage_type"];
          } else {
            print(response.body);
            throw 'La requête a retourné un code d\'état ${response.statusCode}';
          }
          break;
        case "plus":
          if (response.statusCode == 200) {
            ip2loc = jsonDecode(response.body);

            data.as = ip2loc!["as"];
            data.asn = ip2loc!["asn"];
            data.cityName = ip2loc!["city_name"];
            data.countryCode = ip2loc!["country_code"];
            data.countryName = ip2loc!["country_name"];
            data.isProxy = ip2loc!["is_proxy"];
            data.latitude = ip2loc!["latitude"];
            data.longitude = ip2loc!["longitude"];
            data.regionName = ip2loc!["region_name"];
            data.resIp = ip2loc!["ip"];
            data.timeZone = ip2loc!["time_zone"];
            data.zipCode = ip2loc!["zip_code"];
            data.isp = ip2loc!["isp"];
            data.domain = ip2loc!["domain"];
            data.netSpeed = ip2loc!["net_speed"];
            data.iddCode = ip2loc!["idd_code"];
            data.areaCode = ip2loc!["area_code"];
            data.weatherStationCode = ip2loc!["weather_station_code"];
            data.weatherStationName = ip2loc!["weather_station_name"];
            data.elevation = ip2loc!["elevation"];
            data.usageType = ip2loc!["usage_type"];
            data.mcc = ip2loc!["mcc"];
            data.mnc = ip2loc!["mnc"];
            data.mobileBrand = ip2loc!["mobile_brand"];
            data.addressType = ip2loc!["address_type"];

            // Extract continent data
            data.continent.name = ip2loc!["continent"]["name"];
            data.continent.code = ip2loc!["continent"]["code"];
            data.continent.hemisphere = List<String>.from(ip2loc!["continent"]["hemisphere"]);
            data.continent.translation.lang = ip2loc!["continent"]["translation"]["lang"];
            data.continent.translation.value = ip2loc!["continent"]["translation"]["value"];

            // Extract country data
            data.country.name = ip2loc!["country"]["name"];
            data.country.alpha3Code = ip2loc!["country"]["alpha3_code"];
            data.country.numericCode = ip2loc!["country"]["numeric_code"];
            data.country.demonym = ip2loc!["country"]["demonym"];
            data.country.flag = ip2loc!["country"]["flag"];
            data.country.capital = ip2loc!["country"]["capital"];
            data.country.totalArea = ip2loc!["country"]["total_area"];
            data.country.population = ip2loc!["country"]["population"];
            data.country.currency.code = ip2loc!["country"]["currency"]["code"];
            data.country.currency.name = ip2loc!["country"]["currency"]["name"];
            data.country.currency.symbol = ip2loc!["country"]["currency"]["symbol"];
            data.country.language.code = ip2loc!["country"]["language"]["code"];
            data.country.language.name = ip2loc!["country"]["language"]["name"];
            data.country.tld = ip2loc!["country"]["tld"];
            data.country.translation.lang = ip2loc!["country"]["translation"]["lang"];
            data.country.translation.value = ip2loc!["country"]["translation"]["value"];

            // Extract region data
            data.region.name = ip2loc!["region"]["name"];
            data.region.code = ip2loc!["region"]["code"];
            data.region.translation.lang = ip2loc!["region"]["translation"]["lang"];
            data.region.translation.value = ip2loc!["region"]["translation"]["value"];

            // Extract city data
            data.city.name = ip2loc!["city"]["name"];

            // Extract timeZoneInfo data
            data.timeZoneInfo.olson = ip2loc!["time_zone_info"]["olson"];
            data.timeZoneInfo.currentTime = ip2loc!["time_zone_info"]["current_time"];
            data.timeZoneInfo.gmtOffset = ip2loc!["time_zone_info"]["gmt_offset"];
            data.timeZoneInfo.isDst = ip2loc!["time_zone_info"]["is_dst"];
            data.timeZoneInfo.sunrise = ip2loc!["time_zone_info"]["sunrise"];
            data.timeZoneInfo.sunset = ip2loc!["time_zone_info"]["sunset"];

            // Extract geotargeting data
            data.geotargeting.metro = ip2loc!["geotargeting"]["metro"];
          } else {
            print(response.body);
            throw 'La requête a retourné un code d\'état ${response.statusCode}';
          }
        case "security":
          if (response.statusCode == 200) {
            ip2loc = jsonDecode(response.body);

            data.as = ip2loc!["as"];
            data.asn = ip2loc!["asn"];
            data.cityName = ip2loc!["city_name"];
            data.countryCode = ip2loc!["country_code"];
            data.countryName = ip2loc!["country_name"];
            data.isProxy = ip2loc!["is_proxy"];
            data.latitude = ip2loc!["latitude"];
            data.longitude = ip2loc!["longitude"];
            data.regionName = ip2loc!["region_name"];
            data.resIp = ip2loc!["ip"];
            data.timeZone = ip2loc!["time_zone"];
            data.zipCode = ip2loc!["zip_code"];

            data.as = ip2loc!["as"];
            data.asn = ip2loc!["asn"];
            data.cityName = ip2loc!["city_name"];
            data.countryCode = ip2loc!["country_code"];
            data.countryName = ip2loc!["country_name"];
            data.isProxy = ip2loc!["is_proxy"];
            data.latitude = ip2loc!["latitude"];
            data.longitude = ip2loc!["longitude"];
            data.regionName = ip2loc!["region_name"];
            data.resIp = ip2loc!["ip"];
            data.timeZone = ip2loc!["time_zone"];
            data.zipCode = ip2loc!["zip_code"];
            data.isp = ip2loc!["isp"];
            data.domain = ip2loc!["domain"];
            data.netSpeed = ip2loc!["net_speed"];
            data.iddCode = ip2loc!["idd_code"];
            data.areaCode = ip2loc!["area_code"];
            data.weatherStationCode = ip2loc!["weather_station_code"];
            data.weatherStationName = ip2loc!["weather_station_name"];
            data.elevation = ip2loc!["elevation"];
            data.usageType = ip2loc!["usage_type"];
            data.mcc = ip2loc!["mcc"];
            data.mnc = ip2loc!["mnc"];
            data.mobileBrand = ip2loc!["mobile_brand"];
            data.addressType = ip2loc!["address_type"];

            // Extract continent data
            data.continent.name = ip2loc!["continent"]["name"];
            data.continent.code = ip2loc!["continent"]["code"];
            data.continent.hemisphere = List<String>.from(ip2loc!["continent"]["hemisphere"]);
            data.continent.translation.lang = ip2loc!["continent"]["translation"]["lang"];
            data.continent.translation.value = ip2loc!["continent"]["translation"]["value"];

            // Extract country data
            data.country.name = ip2loc!["country"]["name"];
            data.country.alpha3Code = ip2loc!["country"]["alpha3_code"];
            data.country.numericCode = ip2loc!["country"]["numeric_code"];
            data.country.demonym = ip2loc!["country"]["demonym"];
            data.country.flag = ip2loc!["country"]["flag"];
            data.country.capital = ip2loc!["country"]["capital"];
            data.country.totalArea = ip2loc!["country"]["total_area"];
            data.country.population = ip2loc!["country"]["population"];
            data.country.currency.code = ip2loc!["country"]["currency"]["code"];
            data.country.currency.name = ip2loc!["country"]["currency"]["name"];
            data.country.currency.symbol = ip2loc!["country"]["currency"]["symbol"];
            data.country.language.code = ip2loc!["country"]["language"]["code"];
            data.country.language.name = ip2loc!["country"]["language"]["name"];
            data.country.tld = ip2loc!["country"]["tld"];
            data.country.translation.lang = ip2loc!["country"]["translation"]["lang"];
            data.country.translation.value = ip2loc!["country"]["translation"]["value"];

            // Extract region data
            data.region.name = ip2loc!["region"]["name"];
            data.region.code = ip2loc!["region"]["code"];
            data.region.translation.lang = ip2loc!["region"]["translation"]["lang"];
            data.region.translation.value = ip2loc!["region"]["translation"]["value"];

            // Extract city data
            data.city.name = ip2loc!["city"]["name"];

            // Extract timeZoneInfo data
            data.timeZoneInfo.olson = ip2loc!["time_zone_info"]["olson"];
            data.timeZoneInfo.currentTime = ip2loc!["time_zone_info"]["current_time"];
            data.timeZoneInfo.gmtOffset = ip2loc!["time_zone_info"]["gmt_offset"];
            data.timeZoneInfo.isDst = ip2loc!["time_zone_info"]["is_dst"];
            data.timeZoneInfo.sunrise = ip2loc!["time_zone_info"]["sunrise"];
            data.timeZoneInfo.sunset = ip2loc!["time_zone_info"]["sunset"];

            // Extract geotargeting data
            data.geotargeting.metro = ip2loc!["geotargeting"]["metro"];

            // Extract ads_category data
            data.adsCategory = ip2loc!["ads_category"];

            // Extract district data
            data.district = ip2loc!["district"];

            // Extract proxy data
            data.isProxy = ip2loc!["is_proxy"];
            data.proxy.lastSeen = ip2loc!["proxy"]["last_seen"];
            data.proxy.proxyType = ip2loc!["proxy"]["proxy_type"];
            data.proxy.threat = ip2loc!["proxy"]["threat"];
            data.proxy.provider = ip2loc!["proxy"]["provider"];
            data.proxy.isVpn = ip2loc!["proxy"]["is_vpn"];
            data.proxy.isTor = ip2loc!["proxy"]["is_tor"];
            data.proxy.isDataCenter = ip2loc!["proxy"]["is_data_center"];
            data.proxy.isPublicProxy = ip2loc!["proxy"]["is_public_proxy"];
            data.proxy.isWebProxy = ip2loc!["proxy"]["is_web_proxy"];
            data.proxy.isWebCrawler = ip2loc!["proxy"]["is_web_crawler"];
            data.proxy.isResidentialProxy = ip2loc!["proxy"]["is_residential_proxy"];
            data.proxy.isSpammer = ip2loc!["proxy"]["is_spammer"];
            data.proxy.isScanner = ip2loc!["proxy"]["is_scanner"];
            data.proxy.isBotnet = ip2loc!["proxy"]["is_botnet"];
          } else {
            print(response.body);
            throw 'La requête a retourné un code d\'état ${response.statusCode}';
          }
        default:
          if (response.statusCode == 200) {
            ip2loc = jsonDecode(response.body);

            data.as = ip2loc!["as"];
            data.asn = ip2loc!["asn"];
            data.cityName = ip2loc!["city_name"];
            data.countryCode = ip2loc!["country_code"];
            data.countryName = ip2loc!["country_name"];
            data.isProxy = ip2loc!["is_proxy"];
            data.latitude = ip2loc!["latitude"];
            data.longitude = ip2loc!["longitude"];
            data.regionName = ip2loc!["region_name"];
            data.resIp = ip2loc!["ip"];
            data.timeZone = ip2loc!["time_zone"];
            data.zipCode = ip2loc!["zip_code"];
          } else {
            print(response.body);
            throw 'La requête a retourné un code d\'état ${response.statusCode}';
          }
          break;
      }
      return data;
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la requête : $e';
    }
  }*/

  Future<HttpIkaWhoisService> domainWhois(String token,
    {String? option, String? ip, String? domain, int? chp}) async {
  var data = HttpIkaWhoisService(
      registrar: Registrar(),
      registrant: Registrant(),
      admin: Admin(),
      technical: Tech(),
      billing: Billing());
  apikey = token.toUpperCase();

  assert(chp != null, "Expected plan, but null was returned");
  String? plan = super.choosePlan(chp!);

  assert(plan != null, "Expected plan, but null was returned");
  option ??= "whois";
  assert(domain != null, "Expected domain, but null was returned");

  final finalUrl = "${urlW}key=${apikey!}&domain=$domain";

  try {
    final response = await http.get(Uri.parse(finalUrl));
    if (response.statusCode == 200) {
      _extractDataFromJson(data, jsonDecode(response.body));
      return data;
    } else {
      _handleError(data, jsonDecode(response.body));
      return data;
    }
  } catch (e) {
    throw 'Une erreur s\'est produite lors de la requête : $e';
  }
}

void _extractDataFromJson(HttpIkaWhoisService data, Map<String, dynamic> json) {
  data.domain = json["domain"];
  data.domainId = json["domain_id"];
  data.status = json["status"];
  data.createDate = json["create_date"];
  data.updateDate = json["update_date"];
  data.expiresDate = json["expire_date"];
  data.domainAge = json["domain_age"];
  data.whoisServer = json["whois_server"];

  data.registrar.ianaId = json["registrar"]["iana_id"];
  data.registrar.name = json["registrar"]["name"];
  data.registrar.url = json["registrar"]["url"];

  data.registrant.name = json["registrant"]["name"];
  data.registrant.organization = json["registrant"]["organization"];
  data.registrant.streetAddress = json["registrant"]["street_address"];
  data.registrant.city = json["registrant"]["city"];
  data.registrant.region = json["registrant"]["region"];
  data.registrant.zipCode = json["registrant"]["zip_code"];
  data.registrant.country = json["registrant"]["country"];
  data.registrant.phone = json["registrant"]["phone"];
  data.registrant.email = json["registrant"]["email"];
  data.registrant.fax = json["registrant"]["fax"];

  data.admin.city = json["admin"]["city"];
  data.admin.region = json["admin"]["region"];
  data.admin.zipCode = json["admin"]["zip_code"];
  data.admin.country = json["admin"]["country"];
  data.admin.phone = json["admin"]["phone"];
  data.admin.email = json["admin"]["email"];
  data.admin.fax = json["admin"]["fax"];
  data.admin.name = json["admin"]["name"];
  data.admin.streetAddress = json["admin"]["street_address"];
  data.admin.organization = json["admin"]["organization"];

  data.technical.city = json["tech"]["city"];
  data.technical.region = json["tech"]["region"];
  data.technical.zipCode = json["tech"]["zip_code"];
  data.technical.country = json["tech"]["country"];
  data.technical.phone = json["tech"]["phone"];
  data.technical.email = json["tech"]["email"];
  data.technical.fax = json["tech"]["fax"];
  data.technical.name = json["tech"]["name"];
  data.technical.streetAddress = json["tech"]["street_address"];
  data.technical.organization = json["tech"]["organization"];

  data.billing.city = json["billing"]["city"];
  data.billing.region = json["billing"]["region"];
  data.billing.zipCode = json["billing"]["zip_code"];
  data.billing.country = json["billing"]["country"];
  data.billing.phone = json["billing"]["phone"];
  data.billing.email = json["billing"]["email"];
  data.billing.fax = json["billing"]["fax"];
  data.billing.name = json["billing"]["name"];
  data.billing.streetAddress = json["billing"]["street_address"];
  data.billing.organization = json["billing"]["organization"];

  data.nameServer = json["nameservers"];
}

void _handleError(HttpIkaWhoisService data, Map<String, dynamic> json) {
  data.errorCode = json["error"]["error_code"];
  data.errorMessage = json["error"]["error_message"];
}

 /* Future<HttpIkaWhoisService> domainWhois(String token,
      {String? option, String? ip, String? domain, int? chp}) async {
    var data = HttpIkaWhoisService(
        registrar: Registrar(),
        registrant: Registrant(),
        admin: Admin(),
        technical: Tech(),
        billing: Billing());
    apikey = token.toUpperCase();

    assert(chp != null, "Expected plan, but null was returned");

    String? plan = super.choosePlan(chp!);

    /// check if plan is null or not
    assert(plan != null, "Expected plan, but null was returned");

    /// add option to use ip2location or whois domain
    /// default value is [geoip]
    option ??= "whois";

    assert(domain != null, "Expected domain, but null was returned");

    /// Assign the good url
    final finalUrl = "${urlW}key=${apikey!}&domain=$domain";

    //print(finalUrl);

    try {
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        ip2loc = jsonDecode(response.body);

        // print(ip2loc!);

        /// First json data
        data.domain = ip2loc!["domain"];
        data.domainId = ip2loc!["domain_id"];
        data.status = ip2loc!["status"];
        data.createDate = ip2loc!["create_date"];
        data.updateDate = ip2loc!["update_date"];
        data.expiresDate = ip2loc!["expire_date"];
        data.domainAge = ip2loc!["domain_age"];
        data.whoisServer = ip2loc!["whois_server"];

        /// under class Registrar
        data.registrar.ianaId = ip2loc!["registrar"]["iana_id"];
        data.registrar.name = ip2loc!["registrar"]["name"];
        data.registrar.url = ip2loc!["registrar"]["url"];

        /// under class Registrant
        data.registrant.name = ip2loc!["registrant"]["name"];
        data.registrant.organization = ip2loc!["registrant"]["organization"];
        data.registrant.streetAddress = ip2loc!["registrant"]["street_address"];
        data.registrant.city = ip2loc!["registrant"]["city"];
        data.registrant.region = ip2loc!["registrant"]["region"];
        data.registrant.zipCode = ip2loc!["registrant"]["zip_code"];
        data.registrant.country = ip2loc!["registrant"]["country"];
        data.registrant.phone = ip2loc!["registrant"]["phone"];
        data.registrant.email = ip2loc!["registrant"]["email"];
        data.registrant.fax = ip2loc!["registrant"]["fax"];

        ///
        data.admin.city = ip2loc!["admin"]["city"];
        data.admin.region = ip2loc!["admin"]["region"];
        data.admin.zipCode = ip2loc!["admin"]["zip_code"];
        data.admin.country = ip2loc!["admin"]["country"];
        data.admin.phone = ip2loc!["admin"]["phone"];
        data.admin.email = ip2loc!["admin"]["email"];
        data.admin.fax = ip2loc!["admin"]["fax"];
        data.admin.name = ip2loc!["admin"]["name"];
        data.admin.streetAddress = ip2loc!["admin"]["street_address"];
        data.admin.organization = ip2loc!["admin"]["organization"];

        /// Tech
        data.technical.city = ip2loc!["tech"]["city"];
        data.technical.region = ip2loc!["tech"]["region"];
        data.technical.zipCode = ip2loc!["tech"]["zip_code"];
        data.technical.country = ip2loc!["tech"]["country"];
        data.technical.phone = ip2loc!["tech"]["phone"];
        data.technical.email = ip2loc!["tech"]["email"];
        data.technical.fax = ip2loc!["tech"]["fax"];
        data.technical.name = ip2loc!["tech"]["name"];
        data.technical.streetAddress = ip2loc!["tech"]["street_address"];
        data.technical.organization = ip2loc!["tech"]["organization"];

        /// Billing information
        data.billing.city = ip2loc!["billing"]["city"];
        data.billing.region = ip2loc!["billing"]["region"];
        data.billing.zipCode = ip2loc!["billing"]["zip_code"];
        data.billing.country = ip2loc!["billing"]["country"];
        data.billing.phone = ip2loc!["billing"]["phone"];
        data.billing.email = ip2loc!["billing"]["email"];
        data.billing.fax = ip2loc!["billing"]["fax"];
        data.billing.name = ip2loc!["billing"]["name"];
        data.billing.streetAddress = ip2loc!["billing"]["street_address"];
        data.billing.organization = ip2loc!["billing"]["organization"];

        data.nameServer = ip2loc!["nameservers"];

        return data;

        ///
      } else {
        print(response.body);
        ip2loc = jsonDecode(response.body);

        data.errorCode = ip2loc!["error"]["error_code"];
        data.errorMessage = ip2loc!["error"]["error_message"];
        return data;
      }
    } catch (e) {
      throw 'Une erreur s\'est produite lors de la requête : $e';
    }
  }*/
}
