//
//  MenuController.swift
//  Restaurant
//
//  Created by Álvaro Ávalos Hernández on 07/09/18.
//  Copyright © 2018 Álvaro Ávalos Hernández. All rights reserved.
//

import Foundation
import UIKit

class MenuController {
    
    static let shared = MenuController()
    
    //definiciòn de una constante la ser la misma direcciòn
    let baseURL = URL(string: "http://localhost:8090/")!
    
    //request a categorìa
    func fetchCategories(completion: @escaping ([String]?) -> Void){
        //busca la categorìa
        let categoryURL = baseURL.appendingPathComponent("categories")
        //La clase URLSession y las clases relacionadas proporcionan una API para descargar contenido.
        //El punto final de /categories tendrá que decodificarse en un objeto Categorías, y para eso tendrá que crear un codificador JSON
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data,
                let jsonDictionary = try?
                    JSONSerialization.jsonObject(with: data) as?
                        [String:Any],
                let categories = jsonDictionary?["categories"] as?
                    [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    //request a menu y recepciòn de los items
    func fetchMenuItems(categoryName: String, completion: @escaping
        ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        //Una estructura que analiza URL y construye URL a partir de sus partes constituyentes.
        var components = URLComponents(url: initialMenuURL,resolvingAgainstBaseURL: true)!
        //Un único par nombre-valor de la parte de consulta de una URL.
        //Una matriz de elementos de consulta para la URL en el orden en que aparecen en la cadena de consulta original.
        components.queryItems = [URLQueryItem(name: "category",value: categoryName)]
        let menuURL = components.url!
        //Los datos recuperados desde /menu se convertirán en una matriz de objetos MenuItem. Primero deberá crear un codificador JSON para decodificar los datos JSON devueltos por la API.
        let task = URLSession.shared.dataTask(with: menuURL){ (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self,from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    //post para mandar el pedido y recibir el tiempo de su elaboraciòn
    func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
        //hace el pedido
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        //cambio de request de get a post
        request.httpMethod = "POST"
        //indicando que se enviara un json
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        //un diccionario de tipo [String: Any], un tipo que se puede convertir a JSON mediante una instancia de JSONEncoder.
        /*
        let data: [String: Any] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)*/
        // Store the array of menu IDs in JSON under the key "menuIds"
        let data: [String: Any] = ["menuIds": menuIds]
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])
        //A diferencia de un GET, que agrega parámetros de consulta a la URL, los datos para una POST deben almacenarse dentro del cuerpo de la solicitud
        request.httpBody = jsonData
        //el POST devolverá datos JSON que pueden decodificarse en su modelo intermediario PreparationTime
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try?
                    jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }

}
