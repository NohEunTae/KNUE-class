//
//  KNRecentTableViewAdapter.m
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNRecentTableViewAdapter.h"
#import "KNPublicCustomTableViewCell.h"
#import "KNParentHomeModel.h"
#import "KNParentNaviController.h"
#import "KNRecentViewController.h"
#import "KNNoticeDetailViewController.h"
#import "KNNoteDetailViewController.h"
#import "KNNoticeModel.h"
#import "KNNoticeDetailModel.h"
#import "KNNoteModel.h"
#import "KNNoteDetailModel.h"
#import "KNHomeworkModel.h"
#import "KNHomeworkDetailViewController.h"

@interface KNRecentTableViewAdapter () <KNXmlParserDelegate>

@property (nonatomic, strong) NSMutableArray<KNParentHomeModel *> *noticeList, *noteList, *hwList;
@property (nonatomic, strong) KNParentHomeModel *noDataSet;
@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, strong) KNXmlParser *xmlParser;

@end

@implementation KNRecentTableViewAdapter

- (instancetype)init {
    self = [super init];
    if(self) {
        _keys = [[NSMutableArray alloc] initWithObjects:@"공지사항", @"강의노트", @"새 과제", nil];
        _xmlParser = [[KNXmlParser alloc] init];
        _noticeList = [[NSMutableArray alloc] init];
        _noteList = [[NSMutableArray alloc] init];
        _hwList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            KNNoticeDetailViewController *noticeDetailVC = [[KNNoticeDetailViewController alloc] init];
            KNNoticeModel *temp = (KNNoticeModel *)[self.noticeList objectAtIndex:indexPath.row];
            [noticeDetailVC.noticeDetailModel setNoteSeq:temp.noteSeq withClubId:temp.clubId];
            [[KNParentNaviController sharedInstance] pushViewController:noticeDetailVC animated:YES];
            break;
        }
        case 1: {
            KNNoteDetailViewController *noteDetailVC = [[KNNoteDetailViewController alloc] init];
            KNNoteModel *temp = (KNNoteModel *)[self.noteList objectAtIndex:indexPath.row];
            [noteDetailVC.noteDetailModel setNoteSeq:temp.noteSeq withClubId:temp.clubId withClubNm:temp.clubNm];
            [[KNParentNaviController sharedInstance] pushViewController:noteDetailVC animated:YES];
            break;
        }
        case 2: {
            KNHomeworkDetailViewController *homeworkDetailVC = [[KNHomeworkDetailViewController alloc] init];
            KNHomeworkModel *temp = (KNHomeworkModel *)[self.hwList objectAtIndex:indexPath.row];
            homeworkDetailVC.homeworkDetailModel = temp;
            [[KNParentNaviController sharedInstance] pushViewController:homeworkDetailVC animated:YES];
            break;
        }
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            return [self.noticeList count];
        }
        case 1: {
            return [self.noteList count];
        }
        case 2: {
            return [self.hwList count];
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.keys count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.keys objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KNPublicCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newRise" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[KNPublicCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newRise"];
    }
    
    switch (indexPath.section) {
        case 0: {
            KNNoticeModel *noticeModel = (KNNoticeModel *)[self.noticeList objectAtIndex:indexPath.row];
            if(![noticeModel.mainContent isEqualToString:@"데이터가 없습니다."]) {
                NSRange needRange = NSMakeRange([noticeModel.title rangeOfString:@"["].location + 1, [noticeModel.title rangeOfString:@"]"].location - 1);
                noticeModel.clubNm = [noticeModel.title substringWithRange:needRange];
            }

            [[self.noticeList objectAtIndex:indexPath.row] setMainContentAndSubContent];
            [cell modifyTitleLabel:[self.noticeList objectAtIndex:indexPath.row].mainContent
                     withContLabel:[self.noticeList objectAtIndex:indexPath.row].subContent];
            break;
        }
        case 1: {
            [[self.noteList objectAtIndex:indexPath.row] setMainContentAndSubContent];
            [cell modifyTitleLabel:[self.noteList objectAtIndex:indexPath.row].mainContent
                     withContLabel:[self.noteList objectAtIndex:indexPath.row].subContent];
            break;
        }
        case 2: {
            [[self.hwList objectAtIndex:indexPath.row] setMainContentAndSubContent];
            [cell modifyTitleLabel:[self.hwList objectAtIndex:indexPath.row].mainContent
                     withContLabel:[self.hwList objectAtIndex:indexPath.row].subContent];
            break;
        }
        default:
            break;
    }
    [self setNoDataSetWithCell:cell];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:20]];
    [label setTextColor:[UIColor colorWithRed:81.0f/255.0f green:128.0f/255.0f blue:1.0f alpha:1.0f]];
    NSString *string =[self.keys objectAtIndex:section];
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:81.0f/255.0f green:128.0f/255.0f blue:1.0f alpha:0.05f]];
    
    return view;
}

- (void)setNoDataSetWithCell:(KNPublicCustomTableViewCell *)noDataSetCell {
    noDataSetCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if([[noDataSetCell titlaLabelText] isEqualToString:@"데이터가 없습니다."]) {
        noDataSetCell.userInteractionEnabled = NO;
    } else {
        noDataSetCell.userInteractionEnabled = YES;
    }
}

#pragma mark Parsing Recent Data

- (void)parsingRecentData:(id)data withParsingType:(ParsingType)parsingType {
    NSLog(@"[info] start parsing : .... %@", [self.keys objectAtIndex:parsingType]);
    self.xmlParser.delegate = self;
    [self.xmlParser startParsingWithData:data withParsingType:parsingType];
}

- (void)parsingDidFinishedWithParsingType:(ParsingType)parsingType withParsingList:(id)parsingList {
    switch (parsingType) {
        case PTnotice: {
            self.noticeList = parsingList;
            if([self.noticeList count] == 0) {
                self.noDataSet = [[KNParentHomeModel alloc] init];
                [self.noDataSet setMainContentAndSubContent];
                self.noticeList = [[NSMutableArray alloc] initWithObjects:self.noDataSet, nil];
            }
            NSLog(@"[info] notice parsing finished");
            break;
        }
        case PTnote: {
            self.noteList = parsingList;
            if([self.noteList count] == 0) {
                self.noDataSet = [[KNParentHomeModel alloc] init];
                [self.noDataSet setMainContentAndSubContent];
                self.noteList = [[NSMutableArray alloc] initWithObjects:self.noDataSet, nil];
            }
            NSLog(@"[info] note parsing finished");
            break;
        }
        case PThomework: {
            self.hwList = parsingList;
            if([self.hwList count] == 0) {
                self.noDataSet = [[KNParentHomeModel alloc] init];
                [self.noDataSet setMainContentAndSubContent];
                self.hwList = [[NSMutableArray alloc] initWithObjects:self.noDataSet, nil];
            }
            NSLog(@"[info] homework parsing finished");
            break;
        }
        case PTLoginSessionHasExpired: {
            [self.recentVC connectLoginSessionAndReloadView];
            break;
        }
        default:
            break;
    }
}

@end
