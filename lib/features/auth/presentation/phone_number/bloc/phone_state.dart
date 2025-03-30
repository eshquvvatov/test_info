part of 'phone_cubit.dart';

 enum PhonePageState{init,loading,sendCode,error}
 class PhoneState extends Equatable {
   final PhonePageState pageState;
   final String message;
  const PhoneState({required this.pageState,required this.message});

  @override
  List<Object?> get props => [pageState,message];
}


