//
//  Question.swift
//  Burn's Depression Checklist
//
//  Created by saroj mohanty on 7/28/18.
//  Copyright © 2018 saroj. All rights reserved.
//

class Question {
    
    //label for question and var for answer index
    let text : String
    var answerIndex : Int
    
    //set values
    init(text : String, answerIndex : Int = 0) {
        self.text = text
        self.answerIndex = answerIndex
    }
}
