//
//  HomeViewModel.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/08/26.
//

import Foundation

final class HomeViewModel: ObservableObject {

    @Published var meetPeopleEntityList: [MeetPeopleEntity] = []
    @Published var isLoadingMore = false
    @Published var isLoading = false

    init() {
        generateRandomMeetPeopleEntities()
    }

    private func generateRandomMeetPeopleEntity() -> MeetPeopleEntity {
        let randomImage = "user_image_\(Int.random(in: 1...10))"
        let randomRegion = ["Tokyo", "New York", "London", "Paris", "Sydney"].randomElement() ?? ""
        let randomName = ["Alice", "Bob", "Charlie", "David", "Ella"].randomElement() ?? ""
        let randomAge = Int.random(in: 18...60)
        let randomVoiceCallStatus = Bool.random()
        let randomSelfIntroduction = "Hello, I'm \(randomName) from \(randomRegion). I'm \(randomAge) years old."

        return MeetPeopleEntity(image: randomImage,
                                region: randomRegion,
                                name: randomName,
                                age: randomAge,
                                isVoiceCallStatas: randomVoiceCallStatus,
                                selfIntroduction: randomSelfIntroduction)
    }

    func pulledToRefresh() {
        isLoading = false
        meetPeopleEntityList = []
        generateRandomMeetPeopleEntities()
    }

    func loadMoreData() {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        generateRandomMeetPeopleEntities()
    }
}

// MARK: - Private

private extension HomeViewModel {

    func generateRandomMeetPeopleEntities() {
            var entities: [MeetPeopleEntity] = []
            for _ in 0..<Int.random(in: 1...50) {
                let randomMeetPerson = generateRandomMeetPeopleEntity()
                entities.append(randomMeetPerson)
            }
            meetPeopleEntityList += entities
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            isLoading = true
        }
    }
}
