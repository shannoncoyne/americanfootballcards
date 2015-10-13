//
//  TeamModel.swift
//  AmericanFootballCards
//
//  Created by Shannon Coyne on 10/4/15.
//  Copyright © 2015 Shannon Coyne. All rights reserved.
//

import Foundation
import UIKit

struct TeamModelMessages {
    static let notificationName = "team model"
    static let notificationEventKey = "team model event"
    static let newTeamCreated = "new team created"
}

class TeamModel {
    struct Team {
        let teamName: String
        let acronym: String
        let originName: String
        let stadium: String
        let logo: UIImage?
    }
    
    var teams: [Team]
    var divisionModel: DivisionModel?
    var teamNameToArrayIndex: [String : Int]
    var observer: NSObjectProtocol?
    
    required init() {
        teams = [Team]()
        teamNameToArrayIndex = [String : Int]()
        startDivisionModelObserver()
    }
    
    struct Stadium {
        static let att = "AT&T Stadium"
        static let lucasOil = "Lucas Oil Stadium"
        static let gillette = "Gillette Stadium"
        static let metLife = "MetLife Stadium"
        static let sportsAuthority = "Sports Authority Field At Mile High"
        static let nrg = "NRG Stadium"
        static let sunLife = "Sun Life Stadium"
        static let heinz = "Heinz Field"
        static let levis = "Levi's Stadium"
        static let mt = "M&T Bank Stadium"
        static let paulBrown = "Paul Brown Stadium"
        static let firstEnergy = "First Energy Stadium"
        static let uniPhoenix = "University of Phoenix Stadium"
        static let centuryLink = "Century Link Field"
        static let edwardJones = "Edward Jones Dome"
        static let ralphWilson = "Ralph Wilson Stadium"
        static let fedEx = "FedEx Field"
        static let lincolnFinancial = "Lincoln Financial Field"
        static let nissan = "Nissan Stadium"
        static let everBank = "EverBank Field"
        static let qualcomm = "Qualcomm Stadium"
        static let oCo = "O.co Coliseum"
        static let arrowhead = "Arrowhead Stadium"
    }
    
    func addTeam(teamName teamName: String, acronym: String, originName: String, stadium: String, logo: Bool) {
        if logo {
            teams.append(Team(teamName: teamName, acronym: acronym, originName: originName, stadium: stadium, logo: UIImage(named: teamName)))
        } else {
            teams.append(Team(teamName: teamName, acronym: acronym, originName: originName, stadium: stadium, logo: nil))
        }
        
        if let i = teams.indexOf({$0.teamName == teamName}) {
            teamNameToArrayIndex[teamName] = i
        }
    }
    
    func initializeTeams() {
        // hard coded teams!
        
        // AFC-North
        addTeam(teamName: "Ravens", acronym: "BAL", originName: "Baltimore", stadium: Stadium.mt, logo: true)
        addTeam(teamName: "Bengals", acronym: "CIN", originName: "Cincinnati", stadium: Stadium.paulBrown, logo: true)
        addTeam(teamName: "Browns", acronym: "CLE", originName: "Cleveland", stadium: Stadium.firstEnergy, logo: true)
        addTeam(teamName: "Steelers", acronym: "PIT", originName: "Pittsburgh", stadium: Stadium.heinz, logo: true) // Steelers
        
        // AFC-South
        addTeam(teamName: "Texans", acronym: "HOU", originName: "Houston", stadium: Stadium.nrg, logo: true)
        addTeam(teamName: "Colts", acronym: "IND", originName: "Indianapolis", stadium: Stadium.lucasOil, logo: true)
        addTeam(teamName: "Jaguars", acronym: "JAC", originName: "Jacksonville", stadium: Stadium.everBank, logo: true)
        addTeam(teamName: "Titans", acronym: "TEN", originName: "Tennessee", stadium: Stadium.nissan, logo: true)
        
        // AFC-East
        addTeam(teamName: "Bills", acronym: "BUF", originName: "Buffalo", stadium: Stadium.ralphWilson, logo: true)
        addTeam(teamName: "Dolphins", acronym: "MIA", originName: "Miami", stadium: Stadium.sunLife, logo: true)
        addTeam(teamName: "Patriots", acronym: "NE", originName: "New England", stadium: Stadium.gillette, logo: true) // Patriots
        addTeam(teamName: "Jets", acronym: "NYJ", originName: "New York", stadium: Stadium.metLife, logo: true)
        
        // AFC-West
        addTeam(teamName: "Broncos", acronym: "DEN", originName: "Denver", stadium: Stadium.sportsAuthority, logo: true)
        addTeam(teamName: "Chiefs", acronym: "KC", originName: "Kansas City", stadium: Stadium.arrowhead, logo: true)
        addTeam(teamName: "Raiders", acronym: "OAK", originName: "Oakland", stadium: Stadium.oCo, logo: true)
        addTeam(teamName: "Chargers", acronym: "SD", originName: "San Diego", stadium: Stadium.qualcomm, logo: true)
        
        // NFC-North TO-DO
        
        // NFC-South TO-DO
        
        // NFC-East
        addTeam(teamName: "Cowboys", acronym: "DAL", originName: "Dallas", stadium: Stadium.att, logo: true) // Cowboys
        addTeam(teamName: "Giants", acronym: "NYG", originName: "New York", stadium: Stadium.metLife, logo: true)
        addTeam(teamName: "Eagles", acronym: "PHI", originName: "Philadelphia", stadium: Stadium.lincolnFinancial, logo: true)
        addTeam(teamName: "Red Skins", acronym: "WAS", originName: "Washington", stadium: Stadium.fedEx, logo: true)

        // NFC-West
        addTeam(teamName: "49ers", acronym: "SF", originName: "San Francisco", stadium: Stadium.levis, logo: true) // 49ers
        addTeam(teamName: "Cardinals", acronym: "ARI", originName: "Arizona", stadium: Stadium.uniPhoenix, logo: true)
        addTeam(teamName: "Seahawks", acronym: "SEA", originName: "Seattle", stadium: Stadium.centuryLink, logo: true)
        addTeam(teamName: "Rams", acronym: "STL", originName: "St. Louis", stadium: Stadium.edwardJones, logo: true)
        
        notifyObservers(success: true, message: TeamModelMessages.newTeamCreated)
    }
    
    func teamForTeamName(teamName: String) -> Team? {
        if let i = teamNameToArrayIndex[teamName] {
            return teams[i]
        }
        return nil
    }
    
    func startDivisionModelObserver() {
        print("Started division model observer")
        let center = NSNotificationCenter.defaultCenter()
        let uiQueue = NSOperationQueue.mainQueue()
        
        observer = center.addObserverForName(DivisionModelMessages.notificationName, object: divisionModel, queue: uiQueue) {
            [weak self]
            (notification) in
            if let message = notification.userInfo?[DivisionModelMessages.notificationEventKey] as? String {
                print("Responding to division model notification \(message)")
                self?.respondToDivisionModelNotification(message)
            }
            else {
                assertionFailure("No message found in notification")
            }
        }
    }
    
    private func respondToDivisionModelNotification(message: String) {
        switch message {
        case DivisionModelMessages.divisionModelInstantiated:
            print("Division model instantiated")
            initializeTeams()
        default:
            print("Hi")
        }
    }
    
    func notifyObservers(success success: Bool, message: String) {
        let notification = NSNotification(
            name: TeamModelMessages.notificationName,
            object: self,
            userInfo: [TeamModelMessages.notificationEventKey : message]
        )
        
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
}