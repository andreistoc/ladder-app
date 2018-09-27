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
    var isAscending = false
    var isAntagonist = true
    var isWaving = true
    var maximumReps = 9
    var timePerRep = 5
    var restPerRep = 5
    var setsDone = 0
    var laddersToDo = 2
    var laddersDone = 0
    
    //State variables:
    var isRunning = false
    var preCountTimeRemaining = 5
    var isWorkout = false
    var totalTimeRemaining = 0
    var setsArray: [Int] = []
    var currentSet = 1
    var setTime = 0
    var restTime = 0
    
    //Labels
    @IBOutlet weak var timeDisplayTextView: UITextView!
    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var nextTodoTextView: UITextView!
    @IBOutlet weak var nextTextView: UITextView!
    @IBOutlet weak var multiStatusDisplayTextView: UITextView!
    
    
    //Buttons
    @IBOutlet weak var pauseStartResumeBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    //Timer
    var workoutTimer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Customize buttons
        pauseStartResumeBtn.layer.cornerRadius = 16
        resetBtn.layer.cornerRadius = 8
        
        //Set background color
        self.view.backgroundColor = restColor
        
        //Set start button
        pauseStartResumeBtn.setTitle("Start Workout", for: .normal)
        
        //Set initial clear labels
        timeDisplayTextView.text = ""
        statusTextView.text = ""
        nextTextView.text = ""
        nextTodoTextView.text = ""
        multiStatusDisplayTextView.text = "Ladders selected: 2\nMaximum number of reps: 10\n Ladder type: Waving\nAntagonist training selected"
        
        //Populate sets array
        populateSetsArray()
        
        //Calculate total workout time
        totalTimeRemaining = 0
        for i in 1...setsArray.count {
            totalTimeRemaining += setsArray[i-1] * timePerRep * 2
        }
        
        
        
    }
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        if isRunning {
            workoutTimer.invalidate()
            
            //Set initial clear labels
            timeDisplayTextView.text = ""
            statusTextView.text = ""
            nextTextView.text = ""
            nextTodoTextView.text = ""
            multiStatusDisplayTextView.text = "Ladders selected: 2\nMaximum number of reps: 10\n Ladder type: Waving\nAntagonist training selected"
            
            
            //Re-retrieve data from user defaults
            
            
            
            //Reset variables
            preCountTimeRemaining = 5
        }
        pauseStartResumeBtn.setTitle("Start Workout", for: .normal)
    }
    
    @IBAction func pauseStartResumeBtnPressed(_ sender: Any) {
        if !isRunning {
            isRunning = true
            pauseStartResumeBtn.setTitle("Pause", for: .normal)
            preCountIteration()
            workoutTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                print("Timer Running")
                if self.preCountTimeRemaining > 0 {
                    self.preCountIteration()
                } else {
                    
                }
            })
        } else {
            isRunning = false
            pauseStartResumeBtn.setTitle("Resume", for: .normal)
            workoutTimer.invalidate()
            print("Timer Paused")
        }
    }
    
    func secondsToTimestamp(intSeconds:Int)->String {
        let mins:Int = intSeconds/60
        let secs:Int = intSeconds%60
        
        let strTimestamp:String = ((mins<10) ? "0" : "") + String(mins) + ":" + ((secs<10) ? "0" : "") + String(secs)
        return strTimestamp
    }
    
    
    func updateMultiStatusDisplay() {
        //Add ladders done to display
        self.multiStatusDisplayTextView.text = "Ladders done: " + String(laddersDone) + "/" + String(laddersToDo) + "\n"
        
        //Add sets done to display
        self.multiStatusDisplayTextView.text = self.multiStatusDisplayTextView.text + "Sets done in current ladder: " + String(setsDone) + "/" + String(maximumReps) + "\n"
        
        //Add timeRemaining to display
        self.multiStatusDisplayTextView.text = self.multiStatusDisplayTextView.text + "Time remaining: " + secondsToTimestamp(intSeconds: totalTimeRemaining)    }
    
    func populateSetsArray(){
        if isAscending {
            if isWaving{
                for i in 1...maximumReps / 2 {
                    setsArray.append(i)
                    setsArray.append(maximumReps - i + 1)
                }
                
                if maximumReps % 2 == 1 {
                    setsArray.append(maximumReps / 2 + 1)
                }
            } else {
                for i in 1...maximumReps {
                    setsArray.append(i)
                }
            }
        } else {
            if isWaving{
                for i in 1...maximumReps / 2 {
                    setsArray.append(maximumReps - i + 1)
                    setsArray.append(i)
                }
                
                if maximumReps % 2 == 1 {
                    setsArray.append(maximumReps / 2 + 1)
                }
            } else {
                for i in 1...maximumReps {
                    setsArray.append(maximumReps - i + 1)
                }
            }
        }
        print(setsArray)
    }
}

extension WorkoutController {
    
    func preCountIteration(){
        timeDisplayTextView.text = "00:0" + String(preCountTimeRemaining)
        statusTextView.text = "Get Ready!"
        nextTodoTextView.text = String(setsArray[0]) + " Reps"
        preCountTimeRemaining -= 1
        updateMultiStatusDisplay()
    }
    
    func workoutIteration(){
        
    }
    
}

