package mall.member;

import java.sql.Timestamp;

// DTO, VO, DataBean

// useBean 액션태그에서 사용할 클래스 -> 데이터의 이동에서 사용함 
//프로퍼티 -> 멤버변수
// 날짜는 값을 받을 필요가 없으므로 프로퍼티로 만들지 않았다.
public class MemberDTO {
	private String id;
	private String pwd;
	private String name;
	private String email;
	private String tel;
	private String address;
	private Timestamp regDate;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", pwd=" + pwd + ", name=" + name + ", email=" + email + ", tel=" + tel
				+ ", address=" + address + ", regDate=" + regDate + "]";
	}

}
