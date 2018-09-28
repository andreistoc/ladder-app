//
//  PickerController.swift
//  Ladder App
//
//  Created by Andrew Istoc on 19/09/2018.
//  Copyright © 2018 Andrew Istoc. All rights reserved.
//

import UIKit

class PickerController: UIViewController {
    
    //The number of the cell that was selected when customizing
    var customizeCellSelected = 0
    
    //Picker Outlet
    @IBOutlet weak var optionPicker: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(customizeCellSelected)
        choosePicker()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func choosePicker(){
        switch customizeCellSelected {
        case 0:
            ascendingDescending()
        case 1:
            wavingOrNot()
        case 2:
            maximumNumberOfReps()
        case 3:
            timePerRepetition()
        case 4:
            restPerRep()
        case 5:
            laddersToDo()
        case 6:
            restBetweenLadders()
        default:
            break
        }
    }
    
    
}

extension PickerController {
    //Contains the functions that create each picker option depending on customize selection
    func ascendingDescending(){
        
    }
    
    func wavingOrNot(){
        
    }
    
    func maximumNumberOfReps(){
        
    }
    
    func timePerRepetition(){
        
    }
    
    func restPerRep () {
        
    }
    
    func laddersToDo () {
        
    }
    
    func restBetweenLadders () {
        
    }
    
}
