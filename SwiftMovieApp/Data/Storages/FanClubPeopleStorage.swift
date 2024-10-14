//
//  FanClubPeopleStorage.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/8.
//

import Foundation
import SQLite

protocol FanClubPeopleStorage {
    func createTable()
    func save(_ people: People)
    func remove(_ people: People)
    func queryAllPeoples() -> [People]
    func deleteAllPeoples()
}

class DefaultFanClubPeopleStorage: FanClubPeopleStorage {
    var db: Connection?
    // 定义表
    let peopleTable = Table("people")

    // 定义字段
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let character = Expression<String?>("character")
    let department = Expression<String?>("department")
    let profilePath = Expression<String?>("profile_path")

    let knownForDepartment = Expression<String?>("known_for_department")
    let alsoKnownAs = Expression<String?>("also_known_as") // 需要将[Strings]转为文本存储

    let birthDay = Expression<String?>("birthDay")
    let deathDay = Expression<String?>("deathDay")
    let placeOfBirth = Expression<String?>("place_of_birth")

    let biography = Expression<String?>("biography")
    let popularity = Expression<Double?>("popularity")

    // 定义KnownFor和ImageData的字段，如果需要单独存储这些数组可以另建表
    let knownFor = Expression<String?>("known_for") // 需要将[KnownFor]转为文本存储
    let images = Expression<String?>("images") // 需要将[ImageData]转为文本存储
    
    init() {
        var documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        documentUrl.append(component: "people.sqlite3")
        db = try? Connection(documentUrl.path())
    }
    
    func createTable() {
        do {
            try db?.run(peopleTable.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(character)
                t.column(department)
                t.column(profilePath)
                t.column(knownForDepartment)
                t.column(alsoKnownAs)
                t.column(birthDay)
                t.column(deathDay)
                t.column(placeOfBirth)
                t.column(biography)
                t.column(popularity)
                t.column(knownFor)
                t.column(images)
            })
        } catch (let error) {
            print("\(String(describing: self)) call \(#function) with error:\(error.localizedDescription)")
        }
    }
    
    func save(_ people: People) {
        remove(people)
        do {
            let insert = peopleTable.insert(
                id <- people.id,
                name <- people.name,
                character <- people.character,
                department <- people.department,
                profilePath <- people.profile_path,
                knownForDepartment <- people.known_for_department,
                alsoKnownAs <- try? toJSONString(people.also_known_as),
                birthDay <- people.birthDay,
                deathDay <- people.deathDay,
                placeOfBirth <- people.place_of_birth,
                biography <- people.biography,
                popularity <- people.popularity,
                knownFor <- try? toJSONString(people.known_for),
                images <- try? toJSONString(people.images)
            )
            try db?.run(insert)
        } catch (let error) {
            print("\(String(describing: self)) call \(#function) with error:\(error.localizedDescription)")
        }
    }
    
    func remove(_ people: People) {
        do {
            let personToDelete = peopleTable.filter(id == people.id)
            try db?.run(personToDelete.delete())
        } catch (let error) {
            print("\(String(describing: self)) call \(#function) with error:\(error.localizedDescription)")
        }
    }
    
    func queryAllPeoples() -> [People] {
        do {
            var peopleList = [People]()
            var rows: [Row] = []
            if let data = try db?.prepare(peopleTable) {
                rows = Array(data)
            }
            for row in rows {
                let person = People(
                    id: row[id],
                    name: row[name],
                    character: row[character],
                    department: row[department],
                    profile_path: row[profilePath],
                    known_for_department: row[knownForDepartment],
                    known_for: try? fromJSONString([People.KnownFor].self, row[knownFor]),
                    also_known_as: try? fromJSONString([String].self, row[alsoKnownAs]),
                    birthDay: row[birthDay],
                    deathDay: row[deathDay],
                    place_of_birth: row[placeOfBirth],
                    biography: row[biography],
                    popularity: row[popularity],
                    images: try? fromJSONString([ImageData].self, row[images])
                )
                peopleList.append(person)
            }
            return peopleList
        } catch (let error) {
            print("\(String(describing: self)) call \(#function) with error:\(error.localizedDescription)")
            return []
        }
    }
    
    func deleteAllPeoples() {
        do {
            try db?.run(peopleTable.delete())
        } catch (let error) {
            print("\(String(describing: self)) call \(#function) with error:\(error.localizedDescription)")
        }
    }
    
    // 将对象转换为JSON字符串
    func toJSONString<T: Encodable>(_ value: T?) throws -> String? {
        guard let value = value else { return nil }
        let jsonData = try JSONEncoder().encode(value)
        return String(data: jsonData, encoding: .utf8)
    }
    
    // 将JSON字符串转换为对象
    func fromJSONString<T: Decodable>(_ type: T.Type, _ jsonString: String?) throws -> T? {
        guard let jsonString = jsonString else { return nil }
        let jsonData = jsonString.data(using: .utf8)!
        return try JSONDecoder().decode(type, from: jsonData)
    }
}
