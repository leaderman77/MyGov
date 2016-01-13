#import <Foundation/Foundation.h>



@class InformationVC;



@interface InformationVCHelper : NSObject

+(void)setupNavBarImage:(UINavigationBar*)navBar;

+(void)setupTabBarImage:(UITabBar*)tabBar;

+(UIView*)headerViewWithText:(NSString*)text
                    isOpened:(BOOL)isOpened
                     section:(int)section
                      target:(InformationVC*)target;

+(NSMutableArray*)fillDataArr;

+(void)updateSectionHeaderArrowImageWithSection:(int)section
                                       isOpened:(BOOL)isOpened
                                           view:(UIView*)view;

+(void)makeCompatibleWithIOS7:(InformationVC *)target;

@end
