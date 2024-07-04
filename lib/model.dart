class Society {
  late int ID;
  late String SocietyName;
  late String ImageURL;
}

class SocietyDetails {
  late int SocietyID;
  late String SocietySupervisorName;
  late String SocietySupervisorImage;
  late String SocietyPresidentName;
  late String SocietyPresidentImage;
  late String SocietyVicePresidentName;
  late String SocietyVicePresidentImage;
  late String SocietyFinanceSecreteryName;
  late String SocietyFinanceSecreteryImage;
}

class SocietyandDetails {
  late Society society;
  late SocietyDetails detail;
}

class Event{
  late int ID;
  late String EventName;
late  DateTime EventDateandTime;
late String EventVenue;
late String EventCity;
late int SocietyID;
late String EventIcon;
}