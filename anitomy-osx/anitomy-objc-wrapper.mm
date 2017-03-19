//
//  anitomy-objc-wrapper.m
//  Anitomy Objective C Wrapper
//
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

#import "anitomy-objc-wrapper.h"
#import "anitomy.h"
#include <iostream>
#include <string>

@implementation anitomy_bridge
#if TARGET_RT_BIG_ENDIAN
const NSStringEncoding kEncoding_wchar_t =
CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF32BE);
#else
const NSStringEncoding kEncoding_wchar_t =
CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF32LE);
#endif

+(NSDictionary *)tokenize:(NSString *) filename{
    anitomy_bridge * a = [anitomy_bridge new];
    return [a tokenize:filename];
}

-(NSDictionary *)tokenize:(NSString *) filename{
    anitomy::Anitomy anitomy;
    NSData *d = [filename dataUsingEncoding:kEncoding_wchar_t];
    anitomy.Parse(std::wstring((wchar_t *)d.bytes, d.length / sizeof(wchar_t)));//"[Ouroboros]_Fullmetal_Alchemist_Brotherhood_-_01.mkv"
    
    auto& elements = anitomy.elements();
    
    // Generate NSString and Convert
    NSString * title = [self wstringtoNSString:elements.get(anitomy::kElementAnimeTitle)];
    NSString * episode = [self wstringtoNSString:elements.get(anitomy::kElementEpisodeNumber)];
    NSString * episodetitle = [self wstringtoNSString:elements.get(anitomy::kElementEpisodeTitle)];
    NSString * episodetype =[self wstringtoNSString:elements.get(anitomy::kElementEpisodePrefix)];
    NSString * group = [self wstringtoNSString:elements.get(anitomy::kElementReleaseGroup)];
    NSString * year = [self wstringtoNSString: elements.get(anitomy::kElementAnimeYear)];
    NSString * releaseversion = [self wstringtoNSString: elements.get(anitomy::kElementReleaseVersion)];
    NSString * releaseinfo = [self wstringtoNSString:elements.get(anitomy::  kElementReleaseInformation)];
    NSString * videoterm = [self wstringtoNSString: elements.get(anitomy::kElementVideoTerm)];
    NSString * videosource = [self wstringtoNSString: elements.get(anitomy::kElementSource)];
    NSString * videoresolution = [self wstringtoNSString:elements.get(anitomy::kElementVideoResolution)];
    NSString * volumenum = [self wstringtoNSString: elements.get(anitomy::kElementVolumeNumber)];
    NSString * volumeprefix = [self wstringtoNSString: elements.get(anitomy::kElementVolumePrefix)];
    NSString * language = [self wstringtoNSString: elements.get(anitomy::kElementLanguage)];
    NSString * subtitles = [self wstringtoNSString: elements.get(anitomy::kElementLanguage)];
    NSString * season = [self wstringtoNSString:elements.get(anitomy::kElementAnimeSeason)];
    NSString * filetype = [self wstringtoNSString:elements.get(anitomy::kElementFileExtension)];
    NSString * filechecksum = [self wstringtoNSString:elements.get(anitomy::kElementFileChecksum)];
    NSString * rfilename = [self wstringtoNSString:elements.get(anitomy::kElementFileName)];
    // Populate Anime Types, if exists
    NSMutableArray * animetype = [[NSMutableArray alloc]init];
    if (!elements.empty(anitomy::kElementAnimeType)) {
        auto anime_types = elements.get_all(anitomy::kElementAnimeType);
        for (const auto& anime_type : anime_types) {
            [animetype addObject:[self wstringtoNSString:anime_type]];
        }
    }
    NSDictionary * dic = @{@"title": title,@"episode": episode, @"episodetitle": episodetitle, @"episodetype": episodetype,@"group": group,@"year": year,@"releaseversion": releaseversion, @"releaseinfo": releaseinfo, @"videoterm": videoterm, @"videosource": videosource, @"videoresolution": videoresolution, @"season": season, @"type": animetype, @"volumenum": volumenum, @"volumeprefix": volumeprefix, @"language": language, @"subtitles": subtitles, @"filetype": filetype, @"filechecksum": filechecksum, @"filename": rfilename};
    // Clear Elements
    elements.clear();
    // Return Value
    return dic;
}
-(NSString *)wstringtoNSString:(const std::wstring&)ws{
    char *data = (char *)ws.data();
    size_t size = ws.size() * sizeof(wchar_t);
    
    NSString *result = [[NSString alloc] initWithBytes:data length:size
                                               encoding:kEncoding_wchar_t];
    return result;
}
@end
