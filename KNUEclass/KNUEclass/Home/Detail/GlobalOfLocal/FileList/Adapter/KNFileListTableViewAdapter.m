//
//  KNFileListTableViewAdapter.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 18..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNFileListTableViewAdapter.h"
#import "KNFileListModel.h"
#import "KNPublicCustomTableViewCell.h"
#import "KNFileStoreAndViewerModel.h"
#import "KNFileListViewController.h"

@interface KNFileListTableViewAdapter () <KNXmlParserDelegate>

@property (nonatomic, strong) KNXmlParser *xmlParser;
@property (nonatomic, strong) NSMutableArray <KNFileListModel*> *fileListModel;

@end

@implementation KNFileListTableViewAdapter

- (instancetype)init {
    self = [super init];
    if(self) {
        _xmlParser = [[KNXmlParser alloc] init];
        _fileListModel = [[NSMutableArray alloc] init];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KNPublicCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fileList" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell == nil) {
        cell = [[KNPublicCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fileList"];
    }
    [[self.fileListModel objectAtIndex:indexPath.row] setMainContentAndSubContent];
    [cell modifyTitleLabel:[self.fileListModel objectAtIndex:indexPath.row].mainContent
             withContLabel:[self.fileListModel objectAtIndex:indexPath.row].subContent];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fileListModel count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KNFileStoreAndViewerModel *fileManager = [[KNFileStoreAndViewerModel alloc] init];
    NSString *url = [NSString stringWithFormat:@"http://eclass.kangnam.ac.kr/eclass/board/findBoard.action?taskId=FILE_DOWN&fileSeq=%@",[self.fileListModel objectAtIndex:indexPath.row].fileSeq];
    [fileManager fileStoreOnDeviceAndViewerOpenWithUrl:url withFileName:[self.fileListModel objectAtIndex:indexPath.row].regiFileNm withCurrentViewController:[self.delegate getViewController]];
}

#pragma mark Parsing File List Data

- (void)parsingFileListData:(id)data withParsingType:(ParsingType)parsingType {
    self.xmlParser.delegate = self;
    [self.xmlParser startParsingWithData:data withParsingType:parsingType];
}

- (void)parsingDidFinishedWithParsingType:(ParsingType)parsingType withParsingList:(id)parsingList {
    switch (parsingType) {
        case PTLoginSessionHasExpired: {
            [self.fileListVC connectLoginSessionAndReloadView];
            break;
        }
        default: {
            self.fileListModel = parsingList;
            break;
        }
    }
}

@end
