<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>BOARD MODIFY FORM</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function(){
        $('#modifyButton').click(function(){
            if($('#boardPw').val().length <6) {
                alert('boardPw는 6자이상 입력하세요');
                $('#boardPw').focus();
            } else if($('#boardTitle').val()=='') {
                alert('boardTitle을 입력하세요');
                $('#boardTitle').focus();
            } else if($('#boardContent').val()=='') {
                alert('boardContent을 입력하세요');
                $('#boardContent').focus();
            } else if($('#boardUser').val()=='') {
                alert('boardUser을 입력하세요');
                $('#boardUser').focus();
            } else {
                $('#modifyForm').submit();
            }
        });
    });
</script>
</head>
<body>
<div class="container">
<h1>BOARD MODIFY</h1>
<%
    if(request.getParameter("boardNo") == null) {
        response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
    } else {
        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        System.out.println("boardModify param boardNo:"+boardNo);
        String boardTitle = "";
        String boardContent = "";
        
        String dbUrl = "jdbc:mysql://127.0.0.1:3306/jjdev?useUnicode=true&characterEncoding=euckr";
        String dbUser = "root";
        String dbPw = "java0000";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
            String selectSql = "SELECT board_title, board_content FROM board WHERE board_no=?";
            statement = connection.prepareStatement(selectSql);
            statement.setInt(1, boardNo);
            resultSet = statement.executeQuery();
            if(resultSet.next()) {
                boardTitle = resultSet.getString("board_title");
                boardContent = resultSet.getString("board_content");
            } else {
                response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("BOARD MODIFY FROM ERROR!");
        } finally {
            try {resultSet.close();} catch(Exception e){}
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        }
%>    
        <form id="modifyForm" action="<%=request.getContextPath()%>/jsp_board/boardModifyAction.jsp" method="post">
            <div class="form-group">boardNo :
                <input class="form-control" name="boardNo" value="<%=boardNo%>" type="text" readonly="readonly"/>
            </div>
            <div class="form-group">
                <label for="boardPw">비밀번호 확인 :</label>
                <input class="form-control" name="boardPw" id="boardPw" type="password"/>
            </div>    
            <div class="form-group">
                <label for="boardPw">boardTitle :</label>
                <input class="form-control" value="<%=boardTitle%>" name="boardTitle" id="boardTitle" type="text"/>
            </div>
            <div class="form-group">boardContent :
                <textarea class="form-control" id="boardContent" name="boardContent" rows="5" cols="50"><%=boardContent%></textarea>
            </div>
            <div>
                <input class="btn btn-dark" id="modifyButton" type="button" value="수정"/>
                <input class="btn btn-dark" type="reset" value="초기화"/>
                <a class="btn btn-dark" href="<%=request.getContextPath()%>/jsp_board/boardList.jsp">목록</a>
            </div>
        </form>
<%
    }    
%>
</div>
</body>
</html>


