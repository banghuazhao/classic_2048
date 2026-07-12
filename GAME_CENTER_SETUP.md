# Game Center setup

The iOS target contains the Game Center entitlement and signs the local player in at launch. Before submitting a build, enable Game Center for the `com.appsbay.classic2048` App ID and create these components in App Store Connect using the exact permanent IDs below.

## Leaderboards

| Reference name | Leaderboard ID | Sort |
|---|---|---|
| Classic High Score | `com.appsbay.classic2048.classic` | High to low |
| Sprint High Score | `com.appsbay.classic2048.sprint` | High to low |
| Daily Challenge | `com.appsbay.classic2048.daily` | High to low |

Use an integer score format. Add English, Simplified Chinese, and Traditional Chinese localizations.

## Achievements

| Reference name | Achievement ID | Points | Unlock rule |
|---|---|---:|---|
| 2048 Master | `com.appsbay.classic2048.achievement.2048` | 100 | Reach tile 2048 |
| 10K Club | `com.appsbay.classic2048.achievement.10k` | 50 | Score at least 10,000 |
| Efficient Thinker | `com.appsbay.classic2048.achievement.efficient` | 50 | Reach tile 512 within 100 moves |
| Seven Day Streak | `com.appsbay.classic2048.achievement.streak7` | 100 | Complete daily challenges on seven consecutive days |

All achievements are one-time, non-hidden achievements with a 100% completion submission. Add localized earned and unearned descriptions plus original artwork.

## Submission checklist

1. Enable Game Center for the identifier in Certificates, Identifiers & Profiles.
2. Enable Game Center for the app record in App Store Connect.
3. Create and localize the three leaderboards and four achievements above.
4. Test authentication and submissions using a sandbox Game Center account on a physical iOS device.
5. Submit the Game Center components together with the app version for review.
