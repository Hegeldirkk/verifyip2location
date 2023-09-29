# verifyip2location
Verifies the source of ip connections and domains from IP2Location ip2location.io.

[![Static Badge](https://img.shields.io/badge/pub-v1.0.0-blue)](https://pub.dev/packages/verifyip2location)

A Flutter ans dart plugin for get location and whois information.

|             | Android | iOS   | Linux | macOS  | Web | Windows     |
|-------------|---------|-------|-------|--------|-----|-------------|
| **Support** | SDK 16+ | 11.0+ | Any   | 10.14+ | Any | Windows 10+ |

## Usage

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

