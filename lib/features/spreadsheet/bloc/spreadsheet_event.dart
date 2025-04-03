part of 'spreadsheet_bloc.dart';

@immutable
sealed class SpreadsheetEvent {}

class SpreadsheetLoadEvent extends SpreadsheetEvent {}
