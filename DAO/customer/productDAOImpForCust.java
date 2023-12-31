package eStoreProduct.DAO.customer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import eStoreProduct.model.customer.input.Category;
import eStoreProduct.model.customer.input.CategoryRowMapper;
import eStoreProduct.model.customer.input.Product;
import eStoreProduct.model.customer.input.ProductRowMapperForCust;
import eStoreProduct.utility.ProductStockPriceForCust;
import eStoreProduct.DAO.admin.ProdStockDAO; 

@Component
public class productDAOImpForCust implements ProductDAOForCust {

	@PersistenceContext
	private EntityManager entityManager;
	private final JdbcTemplate jdbcTemplate;
	private final String SQL_INSERT_PRODUCT = "insert into slam_products(prod_id, prod_title, prod_prct_id, prod_gstc_id, prod_brand, image_url, prod_desc, reorderlevel)  values(?, ?, ?, ?, ?, ?, ?, ?)";
	private final String SQL_GET_TOP_PRODID = "select prod_id from slam_products order by prod_id desc limit 1";
	private String get_products_by_catg = "select p.prod_id, p.prod_title, p.prod_brand, p.image_url, p.prod_desc, ps.prod_price FROM slam_Products p, slam_productstock ps where p.prod_id = ps.prod_id and p.prod_prct_id = ?";
	private String products_query = "SELECT p.prod_id, p.prod_title, p.prod_brand, p.image_url, p.prod_desc, ps.prod_price FROM slam_Products p, slam_productstock ps where p.prod_id = ps.prod_id";
	private String prdt_catg = "SELECT * FROM slam_ProductCategories";
	// private String get_prd = "SELECT p.*, ps.prod_price,ps.prod_mrp FROM slam_Products p,slam_productstock ps where
	// p.prod_id = ps.prod_id and ps.prod_id=?";
	private String get_prd = "SELECT p.prod_id, p.prod_title, p.prod_brand, p.image_url, p.prod_desc,p.prod_gstc_id, ps.prod_price FROM slam_Products p, slam_productstock ps where p.prod_id = ps.prod_id and ps.prod_id=?";
	private String getNextProd = "SELECT p.prod_id, p.prod_title, p.prod_brand, p.image_url, p.prod_desc, ps.prod_price FROM slam_Products p, slam_productstock ps where p.prod_id = ps.prod_id order by p.prod_id limit ? offset ?";
	private ProdStockDAO prodStockDAO;
	private static final Logger logger = 
			LoggerFactory.getLogger(productDAOImpForCust.class);

	@Autowired
	public productDAOImpForCust(DataSource dataSource, ProdStockDAO prodStockDAO) {
		jdbcTemplate = new JdbcTemplate(dataSource);
		this.prodStockDAO = prodStockDAO;
	}

	@Override
	//method to add a product
	public boolean createProduct(Product p) {
		logger.info("eStoreProduct:DAO:ProductDAOImp:adding a new product");
		int p_id = jdbcTemplate.queryForObject(SQL_GET_TOP_PRODID, int.class);
		p_id = p_id + 1;
		return jdbcTemplate.update(SQL_INSERT_PRODUCT, p_id, p.getProd_title(), p.getProd_prct_id(),
				p.getProd_gstc_id(), p.getProd_brand(), p.getImage_url(), p.getProd_desc(), p.getReorderLevel()) > 0;
	}

	//method to get products based on the category selected
	public List<ProductStockPriceForCust> getProductsByCategory(Integer category_id) {
		logger.info("eStoreProduct:DAO:ProductDAOImp:getting the products based on the category selected");
		System.out.println("in pdaoimp cid   " + category_id);
		List<ProductStockPriceForCust> p = jdbcTemplate.query(get_products_by_catg, new ProductRowMapperForCust(prodStockDAO),
				category_id);

		return p;
	}

	//method to get all the products
	public List<ProductStockPriceForCust> getAllProducts() {
		logger.info("eStoreProduct:DAO:ProductDAOImp:getting all the products");
		return jdbcTemplate.query(products_query, new ProductRowMapperForCust(prodStockDAO));
	}

	//method to get all the categories available
	public List<Category> getAllCategories() {
		logger.info("eStoreProduct:DAO:ProductDAOImp: getting all the categories available");
		return jdbcTemplate.query(prdt_catg, new CategoryRowMapper());
	}

	//method to get product by id
	public ProductStockPriceForCust getProductById(Integer productId) {
		logger.info("eStoreProduct:DAO:ProductDAOImp:getting product by id");
		List<ProductStockPriceForCust> products = jdbcTemplate.query(get_prd, new ProductRowMapperForCust(prodStockDAO), productId);
		return products.isEmpty() ? null : products.get(0);
	}

	@Override
		//method to get the products according to the sorting selected
	public List<ProductStockPriceForCust> sortProductsByPrice(List<ProductStockPriceForCust> productList, String sortOrder) {
		logger.info("eStoreProduct:DAO:ProductDAOImp:getting the products according to the sorting selected");
		if (sortOrder.equals("lowToHigh")) {
			Collections.sort(productList);
		} else if (sortOrder.equals("highToLow")) {
			Collections.sort(productList, Collections.reverseOrder());
		}

		return productList;
	}

	@Override
	//method to get products based on the price range selected
	public List<ProductStockPriceForCust> filterProductsByPriceRange(List<ProductStockPriceForCust> filteredProducts, double minPrice,
			double maxPrice) {
		logger.info("eStoreProduct:DAO:ProductDAOImp:getting products based on the price range selected");
		List<ProductStockPriceForCust> res = new ArrayList<>();
		for (ProductStockPriceForCust product : filteredProducts) {
			if (product.getPrice() >= minPrice && product.getPrice() <= maxPrice) {
				System.out.println(product.getPrice() + "in filter productdao");
				res.add(product);
			}
		}
		return res;
	}

	//method to check the pincode 
	public boolean isPincodeValid(int pincode) {
		logger.info("eStoreProduct:DAO:ProductDAOImp:checking the availability for the pincode");
		String query = "SELECT COUNT(*) FROM slam_regions WHERE ? BETWEEN region_pin_from AND region_pin_to";
		int count = jdbcTemplate.queryForObject(query, Integer.class, pincode);
		return count > 0;
	}

	@Override
	//method to get the product gst hsn code
	public int getproductgstcid(int pid) {
		logger.info("eStoreProduct:DAO:ProductDAOImp:getting the product gst hsn code");
		String sql = "SELECT prod_gstc_id FROM slam_products WHERE prod_id = ?";
		Integer prodGstcId = jdbcTemplate.queryForObject(sql, new Object[] { pid }, Integer.class);

		// If the query returns null, handle the case accordingly
		return prodGstcId != null ? prodGstcId : 0;
	}

	// @Override
		public List<ProductStockPriceForCust> searchproducts(String search) {
			String query = "SELECT p.*, ps.prod_price FROM slam_Products p JOIN slam_productstock ps ON p.prod_id = ps.prod_id "
					+ "WHERE p.prod_title ILIKE '%' || ? || '%' OR p.prod_desc ILIKE '%' || ? || '%' OR p.prod_brand ILIKE '%' || ? || '%'";
			List<ProductStockPriceForCust> products = jdbcTemplate.query(query, new ProductRowMapperForCust(prodStockDAO), search, search,
					search);
			return products;
		}

		public List<String> getSearchSuggestions(String search) {
			String query = "SELECT prod_title FROM slam_Products WHERE prod_title ILIKE '%' || ? || '%'";
			List<String> suggestions = jdbcTemplate.queryForList(query, String.class, search);
			return suggestions;
		}

		@Override
		public List<ProductStockPriceForCust> getPageProducts(int startIndex, int productsPerPage) {
			// TODO Auto-generated method stub
			return jdbcTemplate.query(getNextProd, new ProductRowMapperForCust(prodStockDAO), productsPerPage, startIndex);

		}
}