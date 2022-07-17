package mall.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JDBCUtil;

// DAO(Data Access Object) - DB 연결, 해제, 질의를 담당
public class MemberDAO {
	
	// Singleton Pattern(싱글톤 패턴) - 클래스의 인스턴스를 하나만 생성하는 방법
	private MemberDAO() { }
	
	private static MemberDAO memberDAO = new MemberDAO();
	
	public static MemberDAO getInstance() {
		return memberDAO;
	}
	
	// DB 연결, 질의 객체 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 회원 가입 매소드
	public int insertMember(MemberDTO member) {
		String sql = "insert into member values(?, ?, ?, ?, ?, ?, now())";
		int cnt = 0; 
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getTel());
			pstmt.setString(6, member.getAddress());
			cnt = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	// 회원 ID 중복 체크 매소드
	public int checkID(String id) {
		String sql = "select * from member where id = ?";
		int cnt = 0; // 아이디 존재 여부
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) cnt = 0; // 아이디가 이미 존재 -> 사용할 수 없는 아이디
			else cnt = 1; // 아이디가 없음 -> 사용할 수 있는 아이디
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	// 로그인 매소드
	public int login(String id, String pwd) {
		String sql = "select * from member where id = ?";
		int cnt = -1; 
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) { // 아이디가 있을 때
				String dbPwd = rs.getString("pwd");
				if(pwd.equals(dbPwd)) { // 비밀번호도 일치할 때
					cnt = 1;
				} else {
					cnt = 0;
				}
			} else { // 아이디가 없을 때
				cnt = -1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	// 회원 정보 보기 매소드(1명, 자신의 정보)
	public MemberDTO getMember(String id) {
		String sql = "select * from member where id = ?";
		MemberDTO member = new MemberDTO();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				// 가입일을 제외한 정보
				member.setId(rs.getString("id"));
				member.setPwd(rs.getString("pwd"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setTel(rs.getString("tel"));
				member.setAddress(rs.getString("address"));
				member.setRegDate(rs.getTimestamp("regDate"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return member;
	}
	// 회원 정보 수정 매소드
	public int updateMember(MemberDTO member) {
		String sql = "update member set pwd=?, name=?, "
				+ "email=?, tel=?, address=? where id=?";
		int cnt = 0; 
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getId());
			cnt = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	// 회원 삭제(탈퇴) 매소드  -> 해당 회원이 남긴 리뷰, 카트 정보도 모두 삭제, 구매정보는 삭제하지 않음
	// -> 해당 회원이 남긴 게시판의 글도 모두 삭제하도록 매소드를 만들기로 함
	public int deleteMember(String id, String pwd) throws Exception {
		String sql1 = "delete from member where id=? and pwd=?";
		String sql2 = "delete from review where member_id=?";
		String sql3 = "delete from cart where buyer=?";
		int cnt = 0; // 성공 여부
		
		try {
			conn = JDBCUtil.getConnection();
			/*
			 회원 삭제와 회원이 남긴 게시판 글 삭제는 반드시
			 회원 삭제가 되었을 때만 게시판 글이 삭제되어야 한다.
			 즉, 반드시 둘 다 성공하거나 둘 다 실패해야하므로
			 트랜젝션 방식을 사용해야한다 ★
			 
			 트랜젝션(transaction) 처리: DML(insert, update, delete) 작업이
			 2개 이상 함께 처리되어야할 때 모두 처리되든지, 모두 처리되지 않게 하는 방법
			 -> all or nothing 
			 */
			
			// 트랜잭션 처리 1단계 - autocommit 기능을 끔
			conn.setAutoCommit(false);
			
			// 1작업: 회원 삭제 작업
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.executeUpdate();
			
			// 2작업: 해당 회원이 남긴 리뷰 모두 삭제
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			// 3작업: 회원이 남긴 모든 리
			pstmt = conn.prepareStatement(sql3);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			// 트랜잭션 처리 2단계 - 모든 작업이 정상적으로 완료되었다면 커밋을 함
			conn.commit();
			
			// 트랜잭션 3단계 - 이대로 두면 autocommit기능이 꺼진 상태이기 때문에
			// 다시 autocommit을 true로 되돌려준다.
			conn.setAutoCommit(true);
			cnt = 1;
			
		} catch(Exception e) {
			/* 트랜젝션 처리시에 예외가 발생했을 시 이 예외처리로 오게 된다. 
			 * -> 그 경우 커밋이 아닌 rollback을 해주어야 한다.
			 */
			conn.rollback(); 
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
}
