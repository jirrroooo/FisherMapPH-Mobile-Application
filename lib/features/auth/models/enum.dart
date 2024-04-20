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
