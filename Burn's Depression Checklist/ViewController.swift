//
//  ViewController.swift
//  Burn's Depression Checklist
//
//  Created by saroj mohanty on 7/25/18.
//  Copyright © 2018 saroj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    //reference to table and its identifier
    let questionsTableIdentifier = "QuestionsTableIdentifier"
    @IBOutlet var tableView:UITableView!
    
    //cell array
    var questionsCellArray = [QuestionsTableViewCell]();
    
    //array of Questions
    var questions = [Question]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Load all questions from plist and popluate into array
        let url = Bundle.main.url(forResource: "Questions", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let questionsArray = try! PropertyListSerialization.propertyList(from: data, format: nil) as! [String]
        questions = questionsArray.map {Question(text: $0)}
        
        //register tableview with identifier and xib of cells
        tableView.register(QuestionsTableViewCell.self,
                           forCellReuseIdentifier: questionsTableIdentifier)
        let xib = UINib(nibName: "QuestionsTableViewCell", bundle: nil)
        tableView.register(xib,
                           forCellReuseIdentifier: questionsTableIdentifier)
        tableView.rowHeight = 108;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //return amount of rows in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    //set values of all cells and then return
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: questionsTableIdentifier, for: indexPath) as! QuestionsTableViewCell
        
        let question = questions[indexPath.row]
        cell.questionLabel.text = question.text
        cell.selection.selectedSegmentIndex = question.answerIndex
        cell.callback = { index in
            question.answerIndex = index
        }
        return cell
    }

    @IBAction func calculate(_ sender: UIButton) {
        var score = 0
       
        //loop through all questions and obtain running total of score
        questions.forEach { score += $0.answerIndex }
        
        //strings for title and message
        let scoreMsg = "Score is \(score)"
        var msg = "";
        
        //case switch of all possibilities of scores and their evaluations
        switch score {
            case 0...5:
                msg = "Congratualtions! You have No Depression!"
            case 6...10:
                msg = "You are Normal but unhappy."
            case 11...25:
                msg = "You may suffer from Mild Depression."
            case 26...50:
                msg = "You may suffer from Moderate Depression."
            case 51...75:
                msg = "You may suffer from Severe Depression."
            case 76...100:
                msg = "You may suffer from Extreme Depression. "
            default:
                msg = "An error occured. Please reset and try again."
        }
        
        //Present messages to user
        let controller = UIAlertController(title: scoreMsg,
                                           message:msg, preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "Ok",
                                      style: .default, handler: { action in
        })

        controller.addAction(okAction)
        if let ppc = controller.popoverPresentationController {
            ppc.sourceView = sender
            ppc.sourceRect = sender.bounds
        }
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func reset(_ sender: UIButton) {
        
        //If reset is hit, loop through all Questions and set their answers back to 0
        let resetAction = UIAlertAction(title: "Reset",
                                          style: .destructive) { (action) in
                                            self.questions.forEach { $0.answerIndex = 0 }
                                            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (action) in
        }
        
        let alert = UIAlertController(title: "Reset all answers",
            message: "Are you sure you want to clear all your answers?",
            preferredStyle: .alert)
       
        alert.addAction(resetAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {
            
        }
    }
}

