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

  static String m5(number) => "Level ${number}";

  static String m6(tile) => "Merge the golden tile to ${tile} or higher";

  static String m7(score, moves) => "Score ${score} within ${moves} moves";

  static String m8(moves) => "Play ${moves} moves";

  static String m9(score) => "Reach ${score} points";

  static String m10(tile) => "Create a ${tile} tile";

  static String m11(seconds) => "Play for ${seconds} seconds";

  static String m12(score, seconds) => "Score ${score} in ${seconds} seconds";

  static String m13(tool) => "Select a tile to use ${tool}";

  static String m14(score, mode, moves, tile) =>
      "I scored ${score} in ${mode} with ${moves} moves and reached ${tile}.";

  static String m15(count) => "${count} left";

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
        "All_Levels": MessageLookupByLibrary.simpleMessage(
          "10 levels · easy to expert",
        ),
        "App_Name": MessageLookupByLibrary.simpleMessage("Tile Trials"),
        "Back": MessageLookupByLibrary.simpleMessage("Back"),
        "Background_Music": MessageLookupByLibrary.simpleMessage(
          "Background music",
        ),
        "Best_Highest": m0,
        "Board_Cell": m1,
        "Board_Waiting": MessageLookupByLibrary.simpleMessage(
          "Your board is waiting.",
        ),
        "Bomb_Tool": MessageLookupByLibrary.simpleMessage("3×3 Bomb"),
        "Challenge_Complete": MessageLookupByLibrary.simpleMessage(
          "Challenge Complete",
        ),
        "Challenge_Count": MessageLookupByLibrary.simpleMessage(
          "3 easy · 3 medium · 3 hard",
        ),
        "Challenge_Failed": MessageLookupByLibrary.simpleMessage(
          "Challenge Failed",
        ),
        "Challenge_Modes":
            MessageLookupByLibrary.simpleMessage("Challenge modes"),
        "Challenge_Won":
            MessageLookupByLibrary.simpleMessage("Challenge Complete"),
        "Challenges": MessageLookupByLibrary.simpleMessage("Challenges"),
        "Choose_Mode": MessageLookupByLibrary.simpleMessage(
          "Choose your challenge",
        ),
        "Classic": MessageLookupByLibrary.simpleMessage("Classic"),
        "Classic_Boards":
            MessageLookupByLibrary.simpleMessage("Classic boards"),
        "Classic_Endless":
            MessageLookupByLibrary.simpleMessage("Endless strategy"),
        "Completed": MessageLookupByLibrary.simpleMessage("Completed"),
        "Continue": MessageLookupByLibrary.simpleMessage("Continue"),
        "Daily_Challenge":
            MessageLookupByLibrary.simpleMessage("Daily Challenge"),
        "Daily_History": MessageLookupByLibrary.simpleMessage("Daily history"),
        "Daily_Streak": MessageLookupByLibrary.simpleMessage("Daily streak"),
        "Daily_Subtitle": MessageLookupByLibrary.simpleMessage(
          "Same 100-move puzzle for everyone",
        ),
        "Day_Streak": m2,
        "Double_Tool": MessageLookupByLibrary.simpleMessage("Double"),
        "Easy": MessageLookupByLibrary.simpleMessage("Easy"),
        "Game_Center": MessageLookupByLibrary.simpleMessage("Game Center"),
        "Game_Over": MessageLookupByLibrary.simpleMessage("Game Over"),
        "Game_Over_Message": MessageLookupByLibrary.simpleMessage(
          "No more moves! Start a new game?",
        ),
        "Games_Moves": m3,
        "Goal": MessageLookupByLibrary.simpleMessage("Goal"),
        "Golden": MessageLookupByLibrary.simpleMessage("Golden"),
        "Golden_Goal": MessageLookupByLibrary.simpleMessage("Golden tile"),
        "Golden_Help": MessageLookupByLibrary.simpleMessage(
          "The glowing golden tile triples when merged. Build it to the marked target.",
        ),
        "Hammer_Tool": MessageLookupByLibrary.simpleMessage("Hammer"),
        "Hard": MessageLookupByLibrary.simpleMessage("Hard"),
        "High_Score": MessageLookupByLibrary.simpleMessage("High Score"),
        "Highest_Tile_Result": m4,
        "Home_Description": MessageLookupByLibrary.simpleMessage(
          "Daily puzzles, score sprints, and move-limited strategy.",
        ),
        "Leaderboards": MessageLookupByLibrary.simpleMessage("Leaderboards"),
        "Level_Complete":
            MessageLookupByLibrary.simpleMessage("Level Complete"),
        "Level_Number": m5,
        "Levels": MessageLookupByLibrary.simpleMessage("Levels"),
        "Locked": MessageLookupByLibrary.simpleMessage("Locked"),
        "Medium": MessageLookupByLibrary.simpleMessage("Medium"),
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
        "Move_Goal": MessageLookupByLibrary.simpleMessage("Moves"),
        "Move_Subtitle": MessageLookupByLibrary.simpleMessage(
          "Highest score in 100 moves",
        ),
        "Moves": MessageLookupByLibrary.simpleMessage("Moves"),
        "Music_Forest": MessageLookupByLibrary.simpleMessage("Quiet Forest"),
        "Music_Medieval":
            MessageLookupByLibrary.simpleMessage("Minstrel Journey"),
        "Music_Meditation":
            MessageLookupByLibrary.simpleMessage("Meditation Bowl"),
        "Music_Off": MessageLookupByLibrary.simpleMessage("Off"),
        "Next": MessageLookupByLibrary.simpleMessage("Next"),
        "No_Achievements": MessageLookupByLibrary.simpleMessage(
          "Complete challenges to unlock achievements.",
        ),
        "No_Daily_History": MessageLookupByLibrary.simpleMessage(
          "Complete today\'s challenge to begin your streak.",
        ),
        "Objective_Endless": MessageLookupByLibrary.simpleMessage(
          "Play without limits",
        ),
        "Objective_Golden": m6,
        "Objective_Move_Score": m7,
        "Objective_Moves": m8,
        "Objective_Score": m9,
        "Objective_Tile": m10,
        "Objective_Time": m11,
        "Objective_Timed_Score": m12,
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
        "Score_Goal": MessageLookupByLibrary.simpleMessage("Score"),
        "Select_Tile": m13,
        "Settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "Share_Message": m14,
        "Share_Result": MessageLookupByLibrary.simpleMessage("Share result"),
        "Shuffle": MessageLookupByLibrary.simpleMessage("Shuffle"),
        "Sound_Effects": MessageLookupByLibrary.simpleMessage("Sound effects"),
        "Speed_Goal": MessageLookupByLibrary.simpleMessage("Speed"),
        "Sprint": MessageLookupByLibrary.simpleMessage("Sprint"),
        "Sprint_Subtitle": MessageLookupByLibrary.simpleMessage(
          "3 minute score race",
        ),
        "Start_Playing": MessageLookupByLibrary.simpleMessage("Start playing"),
        "Tile_Goal": MessageLookupByLibrary.simpleMessage("Tile"),
        "Time": MessageLookupByLibrary.simpleMessage("Time"),
        "Time_Up": MessageLookupByLibrary.simpleMessage("Time!"),
        "Today": MessageLookupByLibrary.simpleMessage("Today"),
        "Tools": MessageLookupByLibrary.simpleMessage("Tools"),
        "Uses_Left": m15,
        "Your_Progress": MessageLookupByLibrary.simpleMessage("Your progress"),
        "Zen_Mode": MessageLookupByLibrary.simpleMessage("Zen"),
        "Zen_Revived": MessageLookupByLibrary.simpleMessage(
          "Zen cleared space so you can keep playing.",
        ),
        "Zen_Subtitle": MessageLookupByLibrary.simpleMessage(
          "An endless board that clears space when stuck",
        ),
      };
}
