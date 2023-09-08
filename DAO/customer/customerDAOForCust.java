package eStoreProduct.DAO.customer;

//import eStoreProduct.model.customer.entities.custCredModel;

import eStoreProduct.model.customer.input.custCredModel;

public interface customerDAOForCust {
	boolean createCustomer(custCredModel ccm);

	// custCredModel checkCustomer(String usr, String pswd);

	public void updatelastlogin(int cid);

	public void updatecustomer(custCredModel ccm);

	custCredModel getCustomerById(int custId);

	custCredModel getCustomer(String email, String psd);

	void updatePassword(String p2, String finalemail);
	
	custCredModel getCustomerByEmail(String email);
	
	public String updateShpimentDetails(custCredModel ccm);

}