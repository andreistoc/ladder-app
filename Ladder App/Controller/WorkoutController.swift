//
//  ViewController.swift
//  Ladder App
//
//  Created by Andrew Istoc on 11/09/2018.
//  Copyright © 2018 Andrew Istoc. All rights reserved.
//

import UIKit

class WorkoutController: UIViewController {
    
    //Color variables
    let restColor = #colorLiteral(red: 0, green: 0.6549019608, blue: 0.8823529412, alpha: 1)
    let exerciseColor = #colorLiteral(red: 1, green: 0.368627451, blue: 0.3568627451, alpha: 1)
    
    //Data variables
    var isAscending: Bool = true
    var isAntagonist: Bool = true
    var isWaving: Bool = true
    var maximumReps: Int = 10
    var timePerRep: Int = 5
    var restNeeded: Int = 30
    var setsDone: Int = 0
    var laddersToDo: Int = 1
    var laddersDone: Int = 0
    
    //Labels
    @IBOutlet weak var timeDisplayTextView: UITextView!
    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var nextTodoTextView: UITextView!
    @IBOutlet weak var nextTextView: UITextView!
    @IBOutlet weak var multiStatusDisplayTextView: UITextView!
    
    
    //Start button
    @IBOutlet weak var pauseStartResumeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Customize start button
        pauseStartResumeBtn.layer.cornerRadius = 16
        
        //Set background color
        self.view.backgroundColor = restColor
        
        //Set start button
        pauseStartResumeBtn.setTitle("Start Workout", for: .normal)
        
        //Set initial clear labels
        timeDisplayTextView.text = ""
        statusTextView.text = ""
        nextTextView.text = ""
        nextTodoTextView.text = ""
        multiStatusDisplayTextView.text = ""
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pauseStartResumeBtnPressed(_ sender: Any) {
    }
    

}

