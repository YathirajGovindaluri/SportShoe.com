package in.co.online.sport.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.log4j.Logger;

import in.co.online.sport.bean.BaseBean;
import in.co.online.sport.bean.CategoryBean;
import in.co.online.sport.bean.ProductBean;
import in.co.online.sport.exception.ApplicationException;
import in.co.online.sport.exception.DuplicateRecordException;
import in.co.online.sport.model.CategoryModel;
import in.co.online.sport.model.ProductModel;
import in.co.online.sport.util.DataUtility;
import in.co.online.sport.util.DataValidator;
import in.co.online.sport.util.PropertyReader;
import in.co.online.sport.util.ServletUtility;

/**
 * Servlet implementation class ClothesCtl
 */
@WebServlet(name = "ProductCtl", urlPatterns = { "/ctl/ProductCtl" })
@MultipartConfig(maxFileSize = 16177215)
public class ProductCtl extends BaseCtl {
	private static final long serialVersionUID = 1L;

	private static Logger log = Logger.getLogger(ProductCtl.class);

	@Override
	protected void preload(HttpServletRequest request) {
		log.debug("ProductCtl preload method start");
		CategoryModel model = new CategoryModel();
		try {
			List l = model.list();
			request.setAttribute("catList", l);
		} catch (ApplicationException e) {
			log.error(e);
		}
		log.debug("ProductCtl preload method end");
	}

	/**
	 * Validate input Data Entered By User
	 * 
	 * @param request
	 * @return
	 */
	@Override
	protected boolean validate(HttpServletRequest request) {
		log.debug("ProductCtl validate method start");
		boolean pass = true;

		if (DataValidator.isNull(request.getParameter("name"))) {
			request.setAttribute("name", PropertyReader.getValue("error.require", "Name"));
			pass = false;
		}

		if (DataValidator.isNull(request.getParameter("description"))) {
			request.setAttribute("description", PropertyReader.getValue("error.require", "Description"));
			pass = false;
		}

		if (DataValidator.isNull(request.getParameter("price"))) {
			request.setAttribute("price", PropertyReader.getValue("error.require", "Price"));
			pass = false;
		}

		if ("-----Select-----".equalsIgnoreCase(request.getParameter("catId"))) {
			request.setAttribute("catId", PropertyReader.getValue("error.require", "Category Name"));
			pass = false;
		}

		Part part = null;
		try {
			part = request.getPart("photo");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

		if (DataValidator.isNull(fileName)) {
			request.setAttribute("photo", PropertyReader.getValue("error.require", "Image"));
			pass = false;
		}

		log.debug("ProductCtl validate method end");
		return pass;
	}

	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		log.debug("ProductCtl populateBean method start");
		ProductBean bean = new ProductBean();
		bean.setId(DataUtility.getLong(request.getParameter("id")));
		bean.setCategoryId(DataUtility.getLong(request.getParameter("catId")));
		bean.setName(DataUtility.getString(request.getParameter("name")));
		bean.setPrice(DataUtility.getLong(request.getParameter("price")));
		bean.setDescription(DataUtility.getString(request.getParameter("description")));
		populateDTO(bean, request);
		log.debug("ProductCtl populateBean method end");
		return bean;
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("ClothesCtl doGet method start");
		String op = DataUtility.getString(request.getParameter("operation"));

		ProductModel model = new ProductModel();
		long id = DataUtility.getLong(request.getParameter("id"));
		ServletUtility.setOpration("Add", request);
		if (id > 0 || op != null) {
			System.out.println("in id > 0  condition");
			ProductBean bean;
			try {
				bean = model.findByPK(id);
				ServletUtility.setOpration("Edit", request);
				ServletUtility.setBean(bean, request);
			} catch (ApplicationException e) {
				ServletUtility.handleException(e, request, response);
				return;
			}
		}

		ServletUtility.forward(getView(), request, response);
		log.debug("ProductCtl doGet method end");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("ProductCtl doPost method start");
		String op = DataUtility.getString(request.getParameter("operation"));
		ProductModel model = new ProductModel();
		long id = DataUtility.getLong(request.getParameter("id"));
		if (OP_SAVE.equalsIgnoreCase(op)) {

			ProductBean bean = (ProductBean) populateBean(request);
			try {

				bean.setImage(ServletUtility.subImage(request, response, bean.getName()));
				if (id > 0) {

					model.update(bean);
					ServletUtility.setOpration("Edit", request);
					ServletUtility.setSuccessMessage("Data is successfully Updated", request);
					ServletUtility.setBean(bean, request);

				} else {
					long pk = model.add(bean);
					// bean.setId(id);
					ServletUtility.setSuccessMessage("Data is successfully Saved", request);
					ServletUtility.forward(getView(), request, response);
				}

			} catch (ApplicationException e) {
				e.printStackTrace();
				ServletUtility.forward(OSSView.ERROR_VIEW, request, response);
				return;

			} catch (DuplicateRecordException e) {
				ServletUtility.setBean(bean, request);
				ServletUtility.setErrorMessage(e.getMessage(), request);
			}

		} else if (OP_DELETE.equalsIgnoreCase(op)) {
			ProductBean bean = (ProductBean) populateBean(request);
			try {
				model.delete(bean);
				ServletUtility.redirect(OSSView.PRODUCT_LIST_CTL, request, response);
			} catch (ApplicationException e) {
				ServletUtility.handleException(e, request, response);
				e.printStackTrace();
			}
		} else if (OP_CANCEL.equalsIgnoreCase(op)) {
			ServletUtility.redirect(OSSView.PRODUCT_LIST_CTL, request, response);
			return;
		} else if (OP_RESET.equalsIgnoreCase(op)) {
			ServletUtility.redirect(OSSView.PRODUCT_CTL, request, response);
			return;
		}

		ServletUtility.forward(getView(), request, response);
		log.debug("ClothesCtl doPost method end");
	}

	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return OSSView.PRODUCT_VIEW;
	}

}
