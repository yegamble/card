//
//  ViewController.swift
//  card
//
//  Created by Yosef Gamble on 25/10/19.
//  Copyright © 2019 Yosef Gamble. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
  //  var user = UserModel()
    //var userArray = [User]()
    
    //First card
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    var milliseconds:Float = 120 * 1000 //10 seconds
    
    var points:Int = 0 //player initial score
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Call getCards method
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Create Timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    //MARK: - Timer Methods
    
    @objc func timerElapsed(){
        milliseconds -= 1
        
        //convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        timerLabel.text = "Time Remaining: \(seconds)"
        
        //when timer equals zero
        if milliseconds <= 0{
            timer?.invalidate()
            
            checkGameEnded()
        }
    }
    
    //MARK: - Score Methods (not used)
    
    @objc func scoreCount(){
        points += 1
        
        let count = points
        scoreLabel.text = "Score: \(count)"
        
    }
    
    //MARK: - UICollectionView Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Get a Card Collection Cell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
       
        
        //Get the card that the collection view
        let card = cardArray[indexPath.row]
        
        //set the card for a cell
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            
            cell.flip()
            
            //set status of card
            card.isFlipped = true
            
            //Determine if the card tapped is the first or second
            if firstFlippedCardIndex == nil {
                
                //first card being flipped
                firstFlippedCardIndex = indexPath
               
            } else {
                //This is the second card
                
                
                //TODO: Perform the matching logic
                checkForMatches(indexPath)
            }
            
        } else {
            cell.flipBack()
            
            card.isFlipped = false
        }
                
        
    } //End didSelectItemAt method
    
    //MARK: - Game Logic Methods
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath){
        
        //Get cells for cards that are revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        //Get cards for cells that are revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //compare two cards
        if cardOne.imageName == cardTwo.imageName {
            
            //It's a Match
            points += 1
    
            let count = points
            scoreLabel.text = "Score: \(count)"
            
            //Set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            //Remove cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            //check if any cards are left
            checkGameEnded()
            
        } else {
            // It's not a match
            points -= 1
            
            let count = points
            scoreLabel.text = "Score: \(count)"
            
            //Set the statuses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            //Flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        //Tell collectionview to reload a cell of cardOne if it is nil (offscreen)
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        //Reset the property that tracks the first card flipped
        
        firstFlippedCardIndex = nil
        
    }
        
      func checkGameEnded() {
        
        // Determine if there are any cards unmatched
        var isWon = true
        
        for card in cardArray {
            
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        
        // Messaging variables
        var title = ""
        var message = ""
        
        // If not, then user has won, stop the timer
        if isWon == true {
            
            if milliseconds > 0 {
                timer?.invalidate()
            }
            
            title = "Congratulations!"
            message = "You've won"
            
        }
        else {
            // If there are unmatched cards, check if there's any time left
            
            if milliseconds > 0 {
                return
            }
            
            title = "Game Over"
            message = "You've lost"
        }
        
        // Show won/lost messaging
        showAlert(title, message)
    }
    
    func showAlert(_ title:String, _ message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }

} //ViewControllerClass End

//Setting user name and score

