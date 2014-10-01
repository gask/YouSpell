//
//  DownloadWords.m
//  YouSpell
//
//  Created by Francisco F Neto on 29/09/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "DownloadWords.h"

@interface DownloadWords ()

@end

@implementation DownloadWords

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSMutableArray *plistArray = [NSMutableArray array];
    
    NSString *startingString = @"http://69.162.107.55/words.php";
    //NSString *word = [[[innerArray objectAtIndex:k] objectForKey:@"word"] lowercaseString];
    //NSLog(@"word being downloaded: %@",word);
    
    NSURL *url = [NSURL URLWithString: startingString];
    
    // NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          
                                          //NSLog(@"11");
                                          if(error == nil)
                                          {
                                              NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                              //NSLog(@"Data = %@",text);
                                              
                                              //NSString *jsonString = @"blblblblblb";
                                              NSStringEncoding  encoding;
                                              NSData * jsonData = [text dataUsingEncoding:encoding];
                                              NSError * error=nil;
                                              NSArray *parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
                                              
                                              for(NSInteger i = 0; i < parsedData.count ; i++)
                                              {
                                                  //[plistArray addObject:[NSMutableArray array]];
                                                  
                                                  for(NSInteger k = 0 ; k < [[parsedData objectAtIndex:i] count] ; k++)
                                                  {
                                                      //[plistArray objectAtIndex:i] addObject:[NSDictionary dictionaryWithObjectsAndKeys:[parsedData objectAtIndex:i], nil]
                                                      NSLog(@"%@", [[[parsedData objectAtIndex:i] objectAtIndex:k] objectForKey:@"word"]);
                                                  }
                                              }
                                              
                                              NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                              NSString *documentsDirectory = [paths objectAtIndex:0];
                                              NSString *path = [documentsDirectory stringByAppendingPathComponent:@"giovannao.plist"];
                                              //NSFileManager *fileManager = [NSFileManager defaultManager];

                                              [parsedData writeToFile:path atomically:YES];
                                              
                                              //NSLog(@"word: %@",[[[[parsedData objectForKey:0] objectForKey:0] objectForKey:@"word"] stringValue]);
                                              //NSLog(@"def: %@",[[[[parsedData objectForKey:0] objectForKey:0] objectForKey:@"definition"] stringValue]);
                                              
                                              //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                              //NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
                                              //NSString *filePath = [documentsPath stringByAppendingPathComponent: [word stringByAppendingString: @".mp3"]]; //Add the file name
                                              
                                              //NSLog(@"%@",filePath);
                                              //[data writeToFile:filePath atomically:YES]; //Write the file
                                          }
                                          else
                                          {
                                              NSLog(@"error downloading ");
                                              
                                          }
                                          
                                          
                                          
                                      }];
    
    [dataTask resume];
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
