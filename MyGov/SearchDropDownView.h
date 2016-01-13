//
//  SearchFlightsView.h
//  TashkentAirProject
//
//  Created by Bendik V. on 04.11.13.
//  Copyright (c) 2013 Global Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchDropDownView;

@protocol SearchDropDownDelegate <NSObject>

- (void) menuItemSelected: (NSString *) item;

@end

@interface SearchDropDownView : UIAlertView<UITableViewDataSource, UITableViewDelegate> {
    id <SearchDropDownDelegate> __unsafe_unretained delegate;
}

@property (nonatomic, assign) id<SearchDropDownDelegate> delegate;

- (void) updateFrame:(CGRect) frame;
- (void) setArray: (NSArray *) _arr;
- (void) setValues: (NSArray *) _vals;
- (void) show:(BOOL) show;
- (void) toggle;
@end
