import 'dart:core';

import 'basemodel.dart';


class Product extends BaseModel {

  String _name;
  String _address;
  String _phone;
  String _cop;
  String _sop;
  Product();

  Product.fromValues( this._name, this._address, this._phone,this._cop,this._sop);

  Product.fromValuesWithId(String id, this._name, this._address, this._phone,this._cop,this._sop) {
    super.id = id;

  }

  Product.map(dynamic obj) {
    this.id = obj['PIN'];
    this._name = obj['name'];
    this._address = obj['address'];
    this._phone =obj['phone'];
    this._cop =obj['cop'];
    this._sop =obj['sop'];


  }


  String get name => _name;
  String get address => _address;
  String get phone => _phone;
  String get cop => _phone;
  String get sop => _phone;




  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['PIN'] = id;
    }
    map['name'] = _name;
    map['address'] = _address;
    map['phone'] = _phone;
    map['cop'] = _cop;
    map['sop'] = _sop;


    return map;
  }

  Product.fromMap(Map<String, dynamic> map) {
    this.id = map['PIN'];
    this._name = map['name'];
    this._address = map['address'];
    this._phone = map['phone'];
    this._cop = map['cop'];
    this._sop = map['sop'];

  }

  Product fromMap(Map<String, dynamic> map) {
    var note = new Product();

    note.id = map['PIN'];
    note._name = map['name'];
    note._address = map['address'];
    note._phone = map['phone'];
    note._cop = map['cop'];
    note._sop = map['sop'];


    return note;
  }

  Product createNew() {
    return Product();
  }
}
