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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomizeCell", for: indexPath) as! CustomizeCell
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator
        cell.descriptionTextView.text = "Sets:"
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let row = indexPath.row
    }
}
