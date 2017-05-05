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
<%
	String topicName ="";  
	String sectionName ="";
	String totalPost ="";
	int totalPostNum = 0 ;
	String action="";
	Boolean alertBoxAddEnable = false;
	Boolean alertBoxDeleteEnable = false;
	DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
	PreparedQuery pq = null;
	String newTopicName ="";
	String postby ="";
//Getting topic Name
if (request.getParameter("pname") != null ) {   
	    topicName = request. getParameter("pname");
	    session.setAttribute("pname",  topicName);
      //  System.out.println("page name is " + request. getParameter("pname"));
    } 
else if ( session.getAttribute("pname") != null )  {
	
	topicName =  (String)session.getAttribute("pname");
	
}


//Getting total Posts
if (request.getParameter("totalPost") != null ) {   
    totalPost = request. getParameter("totalPost");
    session.setAttribute("totalPost",  totalPost);
    totalPostNum  = Integer.parseInt(totalPost);
   }
else if ( session.getAttribute("pname") != null )  {
	
	totalPost =  (String)session.getAttribute("totalPost");
	totalPostNum  = Integer.parseInt(totalPost);
	
}



// Getting Section Name
if (request.getParameter("sectionName") != null ) {   
	sectionName = request. getParameter("sectionName");
	session.setAttribute("sectionName",  sectionName);
	
  //  System.out.println("page name is " + request. getParameter("pname"));
}
else if ( session.getAttribute("sectionName") != null )  {
	
	sectionName =  (String)session.getAttribute("sectionName");
	
}



if ( session.getAttribute("userName") != null ) {

if (request.getParameter("action") != null ) {   
	
	action = request. getParameter("action");
    if ( action.equals("addPost"))   {
    	
    	if (request.getParameter("topicName") != null && request.getParameter("message-text") != null  ) {
    	DateFormat dateFormat = new SimpleDateFormat("EEEE, MMMM d, yyyy");
    	Date date = new Date();
    	String messageContent = "";
    	String postheading ="";
    	postheading =  request.getParameter("topicName");
    	//messageContent =  request.getParameter("message-text");   	
    	
    	Transaction ts = ds.beginTransaction();
    	try {
    		Entity e1 = new Entity(topicName);    		
    		e1.setProperty("sectionName", sectionName);
    		e1.setProperty("subsectionName", postheading);
    		e1.setProperty("postDate", dateFormat.format(date));
    		e1.setProperty("postby", session.getAttribute("userName"));
    		e1.setProperty("content",new Text(request.getParameter("message-text")));
    		ds.put(e1);
    		ts.commit();
    		totalPostNum ++;
    		
    	} finally {
    	 	if ( ts.isActive())
    			ts.rollback(); 

    	}
        
    	alertBoxAddEnable = true;
    	}
%>

<script>
    	window.open("subtopic.jsp?action=add", "_self");
    	</script>

<%
	}  else if (action.equals("deletePost") ) {
    	if (  request.getParameter("deleteTopicName") != null ) {
    	alertBoxDeleteEnable = true;
    	newTopicName =  request.getParameter("deleteTopicName");
    	//System.out.println("topic names are i am here " + newTopicName);
    	 Query   qdelete = new Query(topicName).addFilter("subsectionName", FilterOperator.EQUAL, newTopicName);
    		PreparedQuery pqdelete = ds.prepare(qdelete);
    		Entity deleteEntity;
    		for ( Entity endelete : pqdelete.asIterable()) {
    			
    			Long idNum  =  endelete.getKey().getId();	
    			ds.delete(KeyFactory.createKey(topicName,idNum));  			
    			//System.out.println("Entity has been delete successfully ");
    		}
    	}
%>
<script>
    	window.open("subtopic.jsp?action=delete", "_self");
    	</script>
<%
	}		
   else if (action.equals("deletePostContent") ) {
	  
	         if (request.getParameter("recordId") != null ) {
    	    	alertBoxDeleteEnable = true;
    	    	Long recordIdValue =  null;
    	    	recordIdValue = Long.parseLong(request
		.getParameter("recordId"));

    	    	ds.delete(KeyFactory.createKey(topicName,recordIdValue));
    	    			//System.out.println("Entity has been delete successfully ");
    	    		}
%>
<script>
	     	window.open("subtopic.jsp?action=delete", "_self");
	     	</script>

<%
	}
  
   else if (action.equals("add")) {
	   
	   alertBoxAddEnable = true;
   }
	else if (action.equals("delete")) {
		alertBoxDeleteEnable = true; 
   }
%>





<%
	}
}


ArrayList<String>  postNameList   = new ArrayList<String>();
ArrayList<String>  postDateList   = new ArrayList<String>();
int i = 0;
int j; 
int index =0;
int length = 0;
String postDate="";
if (request.getParameter("action") != null ) {   
	
	action = request. getParameter("action");
    if ( action.equals("searchPost"))   {
    	if ( request.getParameter("searchPatten") != null ){
    		String searchPatten  = request.getParameter("searchPatten").toString();
    		searchPatten = searchPatten.toLowerCase();
    		
    		Query p = new Query(topicName).addFilter("sectionName",
    				FilterOperator.EQUAL, sectionName);
    				pq = ds.prepare(p);
    				//System.out.println(" ps  " + p);
    				
    				for (Entity en : pq.asIterable()) {
    			String subsectionName = en.getProperty("subsectionName")
    			.toString();
    				       if (!subsectionName.equals("")) {
    				          postDate = en.getProperty("postDate").toString();
    				          postby  = en.getProperty("postby").toString();
    				          if ( subsectionName.toLowerCase().contains(searchPatten)) {
    				          i++;
    				          postNameList.add(subsectionName);
    				          postDateList.add(postDate+"_"+postby);
    				          }
    				          
    				       }
    				       
    				}   
    		
    	}
        
    	
    }
    // Display contents for Add and remove post requests
    else {
    	Query p = new Query(topicName).addFilter("sectionName",
    			FilterOperator.EQUAL, sectionName);
    			pq = ds.prepare(p);
    			//System.out.println(" ps  " + p);
    			
    			for (Entity en : pq.asIterable()) {
    				String subsectionName = en.getProperty("subsectionName")
    				.toString();
    			       if (!subsectionName.equals("")) {
    			          postDate = en.getProperty("postDate").toString();
    			          postby  = en.getProperty("postby").toString();
    			          i++;
    			          postNameList.add(subsectionName);
    			          postDateList.add(postDate+"_"+postby);
    			          
    			       }
    			       
    			}   
    }
}  

else {
	// Dispaly content for normal request
	Query p = new Query(topicName).addFilter("sectionName",
	FilterOperator.EQUAL, sectionName);
	pq = ds.prepare(p);
	//System.out.println(" ps  " + p);
	
	for (Entity en : pq.asIterable()) {
		String subsectionName = en.getProperty("subsectionName")
		.toString();
	       if (!subsectionName.equals("")) {
	          postDate = en.getProperty("postDate").toString();
	          postby  = en.getProperty("postby").toString();
	          i++;
	          postNameList.add(subsectionName);
	          postDateList.add(postDate+"_"+postby);
	          
	       }
	       
	}   
	
}


totalPostNum  = i;		
length = postNameList.size();
%>



<jsp:include page="header.jsp" />

<script>
	function submitTopic(subtopic) {

		document.getElementById(subtopic).submit();
	}
</script>

<ul class="breadcrumb">
	<li><a href="home.jsp">Home</a> <span class="divider">/</span></li>
	<li><a href="topic.jsp?pname=<%=topicName%>"><%=topicName%> </a> <span
		class="divider">/</span></li>
<%  if (request.getParameter("action") != null ) {   	 %>	
	<li><a href="subtopic.jsp"><%=sectionName%></a></li>
<% } else {%>	
	<li class="Active"><%=sectionName%></li>
<% } %>	
</ul>


<div align="right">

	<button type="button" class="btn btn-success" data-toggle="modal"
		data-target="#searchModal" data-whatever="Search topic Name">Search
		Post</button>
<%
	if ( session.getAttribute("userName") != null ) {
%>	
	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target="#exampleModal" data-whatever="Topic Name">Add
		Post</button>
	<button type="button" class="btn btn-warning" data-toggle="modal"
		data-target="#removeModal" data-whatever="Delete topic Name">Remove
		Post</button>
<% } %>

</div>

<%
	if ( session.getAttribute("userName") != null ) {
%>
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
					Add Post's on
					<%=topicName%>
				</h4>
			</div>
			<form method="post" action="subtopic.jsp?action=addPost">
				<div class="modal-body">

					<div class="form-group">
						<label for="recipient-name" class="control-label">Post
							Heading </label> <input type="text" class="form-control" id="topicName"
							name="topicName">
					</div>
					<div class="form-group">
						<label for="message-text" class="control-label">Content (
							HTML Format)</label>
						<textarea class="form-control" id="message-text" rows="12"
							name="message-text"></textarea>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" name="preview" id="preview"
						class="btn btn-info">
						Preview</a>
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
				<h4 class="modal-title" id="removeModalLabel">
					Delete Topic's on
					<%=topicName%>
				</h4>
			</div>
			<form method="post" action="subtopic.jsp?action=deletePost">
				<div class="modal-body">

					<div class="form-group">
						<label for="recipient-name" class="control-label">Choose
							Topic Name:</label> <select name="deleteTopicName" id="deleteTopicName"
							class="form-control">
							<%
								String entityName="";
														for ( j =0; j < length ; j++   ) {
															entityName =  postNameList.get(j);
							%>
							<option><%=entityName%></option>


							<%
								}
						 
							%>



						</select>
					</div>
					

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-warning">Delete</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%
  }
%>



<div class="modal fade" id="searchModal" tabindex="-1" role="dialog"
	aria-labelledby="searchModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="searcgModalLabel">
					Serch topic on
					<%=topicName%>
				</h4>
			</div>
			<form method="post" action="subtopic.jsp?action=searchPost">
				<div class="modal-body">

					<div class="form-group">
						<label for="recipient-name" class="control-label"> Topic
							Name:</label> <input type="text" id="searchPatten" name="searchPatten"
							class="form-control"    placeholder="Search">

					</div>
					<!--  <div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div> -->

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-warning">Search</button>
				</div>
			</form>
		</div>
	</div>
</div>





<%
	if ( alertBoxAddEnable ) {
%>
<div class="row">
	<div class="col-lg-4"></div>

	<div class="col-lg-4">
		<div class="alert alert-success alert-dismissable">
			<button type="button" class="close" data-dismiss="alert"
				aria-hidden="true">&times;</button>
			Success! Post has been Published.
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
			Post has been Removed.
		</div>
	</div>
</div>
<%
	}
%>

<br />
<div class="list-group">
	<a href="#" class="list-group-item active"> <span
		class="badge pull-right"><%=totalPostNum%></span>
		<h4 class="list-group-item-heading">
			<%=sectionName%>
		</h4> <!-- <input type="text" class="form-control" placeholder="Search"> -->
	</a>

	<%
		//Query p = new Query("datastructure WHERE subsectionName = ");

			/* Query p = new Query(topicName).addFilter("sectionName",
			FilterOperator.EQUAL, sectionName);
			pq = ds.prepare(p);
			//System.out.println(" ps  " + p);
			int i = 0;
			for (Entity e : pq.asIterable()) {
		String subsectionName = e.getProperty("subsectionName")
		.toString();
		

		if (!subsectionName.equals("")) {
			String postDate = e.getProperty("postDate").toString();
			i++; */
			
			
			String subsectionName;
			String splitPostDatePostBy[];
			//String postDate;
			for ( j =0; j < length ; j++   ) {
		subsectionName =  postNameList.get(j);
		splitPostDatePostBy= postDateList.get(j).split("_");
		postDate  = splitPostDatePostBy[0];
		postby  = splitPostDatePostBy[1];
		/* for ( String s:splitPostDatePostBy)
			  System.out.println(s); */
		
		index++;
	%>
	<article id="topic<%=index%>">
		<form method="post" name="<%=subsectionName%>"
			id="<%=subsectionName%>" action="detail.jsp">
			<input type="hidden" name="pname" id="pname" value="<%=topicName%>">
			<input type="hidden" name="sectionName" id="sectionName"
				value="<%=sectionName%>"> <input type="hidden"
				name="subsectionName" id="subsectionName"
				value="<%=subsectionName%>"> <a href="#"
				class="list-group-item" onClick="submitTopic('<%=subsectionName%>')">
				<h4 class="list-group-item-heading"><%=subsectionName%></h4> <%-- <span align="right" class="text-info"> Post on:&nbsp;<%= postDate %><div align="right"><img src="images/arrow.png" /></div></span> --%>

				<span class="text-success"> <b>Post on:</b></span>&nbsp;<span class="text-info"><%=postDate%></span> &nbsp;&nbsp;
				<span class="text-success" ><b>Post By:</b></span>&nbsp;<span class="text-info"><%=postby%></span> 
				<img
				src="images/arrow.png" align="right" />


			</a>

		</form>
	</article>
	<%
		}

			
			//System.out.println("Total posts are " + i);
	%>
</div>






<%
	//System.out.println(" I am here " + totalPostNum);
int totIndex = 0;
int temp = 0;

if ( totalPostNum >= 5) {

	totIndex = totalPostNum / 5;
	temp = totalPostNum % 5;
	if ( temp > 0)
		totIndex ++;	
//System.out.println("total index number is " + totIndex);
%>




<div align="center">
	<ul class="pagination">


		<li class="disabled" id="listprev"><a href="#" id="pageprev"
			onClick="paginationfun('pageprev')">&laquo;</a></li>

		<%
			for (int a = 1; a<=totIndex;a++ ) {
				                   if ( a == 1 )  {
		%>
		<li class="active" id="list<%=a%>"><a href="#" id="page<%=a%>"
			onClick="paginationfun(<%=a%>)">1</a></li>

		<%
			}else{
		%>
		<li id="list<%=a%>"><a href="#" id="page<%=a%>"
			onClick="paginationfun(<%=a%>)"> <%=a%>
		</a></li>


		<%
			} }
		%>

		<%
			if ( totIndex > 1) {
		%>
		<li id="listnext"><a href="#" id="pagenext"
			onClick="paginationfun('pagenext')">&raquo;</a></li>
		<%
			} else {
		%>
		<li class="disabled" id="listnext"><a href="#" id="pagenext"
			onClick="paginationfun('pagenext')">&raquo;</a></li>
		<%
			}
		%>
	</ul>

</div>


<script>

$('article').hide();
</script>

<%
	}

int divPos = 0;
 for ( divPos = 1 ; divPos <= 5 ; divPos ++) {
%>
<script>

$("#topic<%=divPos%>").show();
</script>



<%
	}
%>



<script>

var activePage = 1;
var nextactivePage = 0;
var starpoint = 0;
var endpoint = 0;
function paginationfun (currentSelection) {
	if (currentSelection == "pageprev"  )   {
		//alert("current selection is previous");
		nextactivePage = activePage -1;
	}
	else if (currentSelection == "pagenext" ) {
		//alert("current selection is next");
		
		nextactivePage = activePage + 1;
		
	}
	else {
		//alert("current selection is " +  ( currentSelection ));
		nextactivePage  = currentSelection;
	}
		
$('#list'+activePage).removeClass("active");	
$('#list'+nextactivePage).addClass("active");

//alert("class has been added successfully");	  
activePage   = nextactivePage;

if (  activePage  ==  <%=totIndex%> ) {
	//alert(" i am here active page = 2");
	 $('#listnext').addClass("disabled");
}
else {
	 $('#listnext').removeClass("disabled");
}     
if (  activePage  ==  1 ) {
	//alert("i am here active page = 1");
	 $('#listprev').addClass("disabled");
}
else {
	 $('#listprev').removeClass("disabled");
}     
    	
endpoint  = activePage * 5;
startpoint = endpoint - 4;

$('article').hide();

if ( endpoint  >=  <%=totalPostNum%> ) {
	endpoint  = <%=totalPostNum%> ;
}

var itr = 0
for (  itr = startpoint; itr <= endpoint ; itr++    ){
	$('#topic'+ itr).show();
}	
	
	

}

</script>




<script>

  


	$(document).ready(function() {

		$("#preview").click(function() {

			var postcontent = $('#message-text').val();
			var subsection = $("#topicName").val();
			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "preview.jsp");
			form.setAttribute("target", "TheWindow");
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "content");
			hiddenField.setAttribute("value", postcontent);
			form.appendChild(hiddenField);

			var hiddenFieldsub = document.createElement("input");
			hiddenFieldsub.setAttribute("type", "hidden");
			hiddenFieldsub.setAttribute("name", "subsection");
			hiddenFieldsub.setAttribute("value", subsection);
			form.appendChild(hiddenFieldsub);

			document.body.appendChild(form);
			window.open('', 'TheWindow');
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
			    $('#topicName').focus();
			});
		  
		  $('#searchModal').on('shown.bs.modal', function () {
			    $('#searchPatten').focus();
			});

	});
</script>

<jsp:include page="footer.jsp" />