// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(score, tile) => "最高分 ${score} · 最大方块 ${tile}";

  static String m1(value) => "方块 ${value}";

  static String m2(days) => "连续${days}天";

  static String m3(games, moves) => "${games}局 · ${moves}步";

  static String m4(moves, tile) => "${moves}步 · 最大方块 ${tile}";

  static String m5(score, mode, moves, tile) =>
      "我在${mode}中获得${score}分，用了${moves}步并合成了${tile}。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Achievement_10K": MessageLookupByLibrary.simpleMessage("万分俱乐部"),
        "Achievement_2048": MessageLookupByLibrary.simpleMessage("2048大师"),
        "Achievement_Efficient": MessageLookupByLibrary.simpleMessage("高效思考者"),
        "Achievement_Streak": MessageLookupByLibrary.simpleMessage("连续七天"),
        "Achievements": MessageLookupByLibrary.simpleMessage("成就"),
        "App_Name": MessageLookupByLibrary.simpleMessage("方块试炼"),
        "Back": MessageLookupByLibrary.simpleMessage("返回"),
        "Best_Highest": m0,
        "Board_Cell": m1,
        "Board_Waiting": MessageLookupByLibrary.simpleMessage("你的棋盘正在等待。"),
        "Challenge_Complete": MessageLookupByLibrary.simpleMessage("挑战完成"),
        "Challenge_Modes": MessageLookupByLibrary.simpleMessage("挑战模式"),
        "Choose_Mode": MessageLookupByLibrary.simpleMessage("选择挑战"),
        "Classic": MessageLookupByLibrary.simpleMessage("经典"),
        "Classic_Boards": MessageLookupByLibrary.simpleMessage("经典棋盘"),
        "Classic_Endless": MessageLookupByLibrary.simpleMessage("无尽策略"),
        "Continue": MessageLookupByLibrary.simpleMessage("继续"),
        "Daily_Challenge": MessageLookupByLibrary.simpleMessage("每日挑战"),
        "Daily_History": MessageLookupByLibrary.simpleMessage("每日记录"),
        "Daily_Streak": MessageLookupByLibrary.simpleMessage("每日连续挑战"),
        "Daily_Subtitle":
            MessageLookupByLibrary.simpleMessage("所有玩家共享同一个100步谜题"),
        "Day_Streak": m2,
        "Game_Center": MessageLookupByLibrary.simpleMessage("Game Center"),
        "Game_Over": MessageLookupByLibrary.simpleMessage("游戏结束"),
        "Game_Over_Message": MessageLookupByLibrary.simpleMessage(
          "没有可用的移动了！开始新游戏？",
        ),
        "Games_Moves": m3,
        "High_Score": MessageLookupByLibrary.simpleMessage("最高得分"),
        "Highest_Tile_Result": m4,
        "Home_Description": MessageLookupByLibrary.simpleMessage(
          "每日谜题、限时冲刺与步数策略挑战。",
        ),
        "Leaderboards": MessageLookupByLibrary.simpleMessage("排行榜"),
        "Mode_4_1": MessageLookupByLibrary.simpleMessage("经典 · 每步新增1块"),
        "Mode_5_1": MessageLookupByLibrary.simpleMessage("更大空间 · 轻松节奏"),
        "Mode_5_2": MessageLookupByLibrary.simpleMessage("更大空间 · 快速挑战"),
        "Mode_6_2": MessageLookupByLibrary.simpleMessage("大型棋盘 · 策略模式"),
        "Mode_6_3": MessageLookupByLibrary.simpleMessage("大型棋盘 · 专家模式"),
        "Move_Challenge": MessageLookupByLibrary.simpleMessage("步数挑战"),
        "Move_Subtitle": MessageLookupByLibrary.simpleMessage("在100步内取得最高分"),
        "Moves": MessageLookupByLibrary.simpleMessage("步数"),
        "Next": MessageLookupByLibrary.simpleMessage("下一步"),
        "No_Achievements": MessageLookupByLibrary.simpleMessage("完成挑战以解锁成就。"),
        "No_Daily_History":
            MessageLookupByLibrary.simpleMessage("完成今日挑战以开始连续记录。"),
        "Onboarding_Body_1": MessageLookupByLibrary.simpleMessage(
          "与所有玩家挑战同一个固定种子的100步谜题。",
        ),
        "Onboarding_Body_2": MessageLookupByLibrary.simpleMessage(
          "三分钟冲刺，或在100步内打造最佳棋盘。",
        ),
        "Onboarding_Body_3": MessageLookupByLibrary.simpleMessage(
          "延续每日连胜、解锁成就并登上Game Center。",
        ),
        "Onboarding_Title_1": MessageLookupByLibrary.simpleMessage("每天都有新试炼"),
        "Onboarding_Title_2": MessageLookupByLibrary.simpleMessage("冲刺或谋划"),
        "Onboarding_Title_3": MessageLookupByLibrary.simpleMessage("建立你的纪录"),
        "Paused": MessageLookupByLibrary.simpleMessage("已暂停"),
        "Progress_Achievements": MessageLookupByLibrary.simpleMessage("进度与成就"),
        "Random": MessageLookupByLibrary.simpleMessage("随机"),
        "Restart": MessageLookupByLibrary.simpleMessage("重新开始"),
        "Score": MessageLookupByLibrary.simpleMessage("得分"),
        "Share_Message": m5,
        "Share_Result": MessageLookupByLibrary.simpleMessage("分享结果"),
        "Shuffle": MessageLookupByLibrary.simpleMessage("洗牌"),
        "Sprint": MessageLookupByLibrary.simpleMessage("限时冲刺"),
        "Sprint_Subtitle": MessageLookupByLibrary.simpleMessage("3分钟得分赛"),
        "Start_Playing": MessageLookupByLibrary.simpleMessage("开始游戏"),
        "Time": MessageLookupByLibrary.simpleMessage("时间"),
        "Time_Up": MessageLookupByLibrary.simpleMessage("时间到！"),
        "Today": MessageLookupByLibrary.simpleMessage("今日"),
        "Your_Progress": MessageLookupByLibrary.simpleMessage("你的进度"),
      };
}
