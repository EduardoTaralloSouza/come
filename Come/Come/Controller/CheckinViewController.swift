//
//  CheckinViewController.swift
//  Come
//
//  Created by Eduardo Souza on 14/09/20.
//  Copyright © 2020 Eduardo Tarallo Souza. All rights reserved.
//

import UIKit

class CheckinViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var msg: UILabel!


    var checkin = CheckIn()
    var eventId = ""
    var msgText = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.isHidden = true
        msg.isHidden = true
        name.becomeFirstResponder()
        name.delegate = self
        email.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func goBack() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
     }

    func loading() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func addUserEvent() {
        guard let name = name.text else { return }
        guard let email = email.text else { return }
        checkin.eventId = eventId
        checkin.name = name
        checkin.email = email
    }

    func showMsg(hidden: Bool, message: String) {
        msg.isHidden = hidden
        msg.text = message
    }


    @IBAction func closeView(_ sender: UIButton) {
        goBack()
    }


    @IBAction func checkinPressed(_ sender: UIButton) {
        if !(name.text!.isEmpty) && !(email.text!.isEmpty) {
            if Util().isValidEmail(email.text!) {
                self.addUserEvent()
                self.loading()
                if !(checkin.eventId.isEmpty) && !(checkin.name.isEmpty) && !(checkin.email.isEmpty) {
                    WebService().checkIn(checkin: checkin, completion: { (sucess) in
                        let alert = UIAlertController(title: "Uhuuu 🕺🏻", message: "Feito! Cadastro efetuado com sucesso 😜", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in self.goBack() })
                        alert.addAction(defaultAction)
                        DispatchQueue.main.async(execute: {
                            self.present(alert, animated: true)
                        })
                    }) { (statusCodeError) in
                        DispatchQueue.main.async {
                            Util().showAlertMessage(on: self, title: "Atenção", message: "Tivemos problemas ao tentar acessar o servidor, por favor tente mais tarde")
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                        }
                    }
                } else {
                    Util().showAlertMessage(on: self, title: "Atenção", message: "Tivemos um problema ao tentar fazer checkin, tente novamente!")
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            } else {
                showMsg(hidden: false, message: "E-mail Inválido!")
            }

        } else {
            showMsg(hidden: false, message: "Preencha todos os campos 😉")
        }
    }

}

extension CheckinViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 100 {
            showMsg(hidden: true, message: "")
            email.becomeFirstResponder()
        } else if textField.tag == 200 {
            showMsg(hidden: true, message: "")
            email.resignFirstResponder()
        }
        return true
    }
}
