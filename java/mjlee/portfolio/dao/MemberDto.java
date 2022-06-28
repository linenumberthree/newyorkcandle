package mjlee.portfolio.dao;

public class MemberDto {
	private int no;
	private String name, id, pw, joindate, email, ip, address, postNo, mobileNo;
	private boolean terms;
	
	public MemberDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MemberDto(int no, String name, String id, String pw, String joindate, String email, String ip, String address, String postNo, String mobileNo, boolean terms) {
		super();
		this.no = no;
		this.name = name;
		this.id = id;
		this.pw = pw;
		this.joindate = joindate;
		this.email = email;
		this.ip = ip;
		this.address = address;
		this.postNo= postNo;
		this.mobileNo = mobileNo;
		this.terms= terms;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getPostNo() {
		return postNo;
	}
	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public boolean isTerms() {
		return terms;
	}
	public void setTerms(boolean terms) {
		this.terms = terms;
	}
	@Override
	public String toString() {
		return "MemberDto [no=" + no + ", name=" + name + ", id=" + id + ", pw=" + pw + ", joindate=" + joindate
				+ ", email=" + email + ", ip=" + ip + ", address=" + address + ", postNo=" + postNo + ", mobileNo="
				+ mobileNo + ", terms=" + terms + "]";
	}
	
}
