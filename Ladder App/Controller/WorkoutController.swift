//
//  ViewController.swift
//  Ladder App
//
//  Created by Andrew Istoc on 11/09/2018.
//  Copyright © 2018 Andrew Istoc. All rights reserved.
//

import UIKit
import AVFoundation

class WorkoutController: UIViewController {
    
    //Color variables
    let restColor = #colorLiteral(red: 0, green: 0.6549019608, blue: 0.8823529412, alpha: 1)
    let exerciseColor = #colorLiteral(red: 1, green: 0.368627451, blue: 0.3568627451, alpha: 1)
    
    //Data variables
    var isAscending = false
    var isWaving = true
    var maximumReps = 3
    var timePerRep = 3
    var restPerRep = 5
    var laddersToDo = 2
    var restBetweenLadders = 10
    
    
    //State variables:
    var isRunning = false
    var preCountTimeRemaining = 5
    var isWorkout = true
    var totalTimeRemaining = 0
    var setsArray: [Int] = []
    var setTimesArray: [Int] = []
    var restTimesArray: [Int] = []
    var setTimeRemaining = 0
    var restTimeRemaining = 0
    var setsDone = 0
    var laddersDone = 0
    var ladderRestTimeRemaining = 10
    var workoutStarted = false
    
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
    
    //Speech variables
    let synth = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance(string: "")
    
    //Meep player
    var meepPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "meep.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            meepPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("Could not load audio file")
        }

        
        //Customize buttons
        pauseStartResumeBtn.layer.cornerRadius = 16
        resetBtn.layer.cornerRadius = 8
        
        //Set background color
        self.view.backgroundColor = restColor
        
        //Set start button
        pauseStartResumeBtn.setTitle("Start Workout", for: .normal)
        
        //Generate UserDefaults at first run
        
        if  !isAppAlreadyLaunchedOnce() {
            writeDataToUserDefaults()
        }
        
        //Set initial clear labels
        timeDisplayTextView.text = ""
        statusTextView.text = ""
        nextTextView.text = ""
        nextTodoTextView.text = ""
        setInitialMultiStatusDisplay()
        
        //Populate sets array
        populateSetsArray()
        
        //Calculate rep times and rest times
        restTimesArray = setsArray.map({return $0 * restPerRep})
        setTimesArray = setsArray.map({return $0 * timePerRep})
        
        print(restTimesArray)
        print(setTimesArray)
        
        //Calculate total workout time
        
        calculateTotalTimeRemaining()
        
        //Set utterance rate
        utterance.rate = 0.1
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        resetWorkout()
    }
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        resetWorkout()
    }
    
    @IBAction func pauseStartResumeBtnPressed(_ sender: Any) {
        workoutStarted = true
        nextTextView.text = "Next:"
        if !isRunning {
            isRunning = true
            pauseStartResumeBtn.setTitle("Pause", for: .normal)
            if preCountTimeRemaining > 0 {
                utterance = AVSpeechUtterance(string: "get ready!")
                synth.speak(utterance)
                preCountIteration()
            }
            workoutTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                
                if self.preCountTimeRemaining > 0 {
                    self.preCountIteration()
                    
                    if self.preCountTimeRemaining == 1 || self.preCountTimeRemaining == 2 || self.preCountTimeRemaining == 3 {
                        self.meepPlayer?.play()
                        print("Meep!")
                    }
                    
                    if self.preCountTimeRemaining == 0 {
                        self.utterance = AVSpeechUtterance(string: "Do " + String(self.setsArray[self.setsDone]) + " reps!")
                        self.synth.speak(self.utterance)
                        
                    }
                } else {
                    if self.laddersDone < self.laddersToDo {
                        
                        if self.setsDone == self.setsArray.count {
                            if self.ladderRestTimeRemaining > 0 && self.laddersDone < self.laddersToDo - 1 && self.setsDone != 0 {
                                
                                if self.ladderRestTimeRemaining == self.restBetweenLadders {
                                    self.utterance = AVSpeechUtterance(string: "Rest until the next ladder starts!")
                                    self.synth.speak(self.utterance)
                                }
                                self.ladderRestIteration()
                                
                            } else {
                                self.setsDone = 0
                                self.laddersDone += 1
                                self.setTimeRemaining = self.setTimesArray[0]
                                self.restTimeRemaining = self.restTimesArray[0]
                                self.ladderRestTimeRemaining = self.restBetweenLadders
                                self.isWorkout = true
                                if self.laddersDone < self.laddersToDo {
                                    self.utterance = AVSpeechUtterance(string: "Do " + String(self.setsArray[self.setsDone]) + " reps!")
                                    self.synth.speak(self.utterance)
                                }
                            }
                        } else {
                            if self.isWorkout {
                                self.workoutIteration()
                                if self.setTimeRemaining == 1 || self.setTimeRemaining == 2 || self.setTimeRemaining == 3 {
                                    self.meepPlayer?.play()
                                    print("Meep!")
                                }
                                
                                if self.setTimeRemaining == 0 {
                                    self.isWorkout = false
                                    self.utterance = AVSpeechUtterance(string: "Rest!")
                                    self.synth.speak(self.utterance)
                                    
                                }
                                
                                
                                
                                
                            } else {
                                self.restIteration()
                                
                                if self.restTimeRemaining == 0 || self.restTimeRemaining == 1 || self.restTimeRemaining == 2 {
                                    self.meepPlayer?.play()
                                    print("Meep!")
                                }
                                
                                if self.restTimeRemaining == 0 {
                                    self.setsDone += 1
                                    print("Sets done: \(self.setsDone), Total sets: \(self.maximumReps)")
                                    if self.setsDone < self.maximumReps {
                                        self.setTimeRemaining = self.setTimesArray[self.setsDone]
                                        self.restTimeRemaining = self.restTimesArray[self.setsDone]
                                        self.isWorkout = true
                                        self.view.backgroundColor = self.exerciseColor
                                        self.utterance = AVSpeechUtterance(string: "Do " + String(self.setsArray[self.setsDone]) + " reps!")
                                        self.synth.speak(self.utterance)
                                    }
                                }
                                
                                
                                
                            }
                        }
                        
                        
                        
                        
                    } else {
                        self.finishWorkout()
                        self.utterance = AVSpeechUtterance(string: "Workout done! Great job!")
                        self.synth.speak(self.utterance)
                        self.workoutTimer.invalidate()
                    }
                }
            })
        } else {
            isRunning = false
            pauseStartResumeBtn.setTitle("Resume", for: .normal)
            workoutTimer.invalidate()
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
        
        setsArray = []
        
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
        updateMultiStatusDisplay()
        preCountTimeRemaining -= 1
        totalTimeRemaining -= 1
    }
    
    func workoutIteration(){
        updateMultiStatusDisplay()
        timeDisplayTextView.text = secondsToTimestamp(intSeconds: setTimeRemaining)
        statusTextView.text = "Do " + String(setsArray[setsDone]) + " reps"
        nextTodoTextView.text = "Rest"
        totalTimeRemaining -= 1
        setTimeRemaining -= 1
        self.view.backgroundColor = self.exerciseColor
    }
    
    func restIteration(){
        updateMultiStatusDisplay()
        timeDisplayTextView.text = secondsToTimestamp(intSeconds: restTimeRemaining)
        statusTextView.text = "Rest"
        if setsDone < maximumReps - 1 {
            nextTodoTextView.text = "Do " + String(setsArray[setsDone + 1]) + " reps"
        }
        totalTimeRemaining -= 1
        restTimeRemaining -= 1
        self.view.backgroundColor = self.restColor
    }
    
    func finishWorkout(){
        timeDisplayTextView.text = ""
        statusTextView.text = "Done!"
        nextTextView.text = "Great job!"
        nextTodoTextView.text = ""
        setInitialMultiStatusDisplay()
        self.view.backgroundColor = self.restColor
    }
    
    func ladderRestIteration(){
        updateMultiStatusDisplay()
        timeDisplayTextView.text = secondsToTimestamp(intSeconds: ladderRestTimeRemaining)
        statusTextView.text = "Rest"
        nextTodoTextView.text = "Do " + String(setsArray[0]) + " reps"
        totalTimeRemaining -= 1
        ladderRestTimeRemaining -= 1
    }
    
    func calculateTotalTimeRemaining() {
        //Add length of sets and rests between sets
        totalTimeRemaining = setTimesArray.reduce(0, +) + restTimesArray.reduce(0, +)
        //Multiply by the number of ladders to do
        totalTimeRemaining *= laddersToDo
        //Add the length of the pre count
        totalTimeRemaining += 5
        //Add the rest between the ladders
        totalTimeRemaining += (laddersToDo - 1) * restBetweenLadders
        
        setTimeRemaining = setTimesArray[0]
        restTimeRemaining = restTimesArray[0]
    }
    
    func setInitialMultiStatusDisplay() {
        var stringToDisplay = "Ladders selected: \(laddersToDo)\nMaximum number of reps: \(maximumReps)\n"
        
        if isWaving {
            stringToDisplay += "Ladder type: Waving\n"
        } else {
            if isAscending {
                stringToDisplay += "Ladder type: Ascending\n"
            } else {
                stringToDisplay += "Ladder type: Descending\n"
            }
        }
        
        
        multiStatusDisplayTextView.text = stringToDisplay
    }
    
    
    func getDataFromUserDefaults() {
        //Get data from user defaults
        isAscending = UserDefaults.standard.bool(forKey: DefaultsKeys.isAscendingKey)
        isWaving = UserDefaults.standard.bool(forKey: DefaultsKeys.isWavingKey)
        maximumReps = UserDefaults.standard.integer(forKey: DefaultsKeys.maximumRepsKey)
        timePerRep = UserDefaults.standard.integer(forKey: DefaultsKeys.timePerRepKey)
        restPerRep = UserDefaults.standard.integer(forKey: DefaultsKeys.restPerRepKey)
        laddersToDo = UserDefaults.standard.integer(forKey: DefaultsKeys.laddersToDoKey)
        restBetweenLadders = UserDefaults.standard.integer(forKey: DefaultsKeys.restBetweenLaddersKey)
    }
    
    func writeDataToUserDefaults() {
        UserDefaults.standard.set(isAscending, forKey: DefaultsKeys.isAscendingKey)
        UserDefaults.standard.set(isWaving, forKey: DefaultsKeys.isWavingKey)
        UserDefaults.standard.set(maximumReps, forKey: DefaultsKeys.maximumRepsKey)
        UserDefaults.standard.set(timePerRep, forKey: DefaultsKeys.timePerRepKey)
        UserDefaults.standard.set(restPerRep, forKey: DefaultsKeys.restPerRepKey)
        UserDefaults.standard.set(laddersToDo, forKey: DefaultsKeys.laddersToDoKey)
        UserDefaults.standard.set(restBetweenLadders, forKey: DefaultsKeys.restBetweenLaddersKey)
    }
}


//Function that detects the first time the app runs
extension WorkoutController {
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
}

//Function that resets the workout parameters
extension WorkoutController {
    func resetWorkout() {
        if isRunning {
            workoutTimer.invalidate()
        }
        
        self.view.backgroundColor = restColor
        
        
        
        //Set initial clear labels
        timeDisplayTextView.text = ""
        statusTextView.text = ""
        nextTextView.text = ""
        nextTodoTextView.text = ""
        setInitialMultiStatusDisplay()
        workoutStarted = false
        
        
        //Re-retrieve data from user defaults
        getDataFromUserDefaults()
        populateSetsArray()
        
        //Reset state variables
        isRunning = false
        preCountTimeRemaining = 5
        isWorkout = true
        setTimeRemaining = 0
        restTimeRemaining = 0
        setsDone = 0
        laddersDone = 0
        ladderRestTimeRemaining = 10
        calculateTotalTimeRemaining()
        preCountTimeRemaining = 5
        
        pauseStartResumeBtn.setTitle("Start Workout", for: .normal)
    }
}
