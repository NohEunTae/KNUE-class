//
//  KNALectureNoteViewController.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNParentViewController.h"

@class KNALectureModel;

@interface KNALectureNoteViewController : KNParentViewController

@property (nonatomic, strong) KNALectureModel *aLectureNoteModel;

- (void)connectLoginSessionAndReloadView;

@end
