//
//  KNALectureModel.h
//  KNUEclass
//
//  Created by user on 2018. 3. 8..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNALectureModel : NSObject

@property (nonatomic, strong) NSString *clubNm, *clubId;

- (void)setClubId:(NSString *)clubId withClubNm:(NSString *)clubNm;

@end
