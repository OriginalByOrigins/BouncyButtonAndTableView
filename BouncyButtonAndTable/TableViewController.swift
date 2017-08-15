//
//  TableViewController.swift
//  BouncyButtonAndTable
//
//  Created by Harry Cao on 18/6/17.
//  Copyright © 2017 HarryCodes. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  let cellId = "cellId"
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 50
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

    // Configure the cell...
    cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: CGFloat(drand48()))
    return cell
  }
  
  /** Animate using willDisplayCell */
  /* WRONG METHOD: THIS FUNCTION WILL BE CALLES CONSTANTLY IF WE SCROLL */
//  var delayCounter = 0.0
//  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    cell.transform = CGAffineTransform(translationX: 0, y: self.tableView.bounds.size.height)
//    UIView.animate(withDuration: 2, delay: delayCounter*0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
//      cell.transform = .identity
//    }, completion: nil)
//
//    delayCounter += 1
//  }
  
  /** Animate using viewWillAppear */
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    animateCellsIn()
  }
  
  func animateCellsIn() {
    self.tableView.reloadData()
    
    let cells = self.tableView.visibleCells
  
    for cell in cells {
      cell.transform = CGAffineTransform(translationX: 0, y: self.tableView.bounds.size.height)
    }

    var delayCounter = 0.0
    for cell in cells {
      UIView.animate(withDuration: 2, delay: delayCounter*0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
        cell.transform = .identity
      }, completion: nil)

      delayCounter += 1
    }
  }
}
