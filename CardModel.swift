//
//  CardModel.swift
//  CardFinal
//
//  Created by Akshay Devkate on 04/10/19.
//  Copyright © 2019 Akshay Devkate. All rights reserved.
//

import Foundation

class CardModel{
    
    func getCards() -> [Card]{
        
        //declare an array of stored numbers we've already generated
        var generatedNumberArray = [Int]()
        
        // declare an array to store generated cards
        var generatedCardsArray = [Card]()
        
        //Randmoly generate pairs of cards
        
        while generatedNumberArray.count < 8 {
            
            //get random number
            let randomNumber = arc4random_uniform(13) + 1
            
            //ensure that the random number is not the one we already have
            if generatedNumberArray.contains(Int(randomNumber)) == false{
                
                //log the number
                 print(randomNumber)
                
                //store the number into generatedNumberarray
                generatedNumberArray.append(Int(randomNumber))
                
                //Store the number into generated card array
                generatedNumberArray.append(Int(randomNumber))
                  // create first card object
                 let cardOne = Card()
                
                
                 cardOne.imageName = "Card\(randomNumber)"
                 
                 generatedCardsArray.append(cardOne)
                 
                 //create second card object
                 let cardTwo = Card()
                 
                 cardTwo.imageName =  "Card\(randomNumber)"
                 generatedCardsArray.append(cardTwo)
            }
            
            
            
            
            //Optional : Make it so we only have uique pairs of cards
            
            
        }
        //TODO: Randomize array
        
        for i in 0...generatedCardsArray.count-1{
            
   
        
        //find a random index to swap with
        let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
        
        //swap the two cards
        let temporaryStorage = generatedCardsArray[i]
        generatedCardsArray[i] = generatedCardsArray[randomNumber]
        
            generatedCardsArray[randomNumber] = temporaryStorage
        }
        
        
        //Return the array
        return generatedCardsArray
        
    }
}
