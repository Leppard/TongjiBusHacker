//
//  TJEditPersonalInfoController.m
//  TongjiBusHacker
//
//  Created by Leppard on 12/16/15.
//  Copyright © 2015 Leppard. All rights reserved.
//

#import "TJEditPersonalInfoController.h"
#import "TJPersonalInfoManager.h"
#import <Masonry.h>

#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

static NSString *const kTJPersonalInfoUserDefaultsData = @"kTJPersonalInfoUserDefaultsData";

@interface TJEditPersonalInfoController ()<UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UITextField *nameText;
@property (nonatomic, strong) UITextField *idText;

@end

@implementation TJEditPersonalInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(savePersonalInfoData)];
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    [self setUpViewsWithConstraints];
    
    [self initLocalData];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 == buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - event response

- (void)savePersonalInfoData
{
    if(! [self checkIfCanSave]) {
        [self showErrorAlert];
        return;
    }
    
    [TJPersonalInfoManager shareManager].personName = self.nameText.text;
    [TJPersonalInfoManager shareManager].personID   = self.idText.text;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[TJPersonalInfoManager shareManager]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:kTJPersonalInfoUserDefaultsData];
    [defaults synchronize];
    
    [self showSuccessAlert];
}

#pragma mark - private methods

- (void)dismissKeyBoard
{
    [self.view endEditing:YES];
}

- (void)setUpViewsWithConstraints
{
    [self.view addSubview:self.nameText];
    [self.view addSubview:self.idText];
    
    [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.width.equalTo(@120);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-40);
    }];
    [self.idText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.width.equalTo(@120);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(40);
    }];
}

- (void)initLocalData
{
    self.nameText.text   = [TJPersonalInfoManager shareManager].personName;
    self.idText.text     = [TJPersonalInfoManager shareManager].personID;
}

- (BOOL)checkIfCanSave
{
    if (self.nameText.text.length == 0) {
        return NO;
    }
    if (self.idText.text.length == 0) {
        return NO;
    }
    return YES;
}

- (void)showErrorAlert
{
    if (IS_OS_8_OR_LATER) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"个人信息未填写完整" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"我错了" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"个人信息未填写完整" message:nil delegate:self cancelButtonTitle:@"我错了" otherButtonTitles:nil];
        [view show];
    }
}

- (void)showSuccessAlert
{
    if (IS_OS_8_OR_LATER) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                                                  [self.navigationController popViewControllerAnimated:YES];
                                                              }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [view show];
    }

}

#pragma mark - getters & setters

- (UITextField *)nameText
{
    if (!_nameText) {
        _nameText = [[UITextField alloc] init];
        _nameText.borderStyle = UITextBorderStyleRoundedRect;
        _nameText.placeholder = @"姓名";
        _nameText.delegate = self;
    }
    return _nameText;
}

- (UITextField *)idText
{
    if (!_idText) {
        _idText = [[UITextField alloc] init];
        _idText.borderStyle = UITextBorderStyleRoundedRect;
        _idText.placeholder = @"学号";
        _idText.keyboardType = UIKeyboardTypeNumberPad;
        _idText.delegate = self;
    }
    return _idText;
}

@end
