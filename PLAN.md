# Future Develop Plan 

## Status

Finish: ✅
Pending: 🐢
Urgent: 🐰

---


I want to develop this app on MacOS, iOS, iPad OS, even WatchOS, So what I need to do:



1. package current UTC transfer logic into swift Package, make it can work on mutile platform , then I can reuse the Swift Package to develop logic ✅

2. Design UI for different platform, Mac OS is Ready 🐢 (iOS/iPadOS/WatchOS skeleton added, need polish per platform)

3. make it a Muti-target project, can build for different platforms, do not make it a mutiplatform app project, because I can make more UI customize base on different target 

4. Set a money after I submit it to app store ✅

5. make a auto CI/CD workflow base on GitHub Actions(Or Xcode Cloud), it will be my first money project

6. Optional: Make a CommandLineTool to convert UTC time, could consider open source UTC transfer package and Command Line Tool source code, and make it free, but will charge for iOS /ipadOS/WatchOS/MacOS GUI Apps

7. Added a SIT multi-target using the same code with bundle id `levi.UTCTimeLooker.sit` and app name `UTCTimeLookerSIT`, so local runs won't replace the Prod build ✅
