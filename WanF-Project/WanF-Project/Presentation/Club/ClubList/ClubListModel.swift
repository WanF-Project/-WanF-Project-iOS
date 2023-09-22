//
//  ClubListModel.swift
//  WanF-Project
//
//  Created by 임윤휘 on 2023/08/17.
//

import Foundation

import RxSwift
import RxCocoa

struct ClubListModel {
    let network = ClubNetwork()
    
    /// 모든 모임 조회
    func getAllClubs() -> Single<Result<[ClubResponseEntity], WanfError>> {
        return network.getAllClubs()
    }
    
    /// 모든 모임 조회 - 성공
    func getAllClubsValue(_ result: Result<[ClubResponseEntity], WanfError>) -> [ClubResponseEntity]? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    /// 모든 모임 조회 - 실패
    func getAllClubsError(_ result: Result<[ClubResponseEntity], WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        return Void()
    }
    
    /// 모임 비밀번호 조회
    func getClubPassword(_ clubID: Int) -> Single<Result<ClubPwdRequestEntity, WanfError>> {
        return network.getClubPassword(clubID)
    }
    
    /// 모임 비밀번호 조회 - 성공
    func getClubPasswordValue(_ result: Result<ClubPwdRequestEntity, WanfError>) -> ClubPwdRequestEntity? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    /// 모임 비밀번호 조회 - 실패
    func getClubPasswordError(_ result: Result<ClubPwdRequestEntity, WanfError>) -> Void? {
        guard case .failure(let error) = result else {
            return nil
        }
        return Void()
    }
    
    // 모임 생성
    func createClub(_ club: ClubRequestEntity) -> Single<Result<Void, WanfError>> {
        return network.postCreateClub(club)
    }
    
    func createClubValue(_ result: Result<Void, WanfError>) -> Void? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func createClubError(_ result: Result<Void, WanfError>) -> WanfError? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error
    }
}
