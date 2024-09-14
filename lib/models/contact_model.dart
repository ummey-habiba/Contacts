const tableContact='tbl_contact';
const tblContactColId='id';
const tblContactColName='name';
const tblContactColMobile='mobile';
const tblContactColEmail='email';
const tblContactColWebsite='website';
const tblContactColGroup='contact_group';
const tblContactColGender='gender';
const tblContactColImage='image';
const tblContactColFavourite='favourite';
const tblContactColDob='dob';
const tblContactColAddress='address';


class ContactModel {
  int? id;
  String name;
  String mobile;
  String email;
  String address;
  String group;
  String gender;
  bool favourite;
  String? website;
  String? image;
  String? dob;
  
  ContactModel(
      {required this.name,
      required this.mobile,
      required this.email,
      required this.address,
      required this.group,
      required this.gender,
      this.favourite = false ,
      this.website,
      this.image,
      this.dob});
  Map<String ,dynamic> toMap(){
    final map =<String ,dynamic>{
      tblContactColName :name,
      tblContactColMobile:mobile,
      tblContactColEmail:email,
      tblContactColWebsite :website,
      tblContactColImage :image,
      tblContactColGroup:group,
      tblContactColGender:gender,
      tblContactColDob :dob,
      tblContactColAddress:address,
      tblContactColFavourite:favourite? 1 :0,
    };
    return toMap();
}
}
