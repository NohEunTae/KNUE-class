//
//  KNFileStoreAndViewerModel.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 3..
//  Copyright © 2018년 hwanny. All rights reserved.
//

#import "KNFileStoreAndViewerModel.h"
#import "KNIndicator.h"
#import "KNParentNaviController.h"

@interface KNFileStoreAndViewerModel () <UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) NSArray *paths;
@property (nonatomic, strong) NSString *fileName, *path;
@property (nonatomic, weak) UINavigationController *nav;
@property (nonatomic, strong) UIDocumentInteractionController *doc;
@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation KNFileStoreAndViewerModel

#pragma mark store file and view

- (void)fileStoreOnDeviceAndViewerOpenWithUrl:(NSString *)url withFileName:(NSString *)fileName withCurrentViewController:(UIViewController *)viewController {
    self.fileName = fileName;
    self.viewController = viewController;
    NSLog(@"file name : %@", fileName);
    NSRange range = NSMakeRange([fileName rangeOfString:@"."].location + 1, [fileName length] - [fileName rangeOfString:@"."].location - 1);
    NSString *extention = [fileName substringWithRange:range];

    NSData *urlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    if (urlData) {
        self.paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES);
        NSString *documentsDirectory = [self.paths objectAtIndex:0];
        self.path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", self.fileName]];
        [urlData writeToFile:self.path atomically:YES];
        
        self.nav = viewController.navigationController;
        self.doc = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:self.path]];
        [self.doc setDelegate:self];
        NSLog(@"%@", self.doc.UTI);
        dispatch_async(dispatch_get_main_queue(), ^{
            if(![extention isEqualToString:@"pdf"] && ![extention isEqualToString:@"ppt"] && ![extention isEqualToString:@"pptx"]) {
                [self exportFileToAthoerApplicationWithViewController:viewController];
            } else {
                [self.doc presentPreviewAnimated:YES];
            }
        });
    } else {
        NSLog(@"파일 다운로드 오류");
    }
}

- (void)fileViewerFromDeviceWithPath:(NSString *)path withCurrentViewController:(UIViewController *)viewController {
    self.path = path;
    NSRange range = NSMakeRange([path rangeOfString:@"."].location + 1, [path length] - [path rangeOfString:@"."].location - 1);
    NSString *extention = [path substringWithRange:range];

    self.viewController = viewController;
    self.nav = viewController.navigationController;
    self.doc = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:self.path]];
    self.doc.delegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(![extention isEqualToString:@"pdf"] && ![extention isEqualToString:@"ppt"] && ![extention isEqualToString:@"pptx"]) {
            [self exportFileToAthoerApplicationWithViewController:viewController];
        }
        else {
            [self.doc presentPreviewAnimated:YES];
        }
    });
    
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self.nav;
}


- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller {
    return self.viewController.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller {
    return self.viewController.view.frame;
}

- (void)exportFileToAthoerApplicationWithViewController:(UIViewController *)viewController {
    NSArray *activityItems = @[[NSURL fileURLWithPath:self.path]];
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                      applicationActivities:nil];
    [activityViewController setCompletionWithItemsHandler:^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }];
    [viewController presentViewController:activityViewController
                                 animated:YES
                               completion:nil];

}

@end

