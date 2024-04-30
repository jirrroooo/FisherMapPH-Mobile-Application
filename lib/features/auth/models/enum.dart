enum VesselType {
  small("Small"),
  medium("Medium"),
  large("Large");

  const VesselType(this.label);
  final String label;
}

enum Sex {
  male("Male"),
  female("Female");

  const Sex(this.label);
  final String label;
}

enum CivilStatus {
  married("Married"),
  single("Single"),
  widowed("Widowed"),
  separated("Legally Separated");

  const CivilStatus(this.label);
  final String label;
}

enum EmergencyType {
  boatSinks("Boat Sinks"),
  crewFell("Crew Fell to the Sea"),
  fireOnboard("Fire Emergency"),
  floodedVessel("Flooded Vessel"),
  lostAtSea("Lost at Sea"),
  collision("Collision with Other Vessels"),
  entanglement("Entanglement in Fishing Gear"),
  severeWeather("Severe Weather"),
  hypothermia("Hypothermia"),
  engineFailure("Engine Failure"),
  pirateAttacks("Pirate Attacks"),
  medicalEmergencies("Medical Emergencies"),
  harmfulAlgalBlooms("Exposure to Harmful Algal Blooms"),
  pollutionIncidents("Pollution Incidents"),
  stranded("Stranded in Shallow Waters"),
  equipmentMalfunction("Equipment Malfunction"),
  exhaustion("Exhaustion and Fatigue"),
  whaleCollision("Whale or Large Marine Life Collisions"),
  illegalFishing("Illegal Fishing");

  const EmergencyType(this.label);
  final String label;
}
