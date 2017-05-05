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
    com.google.appengine.api.datastore.Text,
    java.text.SimpleDateFormat,
    java.text.DateFormat,
    java.util.*"%>

<jsp:include page="header.jsp" />

<script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js"></script>


<%
	String topicName = "";
	String sectionName = "";
	String subsectionName = "";
	String postby ="";
	//String topicName ="";  
	String action = "";
	Boolean alertBoxAddEnable = false;

	DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
	PreparedQuery pq = null;
	Query p = null;

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

	if ( session.getAttribute("userName") != null ) {
	if (request.getParameter("action") != null) {

		action = request.getParameter("action");
		if (action.equals("editPost")) {
			Long recordIdValue =  null;
			DateFormat dateFormat = new SimpleDateFormat("EEEE, MMMM d, yyyy");
	    	Date date = new Date();
			//if ( request.getParameter("postheading") != null &&  request.getParameter("recordId") != null) {
			recordIdValue = Long.parseLong(request
						.getParameter("recordId"));
			subsectionName = request.getParameter("postHeading");
			
			Entity updateEntity = ds.get(KeyFactory.createKey(
					topicName, recordIdValue));
			updateEntity.setProperty("sectionName", sectionName);
			updateEntity.setProperty("subsectionName", subsectionName);
			updateEntity.setProperty("content",
					new Text(request.getParameter("message-text")));
			updateEntity.setProperty("postDate", dateFormat.format(date));
			updateEntity.setProperty("postby", session.getAttribute("userName"));
			ds.put(updateEntity);
			session.setAttribute("subsectionName", subsectionName);
			
			//}
			

			/* Transaction ts = ds.beginTransaction();
			
			try { */
			
			/* ts.commit();
			
			
			} finally {
			if ( ts.isActive())
				ts.rollback(); 

			}  */

			alertBoxAddEnable = true;

		}
		
		%>


<script>
window.open("detail.jsp", "_self");
</script>
		<% }
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
	<%-- <li class="Active"><%=subsectionName%></li> --%>
</ul>


<% if ( session.getAttribute("userName") != null ) { %>
<div align="right">

	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target="#exampleModal" data-whatever="Topic Name">Edit
		Post</button>
	<button type="button" class="btn btn-warning" data-toggle="modal"
		data-target="#removeModal" data-whatever="Delete topic Name">Delete
		Post</button>


</div>


<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">
					Edit Post's on
					<%=sectionName%>
				</h4>
			</div>
			<form method="post" action="detail.jsp?action=editPost">
				<div class="modal-body">

					<div class="form-group">
						<label for="recipient-name" class="control-label">Post
							Heading </label> <input type="text" class="form-control" id="postHeading"
							name="postHeading" value="<%=subsectionName%>">
					</div>
					<div class="form-group">
						<label for="message-text" class="control-label">Content (
							HTML Format)</label>
						<%
							p = new Query(topicName).addFilter("subsectionName",
									FilterOperator.EQUAL, subsectionName);
							//System.out.println(" i am before exceptin ");
							pq = ds.prepare(p);
							Text tx = null;
							Long id = null;
							//System.out.println(" i am before exceptin 2 " + pq);
							
								
									//System.out.println(" i am before exceptin 3 " + pq.asIterable());
									for (Entity e : pq.asIterable()) {
										//System.out.println(" i am before exceptin 3 ");
										id = e.getKey().getId();
										//  System.out.println(" i am before exceptin 4 ");
										tx = (Text) e.getProperty("content");
										// System.out.println(" i am before exceptin 5 ");

									}
								
						
								
						%>
						<textarea class="form-control" id="message-text" rows="12"
							name="message-text" id="message-text"><%=tx.getValue()%></textarea>
					</div>

					<input type="hidden" name="recordId" name="recordId"
						value="<%=id%>">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" name="preview" id="preview" class="btn btn-info" >Preview</a>
					<button type="submit" class="btn btn-success">Save</button>
				</div>
			</form>
		</div>
	</div>
</div>


<div class="modal fade" id="removeModal" tabindex="-1" role="dialog"
	aria-labelledby="removeModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">
					Delete Post 
					<%=sectionName%>
				</h4>
			</div>
			<form method="post" action="subtopic.jsp?action=deletePostContent">
				<div class="modal-body">

					<div class="form-group">
						<label for="recipient-name" class="control-label">Are you sure you wants to Delete this post?
							
							</label> 
						<br/> <%=subsectionName%>
						<input type="hidden" name="recordId" name="recordId"
						value="<%=id%>">
							
												</div>
					<!--  <div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div> -->

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" data-dismiss="modal">NO</button>
					<button type="submit" class="btn btn-danger">YES</button>
				</div>
			</form>
		</div>
	</div>
</div>

<%  } %>

<%
	if (alertBoxAddEnable) {
%>
<div class="row">
	<div class="col-lg-4"></div>

	<div class="col-lg-4">
		<div class="alert alert-success alert-dismissable">
			<button type="button" class="close" data-dismiss="alert"
				aria-hidden="true">&times;</button>
			Success! Post has been Edited.
		</div>
	</div>
</div>
<%
	}
%>






<%
	p = new Query(topicName).addFilter("subsectionName",
			FilterOperator.EQUAL, subsectionName);
	pq = ds.prepare(p);
	//System.out.println(" ps  " + p);

	for (Entity e : pq.asIterable()) {

		// content = e.getProperty("content").toString();

		//if (!content.equals("")) {
		Text ob;
		ob = (Text) e.getProperty("content");
		String postDate = e.getProperty("postDate").toString();
		postby  = e.getProperty("postby").toString();
%>

<br/>

<div class="container">
	<div class="row">
	
		<div class="col-md-12">
			<div class="well bs-component">
			<section>

				<h4 class="text-info" align="center"><%=subsectionName%></h4>
				<span align="left" class="text-info"> <span class="text-success"> <b>Post on:</b> </span>&nbsp;<%= postDate %></span><br>
				<span  class="text-info"> <span class="text-success"> <b>Post By:</b> </span>&nbsp;<%= postby %></span>
				<div class="hero-unit">
					<p class="font-size:10px"></p>
					<%=ob.getValue()%>


				</div>
			</section>
		</div>
	</div>
</div>
</div>

<%
	//}
	}
%>








<!-- <b> Why Perform Analyze ?</b>
if we are developing Application, there are many things needs to
consider, like user friendliness, modularity, maintainability, security.
Why to worry about performance? Answer is so simple. we can have all
other things only we can have performance. So, Performance is like a
currency which we can buy all above things.

<b>Given two algorithm, how we can find out which one is better than
	other one ? </b>
One native way of doing this is , implement two algorithm and run it on
our machine for different inputs, and we can see which one is take less
time to run. But there are many problems will arise in this approach for
analyzing the algorithm.
<ul>
	<li>It might be possible that, first algorithm performs better for
		some inputs, second algorithm performs better for some other inputs</li>
	<li>it might be also possible that, first algorithm performs
		better for some other machine, second algorithm performs better for
		some machine for some other inputs.</li>
</ul>

Asymptotic Analyze is a big idea to handle the above issue for analyze
the algorithm. In the Asymptotic analyze, we evaluate the performance of
algorithm, base on Input Size. So, we don't measure the actual running
time of algorithm. so, we calculate the time and space taken by the
algorithm with the input size. For Example, Let us consider the search
problem in sorted array, One way of search is linear search ( order of
growth is linear ) and other way of search is binary search ( Order of
growth is Logarithms. Let us say, linear search on the fast computer and
binary search on the slow computer. For small value of input size n,
Liner search may take less time , but for large input size , binary
search may take less time even though it's being running on the slow
machine because of order of growth is Logarithms. So, machine dependent
constants can always be ignored after certain values of input sizes.

<br />
<b>Does Asymptotic Analyze always works ?</b>
Asymptotic analyze is not perfect. but's currently available to analyze
performance of algorithm. let us say, for given two algorithm takes
1000nlognn , 2nlogn time respectively. But both of the algorithm is
asymptotically same because order of growth is nlogn. So, Asymptotic
analyze we can't judge which is better if we remove the constant value
of the algorithm. Also, Asymptotic Analysis, we always talks about the
input size is always greater than the constant values. it might be also
possible that that those larger values are never given to the software,
So, Algorithm might be asymptotically slower but gives better performs
on particular situation. So, you may end up like , choosing algorithm
which is asymptotically slower but faster for your software. -->

<script>

$(document).ready(function () {
	
	 $("#preview").click(function(){
	    	
		 var postcontent = $('#message-text').val();
		 var subsection  = $("#postHeading").val();
		 var form = document.createElement("form");
		    form.setAttribute("method", "post");
		    form.setAttribute("action", "preview.jsp");
		    form.setAttribute("target","TheWindow");
		    var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", "content");
            hiddenField.setAttribute("value",postcontent );
            form.appendChild(hiddenField);
            
            var hiddenFieldsub = document.createElement("input");
            hiddenFieldsub.setAttribute("type", "hidden");
            hiddenFieldsub.setAttribute("name", "subsection");
            hiddenFieldsub.setAttribute("value",subsection );
            form.appendChild(hiddenFieldsub);
            
            
            document.body.appendChild(form);
            window.open('','TheWindow');
            form.submit();
		    
		    
		 /* var win = window.open('preview.jsp?content='+postcontent, '_blank');
		 if(win){
		     //Browser has allowed it to be opened
		     win.focus();
		 }else{
		     //Broswer has blocked it
		     alert('Please allow popups for this site');
		 }     */	
   	  
   
   	
   });
	 
	  $('#exampleModal').on('shown.bs.modal', function () {
		    $('#message-text').focus();
		});
	
	
});


</script>

<jsp:include page="footer.jsp" />