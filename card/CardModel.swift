//
//  CardModel.swift
//  Colour
//
//  Created by Yosef Gamble on 25/10/19.
//  Copyright © 2019 Yosef Gamble. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card]{
        
        //Declare array to store generated cards
        var generatedCardsArray = [Card]()
        
        //Randomly generate pairs of cards
        for _ in 1...8 {
            
            //Random number generator (0-7) + 1
            let randomNumber = arc4random_uniform(8) + 1
            
            // Log the number
            print(randomNumber)
            
            //Create first card Object
            let cardOne = Card()
            cardOne.imageName = "colour\(randomNumber)"
            
            generatedCardsArray.append(cardOne)
            
            // Create second card object
            let cardTwo = Card()
            cardTwo.imageName = "colour\(randomNumber)"

            generatedCardsArray.append(cardTwo)
            
            //OPTIONAL: Make only unique pairs of cards
        }
        //Randomise array
        
        //Return results to array
        return generatedCardsArray
    }
    
}
