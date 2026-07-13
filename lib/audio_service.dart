import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicChoice {
  final String id;
  final String asset;

  const MusicChoice(this.id, this.asset);
}

class GameAudioService {
  GameAudioService._();

  static final instance = GameAudioService._();
  static const musicChoices = <MusicChoice>[
    MusicChoice('forest', 'audio/music/forest.mp3'),
    MusicChoice('meditation', 'audio/music/meditation_bowl.mp3'),
    MusicChoice('medieval', 'audio/music/medieval_rejoicing.mp3'),
  ];

  static const _musicKey = 'music_choice_v1';
  static const _soundKey = 'sound_effects_v1';
  final AudioPlayer _music = AudioPlayer(playerId: 'background_music');
  final List<AudioPlayer> _effects =
      List.generate(4, (index) => AudioPlayer(playerId: 'game_effect_$index'));
  int _nextEffect = 0;
  String musicChoice = 'off';
  bool soundEffects = true;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    final prefs = await SharedPreferences.getInstance();
    musicChoice = prefs.getString(_musicKey) ?? 'off';
    soundEffects = prefs.getBool(_soundKey) ?? true;
    await _music.setReleaseMode(ReleaseMode.loop);
    await _music.setVolume(.32);
    await _applyMusic();
  }

  Future<void> setMusic(String choice) async {
    musicChoice = choice;
    await (await SharedPreferences.getInstance()).setString(_musicKey, choice);
    await _applyMusic();
  }

  Future<void> setSoundEffects(bool enabled) async {
    soundEffects = enabled;
    await (await SharedPreferences.getInstance()).setBool(_soundKey, enabled);
    if (enabled) await playEffect(GameSound.select);
  }

  Future<void> _applyMusic() async {
    await _music.stop();
    if (musicChoice == 'off') return;
    final choice = musicChoices.where((item) => item.id == musicChoice);
    if (choice.isNotEmpty) await _music.play(AssetSource(choice.first.asset));
  }

  Future<void> playEffect(GameSound sound) async {
    if (!soundEffects) return;
    final path = switch (sound) {
      GameSound.move => 'audio/effects/swap.mp3',
      GameSound.merge => 'audio/effects/chomp.wav',
      GameSound.golden => 'audio/effects/ka_ching.wav',
      GameSound.tool => 'audio/effects/scrape.wav',
      GameSound.select => 'audio/effects/drip.wav',
      GameSound.error => 'audio/effects/error.wav',
    };
    final player = _effects[_nextEffect++ % _effects.length];
    await player.stop();
    await player.play(AssetSource(path), volume: .7);
  }
}

enum GameSound { move, merge, golden, tool, select, error }
