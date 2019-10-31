//
//  CardCollectionViewCell.swift
//  CardFinal
//
//  Created by Akshay Devkate on 05/10/19.
//  Copyright © 2019 Akshay Devkate. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    
    var card:Card?
    
    func setCard(_ card:Card){
        
        //keep track of cards that gets passed in
        self.card = card
        
        if card.isMatched == true{
            
            //if the card is matched make the image view invisible
            
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        }
        else
        {
            
            //if the card hasent been matched make the image view visible
            
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        
        
        
        frontImageView.image = UIImage(named: card.imageName)
        
        
        //determine if the card is in flipped upstate or flipped downstate
        if card.isFlipped == true{
            // make sure front image view is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews ], completion: nil)
        }
        else{
            // make sure back image view is on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    
    
    }
    
    func flip(){
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func flipBack(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
                   
        }
  
    }
    
    func remove(){
        //remove both image views from being visible
         backImageView.alpha = 0
        
        //TODO: animate it
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseIn, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
        
    }
    
}
