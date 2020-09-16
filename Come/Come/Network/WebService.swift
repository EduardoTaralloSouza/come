//
//  Webservice.swift
//  Come
//
//  Created by Eduardo Souza on 14/09/20.
//  Copyright © 2020 Eduardo Tarallo Souza. All rights reserved.
//

import Foundation

class WebService {

    func getEvents(completion: @escaping([Event]?) -> (), onError: @escaping (Int) -> Void) {
        guard let url = URL(string: "http://5f5a8f24d44d640016169133.mockapi.io/api/events") else { fatalError("URL inválida") }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 || response.statusCode == 201 {
                    guard let data = data else { return }
                    do {
                        let events = try JSONDecoder().decode([Event].self, from: data)
                        DispatchQueue.main.async {
                            completion(events)
                        }
                    } catch {
                        print("JSON inválido!")
                    }
                } else {
                    print("Erro \(response.statusCode) na resposta do servidor")
                    onError(response.statusCode)
                }
            } else {
                print("Erro na aplicação: \(String(describing: error?.localizedDescription))")
            }
        }.resume()
    }


    func checkIn(checkin: CheckIn, completion: @escaping (Bool) -> Void, onError: @escaping (Int) -> Void) {
        guard let url = URL(string: "http://5f5a8f24d44d640016169133.mockapi.io/api/checkin") else { fatalError("URL inválida") }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        guard let json = try? JSONEncoder().encode(checkin) else { return }
        request.httpBody = json
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 || response.statusCode == 201 {
                    guard let data = data else { return }
                    print(data)
                    completion(true)
                } else {
                    print("Erro \(response.statusCode) na resposta do servidor")
                    onError(response.statusCode)
                }
            } else {
                print("Erro na aplicação: \(String(describing: error?.localizedDescription))")
            }
        }.resume()
    }

}
