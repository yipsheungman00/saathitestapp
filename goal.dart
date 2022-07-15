import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:ffi';

import 'map.dart';

class Goal{
  int id;
  String name;
  String imageUrl;
  double amount;
  int currency;
  double durationAmount;
  int duration;
  String durationType;
  DateTime createdTimestamp;
  DateTime endDate;
  int state;

  // Constructor, with syntactic sugar for assignment to members.
  Goal(this.id, this.name, this.imageUrl, this.amount, this.currency, this.durationAmount, this.duration, this.durationType, this.createdTimestamp, this.endDate, this.state);

  // Method.
  int convertCurrencyNameToCode(String currencyName) {
    return currencyCode[currencyName];
  }
}