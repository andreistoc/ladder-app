//
//  CustomizeController.swift
//  Ladder App
//
//  Created by Andrew Istoc on 12/09/2018.
//  Copyright © 2018 Andrew Istoc. All rights reserved.
//

import UIKit


class CustomizeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var customizeTableView: UITableView!
    
    var isAscending: Bool = true
    var isAntagonist: Bool = true
    var isWaving: Bool = true
    var maximumReps: Int = 10
    var timePerRep: Int = 5
    var restPerRep: Int = 8
    var numberOfLadders: Int = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customizeTableView.dataSource = self
        customizeTableView.delegate = self
        customizeTableView.separatorStyle = .singleLine
        customizeTableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeCell", for: indexPath) as! CustomizeCell
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator
        
        cell.descriptionTextView.textColor = .white
        
        switch indexPath.row {
        case 0:
            let directionString: String
            if isAscending {
                directionString = "Ascending"
            } else {
                directionString = "Descending"
            }
            cell.descriptionTextView.text = "Direction: " + directionString
        case 1:
            let antagonistString: String
            if isAntagonist {
                antagonistString = "YES"
            } else {
                antagonistString = "NO"
            }
            cell.descriptionTextView.text = "Antagonist training: " + antagonistString
        case 2:
            let wavingString: String
            if isWaving {
                wavingString = "YES"
            } else {
                wavingString = "NO"
            }
            cell.descriptionTextView.text = "Waving ladder: " + wavingString
        case 3:
            cell.descriptionTextView.text = "Maximum number of reps: " + String(maximumReps)
        case 4:
            cell.descriptionTextView.text = "Time per repetition: " + String(timePerRep)
        case 5:
            cell.descriptionTextView.text = "Rest needed per rep: " + String(restPerRep)
        case 6:
            cell.descriptionTextView.text = "Number of ladders to do: " + String(numberOfLadders)
        default:
            break
        }


        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        if segue.identifier = "customizePickerSegue" {
//
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        print("Got here dude")
    }
}
