<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>BOARD LIST</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
<h1>BOARD LIST</h1>
<%
    // boardList.jsp페이지에는 currentPage라는 매개변수가 넘어와야 하는데
    // 매개변수가 안 넘어오는 경우 currentPage를 1이 대입된다.
    int currentPage = 1;
    if(request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }
    System.out.println("currentPage : "+currentPage); 
    // 전체 게시글의 수를 구하는 코드
    int totalRowCount = 0; 
    String dbUrl = "jdbc:mysql://127.0.0.1:3306/jjdev?useUnicode=true&characterEncoding=euckr";
    String dbUser = "root";
    String dbPw = "java0000";
    Connection connection = null;
    PreparedStatement totalStatement = null;
    PreparedStatement listStatement = null;
    ResultSet totalResultSet = null;
    ResultSet listResultSet = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
        
        String totalSql = "SELECT COUNT(*) FROM board"; // board테이블의 전체행의 수를 반환
        totalStatement = connection.prepareStatement(totalSql);
        totalResultSet = totalStatement.executeQuery();
        if(totalResultSet.next()) {
            totalRowCount = totalResultSet.getInt(1);
        }
%>
    <div>전체행의 수 : <%=totalRowCount%></div>
<%    
    int pagePerRow = 10; // 페이지당 보여줄 글의 목록을 10개로 설정
    String listSql = "SELECT board_no, board_title, board_user, board_date FROM board ORDER BY board_no DESC LIMIT ?, ?";
    listStatement = connection.prepareStatement(listSql);
    listStatement.setInt(1, (currentPage-1)*pagePerRow); // 현재페이지가 1페이지면 0행부터, 2페이지면 10행부터, 3페이지면 20행부터...
    listStatement.setInt(2, pagePerRow); 
    listResultSet = listStatement.executeQuery();
%>
    <table class="table table-dark table-hover">
        <thead>
            <tr>
                <th>boardTitle</th>
                <th>boardUser</th>
                <th>boardDate</th>
            </tr>
        </thead>
        <tbody>
<%
            while(listResultSet.next()) {
%>
                <tr>
                    <td><a href="<%=request.getContextPath()%>/jsp_board/boardView.jsp?boardNo=<%=listResultSet.getInt("board_no")%>"><%=listResultSet.getString("board_title")%></a></td>
                    <td><%=listResultSet.getString("board_user")%></td>
                    <td><%=listResultSet.getString("board_date")%></td>
                </tr>
<%        
            }
%>
        </tbody>
    </table>
    <div>
        <a class="btn btn-dark" href="<%=request.getContextPath()%>/jsp_board/boardAddForm.jsp">게시글 입력</a>
    </div>
<%
    // 마지막 페이지는 전체글의수를 pagePerRow로 나누었을때 나누어 떨어지면 몫이 마지막 페이지 
    // ex) 전체글이 50개 / 10개씩 -> 마지막 페이지는 5페이지
    // 나누어 떨어지지 않으면
    // ex) 전체글이 51개 / 10개씩 -> 마지막 페이지는 6페이지
    int lastPage = totalRowCount/pagePerRow;
    if(totalRowCount % pagePerRow != 0) {
        lastPage++;
    }
%>
    <div>
<%
        if(currentPage>1) { // 현재 페이지가 1페이지보다 크면 이전페이지 링크를 추가
%>
            <a class="btn btn-dark" href="<%=request.getContextPath()%>/jsp_board/boardList.jsp?currentPage=<%=currentPage-1%>">이전</a>
<%
        }
        if(currentPage < lastPage) { // 현재 페이지가 마지막 페이지보다 작으면 다음페이지 링크를 추가
%>
            <a class="btn btn-dark" href="<%=request.getContextPath()%>/jsp_board/boardList.jsp?currentPage=<%=currentPage+1%>">다음</a>
<%
        }
%>
    </div>
<%
    } catch(Exception e) {
        e.printStackTrace();
        out.print("게시판 목록 가져오기 실패!");
    } finally {
        try {totalResultSet.close();} catch(Exception e){}
        try {listResultSet.close();} catch(Exception e){}
        try {totalStatement.close();} catch(Exception e){}
        try {listStatement.close();} catch(Exception e){}
        try {connection.close();} catch(Exception e){}
    }
%>
</div>
</body>
</html>


