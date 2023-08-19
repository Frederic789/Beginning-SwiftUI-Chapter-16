//Modified Exercise.swift
import SwiftUI
import Combine

class CharacterStore: ObservableObject {
    @Published var characters: [Character] = []

    init() {
        characters = [
            Character(name: "Warrior", hp: 100, dmg: 20),
            Character(name: "Wizard", hp: 80, dmg: 30),
            Character(name: "Rogue", hp: 60, dmg: 40)
        ]
    }
}

class Character: ObservableObject, Identifiable {
    var id = UUID()
    var name: String
    var hp: Int
    var dmg: Int

    init(name: String, hp: Int, dmg: Int) {
        self.name = name
        self.hp = hp
        self.dmg = dmg
    }
}

struct ExercisesView: View {
  @State var messageOne = ""
    @ObservedObject var characterStore = CharacterStore()

   var body: some View {
        NavigationView {
            ForEach(characterStore.characters.indices, id: \.self) { index in
                NavigationLink(destination: CharacterDetailView(character: $characterStore.characters[index])) {
                    Text(characterStore.characters[index].name)
    
                }
            }
            .navigationTitle("RPG Characters")
        }
    }
}

struct CharacterDetailView: View {
//    @ObservedObject var character: Character
    @Binding var character: Character

    var body: some View {
        Form {
            Section(header: Text("Character Info")) {
                TextField("Name", text: $character.name)
                Stepper("HP: \(character.hp)", value: $character.hp, in: 1...999)
                Stepper("DMG: \(character.dmg)", value: $character.dmg, in: 1...999)
            }
        }
        .navigationTitle(character.name)
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView()
    }
}

