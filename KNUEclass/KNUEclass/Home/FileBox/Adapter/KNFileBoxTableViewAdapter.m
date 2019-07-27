//
//  KNFileBoxTableViewAdapter.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 21..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNFileBoxTableViewAdapter.h"
#import "KNPublicCustomTableViewCell.h"
#import "KNFileBoxModel.h"
#import "KNFileStoreAndViewerModel.h"

@interface KNFileBoxTableViewAdapter () <UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) NSMutableArray <KNFileBoxModel *> *fileModels;

@end

#pragma mark File Box Table View Adapter

@implementation KNFileBoxTableViewAdapter

- (instancetype)init {
    self = [super init];
    if(self){
        self.fileModels =  [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fileModels count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KNFileStoreAndViewerModel *fileManager = [[KNFileStoreAndViewerModel alloc] init];
    NSString *path = [self.fileModels objectAtIndex:indexPath.row].filePath;
    [fileManager fileViewerFromDeviceWithPath:path withCurrentViewController:self.viewController];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KNPublicCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fileBox" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell == nil) {
        cell = [[KNPublicCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fileBox"];
    }
    [cell modifyTitleLabel:[self.fileModels objectAtIndex:indexPath.row].fileName
             withContLabel:[self.fileModels objectAtIndex:indexPath.row].fileSize];
    return cell;
}

#pragma mark File Box Setting

- (void)setFileBoxData {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSURL *tempDirURL = [NSURL fileURLWithPath:documentsDirectory];
    NSArray *directoryList = [fileManager contentsOfDirectoryAtURL:tempDirURL
                                        includingPropertiesForKeys:nil
                                                           options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    for(int fileIndex = 0 ; fileIndex < [directoryList count]; fileIndex++) {
        KNFileBoxModel *fileModel = [[KNFileBoxModel alloc] init];
        NSString *path = [[directoryList objectAtIndex:fileIndex] absoluteString];
        path = [path stringByRemovingPercentEncoding];
        NSRange range = [path rangeOfString:@"/Documents"];
        NSString *name;
        if (range.location == NSNotFound) {
            NSLog(@"[Erorr] 파일함에 파일명 추출 에러");
        } else {
            name = [path substringFromIndex:range.location + range.length + 1];
        }
        fileModel.filePath = [path substringFromIndex:7];
        fileModel.fileName = name;
        float fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:fileModel.filePath error:nil] fileSize];
        fileModel.fileSize = [NSString stringWithFormat:@"%.02f MB",((fileSize / 1024) / 1024)];
        [self.fileModels addObject:fileModel];
    }
    NSLog(@"[Info] Get file list complete");
    if([self.fileModels count] == 0) {
        NSString *noDataString = @"파일함이 비어있습니다.";
        [self.delegate addSubViewWithNoDataMsg:noDataString];
    }
}

@end
