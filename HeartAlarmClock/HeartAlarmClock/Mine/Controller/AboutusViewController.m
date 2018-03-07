//  AboutusViewController.m
//  HeartAlarmClock
/**
 * ━━━━━━神兽出没━━━━━━
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　　　　　┃
 * 　　┃　　　━　　　┃
 * 　　┃　┳┛　┗┳　┃
 * 　　┃　　　　　　　┃
 * 　　┃　　　┻　　　┃
 * 　　┃　　　　　　　┃
 * 　　┗━┓　　　┏━┛Code is far away from bug with the animal protecting
 * 　　　　┃　　　┃    神兽保佑,代码无bug
 * 　　　　┃　　　┃
 * 　　　　┃　　　┗━━━┓
 * 　　　　┃　　　　　　　┣┓
 * 　　　　┃　　　　　　　┏┛
 * 　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　┃┫┫　┃┫┫
 * 　　　　　┗┻┛　┗┻┛
 *
 * ━━━━━━感觉萌萌哒━━━━━━
 */
//  Created by xingjian on 2018/1/24.
//  Copyright © 2018年 xingjian. All rights reserved.杰克
//  @class AboutusViewController
//  @abstract 关于我们
//  @discussion <#类的功能#>
//

#import "AboutusViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHAssetChangeRequest.h>


@interface AboutusViewController ()<UIActionSheetDelegate>
@property(nonatomic,strong)UIImageView *iconImg;
@property(nonatomic,strong)UILabel *versionLab;
@property(nonatomic,strong)UIImageView *tipImg;
@property(nonatomic,strong)UITextView  *jcTextV;
@property(nonatomic,strong)UIView    *jcBottomView;
@property(nonatomic,strong)UIImageView *jcBTImg;
@property(nonatomic,strong)UILabel   *jcBBLab;
@property(nonatomic,strong)UILabel   *jcBTLab;
@end

@implementation AboutusViewController


#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self jcLayoutMyUI];
}

- (void)jcLayoutMyUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.iconImg];
    [self.view addSubview:self.versionLab];
//    [self.view addSubview:self.tipImg];
    [self.view addSubview:self.jcTextV];
    [self.view addSubview:self.jcBottomView];
    
    CGFloat jcTopSpaceY = 146/2;
    if (isIphone_5) {
        jcTopSpaceY = 60/2;
    }
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(90);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(JCNavBarHeight+jcTopSpaceY);
    }];
    [self.versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth);
        make.height.mas_equalTo(16);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.iconImg.mas_bottom).offset(15);
    }];
    
//    [self.tipImg mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.width.mas_equalTo(250/2.0);
//        make.height.mas_equalTo(220/2.0);
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.top.mas_equalTo(self.versionLab.mas_bottom).offset(15);
//    }];
    
    [self.jcTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-40);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.versionLab.mas_bottom).offset(40/2);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-JC_TabbarSafeBottomMargin-125);
    }];
    [self.jcBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth);
        make.height.mas_equalTo(125);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-JC_TabbarSafeBottomMargin);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    [self.jcBottomView addSubview:self.jcBTImg];
    [self.jcBTImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(195/2.0);
        make.height.mas_equalTo(195/2.0);
        make.centerY.mas_equalTo(self.jcBottomView.mas_centerY);
        make.left.mas_equalTo(self.jcBottomView.mas_left).offset(55/2.0);
    }];
    [self.jcBottomView addSubview:self.jcBBLab];
    [self.jcBottomView addSubview:self.jcBTLab];
    [self.jcBTLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-270/2);
        make.height.mas_equalTo(16);
        make.left.mas_equalTo(self.jcBTImg.mas_right).offset(15);
        make.top.mas_equalTo(self.jcBottomView.mas_top).offset(30);
    }];
    [self.jcBBLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KScreenWidth-270/2);
        make.left.mas_equalTo(self.jcBTImg.mas_right).offset(15);
        make.top.mas_equalTo(self.jcBTLab.mas_bottom).offset(15);
        make.height.mas_equalTo(40);
//        make.bottom.mas_equalTo(self.jcBottomView.mas_bottom);
    }];
    UILongPressGestureRecognizer *jcLong = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(jcSavePhotoAlbum:)];
    [self.jcBTImg addGestureRecognizer:jcLong];

}

- (void)jcSavePhotoAlbum:(UILongPressGestureRecognizer *)jcLongGes
{
    if (jcLongGes.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *jcSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
        jcSheet.tag = 8001;
        [jcSheet showInView:self.view];
    }
}
#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 8001) {
        
        if (buttonIndex == 0)
        {
            if ([self isCanSavePhoto]== NO) {
                NSString *title1 = @"请在iPhone的“设置－隐私－照片”选项中";
                NSString *title2 = @"允许";
                NSString *title3 = @"访问你的相册";
                NSString *proName = @"扎心闹钟";
                //如果没权限，给个友好的提示
                NSString *title = [NSString stringWithFormat:@"%@，%@%@%@",title1,title2,proName,title3];
                //无权限
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:self cancelButtonTitle:JCLocalStr(@"I got it", @"我知道了") otherButtonTitles:nil];
                [alert show];
                return;
            }
            else
            {
                CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
                
                if (version>=11.0)
                {
                    //IOS11
                    [self loadImageFinished:self.jcBTImg.image];
                    
                }
                else
                {
                    //有权限，去访问相册保存图片
                    UIImageWriteToSavedPhotosAlbum(self.jcBTImg.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
                    
                }
            }
        }
    }
}

//ios11保存图片
- (void)loadImageFinished:(UIImage *)image
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //写入图片到相册
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"success = %d, error = %@", success, error);
        if (success == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showMessage:@"保存成功" time:2];
            });
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showMessage:@"保存失败" time:2];
            });
            
            
        }
        
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error!=nil) {
        [MBProgressHUD showMessage:@"保存失败" time:2];
        
    }
    else
    {
        [MBProgressHUD showMessage:@"保存成功" time:2];
        
    }
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}
- (BOOL)isCanSavePhoto
{
    BOOL isCanSave = YES;
    CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
    if (version >= 11.0) {
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
        {
            // 无权限
            // do something...
            //无权限
            isCanSave = NO;
        }
        
        
    }
    else
    {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied)
        {
            //无权限
            isCanSave = NO;
        }
    }
    
    return isCanSave;
    
    
}
- (void)layoutNavigationBar
{
    self.navigationBarSelf.title = @"扎心闹钟";
}
#pragma mark - UITableViewDelegate

#pragma mark - Public

#pragma mark - Private

#pragma mark - Getter
- (UIImageView *)iconImg
{
    if (!_iconImg) {
        
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"微信二维码.jpg"];
    }
    return _iconImg;
}
- (UILabel *)versionLab
{
    if (!_versionLab) {
        
        _versionLab = [UILabel new];
        _versionLab.font = [UIFont systemFontOfSize:16];
        _versionLab.textColor = [ToolsHelper colorWithHexString:@"#000000"];
        _versionLab.text = [NSString stringWithFormat:@"版本号V%@",[ToolsHelper getAppVersion]];
        _versionLab.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLab;
}
- (UIImageView *)tipImg
{
    if (!_tipImg) {
        
        _tipImg = [UIImageView new];
        _tipImg.image = [UIImage imageNamed:@"关于我们.png"];
    }
    return _tipImg;
}
- (UITextView *)jcTextV
{
    if (!_jcTextV) {
        
        _jcTextV = [[UITextView alloc]init];
        _jcTextV.textColor = [ToolsHelper colorWithHexString:@"#000000"];
        _jcTextV.font = [UIFont systemFontOfSize:16];
        _jcTextV.text = @"hey！天将降大任于斯人、必先叫他起床！dei，我就是来叫你起床的！好吧，也是叫我起床…作为常年起床困难户，决定自己动手丰衣足食，于是就有了这个扎心闹钟。为了做闹钟里的蒂花之秀，我准备了许多神奇的魔音让大家一起摆脱频困！关机、结束进程和静音都不会响啊！你可憋又不想起床给我关了啊！好了，你要迟到了！";
        _jcTextV.editable = NO;
      
        
    }
    return _jcTextV;
}
- (UIView *)jcBottomView
{
    if (!_jcBottomView) {
        
        _jcBottomView = [UIView new];
        _jcBottomView.backgroundColor = UIColorWithRGB(235, 235, 235);
    }
    return _jcBottomView;
}
- (UIImageView *)jcBTImg
{
    if (!_jcBTImg) {
        
        _jcBTImg = [UIImageView new];
        _jcBTImg.image = [UIImage imageNamed:@"微信二维码.jpg"];
        _jcBTImg.userInteractionEnabled = YES;
    }
    return _jcBTImg;
}
- (UILabel *)jcBTLab
{
    if (!_jcBTLab) {
        _jcBTLab = [UILabel new];
        _jcBTLab.font = [UIFont boldSystemFontOfSize:16];
        _jcBTLab.textColor = [UIColor blackColor];
        _jcBTLab.text = @"微信公众号";
    }
    return _jcBTLab;
}
- (UILabel *)jcBBLab
{
    if (!_jcBBLab) {
        
        _jcBBLab = [UILabel new];
        if (isIphone_5) {
           _jcBBLab.font = [UIFont systemFontOfSize:11];
        }
        else
        {
           _jcBBLab.font = [UIFont systemFontOfSize:14];
        }
 
        _jcBBLab.lineBreakMode = NSLineBreakByWordWrapping;
        _jcBBLab.text = @"微信扫描二维码或点击二维码，保存图片，微信扫描识别即可关注";
        _jcBBLab.numberOfLines = 0;
       // _jcBBLab.backgroundColor = [UIColor redColor];
    }
    return _jcBBLab;
}
#pragma mark - Setter

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
