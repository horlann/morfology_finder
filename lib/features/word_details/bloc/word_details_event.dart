part of 'word_details_bloc.dart';

@immutable
sealed class WordDetailsEvent {}

class WordDetailsSelectEvent extends WordDetailsEvent {
  WordDetailsSelectEvent();
}
