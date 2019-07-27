//
//  KNNoticeDetailModel.h
//  KNUEclass
//
//  Created by user on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNNoticeDetailModel : NSObject

@property (nonatomic, strong) NSString *clubNm, *clubId, *title, *noteCont, *noteSeq, *nickNm, *regiDttm, *readCnt, *fileYn;

- (void)setNoteSeq:(NSString *)noteSeq withClubId:(NSString *)clubId;

@end
