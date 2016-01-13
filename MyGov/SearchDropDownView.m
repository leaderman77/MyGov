//
//  SearchFlightsView.m
//  TashkentAirProject
//
//  Created by Bendik V. on 04.11.13.
//  Copyright (c) 2013 Global Solutions. All rights reserved.
//

#import "SearchDropDownView.h"
@implementation SearchDropDownView {
    UITableView *_dropDownView;
    NSArray *arr;
    NSArray *vals;
    CGRect rect;
}

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)/*frame*/];
    if (self) {
        // Initialization code
        rect = frame;
        arr = [[NSArray alloc] init];
        
        [self setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.6f]];
        
        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleFingerTap.cancelsTouchesInView = YES;
        [self addGestureRecognizer:singleFingerTap];
        
        
        _dropDownView = [[UITableView alloc] initWithFrame:CGRectMake(100, 200, 200, 300)];/*CGRectMake(0, 0, frame.size.width, frame.size.height)*///];
        _dropDownView.delegate = self;
        _dropDownView.dataSource = self;
        _dropDownView.backgroundColor = [UIColor clearColor];
        _dropDownView.scrollEnabled = YES;
        _dropDownView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _dropDownView.separatorColor = [UIColor colorWithRed:42.0f/0xFF green:45.0f/0xFF blue:47.0f/0xFF alpha:0xFF];
        _dropDownView.alpha = 1.0f;
        
        [_dropDownView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SearchDropDownCell"];
        [self addSubview:_dropDownView];
    }
    return self;
}

- (void) updateFrame:(CGRect) frame {
    rect = frame;
    [_dropDownView setFrame:rect];
}

- (void) show:(BOOL) show {
    self.alpha = (show)?1.0f:0.0f;
}

- (void) toggle {
    self.alpha = (self.alpha)?0.0f:1.0f;
}

- (void) handleSingleTap: (UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    if (!CGRectContainsPoint(_dropDownView.frame, location)) {
        [self setAlpha:0.0f];
    }
}

- (void) setArray: (NSArray *) _arr {
    arr = _arr;
    [_dropDownView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void) setValues: (NSArray *) _vals {
    vals = _vals;
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 38;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchDropDownCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    [cell.textLabel setText:@"Next text"]; //, indexPath.row];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setAlpha:0.0f];
    [delegate performSelector:@selector(menuItemSelected:) withObject:[vals objectAtIndex:indexPath.row]];
}

- (void) drawRect:(CGRect)rect {
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(20, 20), 10);
    [super drawRect:CGRectMake(100, 200, 200, 300)];
    CGContextRestoreGState(currentContext);
}

@end
