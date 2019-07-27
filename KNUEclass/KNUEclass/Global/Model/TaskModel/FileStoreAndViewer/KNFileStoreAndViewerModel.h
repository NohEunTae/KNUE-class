//
//  KNFileStoreAndViewerModel.h
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 3..
//  Copyright © 2018년 hwanny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNFileStoreAndViewerModel : NSObject

- (void)fileStoreOnDeviceAndViewerOpenWithUrl:(NSString *)url withFileName:(NSString *)fileName withCurrentViewController:(UIViewController *)viewController;
- (void)fileViewerFromDeviceWithPath:(NSString *)path withCurrentViewController:(UIViewController *)viewController;

@end

