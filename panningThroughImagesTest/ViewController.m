//Complete code for panning through images with no boundary conditions ie:
// once an image reaches the end of the screen, an image that is currently
// off of the screen on the other side is thrown to the other side of the
// line of images and keeps the chain continuous
//
// This is in the process of being changed into something that parses the source
// code for a website for images and then uses those links to find the images
// and from there it would display those images with the same scrolling method that
// here. At this point (friday jan 4), it cuurrently parses for the images and then
// grabs them and displays the first six on the page.
//
//
//  ViewController.m
//  panningThroughImagesTest
//
//  Created by Teddy Rowan on 13-01-03.
//  Copyright (c) 2013 Teddy Rowan. All rights reserved.
//




//NEXT THING TO DO IS TO FIGURE OUT HOW TO SCROLL THEM ACROSS THE SCREEN BUT THAT WILL
// LIKELY TAKE A REDESIGN OF HOW THE IMAGE SCROLLING IS DONE WITH PAN.
// SEE LINE ABOUT 230 -- SHOULD BE ABOUT THE BOTTOM OF THE VIEWDIDLOAD FUNCTION


#import "ViewController.h"

<<<<<<< HEAD
//#define IMAGE_SOURCE1 "http://images.apple.com/v20121208160528/startpage/images/promo_ipad_mini.jpg"
//#define IMAGE_SOURCE2 "http://images.apple.com/v20121208160528/startpage/images/promo_macbook_pro.jpg"
//#define IMAGE_SOURCE3 "http://images.apple.com/v20121208160528/startpage/images/promo_ipod_nano.jpg"
#define IMAGE_SOURCE4 "http://static.adzerk.net/Advertisers/bd294ce7ff4c43b6aad4aa4169fb819b.jpg"
#define IMAGE_SOURCE5 "http://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Litoria_infrafrenata_-_Julatten.jpg/350px-Litoria_infrafrenata_-_Julatten.jpg"
#define IMAGE_SOURCE6 "http://cdn5.raywenderlich.com/wp-content/uploads/2011/11/UIGestureRecognizers.jpg"
=======
#define IMAGE_SOURCE1 "http://images.apple.com/v20121208160528/startpage/images/promo_ipad_mini.jpg"
#define IMAGE_SOURCE2 "http://images.apple.com/v20121208160528/startpage/images/promo_macbook_pro.jpg"
#define IMAGE_SOURCE3 "http://images.apple.com/v20121208160528/startpage/images/promo_ipod_nano.jpg"
//#define IMAGE_SOURCE4 "http://static.adzerk.net/Advertisers/bd294ce7ff4c43b6aad4aa4169fb819b.jpg"
//#define IMAGE_SOURCE5 "http://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Litoria_infrafrenata_-_Julatten.jpg/350px-Litoria_infrafrenata_-_Julatten.jpg"
//#define IMAGE_SOURCE6 "http://cdn5.raywenderlich.com/wp-content/uploads/2011/11/UIGestureRecognizers.jpg"
>>>>>>> commented out bottom 3

// edges of the iPhone screen
#define lBOUNDARY 0
#define rBOUNDARY 320

#define SENTINEL -999


@interface ViewController ()

@end

@implementation ViewController

@synthesize imageScrollView;
@synthesize LL, CC, RR;
@synthesize OL, OR, ORR;
@synthesize sourceURLs, numberOfPictures, imageIndex;

@synthesize storeImageViews;
@synthesize testing, allFromOnline;



// converts the image URL to image
- (UIImage*)stringURLtoImage:(NSString *)url
{
    NSURL *imageURL = [NSURL URLWithString:url];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    return image;
}

// simple absolute value function to avoid having to import the math header file
- (int)mathAbs:(int)num
{
    if (num < 0)
        num *= -1;
    
    return num;
}

// parses through the source code of the website and adds all the urls
// of the .jpg type images on the page
-(NSMutableArray*)getImagesFromPage:(NSString*)url
{
    // initialize the strings
    NSString *search = [[NSString alloc] init];
    NSString *imgADD = [[NSString alloc] init];
    
    
    NSMutableArray *testArray = [[NSMutableArray alloc] init];
    
    // traverse the data
    for (int i = 0; i < [url length] - 4; i++)
    {
        // make a substring from where you are that is 4 long
        search = [url substringWithRange:NSMakeRange(i,4)];
        
        // check the substring to see if it is going to be an image
        if ([search isEqualToString:@".jpg"])
        {
            // index to store where the start of the address is going
            // to be b/c in a second you will be dropping out of the loop
            // and lose any local variables inside of it
            int storeIndex;
            
            // step backwards from where you found the ".jpg" until
            // you find a "http://" which signifies the start of the url for the image
            for (int j = i; j > 0; j--)
            {
                // make a substring and check to see if it is "http://"
                search = [url substringWithRange:NSMakeRange(j, 7)];
                if ([search isEqualToString:@"http://"])
                {
                    // if it is, then check that the next 3 characters are "pic"
                    // THIS IS WEBPAGE SPECIFIC and happens to be how all user
                    // photos are displayed on the POF homepage, it may be different
                    // in other parts of the site.
                    search = [url substringWithRange:NSMakeRange(j+7, 3)];
                    
                    // if the next thing is "pic" then drop out of the loop and
                    // save the value, otherwise give the index a sentinel value and
                    // drop out b/c the photo is likely a icon or something undesired
                    if ([search isEqualToString:@"pic"])
                        storeIndex = j;
                    else
                        storeIndex = SENTINEL;
                    break;
                }
            }
            
            // as long as the index isnt the sentinel value, take the address and store it in the array
            // well it is supposed to do that but may or may still be broken
                // ran into problems with putting it into the array, likely an initialization
                // problem or something
            if (storeIndex != SENTINEL)
            {
                imgADD = [url substringWithRange:NSMakeRange(storeIndex, (i - storeIndex + 4))];
                
                //prints out the URLs of all the image sources
                //NSLog(imgADD);
                
                // changes the URLs to images and then add them to the array
                [testArray addObject:[self stringURLtoImage:imgADD]];
            }
            
        }
        
    }
    
    
    return testArray;

//    NSLog(@"blafakfja");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageIndex = 0;
    
    // make sure to initialize the array (PROPERLY!!!!!!)
    sourceURLs = [[NSMutableArray alloc] init];
    storeImageViews = [[NSMutableArray alloc] init];
    
    // add the picture's URLs to the array
    [sourceURLs addObject:@IMAGE_SOURCE1];
    [sourceURLs addObject:@IMAGE_SOURCE2];
    [sourceURLs addObject:@IMAGE_SOURCE3];
    [sourceURLs addObject:@IMAGE_SOURCE4];
    [sourceURLs addObject:@IMAGE_SOURCE5];
    [sourceURLs addObject:@IMAGE_SOURCE6];
    
    // size of array
    numberOfPictures = [sourceURLs count];
    
    // assigns the images -- NOTICE!!! the POSTFIX OPERATOR
    //which increments the index after each image is assigned
    OL.image = [self stringURLtoImage:sourceURLs[imageIndex ++]];
    LL.image = [self stringURLtoImage:sourceURLs[imageIndex ++]];
    CC.image = [self stringURLtoImage:sourceURLs[imageIndex ++]];
    RR.image = [self stringURLtoImage:sourceURLs[imageIndex ++]];
    OR.image = [self stringURLtoImage:sourceURLs[imageIndex ++]];
    ORR.image = [self stringURLtoImage:sourceURLs[imageIndex ++]];
 
    // add the imageViews to an array so that their locations can easily be
    // found and there element properties. tis should also replace the array
    // full of the image adresses but since memory is not currently an issue
    // b/c this is just a test program -- i want to have both of them in case
    // i need it later
    [storeImageViews addObject:OL];
    [storeImageViews addObject:LL];
    [storeImageViews addObject:CC];
    [storeImageViews addObject:RR];
    [storeImageViews addObject:OR];
    [storeImageViews addObject:ORR];
    
    
    // parse pof to get the images from the thing
    NSURL *siteURL = [NSURL URLWithString:@"http://www.pof.com/"];
    NSData *siteData = [[NSData alloc] initWithContentsOfURL:siteURL];
    NSString *siteSourceCode = [[NSString alloc] initWithData:siteData
                                                     encoding:NSUTF8StringEncoding];
    // logs the entire source code for the homepage
    //NSLog(siteSourceCode);
    
    NSMutableArray *pageImages = [[NSMutableArray alloc] init];
    pageImages = [self getImagesFromPage:siteSourceCode];    
    NSLog(@"The number of pics found is: %d", [pageImages count]);
    
    
    // adding an image view from image
    /*
    UIImageView *imgView = [[UIImageView alloc] initWithImage:pageImages[0]];
    imgView.center = CGPointMake(150, 150);
    [self.view addSubview:imgView];
    */
    
    // adding an image view with a frame
    /*
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    imgView.image = pageImages[0];
    [self.view addSubview:imgView];
    */
    
    
    // displays 6 images on the screen each at the 50x50 size.
    /* // this version goes and displays in rows of 5 images
     for(int i = 0; i < [pageImages count]; i++)
     {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50*(i%5), (i/5)*50, 50, 50)];
        imgView.image = pageImages[i];
        [allFromOnline addSubview:imgView];
     }
     */
    
    for(int i = 0; i < [pageImages count]; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50*(i), 0, 54, 54)];
        imgView.image = pageImages[i];
        [allFromOnline addSubview:imgView];
    }
    
    NSLog(@"%d",[[allFromOnline subviews] count]);
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Shifts all the items one index in the array and
// sends the first item to the last index. ie: index
// one gets the item at two, index two get the third and
// so forth
-(void)pushArrayItemsBack:(NSMutableArray*)array
{
    UIImageView *temp = [array objectAtIndex:0];
    
    for (int i = 1; i < [array count]; i++)
        array[i - 1] = array[i];
    
    array[[array count] - 1] = temp;
}

// This code may be broken... It is meant to do something similar
// to the function above but to shift the items in the other direction
-(void)pushArrayItemsForward:(NSMutableArray*)array
{
    UIImageView *temp = [array objectAtIndex:([array count]-1)];
    
    for (int i = ([array count] - 1); i > 0 ; i--)
        array[i] = array[i - 1];
    
    array[0] = temp;
}


// this version of handlePan is intended to scroll through an arbitrary number
// of images taken directly from the website
-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer
{
    
    
    // this code is to move an image by panning with your finger/mouse
    // make sure to connect it properly and completely in the .xib file
    
    // this is the translation
    CGPoint translation = [recognizer translationInView:self.view];
    
    
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y);
    [recognizer setTranslation:CGPointMake(0,0) inView:self.view];
    
    
    
    
}




/*
// this implements a continuously scrolling array of images - ie once
// it reaches the end, it displays the first one at the back and so on
-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer
{
    
    
    // this code is to move an image by panning with your finger/mouse
    // make sure to connect it properly and completely in the .xib file
    
    // this is the translation
    CGPoint translation = [recognizer translationInView:self.view];
    
    
    // instead of moving the large imageView that contains the 5 or 6 smaller ones,
    // leave it where it is and just move the small ones inside of the large ones
    for (int i = 0; i < [storeImageViews count]; i++)
    {
        UIImageView *temp = storeImageViews[i];
        temp.center = CGPointMake(temp.center.x + translation.x, temp.center.y);
    }
    
    // only want to move this one time so it needs to be outside of the
    // for loop
    [recognizer setTranslation:CGPointMake(0,0) inView:self.view];
    
    
    // storing the two outside items so that the program can read when either of
    // them is about to completely enter onto the phone's screen and as such it
    // can throw another image on the outside of it to avoid having a blank space
    // and allow for the continuous scrolling effec
    UIImageView *temp = storeImageViews[0];
    UIImageView *tempLast = storeImageViews[[storeImageViews count]-1];
    
    
    // left boundary -- NOTE: when moving the imageView, you need to adjust
    // for the frame size of each object and add half of both of their widths.
    // in this project, they are the same size and therefore we can just use one
    // full width to save minor processing power but with other programs this may not
    // be the case and it may be required to add both half widths.
    if (temp.center.x - temp.frame.size.width/2 > lBOUNDARY)
    {
        tempLast.center = CGPointMake(temp.center.x - temp.frame.size.width, temp.center.y);
        
        // once the item has been pushed to the other side of the line of images,
        // the array needs to be re-adjusted to keep the items in the proper order
        [self pushArrayItemsBack:storeImageViews];
    }
    
    // same as above but with a different boundary condition
    // NOTE: the same method for keeping the images in order in the array works
    // in both cases but I am not sure why... I feel as if they should require
    // different functions which move the images in opposite directions
    if (tempLast.center.x + tempLast.frame.size.width/2 < rBOUNDARY)
    {
        temp.center = CGPointMake(tempLast.center.x + tempLast.frame.size.width, temp.center.y);
        [self pushArrayItemsBack:storeImageViews];
    }
    
    
    // displaying the center image in a larger image in the middle of the screen
    // the next part finds the index in the array that is that of the center image
    UIImageView *tempDist = storeImageViews[0];
    int centerIndex = 0;
    int centerDistance = [self mathAbs:((rBOUNDARY - lBOUNDARY)/2 - tempDist.center.x)];
    for (int i = 0; i < [storeImageViews count]; i++)
    {
        tempDist = storeImageViews[i];
        int tempDistanceValue = [self mathAbs:((rBOUNDARY - lBOUNDARY)/2 - tempDist.center.x)];
        
        if (tempDistanceValue < centerDistance)
        {
            centerDistance = tempDistanceValue;
            centerIndex = i;
        }
        
    }
    
    // actually displays the image
    UIImageView *displayImageView = storeImageViews[centerIndex];
    testing.image = displayImageView.image;
    
    
    
}
*/

@end








/*     //Complete code for panning through images with strict boundary conditions ie what is currently
        //found in the eVow iPhone App
 //
 //  ViewController.m
 //  panningThroughImagesTest
 //
 //  Created by Teddy Rowan on 13-01-03.
 //  Copyright (c) 2013 Teddy Rowan. All rights reserved.
 //
 
 #import "ViewController.h"
 
 #define IMAGE_SOURCE1 "http://images.apple.com/v20121208160528/startpage/images/promo_ipad_mini.jpg"
 #define IMAGE_SOURCE2 "http://images.apple.com/v20121208160528/startpage/images/promo_macbook_pro.jpg"
 #define IMAGE_SOURCE3 "http://images.apple.com/v20121208160528/startpage/images/promo_ipod_nano.jpg"
 #define IMAGE_SOURCE4 "http://static.adzerk.net/Advertisers/bd294ce7ff4c43b6aad4aa4169fb819b.jpg"
 #define IMAGE_SOURCE5 "http://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Litoria_infrafrenata_-_Julatten.jpg/350px-Litoria_infrafrenata_-_Julatten.jpg"
 
 // edges of the iPhone screen
 #define lBOUNDARY 0
 #define rBOUNDARY 320
 
 
 @interface ViewController ()
 
 @end
 
 @implementation ViewController
 
 @synthesize imageScrollView;
 @synthesize LL, CC, RR;
 @synthesize OL, OR;
 @synthesize sourceURLs, numberOfPictures, imageIndex;
 
 
 
 // converts the image URL to image
 - (UIImage*)stringURLtoImage:(NSString *)url
 {
 NSURL *imageURL = [NSURL URLWithString:url];
 NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
 UIImage *image = [UIImage imageWithData:imageData];
 
 return image;
 }
 
 
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 
 imageIndex = 0;
 
 // make sure to initialize the array (PROPERLY!!!!!!)
 sourceURLs = [[NSMutableArray alloc] init];
 
 // add the picture's URLs to the array
 [sourceURLs addObject:@IMAGE_SOURCE1];
 [sourceURLs addObject:@IMAGE_SOURCE2];
 [sourceURLs addObject:@IMAGE_SOURCE3];
 [sourceURLs addObject:@IMAGE_SOURCE4];
 [sourceURLs addObject:@IMAGE_SOURCE5];
 
 
 // size of array
 numberOfPictures = [sourceURLs count];
 
 // assigns the images -- NOTICE!!! the POSTFIX OPERATOR
 //which increments the index after each image is assigned
 OL.image = [self stringURLtoImage:sourceURLs[imageIndex ++]];
 LL.image = [self stringURLtoImage:sourceURLs[imageIndex ++]];
 CC.image = [self stringURLtoImage:sourceURLs[imageIndex ++]];
 RR.image = [self stringURLtoImage:sourceURLs[imageIndex ++]];
 OR.image = [self stringURLtoImage:sourceURLs[imageIndex ++]];
 
 }
 
 
 
 
 - (void)didReceiveMemoryWarning
 {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }
 
 
 
 // this implements (almost done) a scrolling through images  thing with a tough
 // border on the left and on the right
 -(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer
 {
 
 
 // this code is to move an image by panning with your finger/mouse
 // make sure to connect it properly and completely in the .xib file
 
 // this is the translation
 CGPoint translation = [recognizer translationInView:self.view];
 
 
 // move the object no matter where it is and then check that it is inside the boundary  conditions
 // in the next step
 recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y);
 [recognizer setTranslation:CGPointMake(0,0) inView:self.view];
 
 
 //ensures that the bar is inside the boundary conditions
 if (imageScrollView.center.x - imageScrollView.frame.size.width/2 > lBOUNDARY)
 imageScrollView.center = CGPointMake(imageScrollView.frame.size.width/2, imageScrollView.center.y);
 
 if (imageScrollView.center.x + imageScrollView.frame.size.width/2 < rBOUNDARY)
 imageScrollView.center = CGPointMake(320 - imageScrollView.frame.size.width/2, imageScrollView.center.y);
 
 
 
 
 }
 
 
 @end
*/