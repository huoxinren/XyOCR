//
//  OCRMainView.m
//
//
//  Created by xyz on 16/11/11.
//  Copyright © 2016年 . All rights reserved.
//

#import "OCRMainView.h"

#import "CertificateInfo.h"

#import "CertificateDefine.h"

//银行卡
#import "WTCameraViewController.h"

//身份证
#import "CameraViewController.h"
#import "WintoneCardOCR.h"

#import "CheckViewController.h"

#define kScreenW        [[UIScreen mainScreen] bounds].size.width
#define kScreenH        [[UIScreen mainScreen] bounds].size.height

@interface OCRMainView ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, WTCameraDelegate, CameraViewDelegate>
{
    NSString *_imagePath;
}

@property (strong, nonatomic) WintoneCardOCR *cardRecog;

@property (strong, nonatomic) CertificateInfo *certificateInfo;


@end


@implementation OCRMainView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
*/

- (id)initViewWithCardType:(int)type ifHaveCheckPage:(BOOL)ifHaveCheckPage
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    
    if (self) {
        
        //[self setFrame:CGRectMake(0, 0, kScreenHeight, kScreenWidth)];
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.source = 0;
        self.bIfHaveCheckPage = ifHaveCheckPage;
        
        if (type == 0)//二代身份证
        {
            [self creatView];
        }
        else    //银行卡
        {
            //
            [self enterBankCamera];
        }
    }
    
    return self;
}

- (id)initViewWithCardType:(int)type ifHaveCheckPage:(BOOL)ifHaveCheckPage ifCheckViewNoEdit:(BOOL)ifCheckViewNoEdit
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    
    if (self) {
        
        //[self setFrame:CGRectMake(0, 0, kScreenHeight, kScreenWidth)];
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.source = 0;
        self.bIfHaveCheckPage = ifHaveCheckPage;
        self.bIfCheckViewNoEdit = ifCheckViewNoEdit;
        
        if (type == 0)//二代身份证
        {
            [self creatView];
        }
        else    //银行卡
        {
            //
            [self enterBankCamera];
        }
    }
    
    return self;
}

- (id)initViewWithCardType:(int)type source:(int)source ifHaveCheckPage:(BOOL)ifHaveCheckPage
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    
    if (self) {
        
        //[self setFrame:CGRectMake(0, 0, kScreenHeight, kScreenWidth)];
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.source = source;
        self.bIfHaveCheckPage = ifHaveCheckPage;
        
        if (type == 0)//二代身份证
        {
            if (self.source)
            {
                [self buttonLeftClickMethod:nil];
            }
            else
            {
                [self creatView];
            }
        }
        else    //银行卡
        {
            //
            [self enterBankCamera];
        }
    }
    
    return self;
}

- (id)initViewWithCardType:(int)type source:(int)source ifHaveCheckPage:(BOOL)ifHaveCheckPage ifCheckViewNoEdit:(BOOL)ifCheckViewNoEdit
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    
    if (self) {
        
        //[self setFrame:CGRectMake(0, 0, kScreenHeight, kScreenWidth)];
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.source = source;
        self.bIfHaveCheckPage = ifHaveCheckPage;
        self.bIfCheckViewNoEdit = ifCheckViewNoEdit;
        
        if (type == 0)//二代身份证
        {
            if (self.source)
            {
                [self buttonLeftClickMethod:nil];
            }
            else
            {
                [self creatView];
            }
        }
        else    //银行卡
        {
            //
            [self enterBankCamera];
        }
    }
    
    return self;
}

- (id)initViewWithCardType:(int)type source:(int)source ifHaveCheckPage:(BOOL)ifHaveCheckPage ifCheckViewNoEdit:(BOOL)ifCheckViewNoEdit ifShowUserName:(BOOL)ifShowUserName
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    
    if (self) {
        
        //[self setFrame:CGRectMake(0, 0, kScreenHeight, kScreenWidth)];
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.source = source;
        self.bIfHaveCheckPage = ifHaveCheckPage;
        self.bIfCheckViewNoEdit = ifCheckViewNoEdit;
        self.bIfShowUserName = ifShowUserName;
        
        if (type == 0)//二代身份证
        {
            if (self.source)
            {
                [self buttonLeftClickMethod:nil];
            }
            else
            {
                [self creatView];
            }
        }
        else    //银行卡
        {
            //
            [self enterBankCamera];
        }
    }
    
    return self;
}

- (void)creatView
{
    //阴影
    UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    [viewBG setBackgroundColor:[UIColor grayColor]];
    [viewBG setAlpha:0.5];
    [self addSubview:viewBG];
    
    UITapGestureRecognizer *tapEnterViewBG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove)];
    [viewBG addGestureRecognizer:tapEnterViewBG];
    [viewBG setUserInteractionEnabled:YES];
    
    float fHeightViewBottom = 130;
    
    //下底  白色
    UIView *viewBottom = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH-fHeightViewBottom, kScreenW, fHeightViewBottom)];
    [viewBottom setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:viewBottom];
    
    /*
    [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewBG.mas_bottom).with.offset(0);
        make.centerX.equalTo(viewBG.mas_centerX).with.offset(0);
        make.width.equalTo(@(kScreenW));
        make.height.equalTo(@(fHeightViewBottom));
    }];
     */
    
    UIButton *buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonLeft setFrame:CGRectMake(0, kScreenH-fHeightViewBottom, kScreenW/2, fHeightViewBottom)];
    [buttonLeft setBackgroundColor:[UIColor clearColor]];
    [buttonLeft setImage:[UIImage imageNamed:@"icon_scan.png"] forState:UIControlStateNormal];
    [buttonLeft setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
    [buttonLeft addTarget:self action:@selector(buttonLeftClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    buttonLeft.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:buttonLeft];
    
    /*
    [buttonLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewBG.mas_left).with.offset(0);
        make.bottom.equalTo(viewBG.mas_bottom).with.offset(0);
        make.width.equalTo(@(kScreenW/2));
        make.height.equalTo(@(fHeightViewBottom));
    }];
    */
    
    UILabel *lableLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenH-40, kScreenW/2, 15)];
    [lableLeft setTextAlignment:NSTextAlignmentCenter];
    [lableLeft setBackgroundColor:[UIColor clearColor]];
    [lableLeft setNumberOfLines:0];
    [lableLeft setFont:[UIFont systemFontOfSize:15.0f]];
    [lableLeft setText:@"扫描识别"];
    [lableLeft setTextColor:[UIColor colorWithRed:(51)/255.0 green:(51)/255.0 blue:(51)/255.0 alpha:255/255.0]];
    [self addSubview:lableLeft];
    
    /*
    [lableLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(buttonLeft.mas_centerX).with.offset(0);
        make.bottom.equalTo(viewBottom.mas_bottom).with.offset(-26);
    }];
     */

    UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonRight setFrame:CGRectMake(kScreenW/2, kScreenH-fHeightViewBottom, kScreenW/2, fHeightViewBottom)];
    [buttonRight setBackgroundColor:[UIColor clearColor]];
    [buttonRight setImage:[UIImage imageNamed:@"icon_pic.png"] forState:UIControlStateNormal];
    [buttonRight setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
    [buttonRight addTarget:self action:@selector(buttonRightClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    buttonRight.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:buttonRight];
    
    /*
    [buttonRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewBG.mas_right).with.offset(0);
        make.bottom.equalTo(viewBG.mas_bottom).with.offset(0);
        make.width.equalTo(@(kScreenW/2));
        make.height.equalTo(@(fHeightViewBottom));
    }];
     */
    
    UILabel *lableRight = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW/2, kScreenH-40, kScreenW/2, 15)];
    [lableRight setTextAlignment:NSTextAlignmentCenter];
    [lableRight setBackgroundColor:[UIColor clearColor]];
    [lableRight setNumberOfLines:0];
    [lableRight setText:@"图片识别"];
    [lableRight setFont:[UIFont systemFontOfSize:15.0f]];
    [lableRight setTextColor:[UIColor colorWithRed:(51)/255.0 green:(51)/255.0 blue:(51)/255.0 alpha:255/255.0]];
    [self addSubview:lableRight];
    
    /*
    [lableRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(buttonRight.mas_centerX).with.offset(0);
        make.bottom.equalTo(viewBottom.mas_bottom).with.offset(-26);
    }];
     */
    
    UIView *viewVerticalLine = [[UIView alloc]initWithFrame:CGRectMake(kScreenW/2, kScreenH-89, 0.5, 48)];
    [viewVerticalLine setBackgroundColor:[UIColor grayColor]];
    [self addSubview:viewVerticalLine];
    
    /*
    [viewVerticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewBottom.mas_centerX).with.offset(0);
        make.centerY.equalTo(viewBottom.mas_centerY).with.offset(0);
        make.width.equalTo(@0.5);
        make.height.equalTo(@(48));
    }];
    */
    
    if (self.bIfHaveCheckPage)
    {
        //增加通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeViewBG) name:NotificationRemoveOCRMainView object:nil];
    }
}

#pragma mark - button Method

- (void)buttonLeftClickMethod:(UIButton *)sender
{
    if (sender == nil)
    {
        if (self.bIfHaveCheckPage)
        {
            //增加通知
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeViewBG) name:NotificationRemoveOCRMainView object:nil];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CameraViewController *cameraVC = [[CameraViewController alloc] init];
        cameraVC.recogType = self.certificateInfo.typeCode;
        cameraVC.resultCount = self.certificateInfo.count;
        cameraVC.typeName = self.certificateInfo.typeName;
        cameraVC.devCode = self.devCode;
        cameraVC.bIfHaveCheckPage = self.bIfHaveCheckPage;
        cameraVC.bIfCheckViewNoEdit = self.bIfCheckViewNoEdit;
        cameraVC.bIfShowUserName = self.bIfShowUserName;
        cameraVC.delegate = self;
        
        [[self viewController].navigationController pushViewController:cameraVC animated:YES];
        
        //[[self viewController] presentViewController:cameraVC animated:YES completion:nil];
    });
}

- (void)buttonRightClickMethod:(UIButton *)sender
{
    [self performSelectorInBackground:@selector(initRecog) withObject:nil];
    //初始化相册
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    
    [[self viewController] presentViewController:picker animated:YES completion:nil];
    
    /*
    if (_delegate != nil)
    {
        [_delegate clickChooseView:1];
        
        NSLog(@"点击了 图片识别 的按钮");
    }
     */
}

- (void)enterBankCamera
{
    if (self.bIfHaveCheckPage)
    {
        //增加通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeViewBG) name:NotificationRemoveOCRMainView object:nil];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        WTCameraViewController *cameraVC = [[WTCameraViewController alloc]init];
        cameraVC.delegate = self;
        cameraVC.devcode = self.devCode; //开发码
        cameraVC.bIfHaveCheckPage = self.bIfHaveCheckPage;
        cameraVC.bIfCheckViewNoEdit = self.bIfCheckViewNoEdit;
        [self  viewController].navigationController.navigationBarHidden = YES;
        
        [[self viewController].navigationController pushViewController:cameraVC animated:YES];
        
        //[[self viewController] presentViewController:cameraVC animated:YES completion:NULL];
    });
}

//初始化核心
- (void) initRecog
{
    NSDate *before = [NSDate date];
    self.cardRecog = [[WintoneCardOCR alloc] init];
    /*提示：该开发码和项目中的授权仅为演示用，客户开发时请替换该开发码及项目中Copy Bundle Resources 中的.lsc授权文件*/
    int intRecog = [self.cardRecog InitIDCardWithDevcode:self.devCode];//@"5LMQ5AAM5PSV5LU"
    NSLog(@"intRecog = %d",intRecog);
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:before];
    NSLog(@"%f", time);
}

#pragma mark--选取相册图片

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self performSelectorInBackground:@selector(didFinishedSelect:) withObject:image];
}

//存储照片
-(void)didFinishedSelect:(UIImage *)image
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    UIImage *saveImage = image;
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"WintoneIDCardFree.jpg"];
    
    //存储图片
    [UIImageJPEGRepresentation(saveImage, 1.0f) writeToFile:imageFilePath atomically:YES];
    _imagePath = imageFilePath;
    [self performSelectorInBackground:@selector(recog) withObject:nil];
}

//取消选择
-(void)imagePickerControllerDIdCancel:(UIImagePickerController*)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)recog
{
    //设置导入识别模式和证件类型
    [self.cardRecog setParameterWithMode:0 CardType:self.certificateInfo.typeCode];
    //图片预处理 7－裁切+倾斜校正+旋转
    [self.cardRecog processImageWithProcessType:7 setType:1];
    
    //导入图片数据
    int loadImage = [self.cardRecog LoadImageToMemoryWithFileName:_imagePath Type:0];
    
    NSLog(@"loadImage = %d", loadImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *caches = paths[0];
    NSString *imagepath = [caches stringByAppendingPathComponent:@"image.jpg"];
    NSString *headImagePath = [caches stringByAppendingPathComponent:@"head.jpg"];
    
    //移除所有
    [self.dictionaryCertificateInfo removeAllObjects];
    
    if (self.certificateInfo.typeCode != 3000) {//***注意：机读码需要自己重新设置类型来识别
        if (self.certificateInfo.typeCode == 2) {
            
            //自动分辨二代证正反面
            [self.cardRecog autoRecogChineseID];
        }else{
            //其他证件
            [self.cardRecog recogIDCardWithMainID:self.certificateInfo.typeCode];
        }
        //非机读码，保存头像
        [self.cardRecog saveHeaderImage:headImagePath];
        
        //保存图片路径到字典
        [self.dictionaryCertificateInfo setValue:headImagePath forKey:@"IDCardHeadImagePath"];
        
        //获取识别结果
        NSString *allResult = @"";
        for (int i = 1; i < self.certificateInfo.count; i++) {
            
            [self.cardRecog saveImage:imagepath];

            //获取字段值
            NSString *field = [self.cardRecog GetFieldNameWithIndex:i];
            //获取字段结果
            NSString *result = [self.cardRecog GetRecogResultWithIndex:i];
            
            NSLog(@"%@:%@\n",field, result);
            
            if ((field != nil) && (result != nil))
            {
                //赋值身份证信息
                [self.dictionaryCertificateInfo setValue:result forKey:field];
            }
            
            if(field != NULL){
                allResult = [allResult stringByAppendingString:[NSString stringWithFormat:@"%@:%@\n", field, result]];
            }
        }
        
        if (![allResult isEqualToString:@""]) {
            
            //保存图片路径到字典
            [self.dictionaryCertificateInfo setValue:imagepath forKey:@"IDCardImagePath"];
            
            //保存userdefoult
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:self.dictionaryCertificateInfo forKey:@"dictionaryCertificateInfo"];
            [userDefaults synchronize];
            
            [self remove];
            
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGetIDInfo object:nil];
        }
    }
}

#pragma mark - WTCamaraDelegate

//银行卡识别核心初始化结果，判断核心是否初始化成功
- (void)initBankCardRecWithResult:(int)nInit{
    NSLog(@"识别核心初始化结果nInit>>>%d<<<",nInit);
}

//拍照和识别成功后返回结果图片、识别字符串
- (void)cameraViewController:(WTCameraViewController *)cameraVC resultImage:(UIImage *)image resultDictionary:(NSDictionary *)resultDic{
    
    NSLog(@"银行卡识别结果resultDic>>>%@<<<",resultDic);
    
    [self remove];
}

//返回按钮被点击时回调此方法，返回相机视图控制器
- (void)backWithCameraViewController:(WTCameraViewController *)cameraVC{
    
    [self remove];
    
    //[cameraVC  dismissViewControllerAnimated:YES completion:NULL];
}

//点击UIAlertView时返回相机视图控制器
- (void)clickAlertViewWithCameraViewController:(WTCameraViewController *)cameraVC{
    // [cameraVC.navigationController popViewControllerAnimated:YES];
    
    
    //[cameraVC  dismissViewControllerAnimated:YES completion:NULL];
}

//相机视图将要消失时回调此方法，返回相机视图控制器
- (void)viewWillDisappearWithCameraViewController:(WTCameraViewController *)cameraVC
{
    //cameraVC.navigationController.navigationBarHidden = NO;
    
    //去掉
    //[cameraVC  dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - CamaraDelegate

- (void)removeViewBG
{
    [self remove];
}


#pragma mark - 弹出 与 移除
- (void)show
{
    [self saveJumpPageMyDoStatus];
    
    [[self viewController].view bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.33 animations:^{
        
        [self setAlpha:1.0f];
        
    } completion:^(BOOL finished) {
    }];
}

- (void)remove
{
    if (self.bIfHaveCheckPage)
    {
        //移除通知
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationRemoveOCRMainView object:nil];
    }
    
    [UIView animateWithDuration:0.33 animations:^{
        
        [self setAlpha:0.0f];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (void)saveJumpPageMyDoStatus
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:PlistJumpPageMyDoStatus];
    
    if (self.bIfJumpPageMyDo)
    {
        [userDefaults setObject:@"YES" forKey:PlistJumpPageMyDoStatus];
    }
    [userDefaults synchronize];
}

- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    
    return nil;
}

- (CertificateInfo *)certificateInfo
{
    if (_certificateInfo == nil) {
        
        _certificateInfo = [[CertificateInfo alloc]init];
        _certificateInfo.typeName = NSLocalizedString(@"二代身份证", nil);
        _certificateInfo.typeCode = 2;
        _certificateInfo.count = 7;
    }
    
    return _certificateInfo;
}

- (NSMutableDictionary *)dictionaryCertificateInfo
{
    if (_dictionaryCertificateInfo == nil) {
        
        _dictionaryCertificateInfo = [NSMutableDictionary dictionary];
    }
    
    return _dictionaryCertificateInfo;
}


- (NSString *)devCode
{
    if (_devCode == nil) {
        //乐富的标志
        _devCode = @"5LMQ5AAM5PSV5LU";
    }
    
    return _devCode;
}

@end
