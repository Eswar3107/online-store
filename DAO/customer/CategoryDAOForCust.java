package eStoreProduct.DAO.customer;
import java.util.List;

import eStoreProduct.model.customer.input.Category;
public interface CategoryDAOForCust {

	public List<Category> getAllCategories();
	boolean addNewCategory(Category catg);
}