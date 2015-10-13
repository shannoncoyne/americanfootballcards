//
//  TeamTableViewController.swift
//  AmericanFootballCards
//
//  Created by Shannon Coyne on 10/4/15.
//  Copyright © 2015 Shannon Coyne. All rights reserved.
//

import UIKit

struct TeamTableIdentifiers {
    static let reuseIdentifier = "teamReuseIdentifier"
}

class TeamTableViewController: UITableViewController {
    var teamModel: TeamModel!
    var gameModel: GameModel!
    var divisionModel: DivisionModel?
    var games: [GameModel.Game]!

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TeamTableIdentifiers.reuseIdentifier, forIndexPath: indexPath) as! TeamTableViewCell
        
        let game = games[indexPath.row]

        if let logo = game.competitorLogo {
            cell.competitorLogo!.image = logo
        } else {
            cell.competitorLogo!.image = UIImage(named: "default")
        }
    
        cell.teamsLabel!.text = "\(game.visitingTeam.acronym) @ \(game.homeTeam.acronym)"
        cell.dateLabel!.text = "\(game.dateTime)"
        cell.stadiumLabel!.text = "\(game.homeTeam.stadium)"
        cell.networkLabel!.text = "\(game.network)"

        return cell
    }
}
