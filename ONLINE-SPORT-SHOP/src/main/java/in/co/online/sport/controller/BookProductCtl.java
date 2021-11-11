package in.co.online.sport.controller;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import in.co.online.sport.bean.BaseBean;
import in.co.online.sport.bean.BookProductBean;
import in.co.online.sport.bean.CartBean;
import in.co.online.sport.bean.ProductBean;
import in.co.online.sport.bean.UserBean;
import in.co.online.sport.exception.ApplicationException;
import in.co.online.sport.exception.DuplicateRecordException;
import in.co.online.sport.model.BookProductModel;
import in.co.online.sport.model.CartModel;
import in.co.online.sport.model.ProductModel;
import in.co.online.sport.util.DataUtility;
import in.co.online.sport.util.DataValidator;
import in.co.online.sport.util.PropertyReader;
import in.co.online.sport.util.ServletUtility;

/**
 * Servlet implementation class BookClothesCtl
 */
@WebServlet(name="BookProductCtl",urlPatterns={"/ctl/BookProductCtl"})
public class BookProductCtl extends BaseCtl {
	private static final long serialVersionUID = 1L;
	
	private static Logger log=Logger.getLogger(BookProductCtl.class);
       
	@Override
    protected boolean validate(HttpServletRequest request) {
		log.debug("BookProductCtl validate method start");
        boolean pass = true;
        
        String op=DataUtility.getString(request.getParameter("operation"));

        if (DataValidator.isNull(request.getParameter("email"))) {
            request.setAttribute("email",
                    PropertyReader.getValue("error.require", "EmailId"));
            pass = false;
        }

        if (DataValidator.isNull(request.getParameter("pinCode"))) {
            request.setAttribute("pinCode",
                    PropertyReader.getValue("error.require", "PinCode"));
            pass = false;
        }
        
        if (DataValidator.isNull(request.getParameter("land"))) {
            request.setAttribute("land",
                    PropertyReader.getValue("error.require", "land"));
            pass = false;
        }
        
        if (DataValidator.isNull(request.getParameter("address"))) {
            request.setAttribute("address",
                    PropertyReader.getValue("error.require", "Address"));
            pass = false;
        }
        
        System.out.println("Validate book Clothes Before"+pass);
        
        if(OP_BOOK_PAY.equalsIgnoreCase(op)) {
        	pass=true;
        }
        
        System.out.println("Validate book Clothes"+pass);
        
        log.debug("BookProductCtl validate method end");
        return pass;
    }

	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		log.debug("BookProductCtl populateBean method start");
		BookProductBean bean=new BookProductBean();
		bean.setId(DataUtility.getLong(request.getParameter("id")));
		bean.setEmailId(DataUtility.getString(request.getParameter("email")));
		bean.setPinCode(DataUtility.getString(request.getParameter("pinCode")));
		bean.setLandMark(DataUtility.getString(request.getParameter("land")));
		bean.setAddress(DataUtility.getString(request.getParameter("address")));
		populateDTO(bean, request);
		log.debug("BookProductCtl populateBean method end");
		return bean;
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.debug("BookProductCtl doGet method start"); 
		String op = DataUtility.getString(request.getParameter("operation"));
	        
		HttpSession session=request.getSession();
		
		long clId=DataUtility.getLong(request.getParameter("cId"));
		session.setAttribute("coId",clId);
	       BookProductModel model = new BookProductModel();
	       try {
	    	   CartBean cBean=new CartBean();
	    	   UserBean uBean=(UserBean)session.getAttribute("user");
	    	   cBean.setUserId(uBean.getId());
				ServletUtility.setList(new CartModel().search(cBean), request);
			} catch (ApplicationException e) {
				e.printStackTrace();
				ServletUtility.handleException(e, request, response);
			}
	        ServletUtility.forward(getView(), request, response);
	        log.debug("BookProductCtl doGet method end");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.debug("BookProductCtl doPost method start");
		String op = DataUtility.getString(request.getParameter("operation"));
		BookProductModel model = new BookProductModel();
		long id = DataUtility.getLong(request.getParameter("id"));
		HttpSession session=request.getSession();
		
		System.out.println("Operation in Do Post---------------"+op);
		System.out.println("BaseCtl----------------OP----"+OP_CONFIRM_PAY);
		if (OP_CONFIRM_PAY.equalsIgnoreCase(op)) {
			
			System.out.println("Operation in Do Post After---------------"+op);
			BookProductBean bean = (BookProductBean) populateBean(request);	
		
			session.setAttribute("BookB", bean);
			
			System.out.println("confirm And Payment do do Post");
			
			ServletUtility.forward(OSSView.PAYMENT_VIEW, request, response);
		
		
		}else if(OP_BOOK_PAY.equalsIgnoreCase(op)) {
			long pk=0;
			BookProductBean bBean=(BookProductBean)session.getAttribute("BookB");
			UserBean uBean=(UserBean)session.getAttribute("user");
			bBean.setName(uBean.getFirstName()+" "+uBean.getLastName());
			bBean.setMobileNo(uBean.getMobileNo());
			CartBean cBean=new CartBean();
			cBean.setUserId(uBean.getId());
			try {
				List cList=new CartModel().search(cBean);
				int size=cList.size();
				CartBean ctBean=null;
				Iterator<CartBean> it=cList.iterator();
				while (it.hasNext()) {
					 ctBean =it.next();
					 ProductBean pBean=new ProductModel().findByPK(ctBean.getProductId());
					 bBean.setProductId(ctBean.getProductId());
					 bBean.setPrice(pBean.getPrice());
					 bBean.setProductName(pBean.getName());
					 pk=model.add(bBean);
					 new CartModel().delete(ctBean);
				
				}
				BookProductBean bpBean=new BookProductBean();
				bpBean.setName(bBean.getName());
				ServletUtility.setList(model.search(bpBean,1,size), request);
			} catch (ApplicationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (DuplicateRecordException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
			
			ServletUtility.forward(OSSView.SUCCESS_VIEW, request, response);
		}else if (OP_CANCEL.equalsIgnoreCase(op)) {
			ServletUtility.redirect(OSSView.PRODUCT_LIST_CTL, request, response);
			return;
	} 
		System.out.println("Before Get View Method");
		ServletUtility.forward(getView(), request, response);
		log.debug("BookProductCtl doPost method end");
	}

	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return OSSView.BOOK_PRODUCT_VIEW;
	}

}
