//
//  DataGetter.swift
//  HomeworkDataFetcher
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation
import HomeworkDataModels

public enum NetworkError: Error {
    case invalidURL
    case serverError
}

public class NetworkFetcher {
    let baseURLString = "https://pokeapi.co/api/v2/"
    
    public init() {}
    
    public func fetchPokemonList(limit: Int, offset: Int) async throws -> ListedResponseDTO {
        let url = self.url(for: .allPokemons(limit: limit, offset: offset))
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        let listedResponse: ListedResponseDTO = try await fetchData(from: url)
        
        return listedResponse
    }
    
    public func fetchPokemon(id: Int) async throws -> PokemonDTO {
        let url = self.url(for: .pokemon(id: id))
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        var pokemon: PokemonDTO = try await fetchData(from: url)
        
        let frontDefault = await downloadImage(from: pokemon.sprites.frontDefault)
        let frontShiny = await downloadImage(from: pokemon.sprites.frontShiny)
        let frontDefaultFemale = await downloadImage(from: pokemon.sprites.frontDefaultFemale)
        let frontShinyFemale = await downloadImage(from: pokemon.sprites.frontShinyFemale)
        pokemon.setSpriteImages(frontDefault: frontDefault,
                                      frontDefaultFemale: frontDefaultFemale,
                                      frontShiny: frontShiny,
                                      frontShinyFemale: frontShinyFemale)
        
        return pokemon
    }
    
    private func downloadImage(from urlString: String?) async -> Data? {
        guard let urlString, let url = URL(string: urlString) else { return nil }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpURLResponse = response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200 else {
                return nil
            }
            return data
        } catch {
            return nil
        }
    }
}

extension NetworkFetcher {
    fileprivate func fetchData<T: Decodable>(from url: URL) async throws -> T {
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.serverError
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}

//MARK: URL assembly
extension NetworkFetcher {
    fileprivate enum RequestType {
        case allPokemons(limit: Int, offset: Int)
        case pokemon(id: Int)
        case url(String)
        
        var path: String {
            switch self {
            case .allPokemons(let limit, let offset):
                return "pokemon?offset=\(offset)&limit=\(limit)"
            case .pokemon(id: let id):
                return "pokemon/\(id)"
            case .url(let url):
                return url
            }
        }
    }
    
    fileprivate func url(for type: RequestType) -> String {
        switch type {
        case .url:
            //Contains whole url
            return type.path
        default:
            return baseURLString + type.path
        }
    }
}
