
<%@page import="in.co.online.sport.bean.CartBean"%>
<%@page import="in.co.online.sport.model.CartModel"%>
<%@page import="java.util.List"%>
<%@page import="in.co.online.sport.controller.LoginCtl"%>
<%@page import="in.co.online.sport.controller.OSSView"%>
<%@page import="in.co.online.sport.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
   <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Mukta:300,400,700"> 
<link rel="stylesheet" href="/ONLINE-SPORT-SHOP/fonts/icomoon/style.css">

    <link rel="stylesheet" href="/ONLINE-SPORT-SHOP/css/bootstrap.min.css">
    <link rel="stylesheet" href="/ONLINE-SPORT-SHOP/css/magnific-popup.css">
    <link rel="stylesheet" href="/ONLINE-SPORT-SHOP/css/jquery-ui.css">
    <link rel="stylesheet" href="/ONLINE-SPORT-SHOP/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/ONLINE-SPORT-SHOP/css/owl.theme.default.min.css">


    <link rel="stylesheet" href="/ONLINE-SPORT-SHOP/css/aos.css">

    <link rel="stylesheet" href="/ONLINE-SPORT-SHOP/css/style.css">
    
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#datepicker" ).datepicker({
      changeMonth: true,
      changeYear: true
    });
  } );
  </script>	
    
</head>
<body>

<%
    UserBean userBean = (UserBean) session.getAttribute("user");

    boolean userLoggedIn = userBean != null;

    String welcomeMsg = "Hi, ";

    if (userLoggedIn) {
        String role = (String) session.getAttribute("role");
        welcomeMsg += userBean.getFirstName() + " (" + role + ")";
    } else {
        welcomeMsg += "Guest";
    }

%>
   <header class="site-navbar" role="banner">
      <div class="site-navbar-top">
        <div class="container">
          <div class="row align-items-center">

            <div class="col-6 col-md-4 order-2 order-md-1 site-search-icon text-left">
            
            </div>

            <div class="col-12 mb-3 mb-md-0 col-md-4 order-1 order-md-2 text-center">
              <div class="site-logo">
                <a href="<%=OSSView.INDEX_CTL%>" class="js-logo-clone">ONLINE-SPORT-SHOP</a>
              </div>
            </div>

            <div class="col-6 col-md-4 order-3 order-md-3 text-right">
              <div class="site-top-icons">
                <ul>
                <%if(userLoggedIn){ %>
                 
               	<%if(userBean.getRoleId()==2){ %>
                  <li>
                    <a href="<%=OSSView.CART_LIST_CTL%>" class="site-cart">
                    	<% CartBean carBean=new CartBean();
                    		carBean.setUserId(userBean.getId());
                    		List cList=new CartModel().search(carBean);%>
                      <span class="icon icon-shopping_cart">Cart(<%=cList.size()%>)</span>  
                    </a>
                  </li> 
                  <%} %>
                   <li><a href="<%=OSSView.LOGIN_CTL%>?operation=<%=LoginCtl.OP_LOG_OUT%>"><span class="glyphicon glyphicon-log-out"></span>LogOut</a></li>
                  <%}else{%>
                  <li><a href="<%=OSSView.LOGIN_CTL%>"><span class="glyphicon glyphicon-log-in"></span>SignIn</a></li>
                  <%} %>
                  <li class="d-inline-block d-md-none ml-md-0"><a href="#" class="site-menu-toggle js-menu-toggle"><span class="icon-menu"></span></a></li>
                </ul>
              </div> 
            </div>

          </div>
        </div>
      </div> 
      <nav class="site-navigation text-right text-md-center" role="navigation">
        <div class="container">
          <ul class="site-menu js-clone-nav d-none d-md-block">
         
           <%if(userLoggedIn){ %>
           
           <%if(userBean.getRoleId()==1){ %>
            
           	<li><a href="<%=OSSView.WELCOME_CTL%>">Home</a></li>
             <li><a href="<%=OSSView.CATEGORY_CTL%>">Add Category</a></li>
             <li><a href="<%=OSSView.CATEGORY_LIST_CTL%>">Category List</a></li>
              <li><a href="<%=OSSView.PRODUCT_CTL%>">Add Product</a></li>
              <li><a href="<%=OSSView.SPORT_LIST_CTL%>">Product List</a></li>
             <li><a href="<%=OSSView.BOOK_PRODUCT_LIST_CTL%>">Booked List</a></li>
              
            <%}else{ %>
            <li><a href="<%=OSSView.WELCOME_CTL%>">Home</a></li>
            <li><a href="<%=OSSView.PRODUCT_LIST_CTL%>">Shop</a></li>
            <li><a href="<%=OSSView.BOOK_PRODUCT_LIST_CTL%>">Book Product</a></li>
            <%} %>
            <%}%>
            
           
          </ul>
        </div>
      </nav>
    </header>
</body>
</html>