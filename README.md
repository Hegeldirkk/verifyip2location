# IP2Location Dart Package
Verifies the source of ip connections and domains from IP2Location ip2location.io.

This Dart package is designed to enable you to verify geolocation and WHOIS information for IP addresses and domains. It is built on the IP2Location API, making it a powerful tool for understanding the location of personal connections.

[![Static Badge](https://img.shields.io/badge/pub-v1.0.3-blue)](https://pub.dev/packages/verifyip2location)

A Flutter ans dart plugin for get location and whois information.

|             | Android | iOS   | Linux | macOS  | Web | Windows     |
|-------------|---------|-------|-------|--------|-----|-------------|
| **Support** | SDK 16+ | 11.0+ | Any   | 10.14+ | Any | Windows 10+ |

## Features

    Retrieve geolocation data, including city name, region name, country name, and country code.
    Detect the use of proxies, Tor, or VPN.
    Get latitude and longitude coordinates of the location.
    Identify devices infected with botnets or malware.
    Fetch WHOIS information for domains.

## Usage


- Retrieving Geolocation Data

```
import 'package:verifyip2location/verifyip2location.dart';

void main() async {
  String ip2token = 'YOUR_IP2LOCATION_API_KEY';
  BaseHttpIkaResponse result = await getIpgeo(ip2token, ip: '8.8.8.8');
  
  // Use the resulting data as needed
  print('Country: ${result.countryName}');
  print('City: ${result.cityName}');
  // ...
}

```

 - Retrieving WHOIS Information for a Domain

 ```
 import 'package:verifyip2location/verifyip2location.dart';

void main() async {
  String ip2token = 'YOUR_IP2LOCATION_API_KEY';
  HttpIkaWhoisService whoisResult = await getDnsWhois(ip2token, domain: 'example.com');
  
  // Use the resulting WHOIS data as needed
  print('Domain Name: ${whoisResult.domain}');
  print('Domain Owner: ${whoisResult.registrantName}');
  // ...
}
```




To use this plugin, add `verifyip2location` as a [github repository](https://github.com/Hegeldirkk/verifyip2location)

### Example

Location Functionnality Description

<?code-excerpt "lib/verifyip2location.dart (basic-example)"?>
```dart
import 'package:verifyip2location/verifyip2location.dart' as verifyip2location;
import 'package:verifyip2location/verifyip2location.dart';



void main() async {
  // Your API key
  final apiKey = 'VOTRE_API_KEY';

  // ip2location class
  BaseHttpIkaResponse? ip2loc;

   // IP address you want to look up
  final ipAddress = '8.8.8.8';

  // Plan you want to use (e.g, 'free = 0', 'starter = 1', 'plus = 2', 'security = 3', etc.)
  int plan = 0;

  try {
    // Using the getIpgeo function to retrieve data
    ip2loc = await verifyip2location.getIpgeo(apiKey, ip: ipAddress, plan: plan, option: 'geoip');

    // Get information
    if (ip2loc.errorStatusCode == 10000 || ip2loc.errorStatusCode == 10001 ){
      print('Adresse IP: ${ip2loc.resIp}');
      print('Pays: ${ip2loc.countryName}');
      print('Ville: ${ip2loc.cityName}');
      print('Latitude: ${ip2loc.latitude}');
      print('Longitude: ${ip2loc.longitude}');
      print('As: ${ip2loc.as}');
      // And so on for other data you want to use.
    } else if (ip2loc.errorStatusCode == 10001){
      print('Error message: ' + ip2loc.errorReasonPhrase!);
    } else{
        print('Error message: ' + ip2loc.errorReasonPhrase!);
    }
  } catch (e) {
    print('An error occurred during the request : $e');
  }
}

```

Requirements

    Dart SDK 2.0 or later.

Notes

    To use this package, you need to obtain an IP2Location API key from the official IP2Location website.
    Ensure you configure your API key in your application before using this package.

Author

This package was created by [DIABAKATE IKARY RYANN](https://dirkk.tech).