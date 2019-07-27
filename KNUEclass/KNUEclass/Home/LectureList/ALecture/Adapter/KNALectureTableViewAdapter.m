//
//  KNALectureTableViewAdapter.m
//  KNUEclass
//
//  Created by 권재환 on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNALectureTableViewAdapter.h"
#import "KNPublicCustomTableViewCell.h"
#import "KNParentNaviController.h"
#import "KNNoticeModel.h"
#import "KNNoteModel.h"
#import "KNHomeworkModel.h"
#import "KNNoticeDetailViewController.h"
#import "KNNoticeDetailModel.h"
#import "KNHomeworkDetailViewController.h"
#import "KNNoteDetailViewController.h"
#import "KNNoteDetailModel.h"
#import "KNALectureTableView.h"
#import "KNALectureNoticeViewController.h"
#import "KNALectureNoteViewController.h"
#import "KNALectureHomeworkViewController.h"

@interface KNALectureTableViewAdapter () <KNXmlParserDelegate>

@property (nonatomic, strong) NSMutableArray<KNNoticeModel *> *aNotice;
@property (nonatomic, strong) NSMutableArray<KNNoteModel *> *aNote;
@property (nonatomic, strong) NSMutableArray<KNHomeworkModel *> *aHomework;
@property (nonatomic, strong) KNXmlParser *xmlParser;
@property (nonatomic) ParsingType identifier;

@end

@implementation KNALectureTableViewAdapter

- (instancetype)initWithIdentifier:(ParsingType)identifier {
    self = [super init];
    if(self) {
        _xmlParser = [[KNXmlParser alloc] init];
        _identifier = identifier;
        switch (identifier) {
            case PTnotice:
                _aNotice = [[NSMutableArray alloc] init];
                break;
            case PTnote:
                _aNote = [[NSMutableArray alloc] init];
                break;
            case PThomework:
                _aHomework = [[NSMutableArray alloc] init];
                break;
            default:
                break;
        }
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.identifier) {
        case PTnotice:
            return [self.aNotice count];
            break;
        case PTnote:
            return [self.aNote count];
            break;
        case PThomework:
            return [self.aHomework count];
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KNPublicCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aLecture" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell == nil) {
        cell = [[KNPublicCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aLecture"];
    }
    switch (self.identifier) {
        case PTnotice: {
            [self.aNotice objectAtIndex:indexPath.row].clubNm = self.delegate.clubNm;
            [[self.aNotice objectAtIndex:indexPath.row] setMainContentAndSubContent];
            [cell modifyTitleLabel:[self.aNotice objectAtIndex:indexPath.row].mainContent
                     withContLabel:[self.aNotice objectAtIndex:indexPath.row].subContent];
            break;
        }
        case PTnote: {
            [[self.aNote objectAtIndex:indexPath.row] setMainContentAndSubContent];
            [cell modifyTitleLabel:[self.aNote objectAtIndex:indexPath.row].mainContent
                     withContLabel:[self.aNote objectAtIndex:indexPath.row].subContent];
            break;
        }
        case PThomework: {
            [self.aHomework objectAtIndex:indexPath.row].clubNm = self.delegate.clubNm;
            [[self.aHomework objectAtIndex:indexPath.row] setMainContentAndSubContent];
            [cell modifyTitleLabel:[self.aHomework objectAtIndex:indexPath.row].mainContent
                     withContLabel:[self.aHomework objectAtIndex:indexPath.row].subContent];
            break;
        }
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.identifier) {
        case PTnotice:{
            KNNoticeDetailViewController *noticeDetailVC = [[KNNoticeDetailViewController alloc] init];
            KNNoticeModel *temp = (KNNoticeModel *)[self.aNotice objectAtIndex:indexPath.row];
            [noticeDetailVC.noticeDetailModel setNoteSeq:temp.noteSeq withClubId:temp.clubId];
            [[KNParentNaviController sharedInstance] pushViewController:noticeDetailVC animated:YES];
            break;
        }
        case PTnote: {
            KNNoteDetailViewController *noteDetailVC = [[KNNoteDetailViewController alloc] init];
            KNNoteModel *temp = (KNNoteModel *)[self.aNote objectAtIndex:indexPath.row];
            [noteDetailVC.noteDetailModel setNoteSeq:temp.noteSeq withClubId:temp.clubId withClubNm:temp.clubNm];
            [[KNParentNaviController sharedInstance] pushViewController:noteDetailVC animated:YES];
            break;
        }
        case PThomework: {
            KNHomeworkDetailViewController *homeworkDetailVC = [[KNHomeworkDetailViewController alloc] init];
            KNHomeworkModel *temp = (KNHomeworkModel *)[self.aHomework objectAtIndex:indexPath.row];
            homeworkDetailVC.homeworkDetailModel = temp;
            [[KNParentNaviController sharedInstance] pushViewController:homeworkDetailVC animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark Parsing Lecture List Data

- (void)parsingLectureListData:(id)data withParsingType:(ParsingType)parsingType {
    self.xmlParser.delegate = self;
    [self.xmlParser startParsingWithData:data withParsingType:parsingType];
}

- (void)parsingDidFinishedWithParsingType:(ParsingType)parsingType withParsingList:(id)parsingList {
    switch (parsingType) {
        case PTnotice: {
            if([parsingList count] < 1) {
                NSString *noDataMsg = @"공지사항 데이터가 존재하지 않습니다.";
                [self.addNoDataViewDelegate addSubViewWithNoDataMsg:noDataMsg];
            } else
                self.aNotice = parsingList;
            break;
        } case PTnote: {
            if([parsingList count] < 1) {
                NSString *noDataMsg = @"강의노트 데이터가 존재하지 않습니다.";
                [self.addNoDataViewDelegate addSubViewWithNoDataMsg:noDataMsg];
            } else {
                self.aNote = parsingList;
            }
            break;
        } case PThomework: {
            if([parsingList count] < 1) {
                NSString *noDataMsg = @"과제 데이터가 존재하지 않습니다.";
                [self.addNoDataViewDelegate addSubViewWithNoDataMsg:noDataMsg];
            } else {
                self.aHomework = parsingList;
            }
            break;
        } case PTLoginSessionHasExpired: {
            switch (self.identifier) {
                case PTnotice: {
                    KNALectureNoticeViewController *aNoticeVC = (KNALectureNoticeViewController *)self.aLectureVC;
                    [aNoticeVC connectLoginSessionAndReloadView];
                } case PTnote: {
                    KNALectureNoteViewController *aNoteVC = (KNALectureNoteViewController *)self.aLectureVC;
                    [aNoteVC connectLoginSessionAndReloadView];
                } case PThomework: {
                    KNALectureHomeworkViewController *aHwVC = (KNALectureHomeworkViewController *)self.aLectureVC;
                    [aHwVC connectLoginSessionAndReloadView];
                }
                default:
                    break;
            }
        }
        default:
            break;
    }
}

@end
