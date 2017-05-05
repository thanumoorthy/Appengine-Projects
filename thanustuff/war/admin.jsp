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
    java.util.*"%>

<jsp:include page="header.jsp" />

<%
	if (session.getAttribute("userName") == null) {
%>
<script>
	window.open("home.jsp", "_self");
</script>
<%
	}
%>
<style>
article {
	display: none
}

#focusedInput {
	outline: 0px none;
	box-shadow: 0px 0px 8px rgba(82, 168, 236, 0.6);
}
</style>


<br />
<div class="container">


	<div class="row">
		<div class="col-md-12">

			<ul class="nav nav-tabs">
				<li><a href="#" onClick="hideall('homepage')">Home</a></li>
				<li><a href="#" onClick="hideall('changepassword')">Change
						Password</a></li>
				<% if ( session.getAttribute("userRole") != null ){
					  if ( session.getAttribute("userRole").toString().equals("admin")) {				
					
					%>
			
				<li><a href="#" onClick="hideall('adduserDiv')">Add user</a></li>
				<li><a href="#" onClick="hideall('removeuserDiv')">Remove user</a></li>
				<% }
					  }%>
				
				<li><a href="#" onClick="hideall('uploadimages')">Upload
						Images</a></li>
			</ul>
			<br />

			<article id="homepage">
				<!-- <div class="container">
					<div class="row">
						<div class="col-md-8"> -->
				<div class="well bs-component">

					Welcome
					<%=session.getAttribute("userName")%>
					<br>

					<p>This is Admin section. Here you can change password.</p>
					<% if ( session.getAttribute("userRole") != null ){
					  if ( session.getAttribute("userRole").toString().equals("admin")) {				
					
					%>
					You can add new user in this site, also you can remove existing user.
					<%}
					  }%>
					
				</div>
				<!-- </div>
					</div>
				</div> -->
			</article>


			<article id="changepassword">
				<div class="container">

					<div class="row" id="changepwdSuccess" align="center" style="display:none">
						<div class="col-lg-2"></div>

						<div class="col-lg-4">
							<div class="alert alert-success alert-dismissable">
								<button type="button" class="close" onClick="javascript:$('#changepwdSuccess').hide();"
									>&times;</button>
								Password has been changed successfully
							</div>
						</div>
						
						<div class="col-lg-2"></div>
					</div>
					
					<div class="row" id="changepwdFailure" align="center" style="display:none">
						<div class="col-lg-2"></div>

						<div class="col-lg-4">
							<div class="alert alert-dismissible alert-danger">
								<button type="button" class="close" onClick="javascript:$('#changepwdFailure').hide();"
									>&times;</button>
								Password doesn't match
							</div>
						</div>
						
						<div class="col-lg-2"></div>
					</div>
					
					<div class="row">
						<div class="col-md-8">

							<div class="well bs-component">
								<form class="form-horizontal" id="changepwd" name="changepwd">
									<fieldset>
										<legend>Change password </legend>
										<div class="form-group">
											<label for="inputuserName" class="col-lg-2 control-label">New Password
												</label>
											<div class="col-lg-10">
												<input type="password" class="form-control" id="newpwd"
													name="newpwd" placeholder="New Password"></input>
											</div>
										</div>
										<div class="form-group">
											<label for="inputPassword" class="col-lg-2 control-label">Confirm new Password</label>
											<div class="col-lg-10">
												<input type="password" class="form-control" id="confirmpwd"
													name="confirmpwd" placeholder="Confirm New Password">

											</div>
											<input type="hidden"  value="<%=session.getAttribute("userName")%>" id="activeuserName"  >
										</div>

										
										<div class="form-group">
											<div class="col-lg-10 col-lg-offset-2">
												<button type="reset" class="btn btn-default">Reset</button>
												<button type="button" class="btn btn-primary" id="changepwd"
													onClick="changepwdFun(this)">Submit</button>
											</div>
										</div>



									</fieldset>
								</form>
							</div>

						</div>
					</div>
				</div>

			</article>

			<article id="uploadimages">
				<p>Here you can upload images</p>

			</article>


			<article id="adduserDiv">
				<div class="container">

					<div class="row" id="adduserSuccess" align="center" style="display:none">
						<div class="col-lg-2"></div>

						<div class="col-lg-4">
							<div class="alert alert-success alert-dismissable">
								<button type="button" class="close" onClick="javascript:$('#adduserSuccess').hide();"
									>&times;</button>
								New user has been added successfully
							</div>
						</div>
						
						<div class="col-lg-2"></div>
					</div>
					
					<div class="row" id="adduserFailure" align="center" style="display:none">
						<div class="col-lg-2"></div>

						<div class="col-lg-4">
							<div class="alert alert-dismissible alert-danger">
								<button type="button" class="close" onClick="javascript:$('#adduserFailure').hide();"
									>&times;</button>
								User Name Already Exists
							</div>
						</div>
						
						<div class="col-lg-2"></div>
					</div>
					
					<div class="row">
						<div class="col-md-8">

							<div class="well bs-component">
								<form class="form-horizontal" id="adduser" name="adduser">
									<fieldset>
										<legend>Add user </legend>
										<div class="form-group">
											<label for="inputuserName" class="col-lg-2 control-label">User
												Name</label>
											<div class="col-lg-10">
												<input type="text" class="form-control" id="adduserName"
													name="adduserName" placeholder="User Name"></input>
											</div>
										</div>
										<div class="form-group">
											<label for="inputPassword" class="col-lg-2 control-label">Password</label>
											<div class="col-lg-10">
												<input type="password" class="form-control" id="addpassword"
													name="addpassword" placeholder="Password">

											</div>
										</div>

										<div class="form-group">
											<label for="select" class="col-lg-2 control-label">Role</label>
											<div class="col-lg-10">
												<select class="form-control" id="role">
													<option>Normal</option>
													<option>Admin</option>

												</select>

											</div>
										</div>
										<div class="form-group">
											<div class="col-lg-10 col-lg-offset-2">
												<button type="reset" class="btn btn-default">Reset</button>
												<button type="button" class="btn btn-primary" id="addUser"
													onClick="addUserFun(this)">Submit</button>
											</div>
										</div>



									</fieldset>
								</form>
							</div>

						</div>
					</div>
				</div>
				
			</article>

			<article id="removeuserDiv">
				<div class="container">

					<div class="row" id="removeuserSuccess" align="center" style="display:none">
						<div class="col-lg-2"></div>

						<div class="col-lg-4">
							<div class="alert alert-success alert-dismissable">
								<button type="button" class="close" onClick="javascript:$('#removeuserSuccess').hide();"
									>&times;</button>
								User has been removed successfully
							</div>
						</div>
						
						<div class="col-lg-2"></div>
					</div>
					
					<div class="row" id="removeuserFailure" align="center" style="display:none">
						<div class="col-lg-2"></div>

						<div class="col-lg-4">
							<div class="alert alert-dismissible alert-danger">
								<button type="button" class="close" onClick="javascript:$('#removeuserFailure').hide();"
									>&times;</button>
								Username couldn't be found.
							</div>
						</div>
						
						<div class="col-lg-2"></div>
					</div>
					
					<div class="row">
						<div class="col-md-8">

							<div class="well bs-component">
								<form class="form-horizontal" id="removeuser" name="removeuser">
									<fieldset>
										<legend>Delete user </legend>
										<div class="form-group">
											<label for="inputuserName" class="col-lg-2 control-label">User
												Name</label>
											<div class="col-lg-10">
												<input type="text" class="form-control" id="removeuserName"
													name="removeuserName" placeholder="User Name"></input>
											</div>
										</div>
										

										
										<div class="form-group">
											<div class="col-lg-10 col-lg-offset-2">
												<button type="reset" class="btn btn-default">Reset</button>
												<button type="button" class="btn btn-danger" id="removeUser"
													onClick="removeUserFun(this)">Delete</button>
											</div>
										</div>



									</fieldset>
								</form>
							</div>

						</div>
					</div>
				</div>

			</article>

		</div>


	</div>
</div>



<!-- <script>


	$('a:not(:first)').click(function(e) {
		e.preventDefault()
		var href = $(this).attr('href')
		$('article').hide();
		$(href).show()
	})
</script> -->

<script>
	$('#homepage').show();
	//$('#changepassword').show();
	//$('#adduser').button('loading');
	
</script>

<script>
	var responseMessageAdduser;
	function hideall(section) {

		$('article').hide();
		$('#' + section).show();

	}
	function addUserFun(e) {
		//alert(" i am submitting form");

		
		var $btn = $(e);
    $btn.button('loading');
    
		$.ajax({
			type : "POST",
			url : "/thanustuff", //process to mail
			data : {
				adduserName : $('#adduserName').val(),
				password : $('#addpassword').val(),
				role : $('#role').val()
			},
			success : function(msg) {
				
				responseMessageAdduser = msg;
				
				if (responseMessageAdduser.search("success") != -1) {
					$btn.button('reset');
					$('#adduserSuccess').show();

				} else {
					$btn.button('reset');
					$('#adduserFailure').show();

				}
			

			},
			error : function() {
				alert("failure");
			}
		});

	}
	
	function removeUserFun(e) {
		//alert(" i am submitting form");

		
		var $btn = $(e);
    $btn.button('loading');
    
		$.ajax({
			type : "POST",
			url : "/thanustuff", //process to mail
			data : {
				removeuserName : $('#removeuserName').val()
			
			},
			success : function(msg) {
				
				responseMessageAdduser = msg;
				
				if (responseMessageAdduser.search("success") != -1) {
					$btn.button('reset');
					$('#removeuserSuccess').show();

				} else {
					$btn.button('reset');
					$('#removeuserFailure').show();

				}
			

			},
			error : function() {
				alert("failure");
			}
		});

	}


	function changepwdFun(e) {
		//alert(" i am submitting form");

		
		var $btn = $(e);
    $btn.button('loading');
    
		$.ajax({
			type : "POST",
			url : "/thanustuff", //process to mail
			data : {
				newpassword : $('#newpwd').val(),
				userName: $('#activeuserName').val()
			
			},
			success : function(msg) {
				
				responseMessageAdduser = msg;
				
				if (responseMessageAdduser.search("success") != -1) {
					$btn.button('reset');
					$('#changepwdSuccess').show();

				} else {
					$btn.button('reset');
					$('#changepwdFailure').show();

				}
			

			},
			error : function() {
				alert("failure");
			}
		});

	}
	
</script>













<jsp:include page="footer.jsp" />