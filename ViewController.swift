//
//  ViewController.swift
//  CardFinal
//
//  Created by Akshay Devkate on 04/10/19.
//  Copyright © 2019 Akshay Devkate. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var timerLabel: UILabel!
    




    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray =  [Card]()
    
    var firstFlippedCardIndex: IndexPath?
    
    var timer:Timer?
    var milliseconds:Float = 10 * 1000 // 10 seconds
    
   
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        collectionView.delegate = self
        collectionView.dataSource = self
    
        //call get card method of card model he varti ahe tikde
        cardArray = model.getCards()
        
        //create a timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
       RunLoop.main.add(timer! , forMode: .common)
        //RunLoop.main.add(<#T##aPort: Port##Port#>, forMode: <#T##RunLoop.Mode#>)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        soundManager.playSound(.shuffle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //MARK: Timer method
    @objc func timerElapsed(){
        milliseconds -= 1
        
        //convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        //set label
        timerLabel.text = "Time remaining\(seconds)"
        
        // when the timer has reached 0
        if milliseconds <= 0{
            
            
            //stop timer
            timer?.invalidate()
            
            //timerLabel.text = UIColor.red
            
            //check if there are any cards unmatched
            
            
        }
        
    
    }
    
    //MARK: UICollectionView Protocol Method
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //get the card collection view object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        //get the card that collection view is trying to dispaly
        let card = cardArray[indexPath.row]
        
        //set that card for the cell
        cell.setCard(card)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        //check if there is any time left
        if milliseconds<=0{
            return
        }
        
        //get the cell that user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //get the card that user selecterd
        let card = cardArray[indexPath.row]
        
        
        if card.isFlipped == false{
            // flip the card
            cell.flip()
            
            //play flip sound
            soundManager.playSound(.flip)
        
            //set the status of the card
            card.isFlipped = true
            
            //determine whether its first card or the second card that is flipped over
            if firstFlippedCardIndex == nil{
                
                //there is the first card is being flipped
                firstFlippedCardIndex = indexPath
            }
            else{
                //this is the second card that is being flipped
                
                //perform matching logic
                checkForMatches(indexPath)
            }
        }
        
    }//end of did select item at method
    
    //MARK - game logic method
    
    func checkForMatches(_ secondFlippedCardndex:IndexPath){
        
        //get the two cards that were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
       
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardndex) as? CardCollectionViewCell
        
         //get the cards for the two cards that were revealed
        
        let cardOne = cardArray [firstFlippedCardIndex!.row]
        let cardTwo = cardArray [secondFlippedCardndex.row]
        
        //compare the two cards
        if cardOne.imageName == cardTwo.imageName {
        
        //its a match
            
            //play sound
            soundManager.playSound(.match)
        
        
        //set the status of the card
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
        
        //remove the cards from the grid
            cardOneCell!.remove()
            cardTwoCell!.remove()
            
        //check if there are any cards that are unmatched
        checkGameEnded()
            
        }
        else{
            
            //its not a match
            
            //play sound
            soundManager.playSound(.nomatch)
            
            //set the statuses of the card
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            
            //flip both cards back
            //changedbyme
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
     
        //tell the collection view to reload the cell of first card if it is nil
        
        if cardOneCell == nil{
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        //Reset the property that track the first card flipped
        firstFlippedCardIndex = nil
    }
    
    
   func checkGameEnded()
    {
        // determine if there are any cards unmatched
        
        var isWon = true
        
        
        for card in cardArray{
            if card.isMatched == false{
                isWon = false
                break
            }
        }
        //messaging variables
        var title = ""
        var message = ""
        
        //if not then user has won stop timer
        if isWon == true{
            if milliseconds > 0
            {
                timer?.invalidate()
            }
            
            title = "Congratulations"
            message = "You have won"
        }
        else{
        
            //if there are unmatched cards check if there any time left
            if milliseconds > 0{
                return
            }
            title = "Game Over"
            message = "You lost"
        }
        
        
        // show won or lost message
        showAlert(title, message)
    }
    
    func showAlert(_ title: String,_ message: String )
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
             let  alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
             
             alert.addAction(alertaction)
             
             present(alert,animated:true ,completion: nil)
    }
    
}// end of view controller

