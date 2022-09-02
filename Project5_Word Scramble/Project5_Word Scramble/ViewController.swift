//
//  ViewController.swift
//  Project5_Word Scramble
//
//  Created by Mohamed on 21/08/2022.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var allWords = [String]()
    var usedWords = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt"){
            if let startWords = try? String(contentsOfFile: startWordsPath){
                allWords = startWords.components(separatedBy: "\n")
            }
        }else{
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return usedWords.count
      }
      
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
          cell.textLabel?.text = usedWords[indexPath.row]
          return cell
      }

      
      func startGame(){
          title = allWords.randomElement()
          usedWords.removeAll(keepingCapacity: true)
          tableView.reloadData()
      }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        //        let submitAction = UIAlertAction(title: "Submit", style: .default) { action in
        //            guard let answer = ac.textFields?[0].text else { return }
        //            self.submit(answer)
        //        }
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()

        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)

                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
    
    /*
    func isPossible(word:String)->Bool{
          var tempWord = title!.lowercased()
          
          for letter in word{
              if let pos = tempWord.range(of: String(letter)){
                  tempWord.remove(at: pos.lowerBound)
              }else{
                  return false
              }
          }
          return true
      }
      
      
      func isOriginal(word:String)-> Bool{
          return !usedWords.contains(word)
      }
      
      
      func isReal(word:String) -> Bool{
          let checker = UITextChecker()
          let rang = NSMakeRange(0, word.utf16.count)
          let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: rang, startingAt: 0, wrap: false, language: "en")
          return misspelledRange.location == NSNotFound
       }
    
    */
    
    func isPossible(word:String)->Bool{
           var tempWord = title!.lowercased()
           
           for letter in word{
               if let pos = tempWord.range(of: String(letter)){
                   tempWord.remove(at: pos.lowerBound)
               }else{
                   return false
               }
           }
           return true
       }
       
       
       func isOriginal(word:String)-> Bool{
           return !usedWords.contains(word)
       }
       
       
       func isReal(word:String) -> Bool{
           let checker = UITextChecker()
           let rang = NSMakeRange(0, word.utf16.count)
           let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: rang, startingAt: 0, wrap: false, language: "en")
           return misspelledRange.location == NSNotFound
        }
      
    
  
    
    
    
}


