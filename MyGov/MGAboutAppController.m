//
//  MGAboutAppController.m
//  MyGov
//
//  Created by Alpha on 27.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGAboutAppController.h"

@interface MGAboutAppController ()

@end

@implementation MGAboutAppController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view setBackgroundColor:RGB(244, 244, 244)];

    
    
    UIImageView *navBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0-[TYSingleton getinstance].insetY, 320, 66)];
    navBar.image = [UIImage imageNamed:@"navbar_.png"];
    
    [self.view addSubview:navBar];
    
    
    UILabel *navBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, titlesOffsetY, 280, 65)];
    navBarLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    navBarLabel.lineBreakMode = NSLineBreakByWordWrapping;
    navBarLabel.numberOfLines = 2;
    navBarLabel.text = @"О приложении";
    navBarLabel.textAlignment = NSTextAlignmentCenter;
    navBarLabel.textColor = [UIColor whiteColor];
    navBarLabel.backgroundColor = [UIColor clearColor];
    
    [navBar addSubview:navBarLabel];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 28-[TYSingleton getinstance].insetY, 45, 30);
    //UIImageView *arr = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 17)];
    
    [[backButton imageView] setContentMode: UIViewContentModeCenter];
    [backButton setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    
    
    UIImageView *bigLogo = [[UIImageView alloc] initWithFrame:CGRectMake(19/2, 70, 301, 113)];
    [bigLogo setImage:[UIImage imageNamed:@"logo_about.png"]];
    
    [self.view addSubview:bigLogo];
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 188, 310, self.view.frame.size.height-(188+5))];
    textView.textColor = [UIColor grayColor];
    textView.text = @"В этом примере, когда мы жмем кнопку закрытия окна, окно не сразу закрывается, а передается команда ядру с указанием идентификатора окна. На этом, кстати, выполнение цепочки кода заканчивается, саму команду может обработать xуже другой поток внутри программы. При этом ядро может разослать всем (или только заинтересованным) модулям сообщение, что такое-то окно закрывается, выполнить какие-то общие действия, связанные с закрытием окна. И только потом сообщает окну, чтобы оно закрылось. Полная гибкость и контроль, ценой некоторого оверхеда при обработке команд. В этом примере, когда мы жмем кнопку закрытия окна, окно не сразу закрывается, а передается команда ядру с указанием идентификатора окна. На этом, кстати, выполнение цепочки кода заканчивается, саму команду может обработать уже другой поток внутри программы. При этом ядро может разослать всем (или только заинтересованным) модулям сообщение, что такое-то окно закрывается, выполнить какие-то общие действия, связанные с закрытием окна. И только потом сообщает окну, чтобы оно закрылось. Полная гибкость и контроль, ценой некоторого оверхеда при обработке команд. В этом примере, когда мы жмем кнопку закрытия окна, окно не сразу закрывается, а передается команда ядру с указанием идентификатора окна. На этом, кстати, выполнение цепочки кода заканчивается, саму команду может обработать уже другой поток внутри программы. При этом ядро может разослать всем (или только заинтересованным) модулям сообщение, что такое-то окно закрывается, выполнить какие-то общие действия, связанные с закрытием окна. И только потом сообщает окну, чтобы оно закрылось. Полная гибкость и контроль, ценой некоторого оверхеда при обработке команд.";
    
    textView.font = [UIFont fontWithName:@"Helvetica" size:15];
    textView.backgroundColor = RGB(244, 244, 244);
    [textView flashScrollIndicators];
    
    //[scroll addSubview:textView];
    [self.view addSubview:textView];
    
}


-(void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end



