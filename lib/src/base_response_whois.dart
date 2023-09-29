class HttpIkaWhoisService {
  ///
  late int? errorCode = 0;

  ///
  late String? errorMessage;

  /// Domain scanning
  late String? domain;

  /// Domain Id
  late String? domainId;

  ///Domain status
  late String? status;

  /// Create date
  late String? createDate;

  /// Updating date
  late String? updateDate;

  /// Expires date
  late String? expiresDate;

  /// Domain age
  late int? domainAge;

  /// Whois server
  late String? whoisServer;

  /// Registrar information
  late Registrar registrar;

  /// Registrant information
  late Registrant registrant;

  /// Admin information
  late Admin admin;

  ///Technical information
  late Tech technical;

  /// billing information
  late Billing billing;

  List<dynamic>? nameServer;

  HttpIkaWhoisService(
      {required this.admin,
      required this.technical,
      required this.billing,
      this.createDate,
      this.updateDate,
      this.domain,
      this.domainAge,
      this.domainId,
      this.expiresDate,
      required this.registrant,
      required this.registrar,
      this.status,
      this.whoisServer,
      this.nameServer});
}

class Registrar {
  String? ianaId;
  String? name;
  String? url;

  Registrar({
    this.ianaId,
    this.name,
    this.url,
  });
}

class Registrant {
  String? name;
  String? organization;
  String? streetAddress;
  String? city = "";
  String? region = "";
  String? zipCode = "";
  String? country = "";
  String? phone = "";
  String? fax = "";
  String? email = "";

  Registrant({
    this.name,
    this.organization,
    this.streetAddress,
    this.city,
    this.region,
    this.zipCode,
    this.country,
    this.phone,
    this.fax,
    this.email,
  });
}

class Admin {
  String? name;
  String? organization;
  String? streetAddress;
  String? city = "";
  String? region = "";
  String? zipCode = "";
  String? country = "";
  String? phone = "";
  String? fax = "";
  String? email = "";

  Admin({
    this.name,
    this.organization,
    this.streetAddress,
    this.city,
    this.region,
    this.zipCode,
    this.country,
    this.phone,
    this.fax,
    this.email,
  });
}

class Tech {
  String? name;
  String? organization;
  String? streetAddress;
  String? city = "";
  String? region = "";
  String? zipCode = "";
  String? country = "";
  String? phone = "";
  String? fax = "";
  String? email = "";

  Tech({
    this.name,
    this.organization,
    this.streetAddress,
    this.city,
    this.region,
    this.zipCode,
    this.country,
    this.phone,
    this.fax,
    this.email,
  });
}

class Billing {
  String? name;
  String? organization;
  String? streetAddress;
  String? city = "";
  String? region = "";
  String? zipCode = "";
  String? country = "";
  String? phone = "";
  String? fax = "";
  String? email = "";

  Billing({
    this.name,
    this.organization,
    this.streetAddress,
    this.city,
    this.region,
    this.zipCode,
    this.country,
    this.phone,
    this.fax,
    this.email,
  });
}
