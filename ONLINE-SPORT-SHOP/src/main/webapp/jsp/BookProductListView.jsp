
<%@page import="in.co.online.sport.model.BookProductModel"%>
<%@page import="in.co.online.sport.controller.BookProductListCtl"%>
<%@page import="in.co.online.sport.util.DataUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="in.co.online.sport.bean.BookProductBean"%>
<%@page import="java.util.List"%>
<%@page import="in.co.online.sport.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Book Product</title>
</head>
<body>
<div class="site-wrap">
<%@ include file="Header.jsp" %>
<div class="bg-light py-3">
      <div class="container">
        <div class="row">
          <div class="col-md-12 mb-0"> <strong class="text-black">Book Product</strong></div>
        </div>
      </div>
    </div>

    <div class="site-section">
    
      <div class="container">
      <form class="col-md-12" action="<%=OSSView.SPORT_LIST_VIEW%>" method="post">
        <div class="row mb-5">
          
            <div class="site-blocks-table">
            <center><b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
					<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b></center>
              <table class="table table-bordered">
                <thead>
                  <tr>
                    
                    <th class="product-name">Product Name</th>
                    <th class="product-price">User Name</th>
                    <th class="product-price">Email</th>
                    <th class="product-price">Mobile No</th>
                    <th class="product-price">Date</th>
                    <th class="product-remove">PinCode</th>
                    <th class="product-remove">Address</th>
                    <th class="product-remove">Price</th>
                    <th class="product-remove">Final Amount</th>
                  </tr>
                </thead>
             
                <tbody>
                
                   <%
							int pageNo=ServletUtility.getPageNo(request);
							int pageSize=ServletUtility.getPageSize(request);
							int index=((pageNo-1)*pageSize)+1;
							List list=ServletUtility.getList(request);
							BookProductBean bean=null;
							Iterator<BookProductBean> iterator=list.iterator();
							while(iterator.hasNext()){
								 bean=iterator.next();
				%>
                  <tr>
                    
                    <td class="product-name">
                      <h2 class="h5 text-black"><%=bean.getProductName()%></h2>
                    </td>
                    <td><%=bean.getName()%></td>
                    <td><%=bean.getEmailId()%></td>
                    <td><%=bean.getMobileNo()%></td>
                    <td><%=DataUtility.getDateString(bean.getDate())%></td>
                     <td><%=bean.getPinCode()%></td>
                      <td><%=bean.getAddress()%></td>
                       <td><%=bean.getPrice()%></td>
                        <td><%=bean.getPrice()%></td>
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
						value="<%=BookProductListCtl.OP_PREVIOUS%>" class="btn btn-primary btn-sm btn-block" <%=(pageNo==1)? "disabled" : "" %>>
              </div>
              <div class="col-md-6">
               <%BookProductModel model=new BookProductModel(); %>
               <input type="submit" name="operation"
						value="<%=BookProductListCtl.OP_NEXT%>" class="btn btn-primary btn-sm btn-block" <%=((list.size()<pageSize)||model.nextPK()-1==bean.getId())? "disabled": "" %>>
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