//
//  KNNoteDetailModel.m
//  KNUEclass
//
//  Created by user on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNNoteDetailModel.h"

@implementation KNNoteDetailModel

- (void)setNoteSeq:(NSString *)noteSeq withClubId:(NSString *)clubId withClubNm:(NSString *)clubNm {
    self.noteSeq = noteSeq;
    self.clubId = clubId;
    self.clubNm = clubNm;
}

@end
