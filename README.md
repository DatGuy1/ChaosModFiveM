This FiveM adaptation was made with the use of EmmyLua and IntelliJ IDEA. Natives in EmmyDoc format were generated to help ease the programming experience. Note that only around 60% (rough estimation) of the original Chaos Mod effects are adapted. The 40% are mostly not here due to replication issues, being impossible to make through only server code (i.e. memory patching), or simply because I didn't have time.

The EnumerateX methods are from [this gist](https://gist.github.com/IllidanS4/9865ed17f60576425369fc1da70259b2). DisplayMessage displays a notification in the bottom left of the screen. ScaleformMessage is the SHOW_SHARD_RANKUP_MP_MESSAGE process.

# License
This repository, due to being an adaptation of [the singleplayer chaos mod](https://github.com/gta-chaos-mod/ChaosModV), also abides by the GNU General Public License 3.0

# Code Disclaimer
I never used Lua nor modded FiveM until less than a month ago. This project was done in around five days. The code is:
- unoptimised
- ugly
- not reliably replicated
- likely to crash

The commit messages are also undescriptive.

# Installation
1. Clone the repository/download it as zip
2. Make sure `ChaosMod` and `helpers` folders are somewhere in the server-data folders
3. Either in server.cfg or in the console, write `ensure ChaosMod` and `ensure helpers`
4. You're ready! Start the mod with /startchaos and stop it with /stopchaos

You can also use /setduration <number> to set the duration for normal-length effects, /setshortduration <number> to set the duration for short-length effects, and /setinterval <number> to set the interval for when new effects should come in.
