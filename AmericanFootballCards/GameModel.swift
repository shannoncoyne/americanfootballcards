//
//  GameModel.swift
//  AmericanFootballCards
//
//  Created by Shannon Coyne on 10/5/15.
//  Copyright © 2015 Shannon Coyne. All rights reserved.
//

import Foundation
import UIKit

class GameModel {
    struct Game {
        let dateTime: String
        let homeTeam: TeamModel.Team
        let visitingTeam: TeamModel.Team
        let network: String
        var competitorLogo: UIImage?
    }
    
    var teamModel: TeamModel!
    var games: [Game]
    let dateStringFormatter = NSDateFormatter()
    
    struct Network {
        static let cbs = "CBS"
        static let espn = "ESPN"
        static let fox = "FOX"
        static let nbc = "NBC"
    }
    
    required init(tmodel: TeamModel) {
        teamModel = tmodel
        games = [Game]()
        addGames()
    }
    
    func getGamesForTeam(team: TeamModel.Team) -> [Game] {
        var gamesForTeam = [Game]()
        
        for game in games {
            var thisGame = game
            if team.teamName == game.homeTeam.teamName {
                thisGame.competitorLogo = game.visitingTeam.logo
                gamesForTeam.append(thisGame)
            }
            else if team.teamName == game.visitingTeam.teamName {
                thisGame.competitorLogo = game.homeTeam.logo
                gamesForTeam.append(thisGame)
            }
        }
        
        return gamesForTeam
    }
    
    func dateFormatter(dateString: String, timeString: String) -> String {
        dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm Z"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateStringFormatter.timeZone = NSTimeZone(name: "EST")
        
        let s = "\(dateString) \(timeString) -0500"
        let d = dateStringFormatter.dateFromString(s)
        
        dateStringFormatter.dateFormat = "MMM d 'at' HH:mm zzz"
        let date = dateStringFormatter.stringFromDate(d!)
        return date
    }
    
    func addGames() {
        games.append(
            Game(
                dateTime: dateFormatter("2015-10-11", timeString: "16:25"),
                homeTeam: teamModel.teamForTeamName("Cowboys")!,
                visitingTeam: teamModel.teamForTeamName("Patriots")!,
                network: Network.cbs,
                competitorLogo: nil
            )
        )
        
        games.append(
            Game(
                dateTime: dateFormatter("2015-10-18", timeString: "20:30"),
                homeTeam: teamModel.teamForTeamName("Colts")!,
                visitingTeam: teamModel.teamForTeamName("Patriots")!,
                network: Network.nbc,
                competitorLogo: nil
            )
        )
        
        games.append(
            Game(
                dateTime: dateFormatter("2015-10-25", timeString: "13:00"),
                homeTeam: teamModel.teamForTeamName("Patriots")!,
                visitingTeam: teamModel.teamForTeamName("Jets")!,
                network: Network.cbs,
                competitorLogo: nil
            )
        )
        
        games.append(
            Game(
                dateTime: dateFormatter("2015-10-29", timeString: "20:25"),
                homeTeam: teamModel.teamForTeamName("Patriots")!,
                visitingTeam: teamModel.teamForTeamName("Dolphins")!,
                network: Network.cbs,
                competitorLogo: nil
            )
        )
        
        games.append(
            Game(
                dateTime: dateFormatter("2015-11-08", timeString: "13:00"),
                homeTeam: teamModel.teamForTeamName("Patriots")!,
                visitingTeam: teamModel.teamForTeamName("Red Skins")!,
                network: Network.fox,
                competitorLogo: nil
            )
        )
        
        games.append(
            Game(
                dateTime: dateFormatter("2015-11-15", timeString: "16:25"),
                homeTeam: teamModel.teamForTeamName("Giants")!,
                visitingTeam: teamModel.teamForTeamName("Patriots")!,
                network: Network.cbs,
                competitorLogo: nil
            )
        )
        
        games.append(
            Game(
                dateTime: dateFormatter("2015-11-23", timeString: "20:30"),
                homeTeam: teamModel.teamForTeamName("Bills")!,
                visitingTeam: teamModel.teamForTeamName("Patriots")!,
                network: Network.espn,
                competitorLogo: nil
            )
        )
        
        games.append(
            Game(
                dateTime: dateFormatter("2015-11-29", timeString: "20:30"),
                homeTeam: teamModel.teamForTeamName("Patriots")!,
                visitingTeam: teamModel.teamForTeamName("Broncos")!,
                network: Network.nbc,
                competitorLogo: nil
            )
        )
        
        games.append(
            Game(
                dateTime: dateFormatter("2015-12-06", timeString: "16:25"),
                homeTeam: teamModel.teamForTeamName("Steelers")!,
                visitingTeam: teamModel.teamForTeamName("Patriots")!,
                network: Network.fox,
                competitorLogo: nil
            )
        )
        
        games.append(
            Game(
                dateTime: dateFormatter("2015-12-13", timeString: "13:00"),
                homeTeam: teamModel.teamForTeamName("Patriots")!,
                visitingTeam: teamModel.teamForTeamName("Texans")!,
                network: Network.cbs,
                competitorLogo: nil
            )
        )
        
        games.append(
            Game(
                dateTime: dateFormatter("2015-12-20", timeString: "13:00"),
                homeTeam: teamModel.teamForTeamName("Titans")!,
                visitingTeam: teamModel.teamForTeamName("Patriots")!,
                network: Network.cbs,
                competitorLogo: nil
            )
        )
        
        games.append(
            Game(
                dateTime: dateFormatter("2015-12-27", timeString: "13:00"),
                homeTeam: teamModel.teamForTeamName("Patriots")!,
                visitingTeam: teamModel.teamForTeamName("Jets")!,
                network: Network.cbs,
                competitorLogo: nil
            )
        )
        
        games.append(
            Game(
                dateTime: dateFormatter("2015-01-03", timeString: "13:00"),
                homeTeam: teamModel.teamForTeamName("Dolphins")!,
                visitingTeam: teamModel.teamForTeamName("Patriots")!,
                network: Network.cbs,
                competitorLogo: nil
            )
        )
    }
}