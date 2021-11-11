
<%@page import="in.co.online.sport.controller.ProductListCtl"%>
<%@page import="in.co.online.sport.bean.CategoryBean"%>
<%@page import="in.co.online.sport.model.CategoryModel"%>
<%@page import="in.co.online.sport.model.ProductModel"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="in.co.online.sport.bean.ProductBean"%>
<%@page import="in.co.online.sport.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Product</title>
</head>
<body>
<body>
<div class="site-wrap">
<%@ include file="Header.jsp" %>
<div class="bg-light py-3">
      <div class="container">
        <div class="row">
          <div class="col-md-12 mb-0"><strong class="text-black">Shop</strong></div>
        </div>
      </div>
    </div>
	<form action="<%=OSSView.PRODUCT_LIST_CTL%>" method="post">
    <div class="site-section">
      <div class="container">

        <div class="row mb-5">
          <div class="col-md-9 order-2">

            <div class="row">
              <div class="col-md-12 mb-5">
                <div class="float-md-left mb-4"><h2 class="text-black h5">Shop All</h2>
                <center><b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
			<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b></center>
                </div>
              </div>
            </div>
            
            <div class="row mb-5">
			<%
					int pageNo = ServletUtility.getPageNo(request);
					int pageSize = ServletUtility.getPageSize(request);
					int index = ((pageNo - 1) * pageSize) + 1;
					ProductBean bean = null;
					List list = ServletUtility.getList(request);
					Iterator<ProductBean> i = list.iterator();
					while (i.hasNext()) {
						bean = i.next();
				%>

              <div class="col-sm-6 col-lg-4 mb-4" data-aos="fade-up">
                <div class="block-4 text-center border">
                  <figure class="block-4-image">
					<%if(userLoggedIn){ %>                  
                    <a href="/ONLINE-SPORT-SHOP/ctl/BookProductCtl?cId=<%=bean.getId()%>"><img  width="340px" height="380px" src="<%=OSSView.APP_CONTEXT%>/images/<%=bean.getImage()%>" alt="Image placeholder" class="img-fluid"></a>
                  	<%}else{ %>
                  	 <a href="LoginCtl?cId=<%=bean.getId()%>"><img width="340px" height="380px" src="<%=OSSView.APP_CONTEXT%>/images/<%=bean.getImage()%>" alt="Image placeholder" class="img-fluid"></a>
                  	<%} %>
                  </figure>
                  <div class="block-4-text p-4">
                    <h3><a href="LoginCtl?cId=<%=bean.getId()%>"><%=bean.getName()%></a></h3>
                    <p class="mb-0"><%=bean.getDescription()%></p>
                    <p class="text-primary font-weight-bold"><%=bean.getPrice()%>Rs</p>
                    <%if(userLoggedIn){ %>
                    <a class="btn btn-primary btn-sm" href="/ONLINE-SPORT-SHOP/ctl/CartCtl?cIdd=<%=bean.getId()%>">Add To Cart</a>
                  	<%}else{ %>
                  	<a class="btn btn-primary btn-sm" href="/ONLINE-SPORT-SHOP/Login?cId=<%=bean.getId()%>">Add To Cart</a>
                  	<%} %>
                  </div>
                </div>
              </div>
              
         <%} %>
            </div>
            <div class="row" data-aos="fade-up">
              <div class="col-md-12 text-center">
                <div class="site-block-27">
                  <ul>
                    <li><input type="submit" class="btn btn-primary btn-lg btn-block" <%=(pageNo==1)? "disabled" : "" %> name="operation" value="<%=ProductListCtl.OP_PREVIOUS%>"></li>
                   
                   <%ProductModel model=new ProductModel(); %>
                    <li><input type="submit" class="btn btn-primary btn-lg btn-block" <%=((list.size()<pageSize)||model.nextPK()-1==bean.getId())? "disabled": "" %> name="operation" value="<%=ProductListCtl.OP_NEXT%>"></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
        

          <div class="col-md-3 order-1 mb-5 mb-md-0">
            <div class="border p-4 rounded mb-4">
              <h3 class="mb-3 h6 text-uppercase text-black d-block">Categories</h3>
              <ul class="list-unstyled mb-0">
              <%
              CategoryModel cModel=new CategoryModel();
              	CategoryBean cBean=null;
              	 List cList=cModel.list();
              	Iterator<CategoryBean> it = cList.iterator();
				while (it.hasNext()) {
					cBean = it.next();
					
					ProductModel clModel=new ProductModel();
					ProductBean clBean=new ProductBean();
					clBean.setCategoryId(cBean.getId());
					List clList =clModel.search(clBean);
              %>
                <li class="mb-1"><a href="<%=OSSView.PRODUCT_LIST_CTL%>?catg=<%=cBean.getId()%>" class="d-flex"><span><%=cBean.getName()%></span> <span class="text-black ml-auto">(<%=clList.size()%>)</span></a></li>                
               <%} %>
              </ul>
            </div>


            </div>
          </div>
            <input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
        </div>
    </div>
    </form>
<%@ include file="Footer.jsp" %>
</div>
</body>
</html>