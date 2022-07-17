package manager.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JDBCUtil;

public class ProductDAO {
	// Singleton Pattern
	private ProductDAO() { }
	
	private static ProductDAO instance = new ProductDAO();
	
	public static ProductDAO getInstance() {
		return instance;
	}
	
	// DB 연결, 질의를 위한 객체 변수
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	
	// ################################## //
	// 상품 등록, 수정, 조회, 삭제에 관련된 매소드

	// 상품 등록 메소드
	public void insertProduct(ProductDTO product) {
		String sql = "insert into product(product_kind, product_name, "
				+ "product_price, product_count, " 
				+ "origin, wine_variety, alcoholicity, amount, "
				+ "product_image, product_content, discount_rate) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getProduct_kind());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setInt(3, product.getProduct_price());
			pstmt.setInt(4, product.getProduct_count());
			pstmt.setString(5, product.getOrigin());
			pstmt.setString(6, product.getWine_variety());
			pstmt.setString(7, product.getAlcoholicity());
			pstmt.setInt(8, product.getAmount());
			pstmt.setString(9, product.getProduct_image());
			pstmt.setString(10, product.getProduct_content());
			pstmt.setInt(11, product.getDiscount_rate());
			pstmt.executeUpdate();
		} catch(Exception e) {
			// 오류가 났을 때 콘솔창에서 확인하는 법(디버깅)
			System.out.println("insertProduct 매소드: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	// 전체 상품수 조회 메소드 - 검색을 하지 않았을 때
	public int getProductCount() {
		String sql = "select count(*) from product";
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("getProductCount 매소드 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	// 상품 분류별 상품수 조회 메소드 - shopMain.jsp
	public int getProductCount(String product_kind) {
		String sql = "select count(*) from product where product_kind = ?";
		int cnt = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_kind);
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("getProductCount(product_kind) 매소드 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	// 검색한 전체 상품수 조회 메소드 - 검색을 했을 때
	public int getProductCount(String s_search, String i_search) {
		String sql = "select count(*) from product where ";
		
		if(s_search.equals("제목")) {
			sql += "product_name";
		} else if(s_search.equals("원산지")) {
			sql += "origin";
		} else if(s_search.equals("와인 품종")) {
			sql += "wine_variety";
		} else if(s_search.equals("상품 종류")) {
			sql += "product_kind";
			// 상품 종류를 상품 코드로 변환
			if(i_search.equals("내추럴 와인")) i_search = "110";
			if(i_search.equals("샴페인")) i_search = "120";
			if(i_search.equals("스파클링 와인")) i_search = "130";
			if(i_search.equals("레드 와인")) i_search = "210";
			if(i_search.equals("화이트 와인")) i_search = "220";
			if(i_search.equals("로제 와인")) i_search = "310";
			if(i_search.equals("주정강화 와인")) i_search = "320";
			if(i_search.equals("와인 글라스")) i_search = "410";
			if(i_search.equals("코스크 스크류")) i_search = "420";
			if(i_search.equals("와인 렉")) i_search = "510";
			if(i_search.equals("와인 셀러")) i_search = "520";
		}
		sql	+= " like ?";
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + i_search + "%");
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("getProductCount(s_search, i_search) 매소드 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
	// 검색을 한 전체 상품 조회 매소드 - 페이징 처리가 됨, 검색 처리를 함
	public List<ProductDTO> getProductList(int startRow, int pageSize, String s_search, String i_search) {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql = "select * from product where ";
		if(s_search.equals("제목")) {
			sql += "product_name";
		} else if(s_search.equals("원산지")) {
			sql += "origin";
		} else if(s_search.equals("와인 품종")) {
			sql += "wine_variety";
		} else if(s_search.equals("상품 종류")) {
			sql += "product_kind";
			// 상품 종류를 상품 코드로 변환
			if(i_search.equals("내추럴 와인")) i_search = "110";
			if(i_search.equals("샴페인")) i_search = "120";
			if(i_search.equals("스파클링 와인")) i_search = "130";
			if(i_search.equals("레드 와인")) i_search = "210";
			if(i_search.equals("화이트 와인")) i_search = "220";
			if(i_search.equals("로제 와인")) i_search = "310";
			if(i_search.equals("주정강화 와인")) i_search = "320";
			if(i_search.equals("와인 글라스")) i_search = "410";
			if(i_search.equals("코스크 스크류")) i_search = "420";
			if(i_search.equals("와인 렉")) i_search = "510";
			if(i_search.equals("와인 셀러")) i_search = "520";
		}
		sql	+= " like ? order by product_id desc limit ?, ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + i_search + "%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				product = new ProductDTO();
				// product_content(글 내용), amount(와인 양)를 제외한 11개의 필드 정보
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setOrigin(rs.getString("origin"));
				product.setWine_variety(rs.getString("wine_variety"));
				product.setAlcoholicity(rs.getString("alcoholicity"));
				product.setProduct_image(rs.getString("product_image"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}
		} catch(Exception e) {
			System.out.println("getProductList 매소드 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}
	
	// 전체 상품 조회 메소드 - 페이징 처리기 됨, 검색 처리는 안함
	public List<ProductDTO> getProductList(int startRow, int pageSize) {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql = "select * from product order by product_id desc limit ?, ?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				product = new ProductDTO();
				// product_content(글 내용), alcoholiciity(알코올 도수)를 제외한 11개의 필드 정보
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setOrigin(rs.getString("origin"));
				product.setWine_variety(rs.getString("wine_variety"));
				product.setAlcoholicity(rs.getString("alcoholicity"));
				product.setProduct_image(rs.getString("product_image"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}
		} catch(Exception e) {
			System.out.println("getProductList 매소드 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}
	
	// 상품 상세 보기(1건 보기) 매소드
	public ProductDTO getProduct(int product_id) {
		ProductDTO product = new ProductDTO();
		String sql = "select * from product where product_id = ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
			rs.next();
			// 상품에 대한 13개(전체) 필드의 정보
			product.setProduct_id(rs.getInt("product_id"));
			product.setProduct_kind(rs.getString("product_kind"));
			product.setProduct_name(rs.getString("product_name"));
			product.setProduct_price(rs.getInt("product_price"));
			product.setProduct_count(rs.getInt("product_count"));
			product.setOrigin(rs.getString("origin"));
			product.setWine_variety(rs.getString("wine_variety"));
			product.setAlcoholicity(rs.getString("alcoholicity"));
			product.setAmount(rs.getInt("amount"));
			product.setProduct_image(rs.getString("product_image"));
			product.setProduct_content(rs.getString("product_content"));
			product.setDiscount_rate(rs.getInt("discount_rate"));
			product.setReg_date(rs.getTimestamp("reg_date"));
		} catch(Exception e) {
			System.out.println("getProductList 매소드 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return product;
	}
	
	// 상품 정보 수정 매소드
	public void updateProduct(ProductDTO product) {
		String sql = "update product set product_kind=?, product_name=?,"
				+ " product_price=?, product_count=?, origin=?, "
				+ "wine_variety=?, alcoholicity=?, amount=?, product_image=?, "
				+ "product_content=?, discount_rate=? where product_id=?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getProduct_kind());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setInt(3, product.getProduct_price());
			pstmt.setInt(4, product.getProduct_count());
			pstmt.setString(5, product.getOrigin());
			pstmt.setString(6, product.getWine_variety());
			pstmt.setString(7, product.getAlcoholicity());
			pstmt.setInt(8, product.getAmount());
			pstmt.setString(9, product.getProduct_image());
			pstmt.setString(10, product.getProduct_content());
			pstmt.setInt(11, product.getDiscount_rate());
			pstmt.setInt(12, product.getProduct_id());
			pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("updateProduct 메소드: " +  e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	// 상품 정보 삭제 매소드
	public void deleteProduct(int product_id) {
		String sql ="delete from product where product_id = ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("deleteProduct 매소드: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	// ################################## //
	// mall 에서 사용하는 매소드
	
	
	// 1. chk가 1일때 - shop에서 100번대, 200번대 신상품 3개씩을 리스트에 담아서 리턴하는 매소드
	// 			110, 120, 220, 230, 240, 250
	// 			신상품의 기준: 출판일(publishing_date)
	// 2. chk가 2일때 - 모든 상품 종류별로 신상품 1개씩을 리스트에 담아서 리턴하는 매소드
	public List<ProductDTO> getProductList(String[] nProducts) {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql = "select * from product where product_kind = ? "
				+ "order by reg_date desc limit 2";
		try {
			conn = JDBCUtil.getConnection();
			for(String s : nProducts) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, s);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					product = new ProductDTO();
					product.setProduct_id(rs.getInt("product_id"));
					product.setProduct_image(rs.getString("product_image"));
					productList.add(product);
				}
			}		
		} catch(Exception e) {
			System.out.println("getProductList(String[]) 매소드: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}
	// 상품 종류별 보기 매소드 - 페이징 처리가 됨, shopMain.jsp에서 사용
	public List<ProductDTO> getProductList(int startRow, int pageSize, 
			String product_kind) {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql = "select * from product where product_kind = ? "
				+ "order by product_id desc limit ?, ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_kind);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				product = new ProductDTO();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setOrigin(rs.getString("origin"));
				product.setWine_variety(rs.getString("wine_variety"));
				product.setProduct_image(rs.getString("product_image"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				productList.add(product);
			}
		} catch(Exception e) {
			System.out.println("getProductList(product_kind): " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return productList;
	}
	
}
