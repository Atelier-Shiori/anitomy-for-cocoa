# Anitomy for Cocoa

This is a OS X port of [*Anitomy*](https://github.com/erengy/anitomy), which is a C++ library for parsing anime video filenames. It's accurate, fast, and simple to use. This port allows you to use *Anitomy* in Objective C and Swift projects.

## Examples

The following filename...

[TaigaSubs]_Toradora!_(2008)_-_01v2_-_Tiger_and_Dragon_[1280x720_H.264_FLAC][1234ABCD].mkv

...would be resolved into these elements:

- Release group: *TaigaSubs*
- Anime title: *Toradora!*
- Anime year: *2008*
- Episode number: *01*
- Release version: *2*
- Episode title: *Tiger and Dragon*
- Video resolution: *1280x720*
- Video term: *H.264*
- Audio term: *FLAC*
- File checksum: *1234ABCD*

##How to Build
1. You will need Xcode 4.2 or later for C++11 support
2. Clone the repo
3. Type xcodebuild to build the project

##How to use
1. Copy the framework to your XCode Project
2. Add this to the header file. For Swift projects, create a [bridging header file](http://swiftalicio.us/2014/11/using-cocoapods-from-swift/)
```objective-c
#import <anitomy-osx/anitomy-objc-wrapper.h>
```

To use, simply do the following:
```objective-c
NSDictionary * d = [[anitomy_bridge alloc] tokenize:@"[Chibiki]_THE_iDOLM@STER_-_01_[720p][C83E5732].mkv"];
NSLog(@"%@",d);
```
It should output the following:
```
{
episode = 01;
group = Chibiki;
releaseversion = "";
title = "THE iDOLM@STER";
videosource = "";
videoterm = "";
year = "";
}
```

## How does it work?

Suppose that we're working on the following filename:

"Spice_and_Wolf_Ep01_[1080p,BluRay,x264]_-_THORA.mkv"

The filename is first stripped off of its extension and split into groups. Groups are determined by the position of brackets:

"Spice_and_Wolf_Ep01_", "1080p,BluRay,x264", "_-_THORA"

Each group is then split into tokens. In our current example, the delimiter for the enclosed group is `,`, while the words in other groups are separated by `_`:

"Spice", "and", "Wolf", "Ep01", "1080p", "BluRay", "x264", "-", "THORA"

Note that brackets and delimiters are actually stored as tokens. Here, identified tokens are omitted for our convenience.

Once the tokenizer is done, the parser comes into effect. First, all tokens are compared against a set of known patterns and keywords. This process generally leaves us with nothing but the release group, anime title, episode number and episode title:

"Spice", "and", "Wolf", "Ep01", "-"

The next step is to look for the episode number. Each token that contains a number is analyzed. Here, `Ep01` is identified because it begins with a known episode prefix:

"Spice", "and", "Wolf", "-"

Finally, remaining tokens are combined to form the anime title, which is `Spice and Wolf`. The complete list of elements identified by *Anitomy* is as follows:

- Anime title: *Spice and Wolf*
- Episode number: *01*
- Video resolution: *1080p*
- Source: *BluRay*
- Video term: *x264*
- Release group: *THORA*

## Why should I use it?

Anime video files are commonly named in a format where the anime title is followed by the episode number, and all the technical details are enclosed within brackets. However, fansub groups tend to use their own naming conventions, and the problem is more complicated than it first appears:

- Element order is not always the same.
- Technical information is not guaranteed to be enclosed.
- Brackets and parentheses may be grouping symbols or a part of the anime/episode title.
- Space and underscore are not the only delimiters in use.
- A single filename may contain multiple delimiters.

There are so many cases to cover that it's simply not possible to parse all filenames solely with regular expressions. *Anitomy* tries a different approach, and it succeeds: It's able to parse tens of thousands of filenames per second, with almost perfect accuracy.

## Are there any exceptions?

Yes, unfortunately. *Anitomy* fails to identify the anime title and episode number on rare occasions, mostly due to bad naming conventions. See the examples below.

Arigatou.Shuffle!.Ep08.[x264.AAC][D6E43829].mkv

Here, *Anitomy* would report that this file is the 8th episode of `Arigatou Shuffle!`, where `Arigatou` is actually the name of the fansub group.

Spice and Wolf 2

Is this the 2nd episode of `Spice and Wolf`, or a batch release of `Spice and Wolf 2`? Without an extension, there's no way to know. It's up to you consider both cases.

## Suggestions to fansub groups

Please consider abiding by these simple rules before deciding on your naming convention:

- Don't enclose anime title, episode number and episode title within brackets. Enclose everything else, including the name of your group.
- Don't use parentheses to enclose release information; use square brackets instead. Parentheses should only be used if they are a part of the anime/episode title.
- Don't use multiple delimiters in a single filename. If possible, stick with either space or underscore.
- Use a separator between anime title and episode number, namely a dash. There are anime titles that end with a number, which creates confusion.
- Indicate the episode interval in batch releases.

##Changes to orginal code
String.h and String.cpp has been renamed to String2.h and String2.cpp so it will compile under Xcode.

## License

The port of *Anitomy* for Cocoa is licensed under the same license as the [orginal code](https://github.com/erengy/anitomy), [GNU General Public License v3](https://www.gnu.org/licenses/gpl-3.0.html). Anitomy is by Eren Okka.
