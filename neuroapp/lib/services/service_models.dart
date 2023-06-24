class ClientInitPackage {
  String Id = 'bapp';

  String Title = 'Brain App';

  String InterfaceVersionId = 'SFV';

  List<ClientDataObject> StructuredObjects = [];

  //method to convert object to json
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Id"] = Id;
    map["Title"] = Title;
    map["InterfaceVersionId"] = InterfaceVersionId;
    map["StructuredObjects"] = StructuredObjects;
    return map;
  }
}

class ClientDataObject {
  // String? Id = '';
  // String? Name = '';
  // String? Value_String = '';
  // int? Value_Int = 0;
  // bool? Value_bool = false;
  double? Value_float = 0.0;

  //method to convert json to object
  ClientDataObject.fromJson(Map<String, dynamic> json) {
    // Id = json['Id'];
    // Name = json['Name'];
    // Value_String = json['Value_String'];
    // Value_Int = json['Value_Int'];
    // Value_bool = json['Value_bool'];
    Value_float = json['Value_float'];
  }
}

class ClientPackage {
  List<ClientDataObject> DataObjects = [];

  //method to convert json to object
  ClientPackage.fromJson(Map<String, dynamic> json) {
    if (json['DataObjects'] != null) {
      DataObjects = [];
      json['DataObjects'].forEach((v) {
        DataObjects.add(ClientDataObject.fromJson(v));
      });
    }
  }
}
