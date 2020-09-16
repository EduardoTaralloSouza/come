//
//  EventsDetailViewController.swift
//  Come
//
//  Created by Eduardo Souza on 14/09/20.
//  Copyright © 2020 Eduardo Tarallo Souza. All rights reserved.
//

import UIKit
import Kingfisher
import MapKit

class EventDetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var titleEvent: UILabel!
    @IBOutlet weak var descriptionEvent: UITextView!
    @IBOutlet weak var priceEvent: UILabel!
    @IBOutlet weak var eventId: UILabel!
    @IBOutlet weak var dateEvent: UILabel!
    @IBOutlet weak var addressEvent: UILabel!
    @IBOutlet weak var map: MKMapView!


    var event: Event?
    var gerenciadorLocais = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        map.delegate = self

        guard let latitude = Double(event!.latitude) else { return }
        guard let longitude = Double(event!.longitude) else { return }

        imageEvent.kf.indicatorType = .activity
        imageEvent.kf.setImage(with: URL(string: event!.image), placeholder: UIImage(named: "placeholderimage"))
        titleEvent.text = event?.title
        descriptionEvent.text = event?.description
        priceEvent.text = ("R$ \(String(event!.price))")
        eventId.text = event?.id
        dateEvent.text = event?.date

        showEventLocation(latitude: latitude, longitude: longitude)
        getEventAddress(latitude: latitude, longitude: longitude)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let checkinVC = segue.destination as? CheckinViewController {
            checkinVC.eventId = event!.id
        }
    }


    func showEventLocation(latitude: Double, longitude: Double) {
        let eventCoordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let zoom = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        let region = MKCoordinateRegion(center: eventCoordinates, span: zoom)

        map.setRegion(region, animated: true)
        map.setCenter(eventCoordinates, animated: true)

        let eventPin = MKPointAnnotation()
        eventPin.title = event?.title
        eventPin.coordinate = eventCoordinates
        map.addAnnotation(eventPin)
    }


    func getEventAddress(latitude: Double, longitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = latitude
        center.longitude = longitude
        let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)

        ceo.reverseGeocodeLocation(loc, completionHandler: {(placemarks, error) in
            guard let placemarks = placemarks, error == nil else { return }
            let address = placemarks as [CLPlacemark]
            if address.count > 0 {
                let address = placemarks[0]
                guard let street = address.thoroughfare else { return }
                guard let number = address.subThoroughfare else { return }
                guard let neighborhood = address.subLocality else { return }
                guard let city = address.locality else { return }
                guard let postalCode = address.postalCode else { return }
                self.addressEvent.text = "\(street), \(number)\n\(neighborhood) / \(city)\n\(postalCode)"
            }
        })
    }


    @IBAction func share(_ sender: UIBarButtonItem) {
        let description = event?.description
        let urlImage = URL(string: event!.image)
        let items = [description as Any, urlImage as Any] as [Any]
        let share = UIActivityViewController (activityItems: items as [Any], applicationActivities: nil)
        present (share, animated: true)
    }

}
