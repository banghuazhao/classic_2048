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

  static String m0(score, tile) => "Best score ${score} · Highest tile ${tile}";

  static String m1(value) => "Tile ${value}";

  static String m2(days) => "${days}-day streak";

  static String m3(games, moves) => "${games} games · ${moves} moves";

  static String m4(moves, tile) => "${moves} moves · Highest tile ${tile}";

  static String m5(score, mode, moves, tile) =>
      "I scored ${score} in ${mode} with ${moves} moves and reached ${tile}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Achievement_10K": MessageLookupByLibrary.simpleMessage("10K Club"),
        "Achievement_2048": MessageLookupByLibrary.simpleMessage("2048 Master"),
        "Achievement_Efficient": MessageLookupByLibrary.simpleMessage(
          "Efficient Thinker",
        ),
        "Achievement_Streak": MessageLookupByLibrary.simpleMessage(
          "Seven Day Streak",
        ),
        "Achievements": MessageLookupByLibrary.simpleMessage("Achievements"),
        "App_Name": MessageLookupByLibrary.simpleMessage("Tile Trials"),
        "Back": MessageLookupByLibrary.simpleMessage("Back"),
        "Best_Highest": m0,
        "Board_Cell": m1,
        "Board_Waiting": MessageLookupByLibrary.simpleMessage(
          "Your board is waiting.",
        ),
        "Challenge_Complete": MessageLookupByLibrary.simpleMessage(
          "Challenge Complete",
        ),
        "Challenge_Modes":
            MessageLookupByLibrary.simpleMessage("Challenge modes"),
        "Choose_Mode": MessageLookupByLibrary.simpleMessage(
          "Choose your challenge",
        ),
        "Classic": MessageLookupByLibrary.simpleMessage("Classic"),
        "Classic_Boards":
            MessageLookupByLibrary.simpleMessage("Classic boards"),
        "Classic_Endless":
            MessageLookupByLibrary.simpleMessage("Endless strategy"),
        "Continue": MessageLookupByLibrary.simpleMessage("Continue"),
        "Daily_Challenge":
            MessageLookupByLibrary.simpleMessage("Daily Challenge"),
        "Daily_History": MessageLookupByLibrary.simpleMessage("Daily history"),
        "Daily_Streak": MessageLookupByLibrary.simpleMessage("Daily streak"),
        "Daily_Subtitle": MessageLookupByLibrary.simpleMessage(
          "Same 100-move puzzle for everyone",
        ),
        "Day_Streak": m2,
        "Game_Center": MessageLookupByLibrary.simpleMessage("Game Center"),
        "Game_Over": MessageLookupByLibrary.simpleMessage("Game Over"),
        "Game_Over_Message": MessageLookupByLibrary.simpleMessage(
          "No more moves! Start a new game?",
        ),
        "Games_Moves": m3,
        "High_Score": MessageLookupByLibrary.simpleMessage("High Score"),
        "Highest_Tile_Result": m4,
        "Home_Description": MessageLookupByLibrary.simpleMessage(
          "Daily puzzles, score sprints, and move-limited strategy.",
        ),
        "Leaderboards": MessageLookupByLibrary.simpleMessage("Leaderboards"),
        "Mode_4_1":
            MessageLookupByLibrary.simpleMessage("Classic · one new tile"),
        "Mode_5_1": MessageLookupByLibrary.simpleMessage(
          "More room · relaxed pace",
        ),
        "Mode_5_2": MessageLookupByLibrary.simpleMessage(
          "More room · faster challenge",
        ),
        "Mode_6_2":
            MessageLookupByLibrary.simpleMessage("Large board · strategic"),
        "Mode_6_3":
            MessageLookupByLibrary.simpleMessage("Large board · expert"),
        "Move_Challenge":
            MessageLookupByLibrary.simpleMessage("Move Challenge"),
        "Move_Subtitle": MessageLookupByLibrary.simpleMessage(
          "Highest score in 100 moves",
        ),
        "Moves": MessageLookupByLibrary.simpleMessage("Moves"),
        "Next": MessageLookupByLibrary.simpleMessage("Next"),
        "No_Achievements": MessageLookupByLibrary.simpleMessage(
          "Complete challenges to unlock achievements.",
        ),
        "No_Daily_History": MessageLookupByLibrary.simpleMessage(
          "Complete today\'s challenge to begin your streak.",
        ),
        "Onboarding_Body_1": MessageLookupByLibrary.simpleMessage(
          "Play the same seeded 100-move puzzle as everyone else.",
        ),
        "Onboarding_Body_2": MessageLookupByLibrary.simpleMessage(
          "Sprint for three minutes or build the best board in 100 moves.",
        ),
        "Onboarding_Body_3": MessageLookupByLibrary.simpleMessage(
          "Grow a daily streak, unlock achievements, and climb Game Center.",
        ),
        "Onboarding_Title_1": MessageLookupByLibrary.simpleMessage(
          "A fresh trial every day",
        ),
        "Onboarding_Title_2":
            MessageLookupByLibrary.simpleMessage("Race or plan"),
        "Onboarding_Title_3": MessageLookupByLibrary.simpleMessage(
          "Build your record",
        ),
        "Paused": MessageLookupByLibrary.simpleMessage("Paused"),
        "Progress_Achievements": MessageLookupByLibrary.simpleMessage(
          "Progress & achievements",
        ),
        "Random": MessageLookupByLibrary.simpleMessage("Random"),
        "Restart": MessageLookupByLibrary.simpleMessage("Restart"),
        "Score": MessageLookupByLibrary.simpleMessage("Score"),
        "Share_Message": m5,
        "Share_Result": MessageLookupByLibrary.simpleMessage("Share result"),
        "Shuffle": MessageLookupByLibrary.simpleMessage("Shuffle"),
        "Sprint": MessageLookupByLibrary.simpleMessage("Sprint"),
        "Sprint_Subtitle": MessageLookupByLibrary.simpleMessage(
          "3 minute score race",
        ),
        "Start_Playing": MessageLookupByLibrary.simpleMessage("Start playing"),
        "Time": MessageLookupByLibrary.simpleMessage("Time"),
        "Time_Up": MessageLookupByLibrary.simpleMessage("Time!"),
        "Today": MessageLookupByLibrary.simpleMessage("Today"),
        "Your_Progress": MessageLookupByLibrary.simpleMessage("Your progress"),
      };
}
