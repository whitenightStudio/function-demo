class User{
  String _id;
  String _name;
  String _tel;
  String _address;
  String _date;
  int _buyCount;
  String _memo;

  User(this._id, this._name, this._tel, this._address, this._date,
      this._buyCount, this._memo);

  String get memo => _memo;

  set memo(String value) {
    _memo = value;
  }

  int get buyCount => _buyCount;

  set buyCount(int value) {
    _buyCount = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get tel => _tel;

  set tel(String value) {
    _tel = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}