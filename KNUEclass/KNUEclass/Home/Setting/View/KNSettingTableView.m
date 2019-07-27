//
//  KNSettingTableView.m
//  KNUEclass
//
//  Created by user on 2018. 2. 22..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNSettingTableView.h"
#import "KNSettingTableViewAdapter.h"

@interface KNSettingTableView ()

@property (nonatomic, strong) KNSettingTableViewAdapter *settingTableViewAdapter;

@end

@implementation KNSettingTableView

#pragma mark Setting Table View

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        _settingTableViewAdapter = [[KNSettingTableViewAdapter alloc] init];
    }
    
    return self;
}

- (void)setDataSourceWithDelegate {
    self.dataSource = self.settingTableViewAdapter;
    self.delegate = self.settingTableViewAdapter;
}

@end
