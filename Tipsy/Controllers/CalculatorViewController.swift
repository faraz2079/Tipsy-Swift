import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var selectedButton: UIButton?
//    var senderText: String?
    var percentage = 0.0
    var stepperValue = 0.0
    var finalNumber = 0.0
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true) //dismisses the keyboard

        selectedButton?.isSelected = false
        sender.isSelected = true
        selectedButton = sender
        
        let senderText = sender.currentTitle!
        let senderNum = senderText.dropLast() // remove the percentage sign of off the String
        let senderDouble = Double(senderNum)
        percentage = senderDouble! / 100
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        var sender = sender.value
        stepperValue = (sender - 1) + 1
        splitNumberLabel.text = String(format: "%.0f", stepperValue)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
                
        let billTextFieldToDouble = Double(billTextField.text!)
        finalNumber = (billTextFieldToDouble!
        + (billTextFieldToDouble! * percentage)) / stepperValue
        print(String(format: "%.2f", finalNumber))

        performSegue(withIdentifier: "CalculateToResult", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "CalculateToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.people = stepperValue
            destinationVC.percentage = percentage
            destinationVC.totalNum = finalNumber
        }
    }

}

