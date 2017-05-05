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

<jsp:include page="header.jsp" />



<%
	DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
	PreparedQuery pq;
	
	String topicName ="";  
	String action="";
	Boolean alertBoxAddEnable = false;
	Boolean alertBoxDeleteEnable = false;
	Boolean alertBoxAddErrorEnable = false;
	String newTopicName = "";
	
if (request.getParameter("pname") != null ) {   
	    topicName = request. getParameter("pname");
	    session.setAttribute("pname",  topicName);	    
    
    } 
else if ( session.getAttribute("pname") != null )  {	
	
	topicName =  (String)session.getAttribute("pname");
	
}

if ( session.getAttribute("userName") != null ) {

if (request.getParameter("action") != null ) {   
	
	action = request. getParameter("action");
    if ( action.equals("addTopic"))   {
    	
    	
    	newTopicName =  request.getParameter("topicName");
    	//.out.println("topic name is " + newTopicName );
    	Transaction ts = ds.beginTransaction();
    	Boolean isAvailable = false;
    	int totCount = 0;

    	Query   search = new Query(topicName).addFilter("sectionName", FilterOperator.EQUAL, newTopicName);
 		pq = ds.prepare(search);
 		totCount = pq.countEntities();
 		if ( totCount > 0) {
 			
 			
 		    %>   

 	    	<script>
 	    	window.open("topic.jsp?action=addError", "_self");
 	    	</script> 
 	 <%   
 			
 		}
 		else {
 			
 			try {
 	    		Entity e1 = new Entity(topicName);
 	    		
 	    		String sectionName =newTopicName;
 	    		String subsectionName ="";
 	    		
 	    		//String content ="<html><head></head>this is game one</html>";		
 	    		 e1.setProperty("sectionName", sectionName);
 	    		e1.setProperty("subsectionName", subsectionName);
 	    		
 	    		ds.put(e1);
 	    		ts.commit();
 	    		//System.out.println("entity has been created");
 	    		
 	    		
 	    		
 	    	} finally {
 	    	 	if ( ts.isActive())
 	    			ts.rollback(); 

 	    	}

 		
    	     %>   

    	<script>
    	window.open("topic.jsp?action=add", "_self");
    	</script> 
 <%   
 		}
   }
    
    else if (action.equals("deleteTopic") ) {
    	alertBoxDeleteEnable = true;
    	newTopicName =  request.getParameter("deleteTopicName");
    //	System.out.println("topic names are i am here " + newTopicName);
    	 Query   qdelete = new Query(topicName).addFilter("sectionName", FilterOperator.EQUAL, newTopicName);
    		PreparedQuery pqdelete = ds.prepare(qdelete);
    		Entity deleteEntity;
    		for ( Entity endelete : pqdelete.asIterable()) {
    			
    			Long idNum  =  endelete.getKey().getId();	
    			ds.delete(KeyFactory.createKey(topicName,idNum));  			
    			//System.out.println("Entity has been delete successfully ");
    		}
    	    
    		  %>   

    	    	<script>
    	    	window.open("topic.jsp?action=remove", "_self");
    	    	</script> 
    	 <%    	 
    	
    	
    }
    
    else if (action.equals("add")){
    	
    	alertBoxAddEnable = true;
    }
 else if (action.equals("addError")){
    	
    	alertBoxAddErrorEnable = true;
    }
    else if ( action.equals("remove")){
    	alertBoxDeleteEnable = true;
    	
    }
    
  %>
  
  

  
<% }
}
%>

<ul class="breadcrumb">
	<li><a href="home.jsp">Home</a> <span class="divider">/</span></li>
	<li class="active"><%=topicName%></li>
</ul>

<% if ( session.getAttribute("userName") != null ) { %>
<div align="right">

	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target="#exampleModal" data-whatever="Topic Name">Add
		Topic</button>
	<button type="button" class="btn btn-warning" data-toggle="modal"
		data-target="#removeModal" data-whatever="Delete topic Name">Remove
		Topic</button>


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
					Add Topic's on
					<%=topicName%>
				</h4>
			</div>
			<form method="post" action="topic.jsp?action=addTopic">
				<div class="modal-body">

					<div class="form-group">
						<label for="recipient-name" class="control-label">Topic
							Name:</label> <input type="text" class="form-control" id="topicName"
							name="topicName">
					</div>
					<!--  <div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div> -->

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary">Add</button>
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
					Delete Topic's on
					<%=topicName%>
				</h4>
			</div>
			<form method="post" action="topic.jsp?action=deleteTopic">
				<div class="modal-body">

					<div class="form-group">
						<label for="recipient-name" class="control-label">Choose
							Topic Name:</label> <select name="deleteTopicName" id="deleteTopicName"
							class="form-control">
							<%
							Query listentity = new Query(topicName).addFilter("subsectionName",
									FilterOperator.EQUAL, "");
						    pq = ds.prepare(listentity);
						    String entityName="";
						    for (Entity e : pq.asIterable()) {
						    	entityName = e.getProperty("sectionName").toString();

								if (!entityName.equals("")) {
									
		                        %>
		                        <option><%=entityName  %></option>
							
		                             
								<%
								
								}
			 }
							%>
							
							
							

						</select>
					</div>
					<!--  <div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div> -->

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-warning">Delete</button>
				</div>
			</form>
		</div>
	</div>
</div>

<%  } %>
<!-- <script>
$('#exampleModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
	  var recipient = button.data('whatever') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('New message to ' + recipient)
	  modal.find('.modal-body input').val(recipient)
	})

</script> -->

<%
	if ( alertBoxAddEnable ) {
%>
<div class="row">
	<div class="col-lg-4"></div>

	<div class="col-lg-4">
		<div class="alert alert-success alert-dismissable">
			<button type="button" class="close" data-dismiss="alert"
				aria-hidden="true">&times;</button>
			Success! Topic has been added.
		</div>
	</div>
</div>
<%
	}
%>
<%
	if ( alertBoxDeleteEnable ) {
%>
<div class="row">
	<div class="col-lg-4"></div>

	<div class="col-lg-4">
		<div class="alert alert-dismissible alert-danger">
			<button type="button" class="close" data-dismiss="alert"
				aria-hidden="true">&times;</button>
			Topic has been Removed.
		</div>
	</div>
</div>
<%
	}
%>



<%
	if ( alertBoxAddErrorEnable ) {
%>
<div class="row">
	<div class="col-lg-4"></div>

	<div class="col-lg-4">
		<div class="alert alert-dismissible alert-danger">
			<button type="button" class="close" data-dismiss="alert"
				aria-hidden="true">&times;</button>
			Topic couldn't be added. Same topic name already exists.
		</div>
	</div>
</div>
<%
	}
%>

<!-- <div class="bs-component">
	<div class="modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">x</button>
					<h4 class="modal-title">Modal title</h4>
				</div>
				<div class="modal-body">
					<p>One fine body</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
</div> -->

<script>
	function submitTopic(subtopic) {
		document.getElementById(subtopic).submit();
	}
	
	$('#exampleModal').on('shown.bs.modal', function () {
	    $('#topicName').focus();
	})
</script>

<br />

<%
	//Query p = new Query("datastructure WHERE subsectionName = ");

	String sectionName = "";
	Query p = new Query(topicName).addFilter("subsectionName",
			FilterOperator.EQUAL, "");
	pq = ds.prepare(p);
	//System.out.println(" ps  " + p);
	int totalCount = 0;
	for (Entity e : pq.asIterable()) {
		sectionName = e.getProperty("sectionName").toString();

		if (!sectionName.equals("")) {
			//.out.println("section name is after  " + sectionName );

			//Map<String,Object> mapname  = e.getProperties();
			//String subsectionName  = e.getProperty("subsectionName").toString();
			Query q = new Query(topicName).addFilter("sectionName",
					FilterOperator.EQUAL, sectionName);
			PreparedQuery pqcount = ds.prepare(q);
			totalCount = pqcount.countEntities();
			//System.out.println("total entities are  + totalCount ");
			totalCount--;
%>
<form method="post" name="<%=sectionName%>" id="<%=sectionName%>"
	action="subtopic.jsp">
	<input type="hidden" name="pname" id="pname" value="<%=topicName%>">
	<input type="hidden" name="sectionName" id="sectionName"
		value="<%=sectionName%>"> <input type="hidden"
		name="totalPost" id="totalPost" value="<%=totalCount%>">

	<div class="list-group">
		<a href="#" class="list-group-item active"
			onClick="submitTopic('<%=sectionName%>')"> <span
			class="badge pull-right"><%=totalCount%></span>
			<h4 class="list-group-item-heading">
				<%=sectionName%>
			</h4>
		</a>
	</div>
</form>

<%
	//System.out.println("Entity value is are ");
			//System.out.println(" sectionName " + sectionName  + " Total posts " +  totalCount  + " ID " + idNum );
		}

	}
%>









<!-- <form method="post" name="search" id="search" action ="subtopic1.jsp">
<input type="hidden" id="heading" value="Analyze">
<div class="list-group">
   <a href="#" class="list-group-item active" onClick="submitTopic('search')">
    <span class="badge pull-right">3</span>
      <h4 class="list-group-item-heading">
         Searching and sorting
      </h4>  
   </a>
</div>
</form> -->






<jsp:include page="footer.jsp" />