//
//  CTMainViewController.h
//  ColorCalculator
//
//  Created by j_chen on 13-12-18.
//  Copyright (c) 2013年 j_chen. All rights reserved.
//  类文件说明

#import <UIKit/UIKit.h>

@interface CTColor : NSObject

@property (nonatomic, assign, readonly) NSInteger red;
@property (nonatomic, assign, readonly) NSInteger green;
@property (nonatomic, assign, readonly) NSInteger blue;
@property (nonatomic, assign, readonly) NSInteger alpha;
@property (nonatomic, strong, readonly) NSString *hexString;

- (id)initWithHexString:(NSString *)hexString;
- (id)initWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b;
- (id)initWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(NSInteger)a;

@end

/** CTMainViewController类说明 */
@interface CTMainViewController : UIViewController

@end

@interface CTHexStringTextFieldDelegate : NSObject<UITextFieldDelegate>

+ (void)formatHexString:(NSMutableString *)targetString;

@end

@interface CTIntStringTextFieldDelegate : NSObject<UITextFieldDelegate>

@end