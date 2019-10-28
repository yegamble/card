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
        
        //Array to store previously generated numbers
        var generatedNumbersArray = [Int]()
        
        //Declare array to store generated cards
        var generatedCardsArray = [Card]()
        
        //Randomly generate pairs of cards
        while generatedNumbersArray.count < 8 {
            
            //Random number generator (0-7) + 1
            let randomNumber = arc4random_uniform(8) + 1
            
            
            //make sure random numbers are unique
            if generatedNumbersArray.contains(Int(randomNumber)) == false {
                // Log the number
                print(randomNumber)
                
                //Create first card Object
                let cardOne = Card()
                cardOne.imageName = "colour\(randomNumber)"
                
                //Store number in generated numbers array
                generatedNumbersArray.append(Int(randomNumber))
                
                generatedCardsArray.append(cardOne)
                
                // Create second card object
                let cardTwo = Card()
                cardTwo.imageName = "colour\(randomNumber)"
                
                generatedCardsArray.append(cardTwo)
            }
        }
        
        //TODO: Randomise array
        
        for i in 0...generatedCardsArray.count - 1{
            let randNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
        
        
            let tempStorage = generatedCardsArray[0]
            generatedCardsArray[0] = generatedCardsArray[randNumber]
            generatedCardsArray[randNumber] = tempStorage
        }
        
        //Return results to array
        return generatedCardsArray
    }
    
}
