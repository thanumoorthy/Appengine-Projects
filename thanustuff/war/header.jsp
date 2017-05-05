<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.io.*, com.google.appengine.api.datastore.DatastoreService,
    com.google.appengine.api.datastore.DatastoreServiceFactory,
    com.google.appengine.api.datastore.Entity,
    com.google.appengine.api.datastore.KeyFactory,
    com.google.appengine.api.datastore.Transaction,
    com.google.appengine.api.datastore.PreparedQuery,
    com.google.appengine.api.datastore.Query,
    com.google.appengine.api.datastore.Query.FilterOperator,
    java.util.*"%>
<%-- Initial entity Population --%>

 <%-- <%
    DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
	Entity e1 = new Entity("algorithm",1);
	Entity e2 = new Entity("datastructure",2);
	Entity e3 = new Entity("puzzle",3);
	Entity e4 = new Entity("interview",4);
	Entity e5 = new Entity("os",5);
	Entity e6 = new Entity("cloud",6);
	Entity e7 = new Entity("java",7);
	Entity e8 = new Entity("android",8);
	Entity e9 = new Entity("story",9);
	Entity e10 = new Entity("movie-review",10);	
	Entity e11 = new Entity ("exam",11);
	Entity e12 = new Entity ("Tech Tips",12);
	
	Entity user1 = new Entity("User");
	user1.setProperty("userName", "Bala");
	user1.setProperty("password", "Bala");
	user1.setProperty("role", "admin");
	user1.setProperty("email", "moorthythanu@gmail.com");
		
	Entity user2 = new Entity("User");
	user2.setProperty("userName", "Thanu");
	user2.setProperty("password", "nopainnogain");
	user2.setProperty("role", "admin");
	user2.setProperty("email", "moorthythanu@gmail.com");
	
	List <Entity >  list_entity = Arrays.asList(e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,user1,user2);
	ds.put(list_entity);
	System.out.println("entity has been created");
    
	 %> --%>

		
		
		
	
    
   
     
<%--  <%
    
    DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
	Entity e1 = new Entity("Tech Tips",12);
	ds.put(e1);
	
	
	%>  --%>
 



<%--  <%
    
    DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
	Entity e1 = new Entity("User");
	e1.setProperty("userName", "Bala");
	e1.setProperty("password", "Bala");
	e1.setProperty("role", "admin");
		
	
	
	ds.put(e1);
	System.out.println("entity has been created");
    
    
    
    %> --%>





<%
	//DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
	//Transaction ts = ds.beginTransaction();

	//try {
	//Entity e1 = new Entity("algorithm",1);

	//Long rownum = en.getKey().getId();
	//en.setProperty("rownum", rownum);
	//String sectionName ="Treeupdate";
	//String subsectionName ="Finding greatest number in tree";
	//String content ="<html><head></head>this is finding greating number element</html>";

	//en.setProperty("sectionName", sectionName);
	//en.setProperty("subsectionName", subsectionName);
	//en.setProperty("content", content);
	//en.setProperty ("rownum","" );
	//ds.put(en);
	//ts.commit();
	//System.out.println("entity has been created");

	//} finally {
	/* 	if ( ts.isActive())
			ts.rollback(); */

	//}
%>

<%--   Topic page select query --%>

<%-- <%
    
   
    //Query p = new Query("datastructure WHERE subsectionName = ");
   
    DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
    
    Query   p = new Query("datastructure");
	PreparedQuery pq = ds.prepare(p);
	System.out.println(" ps  " + p);
	for ( Entity e : pq.asIterable()) {
		String sectionName =  e.getProperty("sectionName").toString();
		if ( !sectionName.equals("") ) {
		
		//Map<String,Object> mapname  = e.getProperties();
		//String subsectionName  = e.getProperty("subsectionName").toString();
		Query q = new Query("datastructure").addFilter("sectionName", FilterOperator.EQUAL, sectionName);
		PreparedQuery pqcount = ds.prepare(q);
		int  totalCount  =  pqcount.countEntities();
		totalCount --;
		
		Long idNum  =  e.getKey().getId();
		
		System.out.println("Entity value is are ");
		System.out.println(" sectionName " + sectionName  + " Total posts " +  totalCount  + " ID " + idNum );
		}
		
	}
    
    
    %>  --%>


<%-- <%
    
    DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
	Transaction ts = ds.beginTransaction();

	try {
		Entity e1 = new Entity("datastructure");
		
		//Long rownum = en.getKey().getId();
		//en.setProperty("rownum", rownum);
		String sectionName ="Arrays";
		String subsectionName ="";
		
		//String content ="<html><head></head>this is game one</html>";		
		 e1.setProperty("sectionName", sectionName);
		e1.setProperty("subsectionName", subsectionName);
	//	e1.setProperty("content", content);
		//en.setProperty ("rownum","" );
		ds.put(e1);
		ts.commit();
		System.out.println("entity has been created");
		
		
		
	} finally {
	 	if ( ts.isActive())
			ts.rollback(); 

	}
    
    
    %>     --%>


<%-- subtopic page select query  --%>
<%--   <%
    
   
    //Query p = new Query("datastructure WHERE subsectionName = ");
   
    DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
    
    Query   p = new Query("datastructure").addFilter("sectionName", FilterOperator.EQUAL, "ArrayList");
	PreparedQuery pq = ds.prepare(p);
	//System.out.println(" ps  " + p);
	int i = 0;
	for ( Entity e : pq.asIterable()) {
		String sectionName =  e.getProperty("sectionName").toString();
	    String subsectionName = e.getProperty("subsectionName").toString();
	    Long rownum  = e.getKey().getId();
	   // System.out.println(" sectionName " + sectionName  +  "SubsectionName " + subsectionName + " rownumber  " + rownum );
	    if ( !subsectionName.equals("") ) {
	    	System.out.println("Entity value is are ");
	    	i++;
			System.out.println(" sectionName " + sectionName  +  " SubsectionName " + subsectionName + " rownumber  " + rownum );
	    	
	    }
}
	System.out.println("Total posts are " + i);
    
    
    %> 
 --%>








<%--  Updating the entity value  --%>
<%--   <%
    
    DatastoreService update = DatastoreServiceFactory.getDatastoreService();
    Query   qupdate = new Query("datastructure").addFilter("sectionName", FilterOperator.EQUAL, "Array");
	PreparedQuery pqupdate = update.prepare(qupdate);
	Entity updateEntity;
	for ( Entity enupdate : pqupdate.asIterable()) {
		
		String newsectionName = "ArrayList";
		Long idNum  =  enupdate.getKey().getId();
		updateEntity  = update.get(KeyFactory.createKey("datastructure",idNum));	
		updateEntity.setProperty("sectionName", newsectionName);
		update.put(updateEntity);
		
		System.out.println("Entity value is are ");
		//System.out.println(" sectionName " + sectionName  + " Total posts " +  totalCount  + " ID " + idNum );
		
	}
    
    
    
    %>  --%>

<%-- updating single record -- content record -- we know the Id number --%>

<%--  <%
    
    DatastoreService update = DatastoreServiceFactory.getDatastoreService();    
    Entity updateEntity;
	updateEntity  = update.get(KeyFactory.createKey("datastructure",10));
	String newsubsectionName = " 	Finding greatest number in Binary tree";
	updateEntity.setProperty("subsectionName", newsubsectionName);
	update.put(updateEntity);

    %>  
 --%>





<%-- Deleting multiple entity --%>


<%--   <%
    
    DatastoreService dsdelete = DatastoreServiceFactory.getDatastoreService();
    Query   qdelete = new Query("datastructure").addFilter("sectionName", FilterOperator.EQUAL, "ArrayList");
	PreparedQuery pqdelete = dsdelete.prepare(qdelete);
	Entity deleteEntity;
	for ( Entity endelete : pqdelete.asIterable()) {
		
		Long idNum  =  endelete.getKey().getId();		
		dsdelete.delete(KeyFactory.createKey("datastructure",idNum));
		
		/* updateEntity  = update.get(KeyFactory.createKey("datastructure",idNum));	
		updateEntity.setProperty("sectionName", newsectionName);
		update.put(updateEntity); */
		
		System.out.println("Entity has been delete successfully ");
		//System.out.println(" sectionName " + sectionName  + " Total posts " +  totalCount  + " ID " + idNum );
		
	}
    
    
    
    %>  
     --%>



<%-- Deleting an single entity  --%>
<%-- 
      <%
    
    DatastoreService delete = DatastoreServiceFactory.getDatastoreService();    
    Entity deleteEntity;
    //deleteEntity  = delete.get(KeyFactory.createKey("datastructure",3));
	delete.delete(KeyFactory.createKey("datastructure",10));
	

    %>  --%>








<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ThanuStuff</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<style>
</style>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css" />
</head>
<body>

	<div class="bs-component">
		<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="home.jsp">ThanuStuff</a>
			</div>

			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-2">
				<ul class="nav navbar-nav">
					<!-- <li class="active"><a href="home.jsp">Home <span
							class="sr-only">(current)</span></a></li> -->
					<li><a href="topic.jsp?pname=puzzle">Puzzle</a></li>
					<li><a href="topic.jsp?pname=algorithm">Algorithm</a></li>
					<li><a href="topic.jsp?pname=datastructure">Data structure</a></li>
					<li><a href="topic.jsp?pname=interview">Interview</a></li>
					<li><a href="topic.jsp?pname=os">OS</a></li>
					<li><a href="topic.jsp?pname=cloud">Cloud</a></li>
					<li><a href="topic.jsp?pname=java">Java</a></li>
					<li><a href="topic.jsp?pname=android">Android</a></li>
					<li><a href="topic.jsp?pname=story">Story</a></li>
					<li><a href="topic.jsp?pname=movie-review">Review</a></li>
					<li><a href="topic.jsp?pname=exam">Exam</a></li>
					<li><a href="topic.jsp?pname=Tech Tips">Tech Tips</a></li>
					<!-- <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Dropdown <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Action</a></li>
                          <li><a href="#">Another action</a></li>
                          <li><a href="#">Something else here</a></li>
                          <li class="divider"></li>
                          <li><a href="#">Separated link</a></li>
                          <li class="divider"></li>
                          <li><a href="#">One more separated link</a></li>
                        </ul>
                      </li> -->
				

				<%   if ( session.getAttribute("userName") != null  ) {
							//System.out.println("user name is " +session.getAttribute("userName") );
					%>
				
				<li><a href="admin.jsp">Welcome! &nbsp;   <%= session.getAttribute("userName") %></a></li>
				
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"  data-toggle="modal" data-target="#logoutModal"
						data-whatever="logout name"><span
							class="glyphicon glyphicon-log-out" > Signout</span></a></li>
				</ul>
				
				
				<% } else {%>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#" data-toggle="modal" data-target="#loginModal"
						data-whatever="Login name"><span
							class="glyphicon glyphicon-log-in"> SignIn</span></a></li>
				</ul>
				<% } %>
			</div>
		</div>
		</nav>

	</div>
	
	
	



<script>

 $(document).ready(function () {
    $("#submit").click(function(){
    	//alert(" i am submitting form");
    	var $btn = $(this);
    $btn.button('loading');
    // simulating a timeout
    
    	
        $.ajax({
            type: "POST",
            url: "/thanustuff", //process to mail
            data: {
            	userName: $('#userName').val(),
		        password: $('#password').val()
            },
            success: function(msg){
            	//alert("success");
            	var returnMessage = msg.toString();
             	if ( returnMessage.search("success") != -1) {
        			    		//alert("login success" + data + " status " + status);
        			  $btn.button('reset');
        			   $("#loginModal").modal('hide');
        			   location.reload();
        			   // $("#message").html(msg);
        			    		
        		}
            	else  {
             	$btn.button('reset');
             	$("#message").html(msg) //hide button and show thank you
               // $("#loginModal").modal('hide'); //hide popup 
               
            }
            },
            error: function(){
                alert("failure");
            }
        });
    });
    
   
/*     $("#logoffbutton").click(function(){
    	
    	
    	  
    	  $("#logoutModal").modal('hide');
    	  location.reload();
    	
    }); */
    $('#loginModal').on('shown.bs.modal', function () {
	    $('#userName').focus();
	}) ;
    
    
}); 
 
    
    /* $(document).ready(function () {
        $("#submit").click(function(){
        	//alert(" i am submitting form" + $('#userName').val());
        	
        	 $.post("/thanustuff",
        			    {
        			        userName: $('#userName').val(),
        			        password: $('#password').val()
        			    },
        			    function(data, status){
        			    	
        			    	if ( data = "login success") {
        			    		//alert("login success" + data + " status " + status);
        			    		$("#loginModal").modal('hide');
        			    		location.reload();
        			    		
        			    	}
        			    	else {
        			    		$("#message").html(data);
        			    	}
        			       // alert("Data: " + data + "\nStatus: " + status);
        			    	//$("#loginModal").modal('hide');
        			    });
        	
        });
    }); */
    
    
    
    
    
  
</script>

	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">Login Window</h4>
				</div>
				<form name="login" id="login" method="post" action="/thanustuff">
					<div class="modal-body">

						<div class="form-group">
							<label for="userName" class="control-label">User Name: </label> <input
								type="text" class="form-control" id="userName" name="userName"
								placeholder="Enter User name" name="userName">
						</div>

						<div class="form-group">
							<label for="recipient-name" class="control-label">Password:
							</label> <input type="password" class="form-control" id="password" name="password"
								placeholder="Enter password" name="password">
						</div>
						<!--  <div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div> -->
					  <p class="text-danger" id="message" name="message"></p>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-success" id="submit" name="submit" data-loading-text="Loading...">Sign In</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	
	
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
	aria-labelledby="logoutModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">
					Logout Box
				</h4>
			</div>
			<form method="post" action="subtopic.jsp?action=deletePostContent">
				<div class="modal-body">

					<div class="form-group">
						<label for="recipient-name" class="control-label">Are you sure you wants to signout?
							
							</label> 
						
						
							
												</div>
					

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success"  data-dismiss="modal">NO</button>
					<a href="logoff.jsp" id="logoffbutton"  name="logoffbutton" class="btn btn-danger">YES</a>
				</div>
			</form>
		</div>
	</div>
</div>