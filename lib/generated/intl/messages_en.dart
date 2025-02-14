// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "btn_ai_tutorial_generator":
            MessageLookupByLibrary.simpleMessage("AI Tutorial Generator"),
        "btn_generate_tutorials":
            MessageLookupByLibrary.simpleMessage("Generate Tutorials"),
        "btn_sign_up": MessageLookupByLibrary.simpleMessage("Get Started"),
        "btn_sing_in": MessageLookupByLibrary.simpleMessage("Log in"),
        "hint_generate_tutorials":
            MessageLookupByLibrary.simpleMessage("Generate Tutorials"),
        "language": MessageLookupByLibrary.simpleMessage("en"),
        "main_text": MessageLookupByLibrary.simpleMessage(
            "Hi, what do you want to learn today?\nTry generating tutorials or search for them."),
        "text_generate_videos":
            MessageLookupByLibrary.simpleMessage("Generate your own videos"),
        "title_language": MessageLookupByLibrary.simpleMessage("English"),
        "welcome_text": MessageLookupByLibrary.simpleMessage(
            "The best and most effective way to learn any subject.")
      };
}
