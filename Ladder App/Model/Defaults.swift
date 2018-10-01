//
//  Defaults.swift
//  Ladder App
//
//  Created by Andrew Istoc on 01/10/2018.
//  Copyright © 2018 Andrew Istoc. All rights reserved.
//

import Foundation

struct Defaults {
    
    let isAscendingKey = "ascending"
    let isWavingKey = "waving"
    let maximumRepsKey = "max"
    let timePerRepKey = "timeperrep"
    let restPerRepKey = "restperrep"
    let laddersToDoKey = "ladderstodo"
    let restBetweenLaddersKey = "restbetweenladders"
    static let userSessionKey = "com.save.usersession"
    let defaults = UserDefaults.standard
    
    
    var isAscending: Bool
    var isWaving: Bool
    var maximumReps: Int
    var timePerRep: Int
    var restPerRep: Int
    var laddersToDo: Int
    var restBetweenLadders: Int
    
    init(isAscending: Bool, isWaving: Bool, maximumReps: Int, timePerRep: Int, restPerRep: Int, laddersToDo: Int, restBetweenLadders: Int) {
        self.isAscending = isAscending
        self.isWaving = isWaving
        self.maximumReps = maximumReps
        self.timePerRep = timePerRep
        self.restPerRep = restPerRep
        self.laddersToDo = laddersToDo
        self.restBetweenLadders = restBetweenLadders
    }
    
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userSessionKey)
    }
    
    func saveAll(isAscending: Bool, isWaving: Bool, maximumReps: Int, timePerRep: Int, restPerRep: Int, laddersToDo: Int, restBetweenLadders: Int) {
        
        defaults.set(isAscending, forKey: isAscendingKey)
        defaults.set(isWaving, forKey: isWavingKey)
        defaults.set(maximumReps, forKey: maximumRepsKey)
        defaults.set(timePerRep, forKey: timePerRepKey)
        defaults.set(restPerRep, forKey: restPerRepKey)
        defaults.set(laddersToDo, forKey: laddersToDoKey)
        defaults.set(restBetweenLadders, forKey: restBetweenLaddersKey)
    }
    
    func saveAscending() {
        defaults.set(isAscending, forKey: isAscendingKey)
    }
    
    func saveWaving() {
        defaults.set(isWaving, forKey: isWavingKey)
    }
    
    func saveMaxReps() {
        defaults.set(maximumReps, forKey: maximumRepsKey)
    }
    
    func saveTimePerRep () {
        defaults.set(timePerRep, forKey: timePerRepKey)
    }
    
    func saveRestPerRep() {
        defaults.set(restPerRep, forKey: restPerRepKey)
    }
    
    func saveLaddersToDo() {
        defaults.set(laddersToDo, forKey: laddersToDoKey)
    }
    
    func saveRestBetweenLadders() {
        defaults.set(restBetweenLadders, forKey: restBetweenLaddersKey)
    }
}
