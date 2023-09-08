package eStoreProduct.model.admin.output;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class CategoryReportViewModelMapper implements RowMapper<CategoryReportViewModel> {

	@Override
	public CategoryReportViewModel mapRow(ResultSet rs, int rowNum) throws SQLException {

		CategoryReportViewModel categoryReport = new CategoryReportViewModel();
		categoryReport.setPtct_id(rs.getLong("prct_id"));
		categoryReport.setPtct_name(rs.getString("prct_title"));
		categoryReport.setTotal_products(rs.getInt("total_products"));
		categoryReport.setTotal_sales(rs.getLong("total_sales"));
		categoryReport.setTotal_amount(rs.getDouble("total_price"));
		categoryReport.setTotal_gst(rs.getDouble("total_gst"));
		return categoryReport;
	}

}