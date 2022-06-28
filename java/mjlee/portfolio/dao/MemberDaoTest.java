package mjlee.portfolio.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import mjlee.portfolio.controller.DBmanager;

public class MemberDaoTest {
	private Connection c;
	private PreparedStatement ps;
	private ResultSet r= null;
	private int res;
	private boolean login;
	private boolean join;
	private boolean edit;
	
	public MemberDaoTest() {
		c= new DBmanager().getConnection();
	}
	
	public boolean login(String id, String pw) {
		String loginSql= "select * from members where id= ? and pw= ?";
		try {
			ps= c.prepareStatement(loginSql);
			ps.setString(1, id);
			ps.setString(2, pw);
			r= ps.executeQuery();
			if(r!=null) {
				login=true;
			}else {
				login=false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return login;
	}
	
	public boolean join(String name, String id, String pw, String ip) {
		String joinSql="insert into members (name, id, pw, ip) values (? , ?, ? ,? )";
		try {
			ps= c.prepareStatement(joinSql);
			ps.setString(1, name);
			ps.setString(2, id);
			ps.setString(3, pw);
			ps.setString(4, ip);
			res= ps.executeUpdate();
			if(res>0) {
				join= true;
			}else {
				join= false;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return join;
	}
	
	public MemberDto selectOneByIp(String id, String ip) {
		String oneSql="select * from members where id= ? and ip = ?";
		MemberDto resDto= new MemberDto();
		try {
			ps= c.prepareStatement(oneSql);
			ps.setString(1, id);
			ps.setString(2, ip);
			r= ps.executeQuery();
			if(r!=null) {
				r.next();
				resDto.setNo(r.getInt("no"));
				resDto.setName(r.getString("name"));
				resDto.setId(r.getString("id"));
				resDto.setPw(r.getString("pw"));
				resDto.setJoindate(r.getString("joindate"));
				resDto.setIp(r.getString("ip"));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return resDto;
	}
	
	public MemberDto selectOneByPw(String id, String pw) {
		String oneSql="select * from members where id= ? and pw = ?";
		MemberDto resDto= new MemberDto();
		try {
			ps= c.prepareStatement(oneSql);
			ps.setString(1, id);
			ps.setString(2, pw);
			r= ps.executeQuery();
			if(r!=null) {
				r.next();
				resDto.setNo(r.getInt("no"));
				resDto.setName(r.getString("name"));
				resDto.setId(r.getString("id"));
				resDto.setPw(r.getString("pw"));
				resDto.setJoindate(r.getString("joindate"));
				resDto.setIp(r.getString("ip"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resDto;
	}
	
	public boolean editMember(String name, String id, String pw, String ip) {
		String editSql="update members set name= ?, pw= ? where id= ? and ip= ?";
		try {
			ps= c.prepareStatement(editSql);
			ps.setString(1, name);
			ps.setString(2, pw);
			ps.setString(3, id);
			ps.setString(4, ip);
			res= ps.executeUpdate();
			if(res>0) {
				edit= true;
			}else {
				edit= false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return edit;
	}
}
