
import Foundation
import Alamofire

struct Data: Decodable {
    var id: Int? = nil
    var title: String? = nil
    var image: String? = nil
    var description: String? = nil
}

struct QuotesResponse: Decodable {
    var success: Bool? = nil
    var data: [Data]? = nil
}

struct SignInRequest: Encodable {
    var email: String
    var password: String
}

struct SignInResponse: Decodable {
    var id: String? = nil
    var email: String? = nil
    var nickname: String? = nil
    var avatar: String? = nil
    var token: String? = nil
}

class ApiClient {
    
    let baseURL = "http://mskko2021.mad.hakta.pro/api/"
    
    func signIn(parameters: SignInRequest, success: @escaping (SignInResponse) -> Void){
        
        let headers = HTTPHeaders(["Content-Type" : "application/json"])
        
        AF.request(baseURL + "user/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
            switch response.result{
            case .success(let data):
                let answer = (try! JSONDecoder().decode(SignInResponse.self, from: data!))
                success(answer)
            case .failure(let error):
                print(error.errorDescription ?? "Something went wrong")
            }
        }
    }
    
    func getQuotes(success: @escaping (QuotesResponse) -> Void){
 

        AF.request(baseURL + "/quotes", method: .get, encoding: URLEncoding(destination: .queryString)).response {response in
            
            switch response.result{
            case .success(let data):
                if let safeData = data{
                    success(try! JSONDecoder().decode(QuotesResponse.self, from: safeData))
                }
                else {
                    print("Unhandled error!")
                }

            case .failure(let data):
                print("Request fail!" + data.localizedDescription)
            }
            
        }
            
            
            
            
            
            
            
        }
    
    
}
