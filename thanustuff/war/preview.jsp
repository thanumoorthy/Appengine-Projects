<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import=" java.text.SimpleDateFormat,
    java.text.DateFormat,java.util.*"   
    
    
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="header.jsp" />
<script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js"></script>
<%
	String topicName = "";
	String sectionName = "";
	String subsectionName = "";
	//String topicName ="";  
	String action = "";


	
	//Getting topic Name
	if (request.getParameter("pname") != null) {
		topicName = request.getParameter("pname");
		session.setAttribute("pname", topicName);
		//  System.out.println("page name is " + request. getParameter("pname"));
	} else if (session.getAttribute("pname") != null) {

		topicName = (String) session.getAttribute("pname");

	}

	//Getting Section Name
	if (request.getParameter("sectionName") != null) {
		sectionName = request.getParameter("sectionName");
		session.setAttribute("sectionName", sectionName);

		//  System.out.println("page name is " + request. getParameter("pname"));
	} else if (session.getAttribute("sectionName") != null) {

		sectionName = (String) session.getAttribute("sectionName");

	}

	
	//Getting subsection Name
	if (request.getParameter("subsectionName") != null) {
		subsectionName = request.getParameter("subsectionName");
		session.setAttribute("subsectionName", subsectionName);
		//  System.out.println("page name is " + request. getParameter("pname"));
	} else if (session.getAttribute("subsectionName") != null) {

		subsectionName = (String) session
				.getAttribute("subsectionName");
		//System.out.println("getting topic name &  section name & subsection name  " + topicName + " " + sectionName + " " +subsectionName);

	}
%>



<ul class="breadcrumb">
	<li><a href="home.jsp">Home</a> <span class="divider">/</span></li>
	<li><a href="topic.jsp?pname=<%=topicName%>"><%=topicName%> </a> <span
		class="divider">/</span></li>
	<li><a href="subtopic.jsp?pname=<%=topicName%>"><%=sectionName%>
	</a> <span class="divider">/</span></li>
	<li class="Active"><%=subsectionName%></li>
</ul>


<div class="row">
	<div class="col-lg-4"></div>

	<div class="col-lg-4">
		<div class="alert alert-success alert-dismissable">
			<button type="button" class="close" data-dismiss="alert"
				aria-hidden="true">&times;</button>
			Preview Post
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col-md-12">
		<div class="well bs-component">
			<section>

				<h4 class="text-info" align="center"><%= request.getParameter("subsection")%></h4>
				<%
				DateFormat dateFormat1 = new SimpleDateFormat("EEEE, MMMM d, yyyy");
				Date date1 = new Date();
				//System.out.println("current date is " + dateFormat1.format(date1)); 
				%>
				<span align="left" class="text-info"> <span class="text-success"><b> Post on:</b> </span>&nbsp;<%= dateFormat1.format(date1) %></span><br>
				<span  class="text-info"> <span class="text-success"> <b>Post By:</b> </span>&nbsp;<%= session.getAttribute("userName") %></span>
				
				<div class="hero-unit">
					<p class="font-size:10px"></p>
					<%  if ( request.getParameter("content") != null ) { %>
                      <%= request.getParameter("content") %> 
				<% } %>
				</div>
			</section>
			</div>
		</div>
	</div>
</div>


<jsp:include page="footer.jsp" />
