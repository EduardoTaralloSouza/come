//
//  EventsTableViewController.swift
//  Come
//
//  Created by Eduardo Souza on 14/09/20.
//  Copyright © 2020 Eduardo Tarallo Souza. All rights reserved.
//

import UIKit
import Kingfisher

class EventsTableViewController: UITableViewController {

    var events: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        WebService().getEvents(completion: { (events) in
            guard let events = events else { return }
            self.events = events
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (statusCode) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                Util().showAlertMessage(on: self, title: "Atenção", message: "ERRO \(statusCode)\nTivemos problemas ao tentar acessar o servidor, por favor tente mais tarde.")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        eventCell.title.text = event.title
        eventCell.date.text = "Dia \(event.date)"
        eventCell.backgroundImage.kf.indicatorType = .activity
        eventCell.backgroundImage.kf.setImage(with: URL(string: event.image), placeholder: UIImage(named: "placeholderimage"))
        return eventCell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showEventDetail", sender: self)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let eventDetailVC = segue.destination as? EventDetailViewController {
            eventDetailVC.event = events[(tableView.indexPathForSelectedRow?.row)!]
        }
    }


}
