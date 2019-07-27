//
//  KNLectureListTableViewAdapter.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNLectureListTableViewAdapter.h"
#import "KNPublicCustomTableViewCell.h"
#import "KNLectureListViewController.h"
#import "KNLectureListModel.h"
#import "KNALectureTabBarController.h"
#import "KNALectureNoticeViewController.h"
#import "KNALectureNoteViewController.h"
#import "KNALectureHomeworkViewController.h"
#import "KNParentNaviController.h"
#import "KNALectureNoticeNaviController.h"
#import "KNALectureNoteNaviController.h"
#import "KNALectureHomeworkNaviController.h"
#import "KNNoDataView.h"
#import "KNALectureModel.h"
#import "KNLectureListViewController.h"

@interface KNLectureListTableViewAdapter () <KNXmlParserDelegate>

@property (nonatomic, strong) NSMutableArray<KNLectureListModel *> *lectureList;
@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, strong) KNXmlParser *xmlParser;

@end

@implementation KNLectureListTableViewAdapter

- (instancetype)init {
    self = [super init];
    if(self) {
        _keys = [[NSMutableArray alloc] initWithObjects:@"수강현황", nil];
        _xmlParser = [[KNXmlParser alloc] init];
        _lectureList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.lectureList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KNALectureTabBarController *tabBarController = [[KNALectureTabBarController alloc] init];
    tabBarController.navigationItem.title = [self.lectureList objectAtIndex:indexPath.row].clubNm;

    KNALectureNoticeViewController *aLectureNoticeV = [[KNALectureNoticeViewController alloc] init];
    [aLectureNoticeV.aLectureNoticeModel setClubId:[self.lectureList objectAtIndex:indexPath.row].clubId withClubNm:[self.lectureList objectAtIndex:indexPath.row].clubNm];
    
    KNALectureNoteViewController *aLectureNoteV = [[KNALectureNoteViewController alloc] init];
    [aLectureNoteV.aLectureNoteModel setClubId:[self.lectureList objectAtIndex:indexPath.row].clubId withClubNm:[self.lectureList objectAtIndex:indexPath.row].clubNm];
    
    KNALectureHomeworkViewController *aLectureHomeworkV = [[KNALectureHomeworkViewController alloc] init];
    [aLectureHomeworkV.aLectureHwModel setClubId:[self.lectureList objectAtIndex:indexPath.row].clubId withClubNm:[self.lectureList objectAtIndex:indexPath.row].clubNm];
    
    [tabBarController setLectureListTabBarWithNoticeVC:aLectureNoticeV
                                            withNoteVC:aLectureNoteV
                                              withHwVC:aLectureHomeworkV];

    [[KNParentNaviController sharedInstance] pushViewController:tabBarController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KNPublicCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lectureList" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell == nil) {
        cell = [[KNPublicCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lectureList"];
    }
    [[self.lectureList objectAtIndex:indexPath.row] setMainContentAndSubContent];
    [cell modifyTitleLabel:[self.lectureList objectAtIndex:indexPath.row].mainContent
             withContLabel:[self.lectureList objectAtIndex:indexPath.row].subContent];
    return cell;
}

#pragma mark Lecture List Parsing Process

- (void)parsingLectureListData:(id)data withParsingType:(ParsingType)parsingType {
    self.xmlParser.delegate = self;
    [self.xmlParser startParsingWithData:data withParsingType:parsingType];
}

- (void)parsingDidFinishedWithParsingType:(ParsingType)parsingType withParsingList:(id)parsingList {
    switch (parsingType) {
        case PTlectureList: {
            if([parsingList count] > 0) {
                self.lectureList = parsingList;
            } else {
                KNNoDataView *noDataView = [[KNNoDataView alloc] initWithFrame:self.view.frame withMsg:@"수강하고 계신 강의의 데이터가 존재하지 않습니다."];
                [self.view addSubview: noDataView];
            }
            break;
        }
        case PTLoginSessionHasExpired: {
            [self.lectureListVC connectLoginSessionAndReloadView];
            break;
        }
        default:
            break;
    }
}

@end
