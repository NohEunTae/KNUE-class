//
//  KNPublicCustomTableViewCell.m
//  KNUEclass
//
//  Created by user on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNPublicCustomTableViewCell.h"

@interface KNPublicCustomTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel, *contLabel;
@property (nonatomic, strong) UIView *cellLine;

@end

@implementation KNPublicCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self createLabel];
        [self createCellLine];
    }
    return self;
}

#pragma mark Public Custom Cell Create Attribute Set

- (void)createLabel {
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    
    _contLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_contLabel];
}

- (void)createCellLine {
    _cellLine = [[UIView alloc] init];
    _cellLine.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [self.contentView addSubview:_cellLine];    
}

- (void)layoutSubviews {
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem: self.titleLabel
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView
                                  attribute:NSLayoutAttributeWidth multiplier:0.9f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem: self.titleLabel
                                  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView
                                  attribute:NSLayoutAttributeHeight multiplier:0.9f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem: self.titleLabel
                                  attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView
                                  attribute:NSLayoutAttributeCenterY multiplier:0.7f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem: self.titleLabel
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
    
    self.contLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.contLabel
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.titleLabel
                                  attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.contLabel
                                  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.titleLabel
                                  attribute:NSLayoutAttributeBottom multiplier:0.95f constant:1.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.contLabel
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.titleLabel
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
    
    self.cellLine.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.cellLine
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView
                                  attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.cellLine
                                  attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView
                                  attribute:NSLayoutAttributeHeight multiplier:0.005f constant:1.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.cellLine
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.cellLine
                                  attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView
                                  attribute:NSLayoutAttributeCenterY multiplier:2.0f constant:0.0f] setActive:YES];
}

#pragma mark Public Custom Cell Modify Labels

- (void)modifyTitleLabel:(NSString *)titleText withContLabel:(NSString *)contText {
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [titleText dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil];
    self.titleLabel.attributedText = attributedString;
    [self.titleLabel setFont:[UIFont fontWithName:@"Arial" size:15]];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if([self.titleLabel.text isEqualToString:@"데이터가 없습니다."])
        self.titleLabel.textColor = [UIColor colorWithRed:188.0f/255.0f green:199.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    else
        self.titleLabel.textColor = [UIColor blackColor];
    
    self.contLabel.text = contText;
    self.contLabel.textColor = [UIColor colorWithRed:188.0f/255.0f green:199.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    [self.contLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
}

- (NSString *)titlaLabelText {
    return self.titleLabel.text;
}

@end
