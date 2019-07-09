<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>BOARD REMOVE FORM</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function(){
        $('#removeButton').click(function(){
            if($('#boardPw').val().length <6) {
                alert('boardPw�� 6���̻� �̾�� �մϴ�');
                $('#boardPw').focus();
            } else {
                $('#removeForm').submit();
            }
        });
    });
</script>
</head>
<body>
<div class="container">
<%
    // boardNo���� �Ѿ���� ������ boardList.jsp�� �̵�
    if(request.getParameter("boardNo") == null) {
        response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
    } else {
%>
        <form  class="form-inline" id="removeForm" action="<%=request.getContextPath()%>/jsp_board/boardRemoveAction.jsp" method="post">
            <!-- boardPw�� �Բ� boardNo���� ���ܼ�(hidden������) �ѱ� -->
            <input name="boardNo" value="<%=request.getParameter("boardNo")%>" type="hidden"/>
            <div class="form-group">
                <label for="boardPw">��й�ȣȮ�� :</label>
                <input class="form-control" id="boardPw" name="boardPw" type="password">
            </div>
            <div class="form-group">
                <input class="btn btn-dark" id="removeButton" type="button" value="����"/>
            </div>
        </form>
<%    
    }
%>
</div>
</body>
</html>


