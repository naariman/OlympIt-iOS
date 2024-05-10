//
//  OlympRepository.swift
//  OlympIt
//
//  Created by Nariman on 07.05.2024.
//

import FirebaseFirestore

enum InitialLessonType: String, CaseIterable {
    case exam
    case olymp
    
    var collectionName: String {
        switch self {
        case .exam:
            return "Exams"
        case .olymp:
            return "Olymps"
        }
    }
    
    var dashboardTitle: String {
        switch self {
        case .exam:
            return "ЕГЭ"
        case .olymp:
            return "Олимпиада"
        }
    }
}

typealias InitialLessonOutputList = [InitialLessonOutput]

struct InitialLessonOutput {
    let id: String
    let name: String
    let iconUrl: URL
}

protocol ILessonsRepository {
    func fetchInitialLessons(by type: InitialLessonType, completion: @escaping (Result<InitialLessonOutputList, Error>) -> Void)
    func fetchLessonsList(initialLessonType: InitialLessonType, type: LessonType, id: String, completion: @escaping (Result<LessonsListOutput, Error>) -> Void)
}

final class LessonsRepositoryImpl {
    let db = Firestore.firestore()
}

extension LessonsRepositoryImpl: ILessonsRepository {
    func fetchInitialLessons(by type: InitialLessonType, completion: @escaping (Result<InitialLessonOutputList, Error>) -> Void) {
        
        db.collection(type.collectionName).getDocuments { querySnapshot, error in
            if let error {
                completion(.failure(error))
            }
            
            if let querySnapshot {
                var response: [InitialLessonOutput] = []
                
                for document in querySnapshot.documents {
                    let data = document.data()
                    
                    let id = document.documentID
                    let name = data["name"] as? String ?? "Error"
                    let icon = data["iconUrl"] as! String
                    let iconUrl = URL(string: icon)!
                    
                    let model = InitialLessonOutput(id: id, name: name, iconUrl: iconUrl)
                    response.append(model)
                }
                
                completion(.success(response))
            }
        }
    }
    
    func fetchLessonsList(initialLessonType: InitialLessonType, type: LessonType, id: String, completion: @escaping (Result<LessonsListOutput, Error>) -> Void) {
        print("/\(initialLessonType.collectionName)/\(id)/\(type.collectionName)")
        db.collection("/\(initialLessonType.collectionName)/\(id)/\(type.collectionName)").getDocuments { querySnapshot, error in
            if let error {
                completion(.failure(error))
            }
            
            if let querySnapshot {
                var response: LessonsListOutput = []
                
                for document in querySnapshot.documents {
                    let data = document.data()
                    
                    let id = document.documentID
                    let name = data["name"] as? String ?? "Error"
                    let hardness = data["hardness"] as? Hardness ?? .low
                    let description = data["description"] as? String ?? "Error"
                    let pdfString = data["pdf"] as? String ?? "Error"
                    let pdfUrl = URL(string: pdfString)!
                    
                    let model = LessonOutput(documentId: id, hardness: hardness, name: name, description: description, pdf: pdfUrl)
                    response.append(model)
                }
                
                completion(.success(response))
            }
        }
    }
}