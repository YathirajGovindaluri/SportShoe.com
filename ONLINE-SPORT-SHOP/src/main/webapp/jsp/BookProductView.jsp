
<%@page import="java.util.Iterator"%>
<%@page import="in.co.online.sport.controller.BookProductCtl"%>
<%@page import="in.co.online.sport.util.ServletUtility"%>
<%@page import="in.co.online.sport.util.DataUtility"%>
<%@page import="in.co.online.sport.bean.ProductBean"%>
<%@page import="in.co.online.sport.model.ProductModel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Book</title>
</head>
<body>
<div class="site-wrap">
<%@ include file="Header.jsp" %>


<form action="<%=OSSView.BOOK_PRODUCT_CTL%>" method="post" >
      <div class="container">
      
      		
        <div class="row mb-5">
          
            <div class="site-blocks-table">
            <center><b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
					<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b></center>
              <table class="table table-bordered" width="100%">
                <thead>
                  <tr>
                    <th class="product-thumbnail">Image</th>
                    <th class="product-name">Name</th>
                    <th class="product-price">Price</th>
                    <th class="product-remove">Description</th>
                    <th class="product-remove">Remove</th>
                  </tr>
                </thead>
             
                <tbody>
                
                   <%
							
							List list=ServletUtility.getList(request);
							CartBean ctbean=null;
							Iterator<CartBean> iterator=list.iterator();
							long totalprice=0;
							while(iterator.hasNext()){
								 ctbean=iterator.next();
								 
								 ProductModel cModel=new ProductModel();
								 ProductBean cBean=cModel.findByPK(ctbean.getProductId());
				%>
                  <tr>
                    <td class="product-thumbnail">
                      <img width="100px" height="100px"     src="<%=OSSView.APP_CONTEXT%>/images/<%=cBean.getImage()%>" alt="Image" class="img-fluid">
                    </td>
                    <td class="product-name">
                      <h2 class="h5 text-black"><%=cBean.getName() %></h2>
                    </td>
                   <%  totalprice =totalprice+cBean.getPrice();%>
                    <td><%=cBean.getPrice()%></td>
                    <td><%=cBean.getDescription()%></td>
                    <td><a href="CartListCtl?crId=<%=ctbean.getId()%>" class="btn btn-primary btn-sm">X</a></td>
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
      
       
       
      	<% String msg=null;%>
        <%if(msg==null && userBean.getRoleId()==2 ){ %>
        <div class="row">
          <div class="col-md-12">
            <h2 class="h3 mb-3 text-black">Fill And Book</h2>
            
          </div>
          <div class="col-md-7">
			
            
            
            <jsp:useBean id="bean" class="in.co.online.sport.bean.BookProductBean"
			scope="request"></jsp:useBean>
			
			
			<input type="hidden" name="id" value="<%=bean.getId()%>"> <input
				type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
			<input type="hidden" name="modifiedBy"
				value="<%=bean.getModifiedBy()%>"> <input type="hidden"
				name="createdDatetime"
				value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
			<input type="hidden" name="modifiedDatetime"
				value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">
              
              <div class="p-3 p-lg-5 border">
               <center><b><font color="red"> <%=ServletUtility.getErrorMessage(request)%></font></b>
               <b><font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font></b>
               </center>
               
               
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="c_email" class="text-black">Email Id<span class="text-danger">*</span></label>
                    <input type="text" class="form-control"  name="email" placeholder="Enter Email Id" 
                    value="<%=DataUtility.getStringData(bean.getEmailId())%>" >
                    <font color="red"> <%=ServletUtility.getErrorMessage("email", request)%></font>
                  </div>
                </div>
                
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="c_email" class="text-black">PinCode<span class="text-danger">*</span></label>
                    <input type="text" class="form-control"  name="pinCode" placeholder="Enter Pin Code" 
                    value="<%=DataUtility.getStringData(bean.getPinCode())%>" >
                    <font color="red"> <%=ServletUtility.getErrorMessage("pinCode", request)%></font>
                  </div>
                </div>
                <div class="form-group row">
                  <div class="col-md-12">
                    <label for="c_email" class="text-black">LandMark<span class="text-danger">*</span></label>
                    <input type="text" class="form-control"  name="land" placeholder="Enter Land Mark" 
                    value="<%=DataUtility.getStringData(bean.getLandMark())%>" >
                    <font color="red"> <%=ServletUtility.getErrorMessage("land", request)%></font>
                  </div>
                </div>
               
                 
                
               
				<div class="form-group row">
                  <div class="col-md-12">
                    <label for="c_message" class="text-black">Address</label>
                    <textarea name="address"  cols="30" rows="4" class="form-control"><%=DataUtility.getStringData(bean.getAddress())%></textarea>
                 <font color="red"> <%=ServletUtility.getErrorMessage("address", request)%></font>
                  </div>
                </div>

                
                <div class="form-group row">
                  <div class="col-lg-6">
                    <input type="submit" class="btn btn-primary btn-lg btn-block" name="operation" value="<%=BookProductCtl.OP_CONFIRM_PAY%>">
                  </div>
                  <div class="col-lg-6">
                    <input type="submit" class="btn btn-primary btn-lg btn-block" name="operation" value="<%=BookProductCtl.OP_CANCEL%>">
                  </div>
                </div>
              </div>
          
          </div>
           <%} %>
 </div>
       
      </div>
    </div>
  </form>
  
  
<div style="margin-top: 20px">
<%@ include file="Footer.jsp" %>
</div>
</div>
</body>
</html>