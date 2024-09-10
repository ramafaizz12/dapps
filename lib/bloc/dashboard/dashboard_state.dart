part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardError extends DashboardState {}

class DashboardSucces extends DashboardState {}
