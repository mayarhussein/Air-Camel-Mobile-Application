import 'package:air_camel/models/drawer/credit_transactions.dart';
import 'package:air_camel/models/drawer/payments.dart';
import 'package:flutter/material.dart';

class CreditPaymentsProvider with ChangeNotifier {
  List<PaymentModel>? _payments;
  List<CreditTransactionsModel>? _creditTransactions;
  double _creditAmount = 0;

  void setCreditTransactions(List<CreditTransactionsModel> list) {
    _creditTransactions = List.from(list);
    calculateCredit();
  }

  void setPayments(List<PaymentModel> list) {
    _payments = List.from(list);
  }

  void calculateCredit() {
    double amount = 0;
    for (var element in _creditTransactions!) {
      amount += element.amount;
    }
    _creditAmount = amount;
  }

  List<PaymentModel> get payments {
    return [...?_payments];
  }

  List<CreditTransactionsModel> get creditTransactions {
    return [...?_creditTransactions];
  }

  double get creditAmount {
    return _creditAmount;
  }
}
