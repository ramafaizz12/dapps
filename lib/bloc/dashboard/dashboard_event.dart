part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardInitialFetch extends DashboardEvent {}

class DashboardDepositEvent extends DashboardEvent {
  final TransactionModel transactionmodel;

  DashboardDepositEvent({required this.transactionmodel});
}

class DashboardWithdrawEvent extends DashboardEvent {
  final TransactionModel transactionmodel;

  DashboardWithdrawEvent({required this.transactionmodel});
}
