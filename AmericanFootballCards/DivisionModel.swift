//
//  NFLTeamsModel.swift
//  AmericanFootballCards
//
//  Created by Shannon Coyne on 10/4/15.
//  Copyright © 2015 Shannon Coyne. All rights reserved.
//

import Foundation

struct DivisionModelMessages {
    static let notificationName = "division model"
    static let notificationEventKey = "division model event"
    static let divisionModelInstantiated = "division model instantiated"
}

class DivisionModel {
    struct Division {
        var divisionName: String
        var teams: [TeamModel.Team]
    }
    
    var divisions: [Division]
    var divisionNameToArrayIndex: [String : Int]
    var teamModel: TeamModel!
    var observer: NSObjectProtocol?
    
    required init(tModel: TeamModel) {
        divisions = [Division]()
        divisionNameToArrayIndex = [String : Int]()
        teamModel = tModel
        initializeDivisions()
        startTeamModelObserver()
        notifyObservers(success: true, message: DivisionModelMessages.divisionModelInstantiated)
    }
    
    func initializeDivisions() {
        // hard coded values for divisions
        let divs = ["AFC-North", "AFC-South", "AFC-East", "AFC-West", "NFC-East", "NFC-West"]
        var index = 0
        
        for div in divs {
            divisions.append(Division(divisionName: div, teams: []))
            divisionNameToArrayIndex[div] = index
            index = index + 1
        }
    }
    
    private func addTeamToDivision(team: TeamModel.Team, division: String) {
        for div in divisions {
            if division == div.divisionName {
                if let index = divisionNameToArrayIndex[div.divisionName] {
                    divisions[index].teams.append(team)
                }
                else {
                    assertionFailure("Could not find index for division with that name")
                }
            }
        }
    }
    
    func startTeamModelObserver() {
        let center = NSNotificationCenter.defaultCenter()
        let uiQueue = NSOperationQueue.mainQueue()
        
        observer = center.addObserverForName(TeamModelMessages.notificationName, object: teamModel, queue: uiQueue) {
            [weak self]
            (notification) in
            if let message = notification.userInfo?[TeamModelMessages.notificationEventKey] as? String {
                self?.respondToTeamModelNotification(message)
            }
            else {
                assertionFailure("No message found in notification")
            }
        }
    }
    
    private func respondToTeamModelNotification(message: String) {
        switch message {
        case TeamModelMessages.newTeamCreated:
            // hard coded!
            for team in teamModel.teams {
                switch team.acronym {
                case "BAL", "CIN", "CLE", "PIT":
                    addTeamToDivision(team, division: "AFC-North")
                case "HOU", "IND", "JAC", "TEN":
                    addTeamToDivision(team, division: "AFC-South")
                case "BUF", "MIA", "NE", "NYJ":
                    addTeamToDivision(team, division: "AFC-East")
                case "DEN", "KC", "OAK", "SDs":
                    addTeamToDivision(team, division: "AFC-West")
                case "DAL", "NYG", "PHI", "WAS":
                    addTeamToDivision(team, division: "NFC-East")
                default: // Cardinals, 49ers, Seahawks, Rams
                    addTeamToDivision(team, division: "NFC-West")
                }
            }
        default:
            assertionFailure("Unrecognized Team model message received")
        }
    }
    
    func notifyObservers(success success: Bool, message: String) {
        let notification = NSNotification(
            name: DivisionModelMessages.notificationName,
            object: self,
            userInfo: [DivisionModelMessages.notificationEventKey : message]
        )
        
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
}