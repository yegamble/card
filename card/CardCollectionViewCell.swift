//
//  CardCollectionViewCell.swift
//  card
//
//  Created by Yosef Gamble on 28/10/19.
//  Copyright © 2019 Yosef Gamble. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontimageview: UIImageView!
    
    @IBOutlet weak var backimageview: UIImageView!
    
    var card:Card?
    
    
    func setCard(_ card:Card){
        
        //card assigned to
        self.card = card
        
        
        //fixed problem of cards re-appearing or disappearing
        if card.isMatched == true {
            
            //if the card matches make the image views invisible
            backimageview.alpha = 0
            frontimageview.alpha = 0
            
            return
        } else {
             //if the card matches make the image views visible
            backimageview.alpha = 1
            frontimageview.alpha = 1
        }
        
        
        frontimageview.image = UIImage(named: card.imageName)
        
        //Determine which way card is flipped.
        if card.isFlipped == true {
            // Make sure the frontimageview is on top
            UIView.transition(from: backimageview, to: frontimageview, duration: 0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: frontimageview, to: backimageview, duration: 0, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)            
        }
        
    }
    
    func flip(){
        
        UIView.transition(from: backimageview, to: frontimageview, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews] , completion: nil)
    }
    
    func flipBack(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
         
            UIView.transition(from: self.frontimageview, to: self.backimageview, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    
    func remove(){
        
        //removes cards from being visible
        backimageview.alpha = 0
        
        
        //TODO: Animate
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontimageview.alpha = 0
        }, completion: nil)
    }
    
}
