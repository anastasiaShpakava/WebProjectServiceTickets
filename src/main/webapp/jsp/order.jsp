<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  <%--jstl tag--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ctg" uri="customtags" %>



<fmt:setLocale value="${locale}" scope="session"/>
<fmt:setBundle basename="local.text"/>

<html>
<head>
    <title><fmt:message key="header.profile.order"/></title>

    <!-- SCRIPTS -->
    <!-- JQuery -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.8.10/js/mdb.min.js"></script>


    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/comments.css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!--for fa fa-send -->

    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">

    <!-- Material Design Bootstrap -->
    <link href="${pageContext.request.contextPath}/css/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
          crossorigin="anonymous">
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap-social.css" rel="stylesheet">

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/tabs.js"></script>

</head>
<body>

<jsp:include page="header.jsp"/>

<div id="page-container">
    <div id="content-wrap">
        <c:if test="${noOrder != null}">
            <p>${noOrder}</p>
        </c:if>

        <c:if test="${not empty ticketDates}">
            <div class="form-group">
                <label for="exampleFormControlSelect1"><fmt:message key="profile.date"/> </label>

                <form method="get" action="show_order">
                    <select name="ticketDate" onchange="this.form.submit()" class="selectpicker"
                            id="exampleFormControlSelect1">
                        <option disabled selected value> -- <fmt:message key="profile.date.select"/> --</option>
                        <c:forEach var="ticketDate" items="${ticketDates}">
                            <option ${ticketDate==selected_date?"selected":""} value="${ticketDate}">${ticketDate}</option>
                        </c:forEach>

                    </select>
                </form>
            </div>
        </c:if>


        <c:if test="${concertOrder or not empty theatreOrder or not empty operaOrder
        or not empty balletOrder or not empty cinemaOrder or not empty sportOrder or not empty exhibitionOrder}">

            <table class="table">

                <thead class="thead-dark">
                <tr>
                    <th scope="col">Event type</th>
                    <th scope="col">Event</th>
                    <th scope="col">Name</th>
                    <th scope="col">Description</th>
                    <th scope="col">Address</th>
                    <th scope="col">Date</th>
                    <th scope="col">Price</th>
                    <th scope="col"><fmt:message key="event.quantity"/></th> <!--Quantity column -->
                    <c:if test="${not ord}">
                        <th scope="col"></th>
                        <!--Delete column -->
                    </c:if>
                </tr>
                </thead>
                <tbody>

                <!--Concert -->
                <c:if test="${not empty concertOrder}">
                    <tr>
                        <th rowspan="${concertOrders.size() + 1}" scope="rowgroup"><fmt:message
                                key="event.concert"/></th>
                    </tr>
                    <c:forEach var="concertOrder" items="${concertOrders}">
                        <tr>
                            <th scope="row"><img
                                    src="${pageContext.request.contextPath}/images/events/concert.jpg"
                                    width="70"
                                    height="80"></th>
                            <td scope="row">${queen.activity.name}</td>
                            <td>${queen.activity.description}</td>
                            <td>${queen.activity.address}</td>
                            <td>${queen.activity.data}</td>
                            <td>${queen.activity.queen.activity.data}</td>
                            <td>$queen.activity.price}</td>
                            <td>
                                <form method="post" action="update_quantity_in_order">
                                    <input type="hidden" name="command" value="update_quantity_in_order">
                                    <input type="hidden" name="ticketId" value="${queen.ticketId}">

                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                                    <span class="input-group-text" style="width: 100px;"><fmt:message
                                                            key="event.quantity"/></span>
                                        </div>
                                        <input type="number" min="1" max="999"
                                               name="quantity" value="${queen.quantity}"
                                               class="form-control" aria-label="Sizing example input"
                                               aria-describedby="inputGroup-sizing-default">
                                        <span style="color:red;">${errorQuantity}</span>
                                    </div>

                                    <!--Update button -->

                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <br>
                                            <button type="submit" class="btn btn-success"><fmt:message
                                                    key="profile.button.update"/></button>
                                        </div>
                                    </div>


                                </form>
                            </td>
                            <td>
                                <form method="post" action="delete_ticket">
                                    <input type="hidden" name="command" value="delete_ticket">
                                    <input type="hidden" name="ticketlId" value="${queen.ticketId}">
                                    <input type="hidden" name="totalEvents" value="${totalEvents}">
                                    <input type="hidden" name="selected_date" value="${selected_date}">
                                    <button type="submit" class="btn btn-danger">
                                        <fmt:message key="profile.button.delete"/>
                                    </button>
                                </form>
                            </td>

                        </tr>
                    </c:forEach>
                </c:if>

<%--                <!--Lunch -->--%>
<%--                <c:if test="${not empty lunchMeals}">--%>
<%--                    <tr>--%>
<%--                        <th rowspan="${lunchMeals.size() + 1}" scope="rowgroup"><fmt:message key="product.lunch"/></th>--%>
<%--                    </tr>--%>
<%--                    <c:forEach var="lunchMeal" items="${lunchMeals}">--%>
<%--                        <tr>--%>
<%--                            <th scope="row"><img--%>
<%--                                    src="${pageContext.request.contextPath}/images/products/${lunchMeal.product.imageURL}"--%>
<%--                                    width="70" height="80"></th>--%>
<%--                            <td>${lunchMeal.product.name}</td>--%>
<%--                            <td>${lunchMeal.product.description}</td>--%>
<%--                            <td>${lunchMeal.product.calories}</td>--%>
<%--                            <td>${lunchMeal.product.proteins}</td>--%>
<%--                            <td>${lunchMeal.product.lipids}</td>--%>
<%--                            <td>${lunchMeal.product.carbohydrates}</td>--%>
<%--                            <td>--%>
<%--                                <form method="post" action="update_quantity_in_diet">--%>
<%--                                    <input type="hidden" name="command" value="update_quantity_in_diet">--%>
<%--                                    <input type="hidden" name="mealId" value="${lunchMeal.mealId}">--%>

<%--                                    <div class="input-group mb-3">--%>
<%--                                        <div class="input-group-prepend">--%>
<%--                                <span class="input-group-text" id="inputGroup-sizing-default"--%>
<%--                                      style="width: 100px;"><fmt:message--%>
<%--                                        key="product.quantity"/></span>--%>
<%--                                        </div>--%>
<%--                                        <input type="number" min="1" max="999"--%>
<%--                                               name="quantity" value="${lunchMeal.quantity}"--%>
<%--                                               class="form-control" aria-label="Sizing example input"--%>
<%--                                               aria-describedby="inputGroup-sizing-default"--%>
<%--                                        >--%>
<%--                                        <span style="color:red;">${errorQuantity}</span>--%>
<%--                                    </div>--%>

<%--                                    <!--Update button -->--%>
<%--                                    <div class="form-group">--%>
<%--                                        <div class="col-xs-12">--%>
<%--                                            <br>--%>
<%--                                            <button type="submit" class="btn btn-success"><fmt:message--%>
<%--                                                    key="profile.button.update"/></button>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </form>--%>
<%--                            </td>--%>
<%--                            <td>--%>
<%--                                <form method="post" action="delete_meal">--%>
<%--                                    <input type="hidden" name="command" value="delete_meal">--%>
<%--                                    <input type="hidden" name="mealId" value="${lunchMeal.mealId}">--%>
<%--                                    <input type="hidden" name="totalProducts" value="${totalProducts}">--%>
<%--                                    <input type="hidden" name="selected_date" value="${selected_date}">--%>
<%--                                    <button type="submit" class="btn btn-danger"><fmt:message--%>
<%--                                            key="profile.button.delete"/></button>--%>
<%--                                </form>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
<%--                </c:if>--%>

<%--                <!--Dinner -->--%>
<%--                <c:if test="${not empty dinnerMeals}">--%>
<%--                    <tr>--%>
<%--                        <th rowspan="${dinnerMeals.size() + 1}" scope="rowgroup"><fmt:message--%>
<%--                                key="product.dinner"/></th>--%>
<%--                    </tr>--%>
<%--                    <c:forEach var="dinnerMeal" items="${dinnerMeals}">--%>
<%--                        <tr>--%>
<%--                            <th scope="row"><img--%>
<%--                                    src="${pageContext.request.contextPath}/images/products/${dinnerMeal.product.imageURL}"--%>
<%--                                    width="70" height="80"></th>--%>
<%--                            <td>${dinnerMeal.product.name}</td>--%>
<%--                            <td>${dinnerMeal.product.description}</td>--%>
<%--                            <td>${dinnerMeal.product.calories}</td>--%>
<%--                            <td>${dinnerMeal.product.proteins}</td>--%>
<%--                            <td>${dinnerMeal.product.lipids}</td>--%>
<%--                            <td>${dinnerMeal.product.carbohydrates}</td>--%>
<%--                            <td>--%>
<%--                                <form method="post" action="update_quantity_in_diet">--%>
<%--                                    <input type="hidden" name="command" value="update_quantity_in_diet">--%>
<%--                                    <input type="hidden" name="mealId" value="${dinnerMeal.mealId}">--%>

<%--                                    <div class="input-group mb-3">--%>
<%--                                        <div class="input-group-prepend">--%>
<%--                                                    <span class="input-group-text" style="width: 100px;"><fmt:message--%>
<%--                                                            key="product.quantity"/></span>--%>
<%--                                        </div>--%>
<%--                                        <input type="number"--%>
<%--                                               name="quantity" value="${dinnerMeal.quantity}"--%>
<%--                                               min="1" max="999"--%>
<%--                                               class="form-control" aria-label="Sizing example input"--%>
<%--                                               aria-describedby="inputGroup-sizing-default">--%>
<%--                                        <span style="color:red;">${errorQuantity}</span>--%>
<%--                                    </div>--%>

<%--                                    <!--Update button -->--%>
<%--                                    <div class="form-group">--%>
<%--                                        <div class="col-xs-12">--%>
<%--                                            <br>--%>
<%--                                            <button type="submit" class="btn btn-success"><fmt:message--%>
<%--                                                    key="profile.button.update"/></button>--%>

<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </form>--%>
<%--                            </td>--%>
<%--                            <td>--%>
<%--                                <form method="post" action="delete_meal">--%>
<%--                                    <input type="hidden" name="command" value="delete_meal">--%>
<%--                                    <input type="hidden" name="mealId" value="${dinnerMeal.mealId}">--%>
<%--                                    <input type="hidden" name="totalProducts" value="${totalProducts}">--%>
<%--                                    <input type="hidden" name="selected_date" value="${selected_date}">--%>
<%--                                    <button type="submit" class="btn btn-danger"><fmt:message--%>
<%--                                            key="profile.button.delete"/></button>--%>
<%--                                </form>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
<%--                </c:if>--%>

                <tr class="table-success">
                    <th><fmt:message key="profile.total"/></th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>${totalPrice}</td>

                    <td></td> <!--Quantity column -->
                    <td></td> <!--Delete column -->
                </tr>

                </tbody>
            </table>


            <!--Comments -->
            <div class="container">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">

                        <div class="comment-tabs">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item nav-link active"><a href="#comments-logout" role="tab"
                                                                        data-toggle="tab"
                                                                        style="text-decoration:none"><h4
                                        class="reviews text-capitalize"><fmt:message key="profile.comments"/></h4></a>
                                </li>
                                <li class="nav-item nav-link "><a href="#add-comment" role="tab" data-toggle="tab"
                                                                  style="text-decoration:none"><h4
                                        class="reviews text-capitalize">
                                    <fmt:message key="profile.add_comment"/></h4></a></li>
                            </ul>

                            <div class="tab-content">
                                <div class="tab-pane active" id="comments-logout">
                                    <ul class="media-list">

                                        <c:if test="${userCommentList.isEmpty()}">
                                            <fmt:message key="profile.message.no_comments"/>
                                        </c:if>

                                        <!--Comment -->
                                        <c:forEach var="userComment" items="${userCommentList}">
                                            <li class="media">
                                                <div class="media-body" style="padding-bottom: 15px;">
                                                    <c:if test="${User.userId == userComment.commentator.userId or User.userId == userComment.userId}">
                                                        <form method="post" action="delete_comment">
                                                            <input type="hidden" name="command" value="delete_comment">
                                                            <input type="hidden" name="commentId"
                                                                   value="${userComment.commentId}">
                                                            <input type="hidden" name="mealDate"
                                                                   value="${selected_date}">


                                                            <button type="submit" class="close float-right"
                                                                    aria-label="Close">
                                                                <span aria-hidden="true">×</span>
                                                            </button>
                                                        </form>
                                                    </c:if>

                                                    <div class="card card-body bg-light">
                                                        <div>
                                                            <h4 class="media-heading text-uppercase"
                                                                style="display:inline-block">
                                                                    ${userComment.commentator.firstName} ${userComment.commentator.surname}
                                                            </h4>
                                                            <span class="float-right"
                                                                  style="display:inline-block">${userComment.dateOfComment}</span>

                                                        </div>

                                                        <p class="media-comment">
                                                                ${userComment.comment}
                                                        </p>
                                                    </div>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>

                                <!--Add comment -->
                                <div class="tab-pane" id="add-comment">
                                    <form method="post" action="comment" class="form-horizontal" id="commentForm"
                                          role="form">
                                        <input type="hidden" name="command" value="comment">
                                        <input type="hidden" name="mealDate" value="${selected_date}">


                                        <div class="form-group">
                                            <div class="col-sm-10">
                                                <textarea minlength="1" maxlength="2000" class="form-control"
                                                          name="comment"
                                                          id="addComment"
                                                          rows="5"></textarea>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-sm-offset-2 col-sm-10">
                                                <button class="btn btn-success btn-circle text-uppercase" type="submit"
                                                        id="submitComment"><span class="fa fa-send"></span>
                                                    <fmt:message key="profile.event.comment"/>
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <!--Add comment -->

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    <jsp:include page="footer.jsp"/>

</div>


</body>
</html>