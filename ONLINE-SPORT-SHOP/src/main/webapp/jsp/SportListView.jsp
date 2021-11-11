
<%@page import="in.co.online.sport.model.ProductModel"%>
<%@page import="in.co.online.sport.controller.SportListCtl"%>
<%@page import="java.util.Iterator"%>
<%@page import="in.co.online.sport.bean.ProductBean"%>
<%@page import="java.util.List"%>
<%@page import="in.co.online.sport.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Product List</title>
</head>
<body>
<div class="site-wrap">
<%@ include file="Header.jsp" %>
<div class="bg-light py-3">
      <div class="container">
        <div class="row">
          <div class="col-md-12 mb-0"> <strong class="text-black">Product List</strong></div>
        </div>
      </div>
    </div>

    <div class="site-section">
    
      <div class="container">
      <form class="col-md-12" action="<%=OSSView.PRODUCT_LIST_CTL%>" method="post">
        <div class="row mb-5">
          
            <div class="site-blocks-table">
            <center><b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
					<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b></center>
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th class="product-thumbnail">Image</th>
                    <th class="product-name">Name</th>
                    <th class="product-price">Category</th>
                     <th class="product-price">Price</th>
                      <th class="product-price">Description</th>
                    <th class="product-remove">Edit</th>
                    <th class="product-remove">Remove</th>
                  </tr>
                </thead>
             
                <tbody>
                
                   <%
							int pageNo=ServletUtility.getPageNo(request);
							int pageSize=ServletUtility.getPageSize(request);
							int index=((pageNo-1)*pageSize)+1;
							List list=ServletUtility.getList(request);
							ProductBean bean=null;
							Iterator<ProductBean> iterator=list.iterator();
							while(iterator.hasNext()){
								 bean=iterator.next();
				%>
                  <tr>
                    <td class="product-thumbnail">
                      <img height="250" width="250"  src="<%=OSSView.APP_CONTEXT%>/images/<%=bean.getImage()%>" alt="Image" class="img-fluid">
                    </td>
                    <td class="product-name">
                      <h2 class="h5 text-black"><%=bean.getName() %></h2>
                    </td>
                    <td><%=bean.getCategoryName()%></td>
                    <td><%=bean.getPrice()%></td>
                    <td><%=bean.getDescription()%></td>
                    <td><a href="ProductCtl?id=<%=bean.getId()%>" class="btn btn-primary btn-sm">Edit</a></td>
                    <td><a href="SportListCtl?faId=<%=bean.getId()%>" class="btn btn-primary btn-sm">X</a></td>
                  </tr>

                 <%} %>
                </tbody>
              </table>
            </div>
          
        </div>

      <div class="row">
          <div class="col-md-6">
            <div class="row mb-5">
            
              <div class="col-md-6 mb-3 mb-md-0">
                <input type="submit" name="operation"
						value="<%=SportListCtl.OP_PREVIOUS%>" class="btn btn-primary btn-sm btn-block" <%=(pageNo==1)? "disabled" : "" %>>
              </div>
              <div class="col-md-6">
               <%ProductModel model=new ProductModel(); %>
               <input type="submit" name="operation"
						value="<%=SportListCtl.OP_NEXT%>" class="btn btn-primary btn-sm btn-block" <%=((list.size()<pageSize)||model.nextPK()-1==bean.getId())? "disabled": "" %>>
              </div>
            </div>
            
          </div>
         <input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
      </div>
      </form>
    </div>
    </div>
<div style=" margin-top: 60px">  
<%@ include file="Footer.jsp" %>
</div>
</div>
</body>
</html>