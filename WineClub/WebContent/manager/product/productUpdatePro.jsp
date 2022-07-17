<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 수정 처리</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8"); 

/* 
자바빈을 이용할 수 없다
-> productContent에서 이미지 파일을 업로드 받기 때문에
-> enctype="multipart/form-data"를 사용했기 때문에

해결법 (파일 업로드 폼의 입력 정보 획득)
-> 파일 업로드 폼은 con.jar 라이브러리의
MultipartRequest 클래스를 사용해 값을 받는다. ★★
*/

// MultipartRequest를 사용하기 위한 다섯가지 매개변수 설정
// request, 업로드 폴더, 파일의 최대크기, encType, 파일명 중복정책
String realFolder = "d:/images_ezenmall"; // 파일이 저장될 폴더
int maxSize = 1024 * 1024 * 5; // 5MB
String encType = "utf-8";
MultipartRequest multi = null;
//ProductDTO 객체를 생성해 setter 매소드를 사용해 값을 객체로 저장
ProductDTO product = new ProductDTO();
try {
	multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());	
	List<String> fileList = new ArrayList<String>();
	int i = 0;
	Enumeration<?> files = multi.getFileNames();
	while(files.hasMoreElements()) {
		String name = (String)files.nextElement();
		// 서버에 저장된 파일이름
		String saveFileName = multi.getFilesystemName(name);
		// 업로드된 파일이름을 fileList에 저장
		fileList.add(saveFileName);
	}
	
	// 만들어진 MultipartRequest를 사용해 폼에서 넘어오는 10개의 필드 값을 획득 (이미지, 상품 내용 이미지는 위에서 이미 따로 처리함)
	// 제외) reg_date(수정하지 않을 것이므로)
	int product_id = Integer.parseInt(multi.getParameter("product_id"));
	String product_kind = multi.getParameter("product_kind");
	String product_name = multi.getParameter("product_name");
	int product_price = Integer.parseInt(multi.getParameter("product_price"));
	int product_count = Integer.parseInt(multi.getParameter("product_count"));
	String origin = multi.getParameter("origin");
	String wine_variety = multi.getParameter("wine_variety");
	String alcoholicity = multi.getParameter("alcoholicity");
	int amount = Integer.parseInt(multi.getParameter("amount"));
	// String product_image = multi.getParameter("product_image"); 파일 이름은 이렇게 얻을 수 없음
	int discount_rate = Integer.parseInt(multi.getParameter("discount_rate"));

	product.setProduct_id(product_id);
	product.setProduct_kind(product_kind);
	product.setProduct_name(product_name);
	product.setProduct_price(product_price);
	product.setProduct_count(product_count);
	product.setOrigin(origin);
	product.setWine_variety(wine_variety);
	product.setAlcoholicity(alcoholicity);
	product.setAmount(amount);
	product.setProduct_image(fileList.get(0)); // 위에서 구한 업로드한 파일의 실제 이름
	product.setProduct_content(fileList.get(1));
	product.setDiscount_rate(discount_rate);

	// JSP에선 System.out.println을 사용해 콘솔창에서 디버깅을 확인할 수 있다.
	System.out.println("product 객체 값 확인 : " + product ); // toString을 호출하지 않아도 toString이 내장되어 있다면 자동으로 호출된다.


} catch(Exception e) {
	System.out.println("productUpdatePro.jsp 파일: " + e.getMessage());
	e.printStackTrace();
} 

String pageNum = multi.getParameter("pageNum");

// DB 연결, product 테이블에 상품 추가 처리
ProductDAO productDAO = ProductDAO.getInstance();
productDAO.updateProduct(product); 
response.sendRedirect("productList.jsp?pageNum=" + pageNum); 

%>
</body>
</html>