package mjlee.portfolio.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mjlee.portfolio.controller.DBmanager;

/*
 * mysql> desc members;
+-------------+-------------+------+-----+-------------------+----------------+
| Field       | Type        | Null | Key | Default           | Extra          |
+-------------+-------------+------+-----+-------------------+----------------+
| memberNo    | int(11)     | NO   | PRI | NULL              | auto_increment |
| memberName  | varchar(10) | NO   |     | NULL              |                |
| memberId    | varchar(20) | NO   |     | NULL              |                |
| memberPw    | varchar(20) | NO   |     | NULL              |                |
| memberEmail | varchar(30) | NO   |     | NULL              |                |
| memberPost  | int(11)     | YES  |     | NULL              |                |
| memberAdd   | text        | YES  |     | NULL              |                |
| memberMob   | varchar(11) | YES  |     | NULL              |                |
| memberDate  | timestamp   | NO   |     | CURRENT_TIMESTAMP |                |
| memberIp    | varchar(30) | NO   |     | NULL              |                |
+-------------+-------------+------+-----+-------------------+----------------+
10 rows in set (0.00 sec)
 * 
 */

public class MemberDao {
	private Connection c;
	private PreparedStatement ps;
	private ResultSet r;
	public int res;
	public ArrayList<MemberDto> resList;
	public MemberDto resDto;
	
	public MemberDao() {
		super();
		c= new DBmanager().getConnection();
		resList= new ArrayList<>();
	}
	
	public int joinWithAllParams(String name, String id, String pw, String email, String postno, String address, String phone, String ip) {
		try {
			ps= c.prepareStatement("insert into members (memberName, memberId, memberPw, memberEmail, memberPost, memberAdd, memberMob, memberIp) values (?,?,?,?,?,?,?,?)");
			ps.setString(1, name);
			ps.setString(2, id);
			ps.setString(3, pw);
			ps.setString(4, email);
			ps.setString(5, postno);
			ps.setString(6, address);
			ps.setString(7, phone);
			ps.setString(8, ip);
			res= ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			}catch(Exception e) { e.printStackTrace(); }
		}
		return res;
	}
	
	public int joinExceptAdd(String name, String id, String pw, String email, String phone, String ip) {
		try {
			ps= c.prepareStatement("insert into members (memberName, memberId, memberPw, memberEmail, memberMob, memberIp) values (?,?,?,?,?,?)");
			ps.setString(1, name);
			ps.setString(2, id);
			ps.setString(3, pw);
			ps.setString(4, email);
			ps.setString(5, phone);
			ps.setString(6, ip);
			res= ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			}catch(Exception e) { e.printStackTrace(); }
		}
		return res;
	}
	
	public int joinExceptPhone(String name, String id, String pw, String email, String postno, String address, String ip) {
		try {
			ps= c.prepareStatement("insert into members (memberName, memberId, memberPw, memberEmail, memberPost, memberAdd, memberIp) values (?,?,?,?,?,?,?)");
			ps.setString(1, name);
			ps.setString(2, id);
			ps.setString(3, pw);
			ps.setString(4, email);
			ps.setString(5, postno);
			ps.setString(6, address);
			ps.setString(7, ip);
			res= ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			}catch(Exception e) { e.printStackTrace(); }
		}
		return res;
	}
	
	public int joinOnlyNecessary(String name, String id, String pw, String email, String ip) {
		try {
			ps= c.prepareStatement("insert into members (memberName, memberId, memberPw, memberEmail, memberIp) values (?,?,?,?,?)");
			ps.setString(1, name);
			ps.setString(2, id);
			ps.setString(3, pw);
			ps.setString(4, email);
			ps.setString(5, ip);
			res= ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			}catch(Exception e) { e.printStackTrace(); }
		}
		return res;
	}
	
	public boolean checkDupId(String id) {
		r= null;
		try {
			ps= c.prepareStatement("select * from members where memberId= ?");
			ps.setString(1, id);
			r= ps.executeQuery();
			if(r.next()) {
				System.out.println("중복 아이디 있음");
				return false;
			}else {
				System.out.println("중복 아이디 없음");
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return false;
	}
	
	public boolean checkDupEmail(String email) {
		r= null;
		try {
			ps= c.prepareStatement("select * from members where memberEmail= ?");
			ps.setString(1, email);
			r= ps.executeQuery(); 
			if(r.next()) {
				System.out.println("중복 이메일 있음");
				return false;
			}else {
				System.out.println("중복 이메일 없음");
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return false;
	}
	
	public boolean login(String id, String pw) {
		try {
			ps= c.prepareStatement("select * from members where memberId=? and memberPw=?");
			ps.setString(1, id);
			ps.setString(2, pw);
			r= ps.executeQuery();
			if(r.next()) {
				System.out.println("로그인 - 계정 정보 있음");
				return true;
			}else {
				System.out.println("로그인 - 계정 정보 없음");
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return false;
	}
	
	public MemberDto tempAccount(String id) {
		try {
			ps= c.prepareStatement("select * from members where memberId= ?");
			ps.setString(1, id);
			r= ps.executeQuery();
			while(r.next()) {
				resDto= new MemberDto();
				resDto.setNo(r.getInt("memberNo"));
				resDto.setId(r.getString("memberId"));
				resDto.setName(r.getString("memberName"));
				resDto.setPw(r.getString("memberPw"));
				resDto.setEmail(r.getString("memberEmail"));
				if(r.getString("memberMob")!=null) {
					resDto.setMobileNo(r.getString("memberMob"));
				}else {
					resDto.setMobileNo("-");
				}
				if(r.getString("memberAdd")!=null) {
					resDto.setAddress(r.getString("memberAdd"));
					resDto.setPostNo(r.getString("memberPost"));
				}else {
					resDto.setAddress("-");
					resDto.setPostNo("-");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return resDto;
	}
	
	public boolean terminate(String id) {
		try {
			ps= c.prepareStatement("delete from members where memberId= ?");
			ps.setString(1, id);
			res= ps.executeUpdate();
			if(res>0) {
				System.out.println("계정삭제됨");
				return true;
			}else {
				System.out.println("계정삭제되지 않음");
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return false;
	}
	
	public boolean updateWithAllParams(String name, String id, String pw, String email, String postNo, String address, String phone) {
		try {
			ps= c.prepareStatement("update members set memberPw= ?, memberEmail= ?, memberPost= ?, memberAdd= ?, memberMob= ? where (memberName= ? and memberId= ?)");
			ps.setString(1, pw);
			ps.setString(2, email);
			ps.setString(3, postNo);
			ps.setString(4, address);
			ps.setString(5, phone);
			ps.setString(6, name);
			ps.setString(7, id);
			res= ps.executeUpdate();
			if(res>0) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean updateExceptPhone(String name, String id, String pw, String email, String postNo, String address) {
		try {
			ps= c.prepareStatement("update members set memberPw= ?, memberEmail= ?, memberPost= ?, memberAdd= ? where (memberName= ? and memberId= ?)");
			ps.setString(1, pw);
			ps.setString(2, email);
			ps.setString(3, postNo);
			ps.setString(4, address);
			ps.setString(5, name);
			ps.setString(6, id);
			res= ps.executeUpdate();
			if(res>0) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean updateExceptAdd(String name, String id, String pw, String email, String phone) {
		try {
			ps= c.prepareStatement("update members set memberPw= ?, memberEmail= ?, memberMob= ? where (memberName= ? and memberId= ?)");
			ps.setString(1, pw);
			ps.setString(2, email);
			ps.setString(3, phone);
			ps.setString(4, name);
			ps.setString(5, id);
			res= ps.executeUpdate();
			if(res>0) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public String findId(String name, String email) {
		try {
			ps= c.prepareStatement("select * from members where memberName= ? and memberEmail= ?");
			ps.setString(1, name);
			ps.setString(2, email);
			r= ps.executeQuery();
			if(r.next()) {
				System.out.println("계정 확인");
				return r.getString("memberId");
			}else {
				System.out.println("계정 확인 불가");
				return "-";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return "-";
	}
	
	public String findPw(String id, String email) {
		try {
			ps= c.prepareStatement("select * from members where memberId= ? and memberEmail= ?");
			ps.setString(1, id);
			ps.setString(2, email);
			r= ps.executeQuery();
			if(r.next()) {
				System.out.println("계정 확인");
				return r.getString("memberPw");
			}else {
				System.out.println("계정 확인 불가");
				return "-";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(r!=null) {r.close();}
				if(ps!=null) {ps.close();}
				if(c!=null) {c.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return "-";
	}
}
