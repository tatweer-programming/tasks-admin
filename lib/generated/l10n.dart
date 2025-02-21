// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Submit Task`
  String get submit_task {
    return Intl.message('Submit Task', name: 'submit_task', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Task Description`
  String get task_description {
    return Intl.message(
      'Task Description',
      name: 'task_description',
      desc: '',
      args: [],
    );
  }

  /// `Task Title`
  String get task_title {
    return Intl.message('Task Title', name: 'task_title', desc: '', args: []);
  }

  /// `Enter task description`
  String get enter_task_description {
    return Intl.message(
      'Enter task description',
      name: 'enter_task_description',
      desc: '',
      args: [],
    );
  }

  /// `Enter task title`
  String get enter_task_title {
    return Intl.message(
      'Enter task title',
      name: 'enter_task_title',
      desc: '',
      args: [],
    );
  }

  /// `Please enter task title`
  String get please_enter_task_title {
    return Intl.message(
      'Please enter task title',
      name: 'please_enter_task_title',
      desc: '',
      args: [],
    );
  }

  /// `Select Worker`
  String get select_worker {
    return Intl.message(
      'Select Worker',
      name: 'select_worker',
      desc: '',
      args: [],
    );
  }

  /// `Please select a worker`
  String get please_select_a_worker {
    return Intl.message(
      'Please select a worker',
      name: 'please_select_a_worker',
      desc: '',
      args: [],
    );
  }

  /// `Choose a worker`
  String get choose_a_worker {
    return Intl.message(
      'Choose a worker',
      name: 'choose_a_worker',
      desc: '',
      args: [],
    );
  }

  /// `Due Date`
  String get due_date {
    return Intl.message('Due Date', name: 'due_date', desc: '', args: []);
  }

  /// `Select date`
  String get select_date {
    return Intl.message('Select date', name: 'select_date', desc: '', args: []);
  }

  /// `Search tasks...`
  String get search_tasks {
    return Intl.message(
      'Search tasks...',
      name: 'search_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Not Accepted yet`
  String get not_accepted_yet {
    return Intl.message(
      'Not Accepted yet',
      name: 'not_accepted_yet',
      desc: '',
      args: [],
    );
  }

  /// `Delete Task`
  String get delete_task {
    return Intl.message('Delete Task', name: 'delete_task', desc: '', args: []);
  }

  /// `Are you sure you want to delete this task?`
  String get are_you_sure_you_want_to_delete_this_task {
    return Intl.message(
      'Are you sure you want to delete this task?',
      name: 'are_you_sure_you_want_to_delete_this_task',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Create Task`
  String get create_task {
    return Intl.message('Create Task', name: 'create_task', desc: '', args: []);
  }

  /// `Task Management`
  String get task_management {
    return Intl.message(
      'Task Management',
      name: 'task_management',
      desc: '',
      args: [],
    );
  }

  /// `all`
  String get all {
    return Intl.message('all', name: 'all', desc: '', args: []);
  }

  /// `pending`
  String get pending {
    return Intl.message('pending', name: 'pending', desc: '', args: []);
  }

  /// `in progress`
  String get in_progress {
    return Intl.message('in progress', name: 'in_progress', desc: '', args: []);
  }

  /// `approved`
  String get approved {
    return Intl.message('approved', name: 'approved', desc: '', args: []);
  }

  /// `cancelled`
  String get cancelled {
    return Intl.message('cancelled', name: 'cancelled', desc: '', args: []);
  }

  /// `Add Image`
  String get add_image {
    return Intl.message('Add Image', name: 'add_image', desc: '', args: []);
  }

  /// `Add Voice`
  String get add_voice {
    return Intl.message('Add Voice', name: 'add_voice', desc: '', args: []);
  }

  /// `Add Site`
  String get add_site {
    return Intl.message('Add Site', name: 'add_site', desc: '', args: []);
  }

  /// `Add Block`
  String get add_block {
    return Intl.message('Add Block', name: 'add_block', desc: '', args: []);
  }

  /// `Add Flat`
  String get add_flat {
    return Intl.message('Add Flat', name: 'add_flat', desc: '', args: []);
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Additional Files`
  String get additional_files {
    return Intl.message(
      'Additional Files',
      name: 'additional_files',
      desc: '',
      args: [],
    );
  }

  /// `completed`
  String get completed {
    return Intl.message('completed', name: 'completed', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
