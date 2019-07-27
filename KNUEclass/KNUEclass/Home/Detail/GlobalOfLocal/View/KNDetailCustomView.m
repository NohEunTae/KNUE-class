//
//  KNDetailCustomView.m
//  KNUEclass
//
//  Created by user on 2018. 2. 17..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "KNDetailCustomView.h"
#import "KNImageManager.h"

@interface KNDetailCustomView ()

@property (nonatomic, strong) UILabel *titleLb, *nickNmLb, *dateLb, *viewsLb, *typeLb;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIImageView *views;
@property (nonatomic, strong) NSString *type;

@end

@implementation KNDetailCustomView

- (instancetype)initWithFrame:(CGRect)frame withType:(NSString *)type {
    self = [super initWithFrame:frame];
    
    if(self) {
        _type = type;
        self.backgroundColor = [UIColor whiteColor];
        [self createDetailCustomViewLabelsAndTextView];
    }
    
    return self;
}

- (void)createDetailCustomViewLabelsAndTextView {
    self.typeLb = [[UILabel alloc] init];
    [self addSubview: self.typeLb];

    self.titleLb = [[UILabel alloc] init];
    [self addSubview:self.titleLb];
    
    self.contentTextView = [[UITextView alloc] init];
    [self addSubview:self.contentTextView];
    
    self.nickNmLb = [[UILabel alloc] init];
    [self addSubview:self.nickNmLb];

    self.dateLb = [[UILabel alloc] init];
    [self addSubview:self.dateLb];
    if(![self.type isEqualToString:@"과제"]) {
        self.viewsLb = [[UILabel alloc] init];
        [self addSubview:self.viewsLb];

        self.views = [[UIImageView alloc] init];
        [self addSubview:self.views];
    }
}

- (void)layoutSubviews {
    self.typeLb.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.typeLb
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeWidth multiplier:0.9f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.typeLb
                                  attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterY multiplier:0.27f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.typeLb
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];

    self.titleLb.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.titleLb
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeWidth multiplier:0.9f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.titleLb
                                  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.typeLb
                                  attribute:NSLayoutAttributeTop multiplier:1.5f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.titleLb
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
    
    self.nickNmLb.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.nickNmLb
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.titleLb
                                  attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.nickNmLb
                                  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLb
                                  attribute:NSLayoutAttributeBottom multiplier:1.05f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.nickNmLb
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.titleLb
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];

    self.dateLb.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.dateLb
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.titleLb
                                  attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.dateLb
                                  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLb
                                  attribute:NSLayoutAttributeBottom multiplier:1.05f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.dateLb
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.nickNmLb
                                  attribute:NSLayoutAttributeCenterX multiplier:1.25f constant:0.0f] setActive:YES];
    if(![self.type isEqualToString:@"과제"]) {
        self.viewsLb.translatesAutoresizingMaskIntoConstraints = NO;
        [[NSLayoutConstraint constraintWithItem:self.viewsLb
                                      attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.titleLb
                                      attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
        [[NSLayoutConstraint constraintWithItem:self.viewsLb
                                      attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLb
                                      attribute:NSLayoutAttributeBottom multiplier:1.05f constant:0.0f] setActive:YES];
        [[NSLayoutConstraint constraintWithItem:self.viewsLb
                                      attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.views
                                      attribute:NSLayoutAttributeCenterX multiplier:2.3f constant:0.0f] setActive:YES];

        self.views.translatesAutoresizingMaskIntoConstraints = NO;

        [[NSLayoutConstraint constraintWithItem:self.views
                                      attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLb
                                      attribute:NSLayoutAttributeBottom multiplier:1.05f constant:0.0f] setActive:YES];
        [[NSLayoutConstraint constraintWithItem:self.views
                                      attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.dateLb
                                      attribute:NSLayoutAttributeCenterX multiplier:0.6f constant:0.0f] setActive:YES];
    }
    self.contentTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [[NSLayoutConstraint constraintWithItem:self.contentTextView
                                  attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.contentTextView
                                  attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.contentTextView
                                  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nickNmLb
                                  attribute:NSLayoutAttributeBottom multiplier:1.1f constant:0.0f] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:self.contentTextView
                                  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f] setActive:YES];
}

#pragma mark Detail Custom View Modify Labels

- (void)modifyTitleLabelText:(NSString *)titleText withNickNmbLabelText:(NSString *)nickNmLbText withDateLabelText:(NSString *)dateLbText withViewsLabelText:(NSString *)viewsLbText  withContentTextViewText:(NSString *)contentText {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.typeLb.text = self.type;
        self.typeLb.textColor = [UIColor colorWithRed:77.0f/255.0f green:109.0f/255.0f blue:236.0f/255.0f alpha:1.0f];
        [self.typeLb setFont:[UIFont fontWithName:@"NanumBarunGothicOTF-YetHangul" size:20]];
        
        NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                initWithData: [titleText dataUsingEncoding:NSUnicodeStringEncoding]
                                                options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                documentAttributes: nil
                                                error: nil];
        self.titleLb.attributedText = attributedString;
        [self.titleLb setFont:[UIFont fontWithName:@"Arial" size:22]];
        self.titleLb.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLb.numberOfLines = 0;
        
        self.nickNmLb.text = nickNmLbText;
        self.nickNmLb.textColor = [UIColor colorWithRed:188.0f/255.0f green:199.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [self.nickNmLb setFont:[UIFont fontWithName:@"Arial" size:13]];
        
        self.dateLb.text = dateLbText;
        self.dateLb.textColor = [UIColor colorWithRed:188.0f/255.0f green:199.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [self.dateLb setFont:[UIFont fontWithName:@"Arial" size:13]];
        if(![self.type isEqualToString:@"과제"]) {
            self.viewsLb.text = viewsLbText;
            self.viewsLb.textColor = [UIColor colorWithRed:188.0f/255.0f green:199.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
            [self.viewsLb setFont:[UIFont fontWithName:@"Arial" size:13]];
            
            UIImage *viewImg = [UIImage imageNamed:@"view"];
            viewImg = [KNImageManager  resizeTabBarIconImageWithImageWithImage:viewImg scaledToSize:CGSizeMake(15, 15)];
            self.views.image = viewImg;
        }
        attributedString = [[NSAttributedString alloc]
                            initWithData: [contentText dataUsingEncoding:NSUnicodeStringEncoding]
                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                            documentAttributes: nil
                            error: nil];
        self.contentTextView.attributedText = attributedString;
        [self.contentTextView.layer setBorderWidth:1.0f];
        [self.contentTextView.layer setBorderColor:[[UIColor colorWithRed:244.0f/255.0f green:245.0f/255.0f blue:1.0f alpha:1.0f] CGColor]];
        self.contentTextView.scrollEnabled = YES;
        self.contentTextView.editable = NO;
    });
}

@end
