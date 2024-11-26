
class UserModel{
  String name;
  String email;
  String country;
  String phone;
  List<dynamic> jobs;
  String? image;
  String role;
  UserModel({required this.name,required this.email,required this.country,required this.jobs,required this.phone,this.image,required this.role});

  Map<String,dynamic> toMap(){ //tomap to store data to firestore
    return {
      'name':name,
      'email':email,
      'role':role,
      'country':country,
      'phone':phone,
      'jobs':jobs
    };
  }

  factory UserModel.fromMap(Map<String,dynamic> map){  //fetch data from firebase
    return UserModel(
      name: map['name'], 
      email: map['email'], 
      role:  map['role'],
      country: map['country'], 
      jobs: map['jobs'], 
      phone: map['phone'],
      image: map['imageUrl']);
  }
}