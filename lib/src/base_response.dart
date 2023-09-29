/// base class for http response
///
///

class BaseHttpIkaResponse {
  /// IP2Location error status code
  late int errorStatusCode;

  /// Raison Phrase error status code
  late String? errorReasonPhrase;

  /// IP Address response data
  /// IPv4 : 8.8.8.8
  late String? resIp;

  /// Country code response data
  /// Two-character country code based on ISO 3166.
  late String? countryCode;

  /// Country name response data
  /// Country name based on ISO 3166.
  late String? countryName;

  /// Region name response data
  /// Region or state name.
  late String? regionName;

  /// City name response data
  late String? cityName;

  /// Latitude and longitude Location information
  /// Geo coordinates
  /// latitude data location
  /// City latitude. Defaults to capital city latitude if city is unknown.
  late double? latitude;

  /// longitude data location
  /// City longitude. Defaults to capital city longitude if city is unknown.
  late double? longitude;

  /// Zip code response data
  /// ZIP/Postal code.
  late String? zipCode;

  /// Time zone response data
  /// UTC time zone (with DST supported).
  late String? timeZone;

  /// Asn response data
  /// Autonomous system number (ASN).
  late String? asn;

  /// As response data
  /// Autonomous system (AS) name.
  late String? as;

  /// Proxy response data
  /// Whether is a proxy or not
  late bool isProxy;

  // Nouvelles propriétés ajoutées pour les données complexes
  late String? isp;
  late String? domain;
  late String? netSpeed;
  late String? iddCode;
  late String? areaCode;
  late String? weatherStationCode;
  late String? weatherStationName;
  late String? mcc;
  late String? mnc;
  late String? mobileBrand;
  late int? elevation;
  late String? usageType;
  late String? addressType;
  late Continent continent; // Classe Continent
  late Country country; // Classe Country
  late Region region; // Classe Region
  late City city; // Classe City
  late TimeZoneInfo timeZoneInfo; // Classe TimeZoneInfo
  late Geotargeting geotargeting; // Classe Geotargeting
  late Proxy proxy; // Classe Proxy
  late String? adsCategory;
  late String? district;

  BaseHttpIkaResponse(
      {this.as,
      this.asn,
      required this.isProxy,
      this.timeZone,
      this.zipCode,
      this.longitude,
      this.latitude,
      this.cityName,
      this.countryCode,
      this.countryName,
      this.regionName,
      this.resIp,
      this.isp,
      this.domain,
      this.netSpeed,
      this.iddCode,
      this.areaCode,
      this.weatherStationCode,
      this.weatherStationName,
      this.mcc,
      this.mnc,
      this.mobileBrand,
      this.elevation,
      this.usageType,
      this.addressType,
      required this.continent,
      required this.country,
      required this.region,
      required this.city,
      required this.timeZoneInfo,
      required this.geotargeting});
}

class Continent {
  late String name;
  late String code;
  late List<String> hemisphere;
  late Translation translation; // Classe Translation
}

class Country {
  late String name;
  late String alpha3Code;
  late int numericCode;
  late String demonym;
  late String flag;
  late String capital;
  late int totalArea;
  late int population;
  late Currency currency; // Classe Currency
  late Language language; // Classe Language
  late String tld;
  late Translation translation; // Classe Translation
}

class Region {
  late String name;
  late String code;
  late Translation translation; // Classe Translation
}

class City {
  late String name;
  late Translation translation; // Classe Translation
}

class TimeZoneInfo {
  late String olson;
  late String currentTime;
  late int gmtOffset;
  late bool isDst;
  late String sunrise;
  late String sunset;
}

class Geotargeting {
  late String metro;
}

class Proxy {
  late int lastSeen;
  late String proxyType;
  late String threat;
  late String provider;
  late bool isVpn;
  late bool isTor;
  late bool isDataCenter;
  late bool isPublicProxy;
  late bool isWebProxy;
  late bool isWebCrawler;
  late bool isResidentialProxy;
  late bool isSpammer;
  late bool isScanner;
  late bool isBotnet;
}

class Currency {
  late String code;
  late String name;
  late String symbol;
}

class Language {
  late String code;
  late String name;
}

class Translation {
  late String lang;
  late String value;
}
