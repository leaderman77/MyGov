//
//  MGLicenceAgreamentView.m
//  MyGov
//
//  Created by Станислав on 14.11.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGLicenceAgreementView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static NSString * const viewName        = @"MGLicenceAgreementView";
static NSString * const viewIPhone5Name = @"MGLicenceAgreementViewIPhone5";
@interface MGLicenceAgreementView()

@property (strong, nonatomic) IBOutlet UITextView *agreementTextView;
@property (strong, nonatomic) IBOutlet UIButton *agreeBtn;
@property (strong, nonatomic) IBOutlet UILabel *licenceLabel;
@property (strong, nonatomic) IBOutlet UISwitch *agreeOrNot;


@end
@implementation MGLicenceAgreementView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
//        self.cbv = nil;
//        CGRect frame = CGRectMake(0, -2, 70, 30);
//        
//        SSCheckBoxViewStyle style = 1;
//        self.cbv = [[SSCheckBoxView alloc] initWithFrame:frame
//                                                   style:style
//                                                 checked:NO];
//        //[self.cbv setText:[NSString stringWithFormat:@""]];
//        self.cbv.userInteractionEnabled = NO;
//
//        
//        
//        [self.cbv setText:@""];
        
        if(IsIphone5)
        {
            [self commonInitIPhone5];
        }
        else
        {  
             [self commonInit];
        }
        
       
    }
    return self;
}

//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    NSLog(@"drawRect");
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, rect); // Очистим context
//    
//    CGContextSetRGBFillColor(context, 255, 0, 0, 1);
//    CGContextFillRect(context, CGRectMake(50, 70, 100, 100));
//    
//    if (self) {
//        [self commonInit];
//    }
//    
//}
- (IBAction)switched:(UISwitch *)sender
{
    if (sender.on)
    {
        _agreeBtn.enabled = YES;

    }
    else
    {
        _agreeBtn.enabled = NO;
    }
}

-(void)commonInit
{
    UIView *view = nil;
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:viewName
                                                     owner:self
                                                   options:nil];
    
    
    for (id object in objects) {
        if ([object isKindOfClass:[UIView class]]) {
            view = object;
            break;
        }
    }
    
    
    if (view != nil) {
        _containerView = view;
        view.frame = CGRectMake(0, 0, 280, 400);
        
        _licenceLabel = (UILabel *)[view viewWithTag:1111];
        _licenceLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        _licenceLabel.backgroundColor = [UIColor clearColor];
        _licenceLabel.textColor = UIColorFromRGB(0x585858);;

        
        _agreementTextView = (UITextView *)[view viewWithTag:1112];
        [_agreementTextView setBackgroundColor:[UIColor whiteColor]];
        [_agreementTextView.layer setBorderWidth:1.0f];
        [_agreementTextView.layer setBorderColor:[RGB(202, 202, 202) CGColor]];
        [view setBackgroundColor:RGB(244, 244, 244)];
        
        _agreeBtn  = (UIButton *)[view viewWithTag:1113];
        [_agreeBtn setBackgroundImage:[UIImage imageNamed:@"next_step.png"] forState:UIControlStateNormal];
        [_agreeBtn setBackgroundImage:[UIImage imageNamed:@"next_step_h.png"] forState:UIControlStateHighlighted];
        [_agreeBtn setTitle:@"Согласен" forState:UIControlStateNormal];
        [_agreeBtn setTitleColor:RGB(42, 182, 241) forState:UIControlStateNormal];
        [[_agreeBtn titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        view.opaque = YES;
        
        [self addSubview:view];
        [self bringSubviewToFront:view];
    }
}


-(void)commonInitIPhone5
{
    UIView *view = nil;
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:viewIPhone5Name
                                                     owner:self
                                                   options:nil];
    
    
    for (id object in objects) {
        if ([object isKindOfClass:[UIView class]]) {
            view = object;
            break;
        }
    }
    
    
    if (view != nil) {
        _containerView = view;
        view.frame = CGRectMake(0, 0, 280, 500);
        
        _licenceLabel = (UILabel *)[view viewWithTag:1111];
        _licenceLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        _licenceLabel.backgroundColor = [UIColor clearColor];
        _licenceLabel.textColor = UIColorFromRGB(0x585858);;
        
        
        _agreementTextView = (UITextView *)[view viewWithTag:1112];
        [_agreementTextView setBackgroundColor:[UIColor whiteColor]];
        [_agreementTextView.layer setBorderWidth:1.0f];
        [_agreementTextView.layer setBorderColor:[RGB(202, 202, 202) CGColor]];
        [view setBackgroundColor:RGB(244, 244, 244)];
        
        _agreeBtn  = (UIButton *)[view viewWithTag:1113];
        [_agreeBtn setBackgroundImage:[UIImage imageNamed:@"next_step.png"] forState:UIControlStateNormal];
        [_agreeBtn setBackgroundImage:[UIImage imageNamed:@"next_step_h.png"] forState:UIControlStateHighlighted];
        [_agreeBtn setTitle:@"Согласен" forState:UIControlStateNormal];
        [_agreeBtn setTitleColor:RGB(42, 182, 241) forState:UIControlStateNormal];
        [[_agreeBtn titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        view.opaque = YES;
        
        [self addSubview:view];
        [self bringSubviewToFront:view];
    }
}

- (IBAction)agreePressed:(UIButton *)sender
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"agreePressed" forKey:@"agreePressed"];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"agreePressed" object:nil userInfo:userInfo];
}
-(void)closeLicenceView
{
    [self removeFromSuperview];
}




@end
