class Contact {
  int _id, _phone;

  Contact(this._id, this._phone);

  factory Contact.fromJson(Map<String, dynamic> json) {
 
    return Contact(json["id"], json["phone"]);
    
  }
}
