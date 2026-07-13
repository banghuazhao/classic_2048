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

  static String m5(number) => "第${number}关";

  static String m6(tile) => "将黄金方块合成至${tile}或更高";

  static String m7(score, moves) => "在${moves}步内获得${score}分";

  static String m8(moves) => "完成${moves}步";

  static String m9(score) => "达到${score}分";

  static String m10(tile) => "合成${tile}方块";

  static String m11(seconds) => "游戏${seconds}秒";

  static String m12(score, seconds) => "在${seconds}秒内获得${score}分";

  static String m13(tool) => "选择一个方块使用${tool}";

  static String m14(score, mode, moves, tile) =>
      "我在${mode}中获得${score}分，用了${moves}步并合成了${tile}。";

  static String m15(count) => "剩余${count}次";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Achievement_10K": MessageLookupByLibrary.simpleMessage("万分俱乐部"),
        "Achievement_2048": MessageLookupByLibrary.simpleMessage("2048大师"),
        "Achievement_Efficient": MessageLookupByLibrary.simpleMessage("高效思考者"),
        "Achievement_Streak": MessageLookupByLibrary.simpleMessage("连续七天"),
        "Achievements": MessageLookupByLibrary.simpleMessage("成就"),
        "All_Levels": MessageLookupByLibrary.simpleMessage("10个关卡 · 从简单到专家"),
        "App_Name": MessageLookupByLibrary.simpleMessage("方块试炼"),
        "Back": MessageLookupByLibrary.simpleMessage("返回"),
        "Background_Music": MessageLookupByLibrary.simpleMessage("背景音乐"),
        "Best_Highest": m0,
        "Board_Cell": m1,
        "Board_Waiting": MessageLookupByLibrary.simpleMessage("你的棋盘正在等待。"),
        "Bomb_Tool": MessageLookupByLibrary.simpleMessage("3×3炸弹"),
        "Challenge_Complete": MessageLookupByLibrary.simpleMessage("挑战完成"),
        "Challenge_Count": MessageLookupByLibrary.simpleMessage(
          "3个简单 · 3个中等 · 3个困难",
        ),
        "Challenge_Failed": MessageLookupByLibrary.simpleMessage("挑战失败"),
        "Challenge_Modes": MessageLookupByLibrary.simpleMessage("挑战模式"),
        "Challenge_Won": MessageLookupByLibrary.simpleMessage("挑战完成"),
        "Challenges": MessageLookupByLibrary.simpleMessage("挑战"),
        "Choose_Mode": MessageLookupByLibrary.simpleMessage("选择挑战"),
        "Classic": MessageLookupByLibrary.simpleMessage("经典"),
        "Classic_Boards": MessageLookupByLibrary.simpleMessage("经典棋盘"),
        "Classic_Endless": MessageLookupByLibrary.simpleMessage("无尽策略"),
        "Completed": MessageLookupByLibrary.simpleMessage("已完成"),
        "Continue": MessageLookupByLibrary.simpleMessage("继续"),
        "Daily_Challenge": MessageLookupByLibrary.simpleMessage("每日挑战"),
        "Daily_History": MessageLookupByLibrary.simpleMessage("每日记录"),
        "Daily_Streak": MessageLookupByLibrary.simpleMessage("每日连续挑战"),
        "Daily_Subtitle":
            MessageLookupByLibrary.simpleMessage("所有玩家共享同一个100步谜题"),
        "Day_Streak": m2,
        "Double_Tool": MessageLookupByLibrary.simpleMessage("加倍"),
        "Easy": MessageLookupByLibrary.simpleMessage("简单"),
        "Game_Center": MessageLookupByLibrary.simpleMessage("Game Center"),
        "Game_Over": MessageLookupByLibrary.simpleMessage("游戏结束"),
        "Game_Over_Message": MessageLookupByLibrary.simpleMessage(
          "没有可用的移动了！开始新游戏？",
        ),
        "Games_Moves": m3,
        "Goal": MessageLookupByLibrary.simpleMessage("目标"),
        "Golden": MessageLookupByLibrary.simpleMessage("黄金"),
        "Golden_Goal": MessageLookupByLibrary.simpleMessage("黄金方块"),
        "Golden_Help": MessageLookupByLibrary.simpleMessage(
          "发光的黄金方块合并时变为三倍。将它合成至标记目标。",
        ),
        "Hammer_Tool": MessageLookupByLibrary.simpleMessage("锤子"),
        "Hard": MessageLookupByLibrary.simpleMessage("困难"),
        "High_Score": MessageLookupByLibrary.simpleMessage("最高得分"),
        "Highest_Tile_Result": m4,
        "Home_Description": MessageLookupByLibrary.simpleMessage(
          "每日谜题、限时冲刺与步数策略挑战。",
        ),
        "Leaderboards": MessageLookupByLibrary.simpleMessage("排行榜"),
        "Level_Complete": MessageLookupByLibrary.simpleMessage("关卡完成"),
        "Level_Number": m5,
        "Levels": MessageLookupByLibrary.simpleMessage("关卡"),
        "Locked": MessageLookupByLibrary.simpleMessage("未解锁"),
        "Medium": MessageLookupByLibrary.simpleMessage("中等"),
        "Mode_4_1": MessageLookupByLibrary.simpleMessage("经典 · 每步新增1块"),
        "Mode_5_1": MessageLookupByLibrary.simpleMessage("更大空间 · 轻松节奏"),
        "Mode_5_2": MessageLookupByLibrary.simpleMessage("更大空间 · 快速挑战"),
        "Mode_6_2": MessageLookupByLibrary.simpleMessage("大型棋盘 · 策略模式"),
        "Mode_6_3": MessageLookupByLibrary.simpleMessage("大型棋盘 · 专家模式"),
        "Move_Challenge": MessageLookupByLibrary.simpleMessage("步数挑战"),
        "Move_Goal": MessageLookupByLibrary.simpleMessage("步数"),
        "Move_Subtitle": MessageLookupByLibrary.simpleMessage("在100步内取得最高分"),
        "Moves": MessageLookupByLibrary.simpleMessage("步数"),
        "Music_Forest": MessageLookupByLibrary.simpleMessage("静谧森林"),
        "Music_Medieval": MessageLookupByLibrary.simpleMessage("吟游旅程"),
        "Music_Meditation": MessageLookupByLibrary.simpleMessage("冥想钵音"),
        "Music_Off": MessageLookupByLibrary.simpleMessage("关闭"),
        "Next": MessageLookupByLibrary.simpleMessage("下一步"),
        "No_Achievements": MessageLookupByLibrary.simpleMessage("完成挑战以解锁成就。"),
        "No_Daily_History":
            MessageLookupByLibrary.simpleMessage("完成今日挑战以开始连续记录。"),
        "Objective_Endless": MessageLookupByLibrary.simpleMessage("无限制游戏"),
        "Objective_Golden": m6,
        "Objective_Move_Score": m7,
        "Objective_Moves": m8,
        "Objective_Score": m9,
        "Objective_Tile": m10,
        "Objective_Time": m11,
        "Objective_Timed_Score": m12,
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
        "Score_Goal": MessageLookupByLibrary.simpleMessage("得分"),
        "Select_Tile": m13,
        "Settings": MessageLookupByLibrary.simpleMessage("设置"),
        "Share_Message": m14,
        "Share_Result": MessageLookupByLibrary.simpleMessage("分享结果"),
        "Shuffle": MessageLookupByLibrary.simpleMessage("洗牌"),
        "Sound_Effects": MessageLookupByLibrary.simpleMessage("音效"),
        "Speed_Goal": MessageLookupByLibrary.simpleMessage("速度"),
        "Sprint": MessageLookupByLibrary.simpleMessage("限时冲刺"),
        "Sprint_Subtitle": MessageLookupByLibrary.simpleMessage("3分钟得分赛"),
        "Start_Playing": MessageLookupByLibrary.simpleMessage("开始游戏"),
        "Tile_Goal": MessageLookupByLibrary.simpleMessage("方块"),
        "Time": MessageLookupByLibrary.simpleMessage("时间"),
        "Time_Up": MessageLookupByLibrary.simpleMessage("时间到！"),
        "Today": MessageLookupByLibrary.simpleMessage("今日"),
        "Tools": MessageLookupByLibrary.simpleMessage("工具"),
        "Uses_Left": m15,
        "Your_Progress": MessageLookupByLibrary.simpleMessage("你的进度"),
        "Zen_Mode": MessageLookupByLibrary.simpleMessage("禅模式"),
        "Zen_Revived": MessageLookupByLibrary.simpleMessage("禅模式已腾出空间，可以继续游戏。"),
        "Zen_Subtitle": MessageLookupByLibrary.simpleMessage("无尽棋盘，卡住时自动腾出空间"),
      };
}
