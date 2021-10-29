class Staff {
  final int id;
  final String accountType;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String createdBy;
  final String date;

  Staff(
      {this.id,
      this.accountType,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.createdBy,
      this.date});

  factory Staff.fromJson(Map<String, dynamic> staff) {
    return Staff(
        id: staff['id'],
        accountType: staff['account_type'],
        name: staff['name'],
        email: staff["email"],
        phone: staff["phone"],
        address: staff["address"],
        createdBy: staff["created_by"],
        date: staff["date"]);
  }
}
