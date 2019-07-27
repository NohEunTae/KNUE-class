//
//  KNXmlParser.m
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNXmlParser.h"
#import "KNNoticeModel.h"
#import "KNNoteModel.h"
#import "KNHomeworkModel.h"
#import "KNLectureListModel.h"
#import "KNNoticeDetailModel.h"
#import "KNNoteDetailModel.h"
#import "KNFileListModel.h"
#import "KNLoginManager.h"
#import "KNKeychainManager.h"

@interface KNXmlParser ()

@end

@implementation KNXmlParser

#pragma mark Start Parsing

- (void)startParsingWithData:(id)data withParsingType:(ParsingType)parsingType {
    NSString *xmlData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    TBXML *tbxml = [[TBXML alloc] initWithXMLString:xmlData error:nil];
    TBXMLElement *elemRoot = tbxml.rootXMLElement;
    if(elemRoot) {
        switch (parsingType) {
            case PTnotice:
                [self parsingXMLdataToNoticeModelWithRootElement:elemRoot];
                break;
            case PTnote:
                [self parsingXMLdataToNoteModelWithRootElement:elemRoot];
                break;
            case PThomework:
                [self parsingXMLdataToHwModelWithRootElement:elemRoot];
                break;
            case PTlectureList:
                [self parsingXMLdataToLectureListModelWithRootElement:elemRoot];
                break;
            case PTnoticeDetail:
                [self parsingXMLdataToNoticeDetailModelWithRootElement:elemRoot];
                break;
            case PTnoteDetail:
                [self parsingXMLdataToNoteDetailModelWithRootElement:elemRoot];
                break;
            case PTnoticeAndNoteFileList:
            case PThomeworkFileList:
                [self parsingXMLdataToFileListModelWithRootElement:elemRoot];
                break;
            default:
                break;
        }
    }
}

#pragma mark Parsing With Parsing Type

- (void)parsingXMLdataToNoticeModelWithRootElement:(TBXMLElement *)elemRoot {
    NSMutableArray<KNNoticeModel *> *parsingList = [[NSMutableArray alloc] init];
    TBXMLElement *eleRecord = nil, *eleDataSet = nil;
    if(elemRoot && elemRoot->firstChild) {
        if([TBXML childElementNamed:@"params" parentElement:elemRoot]) {
            NSLog(@"[info] Login session has expired");
            [self.delegate parsingDidFinishedWithParsingType:PTLoginSessionHasExpired withParsingList:nil];
        }
        else {
            eleDataSet = [TBXML childElementNamed:@"dataset" parentElement:elemRoot];
            if(eleDataSet->firstChild) {
                eleRecord = [TBXML childElementNamed:@"record" parentElement:eleDataSet];
                do {
                    if(eleRecord->firstChild) {
                        KNNoticeModel *oneNoticeData = [[KNNoticeModel alloc] init];
                        oneNoticeData.title = [TBXML textForElement:[TBXML childElementNamed:@"title" parentElement:eleRecord]];
                        oneNoticeData.clubId = [TBXML textForElement:[TBXML childElementNamed:@"clubId" parentElement:eleRecord]];
                        oneNoticeData.noteSeq = [TBXML textForElement:[TBXML childElementNamed:@"noteSeq" parentElement:eleRecord]];
                        oneNoticeData.regiDttm = [TBXML textForElement:[TBXML childElementNamed:@"regiDttm" parentElement:eleRecord]];
                        [parsingList addObject:oneNoticeData];
                    }
                } while ((eleRecord = eleRecord->nextSibling));
                [self.delegate parsingDidFinishedWithParsingType:PTnotice withParsingList:parsingList];
            } else {
                [self.delegate parsingDidFinishedWithParsingType:PTnotice withParsingList:parsingList];
            }
        }
    }
}

- (void)parsingXMLdataToNoteModelWithRootElement:(TBXMLElement *)elemRoot {
    NSMutableArray<KNNoteModel *> *parsingList = [[NSMutableArray alloc] init];
    TBXMLElement *eleRecord = nil, *eleDataSet = nil;
    if(elemRoot && elemRoot->firstChild) {
        if([TBXML childElementNamed:@"params" parentElement:elemRoot]) {
            NSLog(@"Login session has expired");
            [self.delegate parsingDidFinishedWithParsingType:PTLoginSessionHasExpired withParsingList:nil];
        } else {
            eleDataSet = [TBXML childElementNamed:@"dataset" parentElement:elemRoot];
            if(eleDataSet->firstChild) {
                eleRecord = [TBXML childElementNamed:@"record" parentElement:eleDataSet];
                do {
                    if(eleRecord->firstChild) {
                        KNNoteModel *oneNoteData = [[KNNoteModel alloc] init];
                        oneNoteData.title = [TBXML textForElement:[TBXML childElementNamed:@"title" parentElement:eleRecord]];
                        oneNoteData.clubId = [TBXML textForElement:[TBXML childElementNamed:@"clubId" parentElement:eleRecord]];
                        oneNoteData.clubNm = [TBXML textForElement:[TBXML childElementNamed:@"clubNm" parentElement:eleRecord]];
                        oneNoteData.noteSeq = [TBXML textForElement:[TBXML childElementNamed:@"noteSeq" parentElement:eleRecord]];
                        oneNoteData.fileYn = [TBXML textForElement:[TBXML childElementNamed:@"fileYn" parentElement:eleRecord]];
                        oneNoteData.openStDt = [TBXML textForElement:[TBXML childElementNamed:@"openStDt" parentElement:eleRecord]];
                        [parsingList addObject:oneNoteData];
                    }
                } while ((eleRecord = eleRecord->nextSibling));
                [self.delegate parsingDidFinishedWithParsingType:PTnote withParsingList:parsingList];
            } else {
                [self.delegate parsingDidFinishedWithParsingType:PTnote withParsingList:parsingList];
            }
        }
    }
}

- (void)parsingXMLdataToHwModelWithRootElement:(TBXMLElement *)elemRoot {
    NSMutableArray<KNHomeworkModel *> *parsingList = [[NSMutableArray alloc] init];
    TBXMLElement *eleRecord = nil, *eleDataSet = nil;
    if(elemRoot && elemRoot->firstChild) {
        if([TBXML childElementNamed:@"params" parentElement:elemRoot]) {
            NSLog(@"Login session has expired");
            [self.delegate parsingDidFinishedWithParsingType:PTLoginSessionHasExpired withParsingList:nil];
        } else {
            eleDataSet = [TBXML childElementNamed:@"dataset" parentElement:elemRoot];
            if(eleDataSet->firstChild) {
                eleRecord = [TBXML childElementNamed:@"record" parentElement:eleDataSet];
                do {
                    if(eleRecord->firstChild) {
                        KNHomeworkModel *oneHwData = [[KNHomeworkModel alloc] init];
                        oneHwData.workTitle = [TBXML textForElement:[TBXML childElementNamed:@"workTitle" parentElement:eleRecord]];
                        oneHwData.workSeq = [TBXML textForElement:[TBXML childElementNamed:@"workSeq" parentElement:eleRecord]];
                        oneHwData.workCont = [TBXML textForElement:[TBXML childElementNamed:@"workCont" parentElement:eleRecord]];
                        oneHwData.workEdDt = [TBXML textForElement:[TBXML childElementNamed:@"workEdDt" parentElement:eleRecord]];
                        oneHwData.workStDt = [TBXML textForElement:[TBXML childElementNamed:@"workStDt" parentElement:eleRecord]];
                        oneHwData.workAttcYn = [TBXML textForElement:[TBXML childElementNamed:@"workAttcYn" parentElement:eleRecord]];
                        oneHwData.sbmtYn = [TBXML textForElement:[TBXML childElementNamed:@"sbmtYn"
                            parentElement:eleRecord]];
                        oneHwData.clubId = [TBXML textForElement:[TBXML childElementNamed:@"clubId" parentElement:eleRecord]];
                        if([TBXML childElementNamed:@"clubNm" parentElement:eleRecord]) {
                            oneHwData.clubNm = [TBXML textForElement:[TBXML childElementNamed:@"clubNm" parentElement:eleRecord]];
                        }
                        
                        [parsingList addObject:oneHwData];
                    }
                } while ((eleRecord = eleRecord->nextSibling));
                [self.delegate parsingDidFinishedWithParsingType:PThomework withParsingList:parsingList];
            } else {
                [self.delegate parsingDidFinishedWithParsingType:PThomework withParsingList:parsingList];
            }
        }
    }
}

- (void)parsingXMLdataToLectureListModelWithRootElement:(TBXMLElement *)elemRoot {
    NSMutableArray<KNLectureListModel *> *parsingList = [[NSMutableArray alloc] init];
    TBXMLElement *eleRecord = nil, *eleDataSet = nil;
    if(elemRoot && elemRoot->firstChild) {
        if([TBXML childElementNamed:@"params" parentElement:elemRoot]) {
            NSLog(@"Login session has expired");
            [self.delegate parsingDidFinishedWithParsingType:PTLoginSessionHasExpired withParsingList:nil];
        } else {
            eleDataSet = [TBXML childElementNamed:@"dataset" parentElement:elemRoot];
            if(eleDataSet->firstChild) {
                eleRecord = [TBXML childElementNamed:@"record" parentElement:eleDataSet];
                do {
                    if(eleRecord->firstChild) {
                        KNLectureListModel *lectureListData = [[KNLectureListModel alloc] init];
                        lectureListData.clubNm = [TBXML textForElement:[TBXML childElementNamed:@"clubNm" parentElement:eleRecord]];
                        lectureListData.clubId = [TBXML textForElement:[TBXML childElementNamed:@"clubId" parentElement:eleRecord]];
                        [parsingList addObject:lectureListData];
                    }
                } while ((eleRecord = eleRecord->nextSibling));
                [self.delegate parsingDidFinishedWithParsingType:PTlectureList withParsingList:parsingList];
            } else {
                [self.delegate parsingDidFinishedWithParsingType:PTlectureList withParsingList:parsingList];
            }
        }
    }
}

- (void)parsingXMLdataToNoticeDetailModelWithRootElement:(TBXMLElement *)elemRoot {
    TBXMLElement *eleRecord = nil, *eleDataSet = nil;
    if(elemRoot && elemRoot->firstChild) {
        if([TBXML childElementNamed:@"params" parentElement:elemRoot]) {
            NSLog(@"Login session has expired");
            [self.delegate parsingDidFinishedWithParsingType:PTLoginSessionHasExpired withParsingList:nil];
        } else {
            eleDataSet = [TBXML childElementNamed:@"dataset" parentElement:elemRoot];
            if(eleDataSet->firstChild) {
                eleRecord = [TBXML childElementNamed:@"record" parentElement:eleDataSet];
                if(eleRecord->firstChild) {
                    KNNoticeDetailModel *noticeDetailData = [[KNNoticeDetailModel alloc] init];
                    noticeDetailData.title = [TBXML textForElement:[TBXML childElementNamed:@"title" parentElement:eleRecord]];
                    noticeDetailData.clubId = [TBXML textForElement:[TBXML childElementNamed:@"clubId" parentElement:eleRecord]];
                    noticeDetailData.noteSeq = [TBXML textForElement:[TBXML childElementNamed:@"noteSeq" parentElement:eleRecord]];
                    noticeDetailData.noteCont = [TBXML textForElement:[TBXML childElementNamed:@"noteCont" parentElement:eleRecord]];
                    noticeDetailData.nickNm = [TBXML textForElement:[TBXML childElementNamed:@"nickNm" parentElement:eleRecord]];
                    noticeDetailData.regiDttm = [TBXML textForElement:[TBXML childElementNamed:@"regiDttm" parentElement:eleRecord]];
                    noticeDetailData.readCnt = [TBXML textForElement:[TBXML childElementNamed:@"readCnt" parentElement:eleRecord]];
                    noticeDetailData.fileYn = [TBXML textForElement:[TBXML childElementNamed:@"fileYn" parentElement:eleRecord]];
                    
                    [self.delegate parsingDidFinishedWithParsingType:PTnoticeDetail withParsingList:noticeDetailData];
                }
            }
        }
    }
}

- (void)parsingXMLdataToNoteDetailModelWithRootElement:(TBXMLElement *)elemRoot {
    TBXMLElement *eleRecord = nil, *eleDataSet = nil;
    if(elemRoot && elemRoot->firstChild) {
        if([TBXML childElementNamed:@"params" parentElement:elemRoot]) {
            NSLog(@"Login session has expired");
            [self.delegate parsingDidFinishedWithParsingType:PTLoginSessionHasExpired withParsingList:nil];
        } else {
            eleDataSet = [TBXML childElementNamed:@"dataset" parentElement:elemRoot];
            KNNoteDetailModel *noteDetailData = [[KNNoteDetailModel alloc] init];
            if(eleDataSet->firstChild) {
                eleRecord = [TBXML childElementNamed:@"record" parentElement:eleDataSet];
                noteDetailData.clubId = [TBXML textForElement:[TBXML childElementNamed:@"clubId" parentElement:eleRecord]];
                noteDetailData.downCnt = [TBXML textForElement:[TBXML childElementNamed:@"downCnt" parentElement:eleRecord]];
                noteDetailData.fileSeq = [TBXML textForElement:[TBXML childElementNamed:@"fileSeq" parentElement:eleRecord]];
                noteDetailData.regiFileNm = [TBXML textForElement:[TBXML childElementNamed:@"regiFileNm" parentElement:eleRecord]];
            }
            eleDataSet = eleDataSet->nextSibling;
            if(eleDataSet->firstChild) {
                eleRecord = [TBXML childElementNamed:@"record" parentElement:eleDataSet];
                if(eleRecord->firstChild) {
                    noteDetailData.title = [TBXML textForElement:[TBXML childElementNamed:@"title" parentElement:eleRecord]];
                    noteDetailData.noteSeq = [TBXML textForElement:[TBXML childElementNamed:@"noteSeq" parentElement:eleRecord]];
                    noteDetailData.nickNm = [TBXML textForElement:[TBXML childElementNamed:@"nickNm" parentElement:eleRecord]];
                    noteDetailData.regiDttm = [TBXML textForElement:[TBXML childElementNamed:@"regiDttm" parentElement:eleRecord]];
                    noteDetailData.fileYn = [TBXML textForElement:[TBXML childElementNamed:@"fileYn" parentElement:eleRecord]];
                    noteDetailData.noteCont = [TBXML textForElement:[TBXML childElementNamed:@"noteCont" parentElement:eleRecord]];
                    noteDetailData.readCnt = [TBXML textForElement:[TBXML childElementNamed:@"readCnt" parentElement:eleRecord]];
                    [self.delegate parsingDidFinishedWithParsingType:PTnoteDetail withParsingList:noteDetailData];
                }
            }
        }
    }
}

- (void)parsingXMLdataToFileListModelWithRootElement:(TBXMLElement *)elemRoot {
    NSMutableArray<KNFileListModel *> *parsingList = [[NSMutableArray alloc] init];
    TBXMLElement *eleRecord = nil, *eleDataSet = nil;
    if(elemRoot && elemRoot->firstChild) {
        if([TBXML childElementNamed:@"params" parentElement:elemRoot]) {
            NSLog(@"Login session has expired");
            [self.delegate parsingDidFinishedWithParsingType:PTLoginSessionHasExpired withParsingList:nil];
        } else {
            eleDataSet = [TBXML childElementNamed:@"dataset" parentElement:elemRoot];
            if(eleDataSet->firstChild) {
                eleRecord = [TBXML childElementNamed:@"record" parentElement:eleDataSet];
                do {
                    if(eleRecord->firstChild) {
                        KNFileListModel *fileData = [[KNFileListModel alloc] init];
                        fileData.regiFileNm = [TBXML textForElement:[TBXML childElementNamed:@"regiFileNm" parentElement:eleRecord]];
                        fileData.fileSeq = [TBXML textForElement:[TBXML childElementNamed:@"fileSeq" parentElement:eleRecord]];
                        fileData.regiDttm = [TBXML textForElement:[TBXML childElementNamed:@"regiDttm" parentElement:eleRecord]];
                        fileData.downCnt = [TBXML textForElement:[TBXML childElementNamed:@"downCnt" parentElement:eleRecord]];
                        [parsingList addObject:fileData];
                    }
                } while ((eleRecord = eleRecord->nextSibling));
                [self.delegate parsingDidFinishedWithParsingType:PTnoticeAndNoteFileList withParsingList:parsingList];
            }
        }
    }
}

@end
