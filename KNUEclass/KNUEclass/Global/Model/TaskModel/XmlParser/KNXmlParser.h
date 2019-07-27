//
//  KNXmlParser.h
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TBXML+HTTP.h>

typedef NS_ENUM(NSInteger, ParsingType) {
    PTnotice,
    PTnote,
    PThomework,
    PTlectureList,
    PTnoticeDetail,
    PTnoteDetail,
    PTnoticeAndNoteFileList,
    PThomeworkFileList,
    PTLoginSessionHasExpired,
};

@protocol KNXmlParserDelegate <NSObject>

@required
- (void)parsingDidFinishedWithParsingType:(ParsingType)parsingType withParsingList:(id)parsingList;

@end

@interface KNXmlParser : NSObject

@property (nonatomic, weak) id<KNXmlParserDelegate> delegate;

- (void)startParsingWithData:(id)data withParsingType:(ParsingType)parsingType;

@end
