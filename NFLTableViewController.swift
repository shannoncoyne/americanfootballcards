//
//  NFLTableViewController.swift
//  AmericanFootballCards
//
//  Created by Shannon Coyne on 10/4/15.
//  Copyright © 2015 Shannon Coyne. All rights reserved.
//

import UIKit

struct NFLTableIdentifiers {
    static let reuseIdentifier = "reuse identifier"
    static let segueIdentifier = "show team"
}

struct NFLTableErrorMsgs {
    static let couldntLoadData = "couldn't load data"
}

class NFLTableViewController: UITableViewController {
    var teamModel: TeamModel!
    var divModel: DivisionModel! {
        didSet { teamModel.divisionModel = divModel }
    }
    var gameModel: GameModel!
    
    override func awakeFromNib() {
        teamModel = TeamModel()
        divModel = DivisionModel(tModel: teamModel)
        gameModel = GameModel(tmodel: teamModel)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Number of NFL team groupings
        return divModel.divisions.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return divModel.divisions[section].teams.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return divModel.divisions[section].divisionName
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NFLTableIdentifiers.reuseIdentifier, forIndexPath: indexPath) as! NFLTableViewCell
        
        let team = divModel.divisions[indexPath.section].teams[indexPath.row]
        
        print("Populating cell for \(team.teamName)")
        
        if let logo = team.logo {
            cell.teamLogo!.image = logo
        } else {
            cell.teamLogo!.image = UIImage(named: "default")
        }
        cell.teamNameLabel!.text = "\(team.originName) \(team.teamName)"
        
        return cell
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            if let destination = segue.destinationViewController as? TeamTableViewController {
                let team = divModel.divisions[indexPath.section].teams[indexPath.row]
                
                destination.teamModel = teamModel
                destination.divisionModel = divModel
                destination.gameModel = gameModel
                destination.games = gameModel.getGamesForTeam(team)
        
                destination.title = "\(team.originName) \(team.teamName) Schedule"
            }
        }
    }

}
