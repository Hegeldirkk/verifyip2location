///
///Geolocation API Endpoint Configuration
///@plan: var plan of IP2Location.io
///@url: endpoint url
///@apikey: apikey of IP2Location to use services

enum Plan { free, starter, plus, security }

class ConfigIP {
  String? plan;
  String? apikey;
  final String url = "https://api.ip2location.io/?";
  final String urlW = "https://api.ip2whois.com/v2?";

  String? choosePlan(int chp) {

    print(chp);
    // verify that chp is not negative
    assert(chp >= 0, "chp variable must be positive ");

    // check that chp is less than 4
    assert(chp <= 4, "chp variable must be less than 4 ");


    // assign the plan
    switch (chp) {
      case 0:
        plan = Plan.free.name;
      case 1:
        plan = Plan.starter.name;
      case 2:
        plan = Plan.plus.name;
      case 3: 
       plan = Plan.security.name;
        break;
      default:
        plan = Plan.free.name;
    }
    
    return plan;
  }
}


///
///
