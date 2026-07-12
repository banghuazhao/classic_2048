// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_HK locale. All the
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
  String get localeName => 'zh_HK';

  static String m0(score, tile) => "最高分 ${score} · 最大方塊 ${tile}";

  static String m1(value) => "方塊 ${value}";

  static String m2(days) => "連續${days}天";

  static String m3(games, moves) => "${games}局 · ${moves}步";

  static String m4(moves, tile) => "${moves}步 · 最大方塊 ${tile}";

  static String m5(score, mode, moves, tile) =>
      "我在${mode}中獲得${score}分，用了${moves}步並合成了${tile}。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Achievement_10K": MessageLookupByLibrary.simpleMessage("萬分俱樂部"),
        "Achievement_2048": MessageLookupByLibrary.simpleMessage("2048大師"),
        "Achievement_Efficient": MessageLookupByLibrary.simpleMessage("高效思考者"),
        "Achievement_Streak": MessageLookupByLibrary.simpleMessage("連續七天"),
        "Achievements": MessageLookupByLibrary.simpleMessage("成就"),
        "App_Name": MessageLookupByLibrary.simpleMessage("方塊試煉"),
        "Back": MessageLookupByLibrary.simpleMessage("返回"),
        "Best_Highest": m0,
        "Board_Cell": m1,
        "Board_Waiting": MessageLookupByLibrary.simpleMessage("你的棋盤正在等待。"),
        "Challenge_Complete": MessageLookupByLibrary.simpleMessage("挑戰完成"),
        "Challenge_Modes": MessageLookupByLibrary.simpleMessage("挑戰模式"),
        "Choose_Mode": MessageLookupByLibrary.simpleMessage("選擇挑戰"),
        "Classic": MessageLookupByLibrary.simpleMessage("經典"),
        "Classic_Boards": MessageLookupByLibrary.simpleMessage("經典棋盤"),
        "Classic_Endless": MessageLookupByLibrary.simpleMessage("無盡策略"),
        "Continue": MessageLookupByLibrary.simpleMessage("繼續"),
        "Daily_Challenge": MessageLookupByLibrary.simpleMessage("每日挑戰"),
        "Daily_History": MessageLookupByLibrary.simpleMessage("每日記錄"),
        "Daily_Streak": MessageLookupByLibrary.simpleMessage("每日連續挑戰"),
        "Daily_Subtitle":
            MessageLookupByLibrary.simpleMessage("所有玩家共享同一個100步謎題"),
        "Day_Streak": m2,
        "Game_Center": MessageLookupByLibrary.simpleMessage("Game Center"),
        "Game_Over": MessageLookupByLibrary.simpleMessage("遊戲結束"),
        "Game_Over_Message": MessageLookupByLibrary.simpleMessage(
          "沒有可用的移動了！開始新遊戲？",
        ),
        "Games_Moves": m3,
        "High_Score": MessageLookupByLibrary.simpleMessage("最高得分"),
        "Highest_Tile_Result": m4,
        "Home_Description": MessageLookupByLibrary.simpleMessage(
          "每日謎題、限時衝刺與步數策略挑戰。",
        ),
        "Leaderboards": MessageLookupByLibrary.simpleMessage("排行榜"),
        "Mode_4_1": MessageLookupByLibrary.simpleMessage("經典 · 每步新增1塊"),
        "Mode_5_1": MessageLookupByLibrary.simpleMessage("更大空間 · 輕鬆節奏"),
        "Mode_5_2": MessageLookupByLibrary.simpleMessage("更大空間 · 快速挑戰"),
        "Mode_6_2": MessageLookupByLibrary.simpleMessage("大型棋盤 · 策略模式"),
        "Mode_6_3": MessageLookupByLibrary.simpleMessage("大型棋盤 · 專家模式"),
        "Move_Challenge": MessageLookupByLibrary.simpleMessage("步數挑戰"),
        "Move_Subtitle": MessageLookupByLibrary.simpleMessage("在100步內取得最高分"),
        "Moves": MessageLookupByLibrary.simpleMessage("步數"),
        "Next": MessageLookupByLibrary.simpleMessage("下一步"),
        "No_Achievements": MessageLookupByLibrary.simpleMessage("完成挑戰以解鎖成就。"),
        "No_Daily_History":
            MessageLookupByLibrary.simpleMessage("完成今日挑戰以開始連續記錄。"),
        "Onboarding_Body_1": MessageLookupByLibrary.simpleMessage(
          "與所有玩家挑戰同一個固定種子的100步謎題。",
        ),
        "Onboarding_Body_2": MessageLookupByLibrary.simpleMessage(
          "三分鐘衝刺，或在100步內打造最佳棋盤。",
        ),
        "Onboarding_Body_3": MessageLookupByLibrary.simpleMessage(
          "延續每日連勝、解鎖成就並登上Game Center。",
        ),
        "Onboarding_Title_1": MessageLookupByLibrary.simpleMessage("每天都有新試煉"),
        "Onboarding_Title_2": MessageLookupByLibrary.simpleMessage("衝刺或謀劃"),
        "Onboarding_Title_3": MessageLookupByLibrary.simpleMessage("建立你的紀錄"),
        "Paused": MessageLookupByLibrary.simpleMessage("已暫停"),
        "Progress_Achievements": MessageLookupByLibrary.simpleMessage("進度與成就"),
        "Random": MessageLookupByLibrary.simpleMessage("隨機"),
        "Restart": MessageLookupByLibrary.simpleMessage("重新開始"),
        "Score": MessageLookupByLibrary.simpleMessage("得分"),
        "Share_Message": m5,
        "Share_Result": MessageLookupByLibrary.simpleMessage("分享結果"),
        "Shuffle": MessageLookupByLibrary.simpleMessage("洗牌"),
        "Sprint": MessageLookupByLibrary.simpleMessage("限時衝刺"),
        "Sprint_Subtitle": MessageLookupByLibrary.simpleMessage("3分鐘得分賽"),
        "Start_Playing": MessageLookupByLibrary.simpleMessage("開始遊戲"),
        "Time": MessageLookupByLibrary.simpleMessage("時間"),
        "Time_Up": MessageLookupByLibrary.simpleMessage("時間到！"),
        "Today": MessageLookupByLibrary.simpleMessage("今日"),
        "Your_Progress": MessageLookupByLibrary.simpleMessage("你的進度"),
      };
}
