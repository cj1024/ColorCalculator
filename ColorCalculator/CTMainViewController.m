//
//  CTMainViewController.m
//  ColorCalculator
//
//  Created by j_chen on 13-12-18.
//  Copyright (c) 2013年 j_chen. All rights reserved.
//  类文件说明

#import "CTMainViewController.h"
#import "CTAppDelegate.h"

@interface CTMainViewController ()

@property (nonatomic, strong, readwrite) IBOutlet UITextField *mTextFieldHexString;

@property (nonatomic, strong, readwrite) IBOutlet UITextField *mTextFieldIntStringR;
@property (nonatomic, strong, readwrite) IBOutlet UITextField *mTextFieldIntStringG;
@property (nonatomic, strong, readwrite) IBOutlet UITextField *mTextFieldIntStringB;
@property (nonatomic, strong, readwrite) IBOutlet UITextField *mTextFieldIntStringA;

@property (nonatomic, strong, readwrite) IBOutlet UIView *mViewColorPreview;

@property (nonatomic, strong, readwrite) CTHexStringTextFieldDelegate *mTextFieldDelegateHex;

@property (nonatomic, strong, readwrite) CTIntStringTextFieldDelegate *mTextFieldDelegateInt;

@end

@implementation CTMainViewController

#pragma mark - --------------------退出清空--------------------
- (void)dealloc
{
    
}

#pragma mark - --------------------初始化--------------------
#pragma mark 数据初始化
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.mTextFieldDelegateHex = [CTHexStringTextFieldDelegate new];
        self.mTextFieldDelegateInt = [CTIntStringTextFieldDelegate new];
    }
    return self;
}

#pragma mark 视图初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mViewColorPreview.layer.borderColor = [UIColor whiteColor].CGColor;
    self.mViewColorPreview.layer.borderWidth = 1;
    self.mTextFieldHexString.delegate = self.mTextFieldDelegateHex;
    self.mTextFieldIntStringR.delegate = self.mTextFieldIntStringG.delegate = self.mTextFieldIntStringB.delegate = self.mTextFieldIntStringA.delegate = self.mTextFieldDelegateInt;
}

#pragma mark - --------------------System--------------------
#pragma mark 内存警告事件处理函数
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - --------------------功能函数--------------------
#pragma mark - --------------------手势事件--------------------


#pragma mark - --------------------按钮事件--------------------
- (IBAction)fromHexToInt:(id)sender
{
    [self.view endEditing:YES];
    if (self.mTextFieldHexString.text.length == 0)
    {
        return;
    }
    CTColor *color = [[CTColor alloc] initWithHexString:[self.mTextFieldHexString.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    self.mTextFieldIntStringA.text = [NSString stringWithFormat:@"%d",color.alpha];
    self.mTextFieldIntStringR.text = [NSString stringWithFormat:@"%d",color.red];
    self.mTextFieldIntStringG.text = [NSString stringWithFormat:@"%d",color.green];
    self.mTextFieldIntStringB.text = [NSString stringWithFormat:@"%d",color.blue];
    self.mViewColorPreview.backgroundColor = [UIColor colorWithRed:color.red/255.0 green:color.green/255.0 blue:color.blue/255.0 alpha:color.alpha/255.0];
}

- (IBAction)fromIntToHex:(id)sender
{
    [self.view endEditing:YES];
    NSInteger a = self.mTextFieldIntStringA.text.length == 0? 255 : [self.mTextFieldIntStringA.text integerValue];
    NSInteger r = self.mTextFieldIntStringR.text.length == 0? 0 : [self.mTextFieldIntStringR.text integerValue];
    NSInteger g = self.mTextFieldIntStringG.text.length == 0? 0 : [self.mTextFieldIntStringG.text integerValue];
    NSInteger b = self.mTextFieldIntStringB.text.length == 0? 0 : [self.mTextFieldIntStringB.text integerValue];
    CTColor *color = [[CTColor alloc] initWithR:r G:g B:b A:a];
    self.mTextFieldIntStringA.text = [NSString stringWithFormat:@"%d",color.alpha];
    self.mTextFieldIntStringR.text = [NSString stringWithFormat:@"%d",color.red];
    self.mTextFieldIntStringG.text = [NSString stringWithFormat:@"%d",color.green];
    self.mTextFieldIntStringB.text = [NSString stringWithFormat:@"%d",color.blue];
    self.mTextFieldHexString.text = color.hexString;
    self.mViewColorPreview.backgroundColor = [UIColor colorWithRed:color.red/255.0 green:color.green/255.0 blue:color.blue/255.0 alpha:color.alpha/255.0];
}

#pragma mark - --------------------代理方法--------------------


#pragma mark - --------------------属性相关--------------------


#pragma mark - --------------------接口API--------------------


@end

@implementation CTHexStringTextFieldDelegate

#pragma mark - --------------------代理方法--------------------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *matchRegex = @"^[0-9a-fA-F]{0,8}$";
    NSString *currentString = textField.text;
    NSMutableString *targetString = [NSMutableString stringWithString:currentString];
    [targetString replaceCharactersInRange:range withString:string];
    [CTHexStringTextFieldDelegate formatHexString:targetString];
    BOOL result = NO;
    if ([targetString hasPrefix:@"#"])
    {
        [targetString replaceOccurrencesOfString:@"#" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 1)];
    }
    else if([targetString hasPrefix:@"0x"])
    {
        [targetString replaceOccurrencesOfString:@"0x" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 2)];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", matchRegex];
    result = [predicate evaluateWithObject:targetString];
    return result;
}

#pragma mark - --------------------接口API--------------------
+ (void)formatHexString:(NSMutableString *)targetString
{
    if ([targetString hasPrefix:@"#"])
    {
        [targetString replaceOccurrencesOfString:@"#" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 1)];
    }
    else if([targetString hasPrefix:@"0x"])
    {
        [targetString replaceOccurrencesOfString:@"0x" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 2)];
    }
}

@end


@implementation CTIntStringTextFieldDelegate

#pragma mark - --------------------代理方法--------------------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *matchRegex = @"^[1-9][0-9]*|0$";
    NSString *currentString = textField.text;
    NSMutableString *targetString = [NSMutableString stringWithString:currentString];
    [targetString replaceCharactersInRange:range withString:string];
    BOOL result = NO;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", matchRegex];
    result = [predicate evaluateWithObject:targetString];
    if (result)
    {
        result = [targetString integerValue] <= 255;
    }
    return result;
}

@end

@implementation CTColor

#pragma mark - --------------------初始化--------------------
- (id)initWithHexString:(NSString *)hexString
{
    NSMutableString *realHexString =  [NSMutableString stringWithString:hexString];
    [CTHexStringTextFieldDelegate formatHexString:realHexString];
    hexString = realHexString;
    NSInteger r = 0, g = 0, b = 0, a = 255;
    if (realHexString.length == 8)
    {
        unsigned result = 0;
        NSScanner *scanner = [NSScanner scannerWithString:[realHexString substringWithRange:NSMakeRange(0, 2)]];
        [scanner scanHexInt:&result];
        a = result;
        hexString = [realHexString substringWithRange:NSMakeRange(2, 6)];
    }
    if (hexString.length == 6)
    {
        unsigned result = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        [scanner scanHexInt:&result];
        r = (result >> 16) & 0xFF;
        g = (result >> 8) & 0xFF;
        b = result & 0xFF;
    }
    return [self initWithR:r G:g B:b A:a];
}

- (id)initWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b
{
    return [self initWithR:r G:g B:b A:255];
}

- (id)initWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(NSInteger)a
{
    self = [super init];
    if (self)
    {
        _red = r;
        _green = g;
        _blue = b;
        _alpha = a;
        [self getHexStringFromRGBA];
    }
    return self;
}

#pragma mark - --------------------功能函数--------------------
- (void)getHexStringFromRGBA
{
    _hexString = [NSString stringWithFormat:@"0x%02x%02x%02x%02x", _alpha, _red, _green, _blue];
}


@end
