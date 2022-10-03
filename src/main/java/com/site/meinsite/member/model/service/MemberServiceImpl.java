package com.site.meinsite.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.site.meinsite.member.model.dao.MemberDao;
import com.site.meinsite.member.model.vo.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public Member selectMember(String userid) {
		return memberDao.selectMember(userid);
	}

	@Override
	public int selectDupcheckId(String userid) {
		return memberDao.selectDupCheckId(userid);
	}

	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public int findPwd(Member member) {
		return memberDao.findPwd(member);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	public int deleteMember(String userid) {
		return memberDao.deleteMember(userid);
	}

	@Override
	public Member selectByid(String userid) {
		// TODO Auto-generated method stub
		return memberDao.selectByid(userid);
	}

	@Override
	public Member selectByMail(String email) {
		// TODO Auto-generated method stub
		return memberDao.selectByMail(email);
	}

	@Override
	public int selectMailCheck(String email) {
		return memberDao.selectMailCheck(email);
	}

	@Override
	public int chkSelectForPwd(Member loginMember) {
		return memberDao.chkSelectForPwd(loginMember);
	}
}
