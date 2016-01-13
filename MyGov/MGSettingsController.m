//
//  MGSettingsController.m
//  MyGov
//
//  Created by Alpha on 27.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGSettingsController.h"
#import "MMPickerView.h"
#import "TSLanguageManager.h"

@interface MGSettingsController () {

    UILabel *navBarLabel;
    
    UIPickerView *myPickerView;
    UILabel *langRightLabel;
    NSString *selectedValue;
}
@end

@implementation MGSettingsController

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
    
    
    navBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, titlesOffsetY, 280, 65)];
    navBarLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    navBarLabel.lineBreakMode = NSLineBreakByWordWrapping;
    navBarLabel.numberOfLines = 2;
    navBarLabel.text = [TSLanguageManager localizedString:@"MAIN_TITLE_SETTINGS"];
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
    
    UIButton *openButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-(305/2), 120, 305, 33)];
    [openButton setBackgroundImage:[UIImage imageNamed:@"btn_h.png"] forState:UIControlStateNormal];
    [openButton setBackgroundImage:[UIImage imageNamed:@"btn_click_h.png"] forState:UIControlStateHighlighted];
    [openButton setTitle:@"Сменить язык" forState:UIControlStateNormal];
    [openButton setTitle:@"Сменить язык" forState:UIControlStateHighlighted];
    [openButton addTarget:self action:@selector(changeLanguage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:openButton];
    
    UILabel *langLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 47, 35)];
    langLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    langLabel.textColor = [UIColor blackColor];
    langLabel.text = @"Язык: ";
    langLabel.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:langLabel];
    
    langRightLabel = [[UILabel alloc] initWithFrame:CGRectMake(langLabel.frame.size.width+10, 80, 100, 35)];
    langRightLabel.textAlignment = NSTextAlignmentLeft;
    langRightLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    langRightLabel.textColor = RGB(39, 179, 238); //[UIColor lightGrayColor];
    langRightLabel.text = @"Русский";
    langRightLabel.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:langRightLabel];
    
    
    self.languages = [[NSMutableArray alloc] initWithObjects:@"Русский", @"Узбекский", nil];
    
}

-(void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)changeLanguage:(UIButton *)sender
{
    /*
    NSArray *objects = self.languages; //@[@"This is a mix of objects", @14, @13.3, @"A string", @1000];
    
    [MMPickerView showPickerViewInView:self.view
                           withObjects:objects
                           withOptions:nil
               objectToStringConverter:^NSString *(id object) {
                   //This is where you convert your object and return a string, for eg. return person.name;
                   return [object description];
                   
               }
                            completion:^(id selectedObject) {
                                //The selected object is returned, and you can use the value as you wish
                                //For example: self.label.text = person.name;
                                langRightLabel.text = [selectedObject description];
                                NSLog(@"DOne Pressed!");
                            }];
    
    */
    NSArray *strings = self.languages;
    
    
    UIFont *customFont  = [UIFont fontWithName:@"Helvetica" size:23.0];
    NSDictionary *options = @{MMbackgroundColor: RGB(231, 231, 231),
                              MMtextColor: RGB(59, 59, 59),
                              MMtoolbarColor: [UIColor blackColor],
                              MMbuttonColor: [UIColor blackColor],
                              MMfont: customFont,
                              MMvalueY: @5};
        
    [MMPickerView showPickerViewInView:self.view
                           withStrings:strings
                           withOptions:options
                            completion:^(NSString *selectedString) {
                                //selectedString is the return value which you can use as you wish
                                langRightLabel.text = selectedString;
                                
                                
                                if ([selectedString isEqualToString:@"Русский"]) {
                                    NSLog(@"RU Choosed!");
                                    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
                                    [defaults setObject:@"ru" forKey:isitFirstLunch];
                                    [defaults synchronize];
                                    
                                    [TSLanguageManager setSelectedLanguage:@"ru"];
                                    navBarLabel.text = [TSLanguageManager localizedString:@"MAIN_TITLE_SETTINGS"];
                                } else {
                                    NSLog(@"UZ Choosed!");
                                    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
                                    [defaults setObject:@"uz" forKey:isitFirstLunch];
                                    [defaults synchronize];
                                    
                                    [TSLanguageManager setSelectedLanguage:@"uz"];
                                    navBarLabel.text = [TSLanguageManager localizedString:@"MAIN_TITLE_SETTINGS"];
                                }
                                
                            }];
     

}


@end
