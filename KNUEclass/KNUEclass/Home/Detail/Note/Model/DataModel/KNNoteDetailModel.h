//
//  KNNoteDetailModel.h
//  KNUEclass
//
//  Created by user on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNNoteDetailModel : NSObject

@property (nonatomic, strong) NSString *clubNm;
@property (nonatomic, strong) NSString *regiFileNm, *fileSeq, *downCnt, *clubId;
@property (nonatomic, strong) NSString *noteSeq, *title, *nickNm, *regiDttm, *fileYn, *noteCont, *readCnt;

- (void)setNoteSeq:(NSString *)noteSeq withClubId:(NSString *)clubId withClubNm:(NSString *)clubNm;

@end
