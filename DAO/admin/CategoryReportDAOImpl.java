package eStoreProduct.DAO.admin;
import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import eStoreProduct.model.admin.output.CategoryReportViewModel;
import eStoreProduct.model.admin.output.CategoryReportViewModelMapper;

@Component
public class CategoryReportDAOImpl implements CategoryReportDAO {

	JdbcTemplate jdbcTemplate;

	@Autowired
	public CategoryReportDAOImpl(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}

	private static final Logger logger = LoggerFactory.getLogger(CategoryReportDAOImpl.class);

	/**
	 * Retrieves a list of CategoryReportViewModel objects containing category report data.
	 *
	 * @return The list of CategoryReportViewModel objects.
	 */

	public List<CategoryReportViewModel> getCatRep() {
		/*
		 * String hql =
		 * "select new eStoreProduct.model.admin.output.CategoryReportViewModel(spc.id, spc.prct_title, count(*), sum(sop.price), sum(sop.gst), sum(sop.quantity)) "
		 * + "from orderModel so, SlamOrderProduct sop, SlamProduct sp, productCategoryModel spc " +
		 * "where sop.productId = sp.id and sp.productCategory = spc.id group by spc.id";
		 */

		String hql = "select * from categoryReports ";

		List<CategoryReportViewModel> result = jdbcTemplate.query(hql, new CategoryReportViewModelMapper());

		// Log message indicating the execution of the method
		logger.info("Executed getCatRep() method in CategoryDAOImp");

		// Log the result for debugging purposes
		logger.debug("Category Report Result: {}", result);
		return result;

	}

}

