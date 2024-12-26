part of 'ajout_utilisateur_bloc.dart';

sealed class AjoutUtilisateurState extends Equatable {
  const AjoutUtilisateurState();

  @override
  List<Object> get props => [];
}

final class AjoutUtilisateurInitial extends AjoutUtilisateurState {}

// ignore: must_be_immutable
final class AjoutUtilisateurError extends AjoutUtilisateurState {
  String message;
  AjoutUtilisateurError({required this.message});

  @override
  List<Object> get props => [message];
}

final class AjoutUtilisateurLoading extends AjoutUtilisateurState {}

final class AjoutUtilisateurDone extends AjoutUtilisateurState {}
