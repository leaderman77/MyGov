//
//  MGPostAppealController.m
//  MyGov
//
//  Created by Alpha on 28.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGPostAppealController.h"
#import <QuartzCore/QuartzCore.h>
#import "MGAppDelegate.h"
#import "RTLabel.h"
#import "RadioButton.h"
#import "MGStepOne.h"
#import "MGStepTwo.h"
#import "MGLicenceAgreementView.h"
#import "DimView.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface MGPostAppealController () {
    int counter;
    
    UITextField *inputTextField;
    RTLabel *label;
    NSString *customText;
    UILabel *navBarLabel;
    
    NSMutableArray* buttons;
    
    MGStepOne *st1;
    MGStepTwo *st2;
    MGStepThird *st3;
    MGLicenceAgreementView *licence;
    DimView *dimView;

    
    UIView *view1;
    UIView *view2;
    
    UIImageView *navBar;
}

@end

@implementation MGPostAppealController
@synthesize stepsBar;

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
    
    //[self.view removeConstraints:self.view.constraints];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    //self.view.tag = 7777;
    
    navBar = [[UIImageView alloc] init];
    navBar.image = [UIImage imageNamed:@"navbar_.png"];
    
    [self.view addSubview:navBar];
    
    if (!IS_OS_7_OR_LATER) {
        navBar.frame = CGRectMake(0, -sb_height/2, 320, 66);
    } else {
        navBar.frame = CGRectMake(0, 0, 320, 66);
    }
    
    [self.view addSubview:navBar];
    
    counter = 0;
    
    navBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, titlesOffsetY, 280, 65)];
    navBarLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    navBarLabel.lineBreakMode = NSLineBreakByWordWrapping;
    navBarLabel.numberOfLines = 2;
    navBarLabel.text = @"Идентифицироваться";
    navBarLabel.textAlignment = NSTextAlignmentCenter;
    navBarLabel.textColor = [UIColor whiteColor];
    navBarLabel.backgroundColor = [UIColor clearColor];
    
    [navBar addSubview:navBarLabel];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 28-[TYSingleton getinstance].insetY, 45, 30);
    
    [[backButton imageView] setContentMode: UIViewContentModeCenter];
    [backButton setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    
    UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    callButton.frame = CGRectMake(self.view.frame.size.width-50, 28-[TYSingleton getinstance].insetY, 45, 30);
    
    [[callButton imageView] setContentMode: UIViewContentModeCenter];
    [callButton setImage:[UIImage imageNamed:@"call_service.png"] forState:UIControlStateNormal];
    [callButton addTarget:self action:@selector(getCall:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:callButton];
    
    UIImageView *substrateForBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 66-[TYSingleton getinstance].insetY, 320, 43)];
    substrateForBar.image = [UIImage imageNamed:@"substrate.png"];
    
    [self.view addSubview:substrateForBar];
    
    stepsBar = [[UIImageView alloc] initWithFrame:CGRectMake(0.5, 69-[TYSingleton getinstance].insetY, 320, 34)];
    [stepsBar setContentMode:UIViewContentModeCenter];
    [stepsBar setImage:[UIImage imageNamed:@"Steps_bar_1.png"]];
    
    [self.view addSubview:stepsBar];
    

    

    
    st1 = [[MGStepOne alloc] initWithFrame:CGRectMake(0, 66+40-[TYSingleton getinstance].insetY, 320, (self.view.frame.size.height-105)+[TYSingleton getinstance].insetY)];
    [st1 initAllObjects];
    st1.mainDelegate = self;
    [st1 setContentSize:(CGSizeMake(320, 660))];
    [st1 setTag:111];
    
    [self.view insertSubview:st1 belowSubview:navBar];
    

    
    st2 = [[MGStepTwo alloc] init];
    st2.mainDelegate = self;
    
    [st2.view setFrame:CGRectMake(0, 106-[TYSingleton getinstance].insetY, 320, self.view.frame.size.height-105)];
    //[st2 initAllObjects];
    [self.view insertSubview:st2.view belowSubview:st1];
    [st2.view setHidden:YES];
    
    st3 = [[MGStepThird alloc] initWithFrame:CGRectMake(0, 66+20+[TYSingleton getinstance].insetY, 320, (self.view.frame.size.height-85)-[TYSingleton getinstance].insetY)];
    st3.mainDelegate = self;
    [st3 initAllObjects];
    [st3 setContentSize:(CGSizeMake(320, 480))];
    [st3 setTag:111];
    [st3 setHidden:YES];
    
    //[self addStepsBar:3];
    
    [self.view insertSubview:st3 belowSubview:st2.view];
    
    [st1 setScrollEnabled:NO];
    dimView = [[DimView alloc] initWithFrame:CGRectMake(0, 0, 320, 600)];
    [self.view addSubview:dimView];
    

    //[self.view insertSubview:dimView belowSubview:navBar];
    
    if(IsIphone5)
    {
        licence = [[MGLicenceAgreementView alloc]initWithFrame:CGRectMake(20, 66-[TYSingleton getinstance].insetY, 280, 500)];
    }
    else
    {
        licence = [[MGLicenceAgreementView alloc]initWithFrame:CGRectMake(20, 66-[TYSingleton getinstance].insetY, 280, 400)];
    }
    //licence = [[MGLicenceAgreementView alloc]initWithFrame:CGRectMake(20, 66-[TYSingleton getinstance].insetY, 280, 400)];
    //licence = [[MGLicenceAgreementView alloc]init];
    licence.alpha=1;
    //[self.view insertSubview:licence belowSubview:navBar];
    [self.view addSubview:licence];
    [self.view bringSubviewToFront:licence];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"agreePressed"
                                               object:nil];
    
    

    
    //[stepTwoScrollView secondHide];
    //[st2 setAlpha:0.2];
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView tag]);
    [alertView close];
}

-(void)openPickerForImage {
    [self selectPhotos];
}

- (void)selectPhotos
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    //imageView.image = image;
    [TYSingleton getinstance].imageFromPhone = image;
    NSLog(@"#IMAGE# : %@", [image description]);
    NSLog(@"##################### HERE IMAGE ################");
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    __block NSString *fName = [[NSString alloc] init];
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        NSString *fileName = [representation filename];
        fName = [representation filename];
        NSLog(@"fileName : %@ == %@", fileName, fName);
        [TYSingleton getinstance].imageFromPhoneName = fileName;
        [st3 checkSelectedPhoto:fileName];
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageURL
                   resultBlock:resultblock
                  failureBlock:nil];
    
    //NSURL *urlPath = [info valueForKey:UIImagePickerControllerReferenceURL];
    UIImage *cameraImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSData *myData = UIImagePNGRepresentation(cameraImage);
    
    [TYSingleton getinstance].imageFromPhone = cameraImage;
    
    [picker dismissModalViewControllerAnimated:YES];    
    //NSLog(@"fName : %@", fName);
    //[st3 checkSelectedPhoto:fName];
}


-(void)addStepsBar:(int)number {
    
    if (number == 3) {
        UIImage * toImage3 = [UIImage imageNamed:@"Steps_bar_3.png"];
        [UIView transitionWithView:stepsBar
                          duration:1.0f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            [stepsBar setImage:toImage3];
                            //[self.view setBackgroundColor:[UIColor greenColor]];
                            
                        } completion:^(BOOL fnd){
                        }];
    }
    if (number == 2) {
        UIImage * toImage2 = [UIImage imageNamed:@"Steps_bar_2.png"];
        
        [UIView transitionWithView:stepsBar
                          duration:1.0f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            stepsBar.image = toImage2;
                        } completion:^(BOOL done) {
                        }];
    }
    if (number == 1) {
        UIImage * toImage1 = [UIImage imageNamed:@"Steps_bar_1.png"];
        
        [UIView transitionWithView:stepsBar
                          duration:1.0f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            stepsBar.image = toImage1;
                        } completion:nil];
    }
}

-(void)moveToStepOne {
    //[st1 setHidden:YES];
    [st2.view setHidden:YES];
    [st3 setHidden:YES];
    [st1 setHidden:NO];
    [navBarLabel setText:@"Идентифицироваться"];
    [self.view insertSubview:st1 belowSubview:navBar];
    [self addStepsBar:1];
}

-(void)moveToStepTwo {
    [st1 setHidden:YES];
    //[st2.view setHidden:YES];
    [st3 setHidden:YES];
    [st2.view setHidden:NO];
    [navBarLabel setText:@"Выбор организации"];
    [self.view insertSubview:st2.view belowSubview:navBar];
    [self addStepsBar:2];
}

-(void)moveToStepThree {
    [st1 setHidden:YES];
    [st2.view setHidden:YES];
    //[st3 setHidden:YES];
    [st3 setHidden:NO];
    [st2.view setHidden:YES];
    [navBarLabel setText:@"Заполнение формы"];
    [self.view insertSubview:st3 belowSubview:navBar];
    [self addStepsBar:3];
}


-(void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getBack {
    
    [TYSingleton getinstance].sendOrNot = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getCall:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callNumber]];
    //view1.alpha = 0.2;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - NSConnection Methods

-(void)getCategories {
    dataforc = [[NSMutableData alloc] initWithCapacity:0];
//    NSString *urlAsString = @"http://saidazim.my.dev.gov.uz/mobileapi/getCategories";
    NSString *urlAsString = @"https://my.gov.uz/mobileapi/getCategories";
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"POST"];
    NSMutableString *body = [[NSMutableString alloc] init];
    
    [body appendString:[NSString stringWithFormat:@"%@", urlAsString]];
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    connec = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [connec start];
    NSLog(@"URL: %@", url);
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"#e# Авторизация НЕ получилась! ");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization
                     JSONObjectWithData:dataforc options:NSJSONReadingAllowFragments error:&error];
    if ([jsonObject isKindOfClass:[NSArray class]]){
        NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
        //NSLog(@"IF dict: %@", deserializedDictionary);
        for (NSDictionary *obj in deserializedDictionary) {
            NSString *name = [obj objectForKey:@"name_ru"];
            //NSLog(@"%@", name);
            [self.categoriesList addObject:[NSString stringWithFormat:@"%@", name]];
        }
        [TYSingleton getinstance].step2Headers = self.categoriesList;
    }
    //NSLog(@"Cat list: %@", self.categoriesList);
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == connec)
    {
        [dataforc appendData:data];
    }
}

-(void)receiveNotification : (NSNotification *)notification
{
    //handling the notification with beacons
    
    if ([notification.name isEqualToString:@"agreePressed"])
    {
        [licence closeLicenceView];
        [dimView removeFromSuperview];
        [st1 setScrollEnabled:YES];
    }
    else
    {
    
    }
}


@end
