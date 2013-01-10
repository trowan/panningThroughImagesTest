//
//  ViewController.h
//  panningThroughImagesTest
//
//  Created by Teddy Rowan on 13-01-03.
//  Copyright (c) 2013 Teddy Rowan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UIView *imageScrollView;
    UIImageView *LL;
    UIImageView *CC;
    UIImageView *RR;
    UIImageView *OL;
    UIImageView *OR;
    UIImageView *ORR;
    
    
    NSMutableArray *sourceURLs;
    NSInteger numberOfPictures;
    NSInteger imageIndex;
    
    NSMutableArray *storeImageViews;
    UIImageView *testing;
    
    
    UIView *allFromOnline;
    
}

@property(nonatomic, retain) IBOutlet UIView *imageScrollView;
@property(nonatomic, retain) IBOutlet UIImageView *LL;
@property(nonatomic, retain) IBOutlet UIImageView *CC;
@property(nonatomic, retain) IBOutlet UIImageView *RR;
@property(nonatomic, retain) IBOutlet UIImageView *OL;
@property(nonatomic, retain) IBOutlet UIImageView *OR;
@property(nonatomic, retain) IBOutlet UIImageView *ORR;


@property(nonatomic, retain) NSMutableArray *sourceURLs;
@property(nonatomic) NSInteger imageIndex;
@property(nonatomic) NSInteger numberOfPictures;

@property(nonatomic, retain) NSMutableArray *storeImageViews;
@property(nonatomic, retain) IBOutlet UIImageView *testing;
@property(nonatomic, retain) IBOutlet UIView *allFromOnline;

-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
-(UIImage*)stringURLtoImage:(NSString *)url;

@end
