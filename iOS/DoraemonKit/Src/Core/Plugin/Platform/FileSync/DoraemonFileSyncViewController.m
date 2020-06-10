//
//  DoraemonFileSyncViewController.m
//  DoraemonKit-DoraemonKit
//
//  Created by didi on 2020/6/10.
//

#import "DoraemonFileSyncViewController.h"
#import "DoraemonDefine.h"
#import "DoraemonFileSyncManager.h"

@interface DoraemonFileSyncViewController ()

@property (nonatomic, strong) UIImageView *bannerImage;
@property (nonatomic, strong) UIButton *ctrlBtn;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *ipLabel;

@end

@implementation DoraemonFileSyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = DoraemonLocalizedString(@"文件同步");
    
    _bannerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bigTitleView.doraemon_bottom, self.view.doraemon_width, kDoraemonSizeFrom750_Landscape(422))];
    _bannerImage.image = [UIImage doraemon_imageNamed:@"doraemon_file_sync_banner"];
    [self.view addSubview:_bannerImage];
    
    _ctrlBtn = [[UIButton alloc] init];
    _ctrlBtn.layer.cornerRadius = kDoraemonSizeFrom750_Landscape(8);
    [_ctrlBtn addTarget:self action:@selector(ctrlBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ctrlBtn];
    
    _tipLabel = [[UILabel alloc] init];
   
    _tipLabel.textColor = [UIColor doraemon_black_3];
    
    _tipLabel.font = [UIFont systemFontOfSize:kDoraemonSizeFrom750_Landscape(24)];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_tipLabel];
    
    _ipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _bannerImage.doraemon_bottom + kDoraemonSizeFrom750_Landscape(290), self.view.doraemon_width, kDoraemonSizeFrom750_Landscape(64))];
    _ipLabel.textColor = [UIColor doraemon_black_1];
    _ipLabel.textAlignment = NSTextAlignmentCenter;
    _ipLabel.font = [UIFont systemFontOfSize:kDoraemonSizeFrom750_Landscape(56)];
    [self.view addSubview:_ipLabel];
    
    [self refreshUIWithStatus:[DoraemonFileSyncManager sharedInstance].start];
}

- (BOOL)needBigTitleView{
    return YES;
}

- (void)ctrlBtnClick{
    BOOL status = [DoraemonFileSyncManager sharedInstance].start;
    status = !status;
    [DoraemonFileSyncManager sharedInstance].start = status;
    if (status) {
        [[DoraemonFileSyncManager sharedInstance] startServer];
    }else{
        [[DoraemonFileSyncManager sharedInstance] stop];
    }
    [self refreshUIWithStatus:status];
}

- (void)refreshUIWithStatus:(BOOL)start{
    if (start) {
        _ctrlBtn.frame = CGRectMake(self.view.doraemon_width/2-kDoraemonSizeFrom750_Landscape(300)/2, self.view.doraemon_height-kDoraemonSizeFrom750_Landscape(80)-kDoraemonSizeFrom750_Landscape(100), kDoraemonSizeFrom750_Landscape(300), kDoraemonSizeFrom750_Landscape(100));
        _ctrlBtn.backgroundColor = [UIColor doraemon_colorWithHexString:@"#F6F7F9"];
        [_ctrlBtn setTitleColor:[UIColor doraemon_blue] forState:UIControlStateNormal];
        [_ctrlBtn setTitle:@"关闭本地服务" forState:UIControlStateNormal];
        
        _tipLabel.frame = CGRectMake(0, _ipLabel.doraemon_bottom+kDoraemonSizeFrom750_Landscape(24), self.view.doraemon_width, kDoraemonSizeFrom750_Landscape(32));
        _tipLabel.text = @"请在Web端通过当前ip进行连接";
        
        _ipLabel.hidden = NO;
        NSURL *url = [DoraemonFileSyncManager sharedInstance].serverURL;
        
        _ipLabel.text = [NSString stringWithFormat:@"%@:%@",url.host,url.port];
    }else{
        _ctrlBtn.frame = CGRectMake(self.view.doraemon_width/2-kDoraemonSizeFrom750_Landscape(300)/2, _bannerImage.doraemon_bottom+kDoraemonSizeFrom750_Landscape(290), kDoraemonSizeFrom750_Landscape(300), kDoraemonSizeFrom750_Landscape(100));
        _ctrlBtn.backgroundColor = [UIColor doraemon_blue];
        [_ctrlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_ctrlBtn setTitle:@"开启本地服务" forState:UIControlStateNormal];
        
        _tipLabel.frame = CGRectMake(0, self.view.doraemon_height-kDoraemonSizeFrom750_Landscape(40)-kDoraemonSizeFrom750_Landscape(32), self.view.doraemon_width, kDoraemonSizeFrom750_Landscape(32));
        _tipLabel.text = @"提示：点击按钮开启本地服务";
        
        _ipLabel.hidden = YES;
        _ipLabel.text = @"";
    }
}

@end
