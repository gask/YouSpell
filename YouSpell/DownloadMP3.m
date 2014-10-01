//
//  DownloadMP3.m
//  YouSpell
//
//  Created by Francisco F Neto on 17/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "DownloadMP3.h"

@interface DownloadMP3 ()

@end

@implementation DownloadMP3

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) mp3ReceivedWithData: (NSData *) data response: (NSURLResponse *) response andError: (NSError *)error
{
    
}

//http://tts-api.com/tts.mp3?q=tiara

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    wordsArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"giovannao" ofType:@"plist"]];
    
    for (int i = 0; i < wordsArray.count; i++)
    {
        NSArray *innerArray = [wordsArray objectAtIndex:i];
        for (int k = 0; k <  innerArray.count; k++)
        {
            NSString *startingString = @"http://tts-api.com/tts.mp3?q=";
            NSString *word = [[[innerArray objectAtIndex:k] objectForKey:@"word"] lowercaseString];
            NSLog(@"word being downloaded: %@",word);
            
            /*NSURL *url = [NSURL URLWithString: [startingString stringByAppendingString: word]];
            
            // NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
            
            NSURLSession *defaultSession = [NSURLSession sharedSession];
            
            NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                              {
                                                  
                                                  //NSLog(@"11");
                                                  if(error == nil)
                                                  {
                                                      //NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                      //NSLog(@"Data = %@",text);
                                                      
                                                      NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                                      NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
                                                      NSString *filePath = [documentsPath stringByAppendingPathComponent: [word stringByAppendingString: @".mp3"]]; //Add the file name
                                                      
                                                      //NSLog(@"%@",filePath);
                                                      [data writeToFile:filePath atomically:YES]; //Write the file
                                                  }
                                                  else
                                                  {
                                                      NSLog(@"error downloading word: %@", word);
                                            
                                                  }
                                                  
                                                  
                                                  
                                              }];
            
            [dataTask resume];
            
        */}
    }
    
    
    
    /*if (data != nil)
    {
        NSLog(@"is not nil");
        
        NSString *bentinho = [[NSString alloc] initWithContentsOfURL:url encoding:NSStringEncodingConversionExternalRepresentation error:&error];
        
        
        //NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"a" ofType:@"mp3"]];
        
        //AudioServicesCreateSystemSoundID((__bridge CFURLRef) soundURL, &sound);
        
        
        //NSString *readdata = [[NSString alloc] initWithContentsOfURL:(NSData *)data ];
    }*/
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
