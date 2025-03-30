part of 'main_bloc.dart';
enum CheckStatus { init, checkIn, checkOut, completed }
enum PageState { init, loading, success, error }

class MainState extends Equatable {
  final CheckStatus checkStatus;
  final PageState pageState;
  final int currentPage;

  const MainState({
    required this.pageState,
    required this.checkStatus,
    required this.currentPage,
  });

  MainState copyWith({
    CheckStatus? checkStatus,
    PageState? pageState,
    int? currentPage,
  }) {
    return MainState(
      checkStatus: checkStatus ?? this.checkStatus,
      pageState: pageState ?? this.pageState,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [checkStatus, pageState, currentPage];
}
