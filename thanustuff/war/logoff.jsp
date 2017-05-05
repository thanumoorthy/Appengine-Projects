  <% session.setAttribute("userName", null); %>
    <% session.setAttribute("userRole", null); %>
<jsp:include page="header.jsp" />
<script>
window.open("home.jsp", "_self");
</script>
<jsp:include page="slides.jsp" />
<jsp:include page="home-menu.jsp" />
<jsp:include page="footer.jsp" />