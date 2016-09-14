//
//  ViewController.m
//  Quiz
//
//  Created by Princess Sampson on 9/14/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) IBOutlet UILabel *answerLabel;
@property(nonatomic) NSArray *questions;
@property(nonatomic) NSArray *answers;
@property(nonatomic) NSUInteger currentQuestionIndex;

@end

@implementation ViewController

- (IBAction)showNextQuestion:(id)sender {
    self.currentQuestionIndex++;
    if(self.currentQuestionIndex == self.questions.count) {
        self.currentQuestionIndex = 0;
    }
    
    NSString *question = self.questions[self.currentQuestionIndex];
    self.questionLabel.text = question;
    self.answerLabel.text = @"???";
}
- (IBAction)showNextAnswer:(id)sender {
    NSString *answer = self.answers[self.currentQuestionIndex];
    self.answerLabel.text = answer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.questions = @[@"What is your name?",
                     @"What is your quest?",
                     @"What is your favorite color?"];
    
    self.answers = @[@"Sir Galahad of Camelot",
                       @"I seek the Grail",
                       @"Blue. No, yel–"];
    
    self.questionLabel.text = self.questions[self.currentQuestionIndex];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
