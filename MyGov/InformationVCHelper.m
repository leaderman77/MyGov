#import "InformationVCHelper.h"
#import "MGStepTwo.h"
//#import "CoreDataHelper.h"
#import "MGAppDelegate.h"
#import "TYSingleton.h"



@implementation InformationVCHelper



+(void)setupNavBarImage:(UINavigationBar*)navBar
{
    if( [navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        NSArray * vComp = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
        UIImage * image;
        
        if( [[vComp objectAtIndex:0] intValue] >= 7 )
            image = [UIImage imageNamed:@"navbar7"];
        else
            image = [UIImage imageNamed:@"navbar"];

        [navBar setBackgroundImage:image
                     forBarMetrics:UIBarMetricsDefault];
    }
}

+(void)setupTabBarImage:(UITabBar*)tabBar
{
    if( [tabBar respondsToSelector:@selector(setBackgroundImage:)] )
        [tabBar setBackgroundImage:[UIImage imageNamed:@"tabBar"]];
}

+(UIView*)headerViewWithText:(NSString *)text
                    isOpened:(BOOL)isOpened
                     section:(int)section
                      target:(InformationVC *)target
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];

    UIImageView * fonIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"plashka.png"]];
    fonIV.frame = view.frame;
    [view addSubview:fonIV];
    
    UILabel * label = [self labelWithText:text];
    [view addSubview:label];
    
    UIImageView * arrowIV = [self arrowIV:isOpened];
    [view addSubview:arrowIV];
    
    UIButton * button = [self buttonWithTag:section
                                     target:target];
    [view addSubview:button];
    
    return view;
}


+(UILabel*)labelWithText:(NSString*)text
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 285, 31)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = text;
    label.font = [UIFont fontWithName:@"Helvetica" size:15];
    
    return label;
}





+(UIImageView*)arrowIV:(BOOL)isOpened
{
    NSString * name = isOpened ? @"indicator_blue" : @"indicator_blue";
    
    UIImage * image = [UIImage imageNamed:name];
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    imageView.tag = 4444;
    
    imageView.frame = CGRectMake(285 + (40 - image.size.width) / 2.0,
                                 (31 - image.size.height) / 2.0,
                                 image.size.width,
                                 image.size.height);
    
    return imageView;
}





+(UIButton*)buttonWithTag:(int)tag
                   target:(InformationVC*)target
{
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 31)];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTag:tag];

    [button addTarget:target
               action:@selector(sectionOpenClosePressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}



+(NSMutableArray*)fillDataArr
{
    NSMutableArray * resArr = [NSMutableArray array];
    
    
    // section 1
    
    NSMutableDictionary * sectionDic = [NSMutableDictionary dictionary];
    
    NSMutableArray * arr = [sectionDic objectForKey:@"arr"];
    
    /*
    sectionDic = [NSMutableDictionary dictionary];
    
    [sectionDic setObject:@"Моя категория" forKey:@"title"];
    [sectionDic setObject:[NSNumber numberWithBool:NO] forKey:@"is_opened"];
    [sectionDic setObject:[NSMutableArray array] forKey:@"arr"];
    
    arr = [sectionDic objectForKey:@"arr"];
    
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                    @"О приложении", @"title",
                    @"about", @"webName",
                    nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                    @"О приложении", @"title",
                    @"about", @"webName",
                    nil]];

    
    [resArr addObject:sectionDic];
    
    // section 2
    sectionDic = [NSMutableDictionary dictionary];
    
    [sectionDic setObject:@"О приложении" forKey:@"title"];
    [sectionDic setObject:[NSNumber numberWithBool:NO] forKey:@"is_opened"];
    [sectionDic setObject:[NSMutableArray array] forKey:@"arr"];
    
    arr = [sectionDic objectForKey:@"arr"];
    
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                    @"О приложении", @"title",
                    @"about", @"webName",
                    nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                    @"О приложении", @"title",
                    @"about", @"webName",
                    nil]];
    
    [resArr addObject:sectionDic];
    */
    ///// load with for
    
    for (int i=0; i < [[[TYSingleton getinstance] step2Headers] count]; i++) {
        sectionDic = [NSMutableDictionary dictionary];
        
        NSString *catName = [NSString stringWithFormat:@"%@", [[[[TYSingleton getinstance] step2Headers] objectAtIndex:i] objectForKey:@"name_ru"]];
        
        [sectionDic setObject:catName forKey:@"title"];
        [sectionDic setObject:[NSNumber numberWithBool:NO] forKey:@"is_opened"];
        [sectionDic setObject:[NSMutableArray array] forKey:@"arr"];
        
        NSMutableArray * arr = [sectionDic objectForKey:@"arr"];
        for (int j=0; j < [[[[TYSingleton getinstance] step2Body] objectAtIndex:i] count]; j++) {
            
            NSString *name = [[[[TYSingleton getinstance] step2Body] objectAtIndex:i] objectAtIndex:j];
            
            [arr addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                            name, @"title",
                            @"NO", @"selected",
                            nil]];
        }
        [resArr addObject:sectionDic];
    }
    
    
    //NSLog(@"#### RES-ARR ####: %@", resArr);
    
    return resArr;
}



+(void)updateSectionHeaderArrowImageWithSection:(int)section
                                       isOpened:(BOOL)isOpened
                                           view:(UIButton*)view
{
    UIImageView * imageView = (UIImageView*)[view viewWithTag:4444];
    //UIButton *imageView = (UIButton*)[view viewWithTag:view.tag];
    CGPoint center = imageView.center;
    
    UIImage * imageIndicator = [UIImage imageNamed:@"indicator_blue.png"];
    imageView.image = imageIndicator;
    
    if (!isOpened) {
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn)
                     animations:^{
                        //[imageView setImage:image];
                             imageView.transform = CGAffineTransformMakeRotation( 0 * M_PI  / 180);
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Face right done");
                     }];
    } else {
        [UIView animateWithDuration:0.9
                              delay:0.0
                            options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                         animations:^{
                             //[imageView setImage:image];
                             imageView.transform = CGAffineTransformMakeRotation( 180 * M_PI  / 180);                         }
                         completion:^(BOOL finished){
                             NSLog(@"Face right done");
                         }];
    }
    
    //imageView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    //CGFloat angle = 7 / 12.0 * M_PI * 2.0;
    //imageView.transform = CGAffineTransformRotate(15, 90);
    
    imageView.frame = CGRectMake(0, 0, imageIndicator.size.width, imageIndicator.size.height);
    imageView.center = center;
}


+(void)makeCompatibleWithIOS7:(InformationVC *)target
{
//    if( [target respondsToSelector:@selector(edgesForExtendedLayout)] )
//        target.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    //NSDictionary * dic = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
      //                                               forKey:UITextAttributeTextColor];
    
    
    //NSArray * vComp = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
}


@end
