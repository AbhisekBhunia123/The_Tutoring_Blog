
<%@page import="com.tech.blog.entities.*,com.tech.blog.dao.*,com.tech.blog.helper.*,java.util.*,java.text.*" %>
<%@page errorPage="error_page.jsp" %>
<%
    User user=(User)session.getAttribute("currentUser");
    if(user == null){
    response.sendRedirect("login_page.jsp");
    
    }

%>
<%
    int postId=Integer.parseInt(request.getParameter("post_id"));
    
    PostDao d=new PostDao(ConnectionProvider.getConnection());
    
    Post p=d.getPostByPostId(postId);
    
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle() %> || Tech Blog</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 98%, 66% 93%, 29% 98%, 0 94%, 0 0);
            }

            .post-title{
                font-weight: 100;
                font-size: 30px;
            }

            .post-content{
                font-weight: 100;
                font-size: 20px;
            }

            .post-date{
                font-style: italic;
                font-weight: bold;

            }

            .post-user-info{
                font-size: 20px;

            }
        </style>
    
</head>
<body>
    <!--navbar-->

    <nav class="navbar navbar-expand-lg navbar-dark primary-background">
        <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span>Tech Blog</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#"><span class="fa fa-bullhorn"></span>Learn Code With Abhisek <span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="fa fa-check-square-o"></span> Categories
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="#">Programming Language</a>
                        <a class="dropdown-item" href="#">Project Implementation</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Data Structure</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span>Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" style="cursor:pointer" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-asterisk"></span>Do Post</a>
                </li>

            </ul>
            <ul class="navbar-nav mr-right">
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span><%= user.getName() %></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"></span>Logout</a>
                </li>
            </ul>
        </div>
    </nav>


    <!--end of navbar-->

    <!--main content of body-->

    <div class="container">
        <div class="row my-4">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header">
                        <h4 class="post-title"><%= p.getpTitle() %></h4>
                    </div>
                    <div class="card-body">
                        <img class="card-img-top" src="blog_pics/<%= p.getpPic() %>" alt="Card image cap" style="height: 200px;max-width: 100%">

                        <div class="row my-3">
                            <div class="col-md-8">
                                <% 
                                UserDao ud=new UserDao(ConnectionProvider.getConnection());
                                    
                                    
                                %>
                                <p class="post-user-info"><a href="#"><%= ud.getUserByUserId(p.getUserId()).getName() %></a> has posted</p>

                            </div>
                            <div class="col-md-4">
                                <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate()) %></p>
                            </div>
                        </div>

                        <p class="post-content"><%= p.getpContent() %></p>

                        <br>
                        <br>
                        <div class="post-code">
                            <pre><%= p.getpCode() %></pre>
                        </div>
                    </div>
                    <div class="card-footer">
                        <% 
                            LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
                                
                        %>
                        <a href="#" onclick="doLike(<%= p.getPid() %>,<%= user.getId() %>)" class="btn"><i class="fa fa-thumbs-o-up" ></i><span class="like-counter"> <%= ld.countLikeOnPost(p.getPid()) %></span> </a>
                        <a href="#" class="btn"><i class="fa fa-commenting-o"></i><span>20</span> </a>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>

    <!--end main content of body-->

    <!--profile modal-->


    <!-- Modal -->
    <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header primary-background text-white">
                    <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container text-center">
                        <img src="pics/<%= user.getProfile() %>" style="border-radius: 50%;width:150px;height: 150px" />
                        <h5 class="modal-title"> <%= user.getName() %></h5>

                        <!--details-->
                        <div id="profile-details">
                            <table class="table">

                                <tbody>
                                    <tr>
                                        <th scope="row">ID</th>
                                        <td><%= user.getId() %></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Email</th>
                                        <td><%= user.getEmail() %></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Gender</th>
                                        <td><%= user.getGender() %></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Status</th>
                                        <td><%= user.getAbout() %></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Registered on</th>
                                        <td><%= user.getDateTime().toString() %></td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!--profile edit-->
                        <div id="profile-edit" style="display:none">
                            <h3 class="mt-2">Please Edit Carefully</h3>
                            <form action="EditServlet" method="post" enctype="multipart/form-data">
                                <table class="table">
                                    <tr>
                                        <td>ID</td>
                                        <td><%= user.getId() %></td>
                                    </tr>
                                    <tr>
                                        <td>Email</td>
                                        <td><input class="form-control" type="email" name="user_email" value="<%= user.getEmail() %>"/></td>
                                    </tr>
                                    <tr>
                                        <td>Name</td>
                                        <td><input class="form-control" type="text" name="user_name" value="<%= user.getName() %>"/></td>
                                    </tr>
                                    <tr>
                                        <td>Password</td>
                                        <td><input class="form-control"  type="password" name="user_password" value="<%= user.getPassword() %>"/></td>
                                    </tr>
                                    <tr>
                                        <td>Gender</td>
                                        <td><%= user.getGender().toUpperCase() %></td>
                                    </tr>
                                    <tr>
                                        <td>About</td>
                                        <td>
                                            <textarea class="form-control" name="user_about" rows="3"><%= user.getAbout() %>
                                            </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>New Profile PIc</td>
                                        <td>
                                            <input type="file" accept=".png,.jpg,.jpeg" name="image" class="form-control" />
                                        </td>
                                    </tr>

                                </table>

                                <div class="container">
                                    <button type="submit" class="btn btn-outline-primary">Save</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>

    <!--end of profile modal-->

    <!--post modal-->


    <!-- Modal -->
    <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Provide the post details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="add-post-form" action="AddPostServlet" method="post">
                        <div class="form-group">
                            <select class="form-control" name="cid">
                                <option selected disabled>---Select Category---</option>
                                <%
                                    PostDao postd=new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> list=postd.getAllCategories();
                                    for(Category c:list){
                                %>
                                <option value="<%= c.getCid() %>"><%= c.getName() %></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <input name="pTitle" type="text" placeholder="Enter post title" class="form-control" />
                        </div>
                        <div class="form-group">
                            <textarea name="pContent" class="form-control" placeholder="Enter your content" style="height:200px"></textarea>
                        </div>
                        <div class="form-group">
                            <textarea name="pCode" class="form-control" placeholder="Enter your programm (if any)" style="height:200px"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Select your pic.</label>
                            <br>
                            <input type="file" name="pic" />
                        </div>
                        <div class="container text-center">
                            <button type="submit" class="btn btn-outline-primary">Post</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>

    <!--end of post modal-->



    <script
        src="https://code.jquery.com/jquery-3.6.4.min.js"
        integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8="
        crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="js/myjs.js" type="text/javascript"></script>
    <script>
                            $(document).ready(function () {
                                let editStatus = false;


                                $("#edit-profile-btn").click(function () {
                                    if (editStatus === false) {
                                        $("#profile-details").hide();
                                        $("#profile-edit").show();
                                        editStatus = true;
                                        $(this).text("Back");
                                    } else {
                                        $("#profile-edit").hide();
                                        $("#profile-details").show();
                                        editStatus = false;
                                        $(this).text("Edit");
                                    }
                                });
                            });
    </script>

    <!--now add post js-->
    <script>
        $(document).ready(function () {

            $("#add-post-form").on("submit", function (event) {
                //this.code gets called when form submitted....
                event.preventDefault();
                let form = new FormData(this);

                //now requesting to server
                $.ajax({
                    url: "AddPostServlet",
                    type: "POST",
                    data: form,
                    success: function (data, textStatus, jqXHR) {
                        //success...
                        if (data.trim() === 'done') {
                            swal("Good job!", "Post saved successfully", "success");

                        } else {
                            swal("Error", "Something went wrong try again", "error");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        swal("Error", "Something went wrong try again", "error");
                    },
                    processData: false,
                    contentType: false
                });
            });
        });
    </script>
    <!--loading post using ajax-->
    <script>
        function doLike(pid, uid) {
//                console.log(pid, uid);
            const d = {
                uid: uid,
                pid: pid,
                operation: 'Like'
            }
            $.ajax({
                url: "LikeServlet",
                data: d,
                success: function (data, textStatus, jqXHR) {
                    console.log(data);
                    if (data.trim() === 'true') {
                        let c = $(".like-counter").html();
                        c++;
                        $(".like-counter").html(c);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(data);
                }
            })
        }
    </script>
</body>
</html>
