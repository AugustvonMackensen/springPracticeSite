package com.site.meinsite.member.model.service;

import com.site.meinsite.member.model.vo.Member;

public interface MemberService {

	Member selectMember(String userid);
	int selectDupcheckId(String userid);
	int insertMember(Member member);
	int findPwd(Member member);
	Member selectFindId(String email);
	Member pwdSelectId(Member member);
	int updateMember(Member member);
	int deleteMember(String userid);

}
