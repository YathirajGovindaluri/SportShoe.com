
<%@page import="in.co.online.sport.bean.BookProductBean"%>
<%@page import="in.co.online.sport.model.CartModel"%>
<%@page import="in.co.online.sport.controller.CartListCtl"%>
<%@page import="in.co.online.sport.bean.ProductBean"%>
<%@page import="in.co.online.sport.model.ProductModel"%>
<%@page import="java.util.Iterator"%>
<%@page import="in.co.online.sport.bean.CartBean"%>
<%@page import="java.util.List"%>
<%@page import="in.co.online.sport.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cart</title>
</head>
<body>
<div class="site-wrap">
<%@ include file="Header.jsp" %>
<div class="bg-light py-3">
      <div class="container">
        <div class="row">
          <div class="col-md-12 mb-0"><strong class="text-black">Cart</strong></div>
        </div>
      </div>
    </div>

    <div class="site-section">
    
      <div class="container">
        <div class="row mb-5">
          
            <div class="site-blocks-table">
					<b><font color="green">Your Order Have Done Successfully</font></b>
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th class="product-thumbnail">Image</th>
                    <th class="product-name">Name</th>
                    <th class="product-price">Price</th>
                    <th class="product-remove">Description</th>
                  </tr>
                </thead>
             
                <tbody>
                
                   <%
							List list=ServletUtility.getList(request);
							BookProductBean bean=null;
							Iterator<BookProductBean> iterator=list.iterator();
							long totalprice=0;
							while(iterator.hasNext()){
								 bean=iterator.next();
								 
								 ProductModel cModel=new ProductModel();
								 ProductBean cBean=cModel.findByPK(bean.getProductId());
				%>
                  <tr>
                    <td class="product-thumbnail">
                      <img width="250px" height="250px"     src="<%=OSSView.APP_CONTEXT%>/images/<%=cBean.getImage()%>" alt="Image" class="img-fluid">
                    </td>
                    <td class="product-name">
                      <h2 class="h5 text-black"><%=cBean.getName() %></h2>
                    </td>
                   <%  totalprice =totalprice+cBean.getPrice();%>
                    <td><%=cBean.getPrice()%></td>
                    <td><%=cBean.getDescription()%></td>
                  </tr>

                 <%} %>
                 <tr>
                 
                 <td colspan="2">Total</td>
                 <td colspan="3"><%=totalprice%></td>
                 </tr>
                </tbody>
              </table>
            </div>
          
        </div>
    </div>
    </div>
<div style=" margin-top: 60px">  
<%@ include file="Footer.jsp" %>
</div>
</div>
</body>
</html>