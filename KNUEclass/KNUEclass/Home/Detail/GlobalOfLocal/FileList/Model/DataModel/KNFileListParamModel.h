//
//  KNFileListModel.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 18..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNXmlParser.h"

@interface KNFileListParamModel : NSObject

@property (nonatomic, strong) NSString *clubId, *noteSeq, *workSeq;
@property (nonatomic) ParsingType parsingType;

@end 
