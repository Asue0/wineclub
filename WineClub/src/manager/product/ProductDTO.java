package manager.product;

import java.sql.Timestamp;

// ProductDTO - 데이터를 객체로 저장하여 이동하는 클래스
// 13개의 프로퍼티 - DB product 테이블과 매핑(1대1 매치)가 되어야함

// 상품 아이디, 상품 종류, 상품 이름, 상품 가격, 상품 수량, 원산지
// 와인 품종, 알콜 도수, 와인 양, 상품 이미지, 상품 내용, 할인율, 등록 일시
public class ProductDTO {
	private int product_id;
	private String product_kind;
	private String product_name;
	private int product_price;
	private int product_count;
	private String origin;
	private String wine_variety;
	private String alcoholicity;
	private int amount; 
	private String product_image;
	private String product_content;
	private int discount_rate;
	private Timestamp reg_date;

	public int getProduct_id() {
		return product_id;
	}

	public String getProduct_kind() {
		return product_kind;
	}

	public String getProduct_name() {
		return product_name;
	}

	public int getProduct_price() {
		return product_price;
	}

	public int getProduct_count() {
		return product_count;
	}

	public String getOrigin() {
		return origin;
	}

	public String getWine_variety() {
		return wine_variety;
	}

	public String getAlcoholicity() {
		return alcoholicity;
	}

	public int getAmount() {
		return amount;
	}

	public String getProduct_image() {
		return product_image;
	}

	public String getProduct_content() {
		return product_content;
	}

	public int getDiscount_rate() {
		return discount_rate;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public void setProduct_kind(String product_kind) {
		this.product_kind = product_kind;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public void setWine_variety(String wine_variety) {
		this.wine_variety = wine_variety;
	}

	public void setAlcoholicity(String alcoholicity) {
		this.alcoholicity = alcoholicity;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}

	public void setProduct_content(String product_content) {
		this.product_content = product_content;
	}

	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "ProductDTO [product_id=" + product_id + ", product_kind=" + product_kind + ", product_name="
				+ product_name + ", product_price=" + product_price + ", product_count=" + product_count + ", origin="
				+ origin + ", wine_variety=" + wine_variety + ", alcoholicity=" + alcoholicity + ", amount=" + amount
				+ ", product_image=" + product_image + ", product_content=" + product_content + ", discount_rate="
				+ discount_rate + ", reg_date=" + reg_date + "]";
	}

}
