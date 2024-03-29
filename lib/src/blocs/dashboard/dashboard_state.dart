part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitState extends DashboardState {}

class NavigatorTappedPageState extends DashboardState {
  final PageName pageName;

  NavigatorTappedPageState({required this.pageName});
  @override
  // TODO: implement props
  List<Object> get props => [this.pageName];
}

class DashboardLoading extends DashboardState {
  final bool isLoading;

  DashboardLoading({required this.isLoading});
  @override
  // TODO: implement props
  List<Object> get props => [isLoading];
}
