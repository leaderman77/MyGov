//
//  MGHistoryController.m
//  MyGov
//
//  Created by Alpha on 27.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGHistoryController.h"
#import "MGHistoryCell.h"
#import "MGHistoryDetailController.h"

@interface MGHistoryController () {
    
    CustomIOS7AlertView *alertView;
    int selectedID;
}

@end

static NSString *CellIdentifier = @"CellIdentifier";


@implementation MGHistoryController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view setBackgroundColor:RGB(244, 244, 244)];
    
    
    UIImageView *navBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0-[TYSingleton getinstance].insetY, 320, 66)];
    navBar.image = [UIImage imageNamed:@"navbar_.png"];
    
    [self.view addSubview:navBar];
    
    
    UILabel *navBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, titlesOffsetY, 280, 65)];
    navBarLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    navBarLabel.lineBreakMode = NSLineBreakByWordWrapping;
    navBarLabel.numberOfLines = 2;
    navBarLabel.text = @"История обращений";
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
    
    if (!IS_OS_7_OR_LATER) {
    self.historyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, navBar.frame.size.height-[TYSingleton getinstance].insetY-2, //64-[TYSingleton getinstance].insetY,
                                                                      self.view.frame.size.width,
                                                                      self.view.frame.size.height-(64-[TYSingleton getinstance].insetY))];
    } else {
        self.historyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, navBar.frame.size.height-22, //64-[TYSingleton getinstance].insetY,
                                                                          self.view.frame.size.width,
                                                                          self.view.frame.size.height-(64-[TYSingleton getinstance].insetY)+22)];
    }
    
    [self.view insertSubview:self.historyTable belowSubview:navBar]; //addSubview:self.historyTable];
    
    
    [self.historyTable registerClass:[MGHistoryCell class] forCellReuseIdentifier:kCellIDTitle];
    
    self.historyTable.dataSource = self;
    self.historyTable.delegate = self;
    
    self.historyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    DLog(@"appealData: %@", [self.appealData objectForKey:@"data"]);
}

-(void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getCall:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callNumber]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.appealData objectForKey:@"data"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIDTitle forIndexPath:indexPath];
    
    // Configure the cell...
    cell.nameLabel.text = [NSString stringWithFormat:@"ID: %@", [[[self.appealData objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"id"]];
                           //[[[self.appealData objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"authority_id"],
                           //[[[self.appealData objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"status"]];
    
    NSString *date_text = [[[self.appealData objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"added_on"];
    
    NSRange stringRange = {0, 10};
    
    // adjust the range to include dependent chars
    stringRange = [date_text rangeOfComposedCharacterSequencesForRange:stringRange];
    
    // Now you can create the short string
    NSString *shortString = [date_text substringWithRange:stringRange];
    
    cell.dateLabel.text =  shortString;
    [cell setColorToDateBG:@"grayColor"]; // redColor, grayColor, blueColor
    
    NSString *cellStatus = [[[self.appealData objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"status"];
    
    if ([cellStatus isEqualToString:@"new"]) {
        [cell setColorToDateBG:@"blueColor"];
    } else if ([cellStatus isEqualToString:@"process"]){
        [cell setColorToDateBG:@"yellowColor"];
    } else if ([cellStatus isEqualToString:@"processed"]){
        [cell setColorToDateBG:@"greenColor"];
    } else if ([cellStatus isEqualToString:@"draft"]){
        [cell setColorToDateBG:@"violetColor"];
    } else if ([cellStatus isEqualToString:@"notactive"]){
        [cell setColorToDateBG:@"grayColor"];
    }
    
    /*
    if (indexPath.row == 0) {
        [cell setColorToDateBG:@"blueColor"];
    } else if (indexPath.row == 1){
        [cell setColorToDateBG:@"yellowColor"];
    } else if (indexPath.row == 2){
        [cell setColorToDateBG:@"greenColor"];
    } else if (indexPath.row == 3){
        [cell setColorToDateBG:@"violetColor"];
    } else if (indexPath.row == 4){
        [cell setColorToDateBG:@"grayColor"];
    }
     */
    
    //cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //MGHistoryCell *cell = [self.historyTable cellForRowAtIndexPath:indexPath]; //dequeueReusableCellWithIdentifier:kCellIDTitle forIndexPath:indexPath];
    //MGHistoryCell *cell = (MGHistoryCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    selectedID = [[[[self.appealData objectForKey:@"data"] objectAtIndex:indexPath.row] objectForKey:@"id"] integerValue];
    [self loadAllData];
}

-(void)loadAllData {
    // Requests
    
    // get history
    [self getDetailHistory];
    
    
    alertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        DLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView tag]);
        //[alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2-(200/2)+30, 200, 100)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [imageView setImage:[UIImage imageNamed:@"box_al.png"]];
    
    [demoView addSubview:imageView];
    
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 40)];
    tLabel.text = @"Загрузка данных...";
    tLabel.textAlignment = NSTextAlignmentCenter;
    tLabel.textColor = [UIColor whiteColor];
    tLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    tLabel.backgroundColor = [UIColor clearColor];
    
    [demoView addSubview:tLabel];
    
    UIButton *repeat = [[UIButton alloc] initWithFrame:CGRectMake(310/2 - 181/2, 145, 181, 42)];
    [repeat setTitle:@"Повторить" forState:UIControlStateNormal];
    [repeat setBackgroundImage:[UIImage imageNamed:@"btn_al.png"] forState:UIControlStateNormal];
    [repeat setBackgroundImage:[UIImage imageNamed:@"btn_al.png"] forState:UIControlStateNormal];
    [repeat.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    
    //[demoView addSubview:repeat];
    
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    spinner.frame = CGRectMake(demoView.frame.size.width/2 - 70/2, 30, 70, 70);
    //[spinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)]; // I do this because I'm in landscape mode
    [demoView addSubview:spinner]; // spinner is not visible until started
    
    [spinner startAnimating];
    
    return demoView;
}

-(void)getDetailHistory {
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://saidazim.my.dev.gov.uz/"]];
    
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://my.gov.uz/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    DLog(@"#### History Call ####: oa: %@ %@", [TYSingleton getinstance].oauth_token,
          [TYSingleton getinstance].oauth_token_secret);
    NSDictionary *parameters = @{@"token" : [TYSingleton getinstance].oauth_token,
                                 @"token_secret" : [TYSingleton getinstance].oauth_token_secret,
                                 @"request_id" : [NSString stringWithFormat:@"%i", selectedID],
                                 @"language":[TSLanguageManager selectedLanguage]};
    
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
//                                                            path:@"http://saidazim.my.dev.gov.uz/mobileapi/getApp"
//                                                      parameters:parameters];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"https://my.gov.uz/mobileapi/getUserRequest"
                                                      parameters:parameters];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         DLog(@"Response Detail History: %@",jsons);
         
         if ([[jsons objectForKey:@"status"] isEqualToString:@"success"]) {
         
         //NSLog(@"JSon count: %i", [jsons count]);
         //NSLog(@"JSON Cat: %@", jsons);
         //for (NSDictionary *obj in jsons) {
             //NSLog(@"HS: %@", obj);
         //}
         
         [alertView close];
         MGHistoryDetailController *detailHistory = [[MGHistoryDetailController alloc] init];
         
         NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
         [dic setValue:jsons forKey:@"data"];
         detailHistory.fields = dic;
         detailHistory.recTitle = [NSString stringWithFormat:@"%@", [[jsons objectForKey:@"results"] objectForKey:@"id"]];
             
         [self.navigationController pushViewController:detailHistory animated:YES];
         
         }
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         DLog(@"error: %@", [operation error]);
     }];
    
    [operation start];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
