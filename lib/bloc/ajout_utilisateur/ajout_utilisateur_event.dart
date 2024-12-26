part of 'ajout_utilisateur_bloc.dart';

sealed class AjoutUtilisateurEvent extends Equatable {
  const AjoutUtilisateurEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class OnAddUser extends AjoutUtilisateurEvent {
  Users? users;
  String password;
  OnAddUser({required this.users,required this.password});

  @override
  List<Object> get props => [users!];
}
