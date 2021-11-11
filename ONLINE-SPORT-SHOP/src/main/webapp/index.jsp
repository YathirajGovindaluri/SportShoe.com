<%@page import="in.co.online.sport.bean.ProductBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="in.co.online.sport.bean.CategoryBean"%>
<%@page import="in.co.online.sport.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Online Sport Store</title>

 
</head>
<body>
<div class="site-wrap">
 
<%@ include file="jsp/Header.jsp" %>
    <div class="site-blocks-cover" style="background-image: url(images/hero_1.jpg);" data-aos="fade">
      <div class="container">
        <div class="row align-items-start align-items-md-center justify-content-end">
          <div class="col-md-5 text-center text-md-left pt-5 pt-md-0">
            <h1 class="mb-2">Online Sports Shop</h1>
     
          </div>
        </div>
      </div>
    </div>

    <div class="site-section site-section-sm site-blocks-1">
      <div class="container">
        <div class="row">
          <div class="col-md-6 col-lg-4 d-lg-flex mb-4 mb-lg-0 pl-4" data-aos="fade-up" data-aos-delay="">
            <div class="icon mr-4 align-self-start">
              <span class="icon-truck"></span>
            </div>
            <div class="text">
              <h2 class="text-uppercase">Free Shipping</h2>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus at iaculis quam. Integer accumsan tincidunt fringilla.</p>
            </div>
          </div>
          <div class="col-md-6 col-lg-4 d-lg-flex mb-4 mb-lg-0 pl-4" data-aos="fade-up" data-aos-delay="100">
            <div class="icon mr-4 align-self-start">
              <span class="icon-refresh2"></span>
            </div>
            <div class="text">
              <h2 class="text-uppercase">Free Returns</h2>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus at iaculis quam. Integer accumsan tincidunt fringilla.</p>
            </div>
          </div>
          <div class="col-md-6 col-lg-4 d-lg-flex mb-4 mb-lg-0 pl-4" data-aos="fade-up" data-aos-delay="200">
            <div class="icon mr-4 align-self-start">
              <span class="icon-help"></span>
            </div>
            <div class="text">
              <h2 class="text-uppercase">Customer Support</h2>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus at iaculis quam. Integer accumsan tincidunt fringilla.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
     
    <div class="site-section site-blocks-2">
      <div class="container">
      <h2>Product Categories</h2>
        <div class="row">
        
         
         <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;
                    CategoryBean bean=null;
                    List list = ServletUtility.getList(request);
                    Iterator<CategoryBean> it = list.iterator();

                    while (it.hasNext()) {

                         bean = it.next();
                %>
          <div class="col-sm-6 col-md-6 col-lg-4 mb-4 mb-lg-0" data-aos="fade" data-aos-delay="">
            <a class="block-2-item" href="<%=OSSView.PRODUCT_LIST_CTL%>?catg=<%=bean.getId()%>">
              <figure class="image">
                <img width="340px" height="300px" src="<%=OSSView.APP_CONTEXT%>/images/<%=bean.getImage()%>" alt="" class="img-fluid">
              </figure>
              <div class="text">
                <span class="text-uppercase">Collections</span>
                <h3><%=bean.getName()%></h3>
              </div>
            </a>
          </div>
          <%} %>
          
        </div>
      </div>
    </div>

    <div class="site-section block-3 site-blocks-2 bg-light">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-md-7 site-section-heading text-center pt-4">
            <h2>Featured Products</h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="nonloop-block-3 owl-carousel">
            <%
                  
                    ProductBean pBean=null;
                    List pList = (List)request.getAttribute("pList");
                    Iterator<ProductBean> pIt = pList.iterator();

                    while (pIt.hasNext()) {

                         pBean = pIt.next();
                %>
            
              <div class="item">
                <div class="block-4 text-center">
                <a class="block-2-item" href="<%=OSSView.LOGIN_CTL%>?cId=<%=pBean.getId()%>">
                  <figure class="block-4-image">
                    <img width="340px" height="380px" src="<%=OSSView.APP_CONTEXT%>/images/<%=pBean.getImage()%>" alt="Image placeholder" class="img-fluid">
                  </figure>
                  <div class="block-4-text p-4">
                    <h2><a href="<%=OSSView.LOGIN_CTL%>?cId=<%=pBean.getId()%>"><%=pBean.getName() %></a></h2>
                    <p class="mb-0"><%=pBean.getDescription()%></p>
                    <p class="text-primary font-weight-bold">$ <%=pBean.getPrice()%></p>
                  </div>
                  </a>
                </div>
              </div>
              
             <%} %>
             
              
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    

   
<%@ include file="jsp/Footer.jsp" %>
</div>
  
</body>
</html>