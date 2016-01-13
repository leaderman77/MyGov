//
//  MGStepTwo.m
//  MyGov
//
//  Created by Alexander Makshov on 04.04.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGStepTwo.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "SSCheckBoxView.h"
#import "UIHelpers.h"
#import "MGStepTwoCell.h"
#import "InformationVCHelper.h"

@interface MGStepTwo () {
    NSMutableDictionary *tempDic;
}

@property (nonatomic, strong) NSMutableArray *contents;

@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (assign, nonatomic) int openedSection;

@end

static NSString *cellReusableIdentif = @"cellStepTwoIdentifier";

@implementation MGStepTwo
@synthesize yourSeperatedData;
@synthesize arrData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray *)contents
{
    NSMutableArray *globalArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    [globalArray addObject:[[TYSingleton getinstance] step2Headers]];
    
    if (!_contents) {
        
        /*_contents = @[@[@[@"Section0_Row0", @"S0Row0_Subrow1",@"S0Row0_Subrow2", @"S0Row0_Subrow3"],
                        @[@"Section0_Row1", @"S1Row1_Subrow1", @"S1Row1_Subrow2", @"S1Row1_Subrow3", @"S1Row1_Subrow4", @"S1Row1_Subrow5", @"S1Row1_Subrow6", @"S1Row1_Subrow7", @"S1Row1_Subrow8", @"S1Row1_Subrow9", @"S1Row1_Subrow10", @"S1Row1_Subrow11", @"S1Row1_Subrow12"],
                        @[@"Section0_Row2", @"S2Row1_Subrow1", @"S2Row1_Subrow2", @"S2Row1_Subrow3"]],
                      ];
         */
        
        _contents = globalArray;
        
    }
    return _contents;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.tableView deselectRowAtIndexPath:self.selectedIndexPath
                                  animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view setOpaque:YES];
    
    self.tableView.frame = CGRectMake(0, 0, 320, 427);
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    
    self.st3 = [[MGStepThird alloc] init];
    self.st1 = [[MGStepOne alloc] init];
    UIButton *nextStep;
    UIButton *prevStep;
    if(IsIphone5)
    {
        //your stuff
        nextStep = [[UIButton alloc] initWithFrame:CGRectMake(168, (self.view.frame.size.height-60), 142, 35)];
        prevStep = [[UIButton alloc] initWithFrame:CGRectMake(10, (self.view.frame.size.height-60), 142, 35)];

    }
    else
    {
        //your stuff
        nextStep = [[UIButton alloc] initWithFrame:CGRectMake(168, (self.view.frame.size.height-60)-90, 142, 35)];
        prevStep = [[UIButton alloc] initWithFrame:CGRectMake(10, (self.view.frame.size.height-60)-90, 142, 35)];

    }
    
    if (!IS_OS_7_OR_LATER) {
        nextStep.frame = CGRectMake(168, (self.view.frame.size.height-60)-75, 142, 35);
    }
    [nextStep setBackgroundImage:[UIImage imageNamed:@"next_step.png"] forState:UIControlStateNormal];
    [nextStep setBackgroundImage:[UIImage imageNamed:@"next_step_h.png"] forState:UIControlStateHighlighted];
    [nextStep setTitle:@"Следующий шаг" forState:UIControlStateNormal];
    [nextStep setTitleColor:RGB(42, 182, 241) forState:UIControlStateNormal];
    [[nextStep titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [nextStep addTarget:self action:@selector(goToTheNextStep:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextStep];
    
    
    if (!IS_OS_7_OR_LATER) {
        prevStep.frame = CGRectMake(10, (self.view.frame.size.height-60)-75, 142, 35);
    }
    [prevStep setBackgroundImage:[UIImage imageNamed:@"next_step.png"] forState:UIControlStateNormal];
    [prevStep setBackgroundImage:[UIImage imageNamed:@"next_step_h.png"] forState:UIControlStateHighlighted];
    [prevStep setTitle:@"Предыдущий шаг" forState:UIControlStateNormal];
    [prevStep setTitleColor:RGB(42, 182, 241) forState:UIControlStateNormal];
    [[prevStep titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [prevStep addTarget:self action:@selector(goToThePrevStep:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:prevStep];
    
    
    
    //[InformationVCHelper makeCompatibleWithIOS7:self];
    [InformationVCHelper setupNavBarImage:self.navigationController.navigationBar];
    [InformationVCHelper setupTabBarImage:self.tabBarController.tabBar];
    
    self.dataArr = [InformationVCHelper fillDataArr];
    
    if (IS_OS_7_OR_LATER) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    [self.tableView registerClass:[MGStepTwoCell class] forCellReuseIdentifier:cellReusableIdentif];
    
    //NSLog(@"Content: %@", [self contents]);
    //NSLog(@"Trace arr: %@", [TYSingleton getinstance].step2Headers);
    
    yourSeperatedData = [[NSMutableArray alloc] init];
    yourSeperatedData = [TYSingleton getinstance].selectedRows;
    //[yourSeperatedData addObjectsFromArray:[TYSingleton getinstance].selectedRows];
    arrData = [[NSMutableArray alloc] initWithArray:[_contents objectAtIndex:0]];
    //NSLog(@"ArrData: %@", yourSeperatedData);
    
    tempDic = [[NSMutableDictionary alloc] init];
    self.idBox = [[NSMutableArray alloc] init];
}

-(void)goToTheNextStep:(UIButton *)sender {
    [self.mainDelegate moveToStepThree];
}

-(void)goToThePrevStep:(UIButton *)sender {
    [self.mainDelegate moveToStepOne];
}

-(void)showView {
    [self.view setHidden:NO];
    self.view.frame = CGRectMake(0, 106, 320, self.view.frame.size.height-105);
}

-(void)hideView {
    [self.view setHidden:YES];
}

#pragma mark – actions
-(void)updateTable
{
    self.dataArr = [InformationVCHelper fillDataArr];
    [self.tableView reloadData];
}



-(void)sectionOpenClosePressed:(id)sender
{
    UIButton * button = (UIButton*)sender;
    int section = button.tag;
    
    self.openedSection = button.tag;
    NSLog(@"Opened With tag: %i", self.openedSection);
   
    
    NSMutableDictionary * sectionDic = [self.dataArr objectAtIndex:section];
    BOOL isSectionOpened = [[sectionDic objectForKey:@"is_opened"]boolValue];
    NSMutableArray * arr = [sectionDic objectForKey:@"arr"];
    
    /*
    for (int k=0; k < [self.dataArr count]; k++) {
        NSMutableDictionary * sectionDicK = [self.dataArr objectAtIndex:k];
        BOOL isSectionOpenedK = [[sectionDicK objectForKey:@"is_opened"]boolValue];
        NSMutableArray * arrK = [sectionDicK objectForKey:@"arr"];
        
        NSLog(@"### K: %hhd", isSectionOpenedK);
        
        NSMutableArray * indexPathsArrK = [NSMutableArray array];
        
        if (isSectionOpenedK == 1) {
        for(int p = 0; p < [arrK count]; p++)
        {
            NSIndexPath * newPathK = [NSIndexPath indexPathForRow:p inSection:k];
            [indexPathsArrK addObject:newPathK];
        }
        
        if( isSectionOpened )
        {
            NSLog(@"Section Сlosed: %i", k);
        }
        else
        {
            NSLog(@"Section Opened: %i", k);
            [self.tableView beginUpdates];
            // your code goes here
            [self.tableView deleteRowsAtIndexPaths:indexPathsArrK
                                  withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        }
        }
    }
    */
    isSectionOpened = !isSectionOpened;
    
    [sectionDic setObject:[NSNumber numberWithBool:isSectionOpened]
                   forKey:@"is_opened"];
    
    [InformationVCHelper updateSectionHeaderArrowImageWithSection:section
                                                         isOpened:isSectionOpened
                                                             view:[button superview]];
    
    
    NSMutableArray * indexPathsArr = [NSMutableArray array];
    
    for(int i = 0; i < [arr count]; i++)
    {
        NSIndexPath * newPath = [NSIndexPath indexPathForRow:i inSection:section];
        [indexPathsArr addObject:newPath];
    }
    
    if( isSectionOpened )
    {
        [self.tableView insertRowsAtIndexPaths:indexPathsArr
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        [self.tableView deleteRowsAtIndexPaths:indexPathsArr
                              withRowAnimation:UITableViewRowAnimationFade];
    }
}





#pragma mark – table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 31;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSMutableDictionary * sectionDic = [self.dataArr objectAtIndex:section];
    NSString * sectionTitle = [sectionDic objectForKey:@"title"];
    BOOL isSectionOpened = [[sectionDic objectForKey:@"is_opened"]boolValue];
    
    UIView * view = [InformationVCHelper headerViewWithText:sectionTitle
                                                   isOpened:isSectionOpened
                                                    section:section
                                                     target:self];
    view.tag = section;
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableDictionary * sectionDic = [self.dataArr objectAtIndex:section];
    BOOL isSectionOpened = [[sectionDic objectForKey:@"is_opened"]boolValue];
    
    if( isSectionOpened )
    {
        NSMutableArray * arr = [sectionDic objectForKey:@"arr"];
        return [arr count];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGStepTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellReusableIdentif forIndexPath:indexPath];
    
    NSMutableDictionary * sectionDic = [self.dataArr objectAtIndex:indexPath.section];
    NSMutableArray * arr = [sectionDic objectForKey:@"arr"];
    NSMutableDictionary * dic = [arr objectAtIndex:indexPath.row];
    
    //cell.textLabel.text = [dic objectForKey:@"title"];
    //cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.mgLabel.text = [dic objectForKey:@"title"];
    
    [cell.cbv setStateChangedTarget:self
                           selector:@selector(checkBoxViewChangedState:)];
    
    //if (yourSeperatedData && [[[yourSeperatedData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isEqualToString:@"YES"])
    if ([[dic objectForKey:@"selected"] isEqualToString:@"YES"])
    {
        [cell.cbv setChecked:YES];
    } else {
        [cell.cbv setChecked:NO];
    }
    //NSLog(@"Selected? : %@", [dic objectForKey:@"selected"]);
    
    cell.cbv.tag = indexPath.row;
    //NSLog(@"TRACE: %i %i %i", indexPath.section, indexPath.row, indexPath.subRow);
    return cell;
}


#pragma mark – table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.openedSection = indexPath.section;
    
    NSLog(@"Cell select: %@", indexPath);
    
    NSMutableDictionary * sectionDic = [self.dataArr objectAtIndex:indexPath.section];
    NSMutableArray * arr = [sectionDic objectForKey:@"arr"];
    NSMutableDictionary * dic = [arr objectAtIndex:indexPath.row];
    
    
    NSMutableArray *cat_ = [[NSMutableArray alloc] init];
    cat_ = [TYSingleton getinstance].allCatID;
    
    NSMutableArray *sub_ = [[NSMutableArray alloc] init];
    sub_ = [TYSingleton getinstance].allSubID;
    
    //NSLog(@"DIC: %@", dic);
    //if (yourSeperatedData && [[[yourSeperatedData objectAtIndex:self.openedSection] objectAtIndex:[cbv tag]] isEqualToString:@"YES"])
    if ([[dic objectForKey:@"selected"] isEqualToString:@"NO"])
    {
        //[[yourSeperatedData objectAtIndex:self.openedSection] replaceObjectAtIndex:[cbv tag] withObject:@"NO"];
        if ([tempDic count] > 4) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Оповещение" message:@"Максимальное количество выбранных гос. органов равняется 5" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        } else {
            [tempDic setValue:[NSString stringWithFormat:@"%@", [[cat_ objectAtIndex:indexPath.section] objectForKey:@"id"]] forKeyPath:[[sub_ objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
            [dic setObject:@"YES" forKey:@"selected"];
            NSLog(@"Set to: %@", [dic objectForKey:@"selected"]);
        }
    }
    else {
        //[[yourSeperatedData objectAtIndex:self.openedSection] replaceObjectAtIndex:[cbv tag] withObject:@"YES"];
        [dic setObject:@"NO" forKey:@"selected"];
        NSLog(@"Set to: %@", [dic objectForKey:@"selected"]);
        
        [tempDic removeObjectForKey:[NSString stringWithFormat:@"%@", [[sub_ objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]]];
    }
    NSLog(@"idBox new: %@", self.idBox);
    
    NSArray *tempArray = [[NSArray alloc] initWithArray:[tempDic allKeys]];
    
    NSMutableDictionary *sendDic = [[NSMutableDictionary alloc] init];
    
    for (int i=0; i < [tempDic count]; i++) {
        [sendDic setObject:[tempArray objectAtIndex:i] forKey:[NSString stringWithFormat:@"%i", i]];
    }
    
    NSLog(@"Temp Dic: %@", [tempDic allKeys]);
    NSLog(@"Send Array: %@", sendDic);
    [TYSingleton getinstance].allAuthorityId = sendDic;
    
    [self.tableView reloadData];
}


- (void)checkBoxViewChangedState:(SSCheckBoxView *)cbv
{
    NSLog(@"checkBoxViewChangedState %i %i", self.openedSection, [cbv tag]);
    
    NSMutableDictionary * sectionDic = [self.dataArr objectAtIndex:self.openedSection];
    NSMutableArray * arr = [sectionDic objectForKey:@"arr"];
    NSMutableDictionary * dic = [arr objectAtIndex:[cbv tag]];
    
    //NSLog(@"DIC: %@", dic);
    //if (yourSeperatedData && [[[yourSeperatedData objectAtIndex:self.openedSection] objectAtIndex:[cbv tag]] isEqualToString:@"YES"])
    if ([[dic objectForKey:@"selected"] isEqualToString:@"NO"])
    {
        //[[yourSeperatedData objectAtIndex:self.openedSection] replaceObjectAtIndex:[cbv tag] withObject:@"NO"];
        [dic setObject:@"YES" forKey:@"selected"];
        NSLog(@"Set to: %@", [dic objectForKey:@"selected"]);
    }
    else {
        //[[yourSeperatedData objectAtIndex:self.openedSection] replaceObjectAtIndex:[cbv tag] withObject:@"YES"];
        [dic setObject:@"NO" forKey:@"selected"];
        NSLog(@"Set to: %@", [dic objectForKey:@"selected"]);
    }
    
    [self.tableView reloadData];
    //[self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
}



@end
