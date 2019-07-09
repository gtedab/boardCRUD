<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>BOARD ADD</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function(){
        $('#addButton').click(function(){
            if($('#boardPw').val().length <6) {
                alert('boardPw�� 6���̻� �Է��ϼ���');
                $('#boardPw').focus();
            } else if($('#boardTitle').val()=='') {
                alert('boardTitle�� �Է��ϼ���');
                $('#boardTitle').focus();
            } else if($('#boardContent').val()=='') {
                alert('boardContent�� �Է��ϼ���');
                $('#boardContent').focus();
            } else if($('#boardUser').val()=='') {
                alert('boardUser�� �Է��ϼ���');
                $('#boardUser').focus();
            } else {
                $('#addForm').submit();
            }
        });
    });
</script>
</head>
<body>
<div class="container">
	<h1>BOARD ADD</h1>
	<form id="addForm" action="<%=request.getContextPath()%>/jsp_board/boardAddAction.jsp" method="post">
    	<div class="form-group">
    		<label for="boardPw">boardPw :</label>>
    		<input class="form-control" name="boardPw" id="boardPw" type="password"/>
    	</div>
    	<div class="form-group">
            <label for="boardPw">boardTitle :</label>
            <input class="form-control" name="boardTitle" id="boardTitle" type="text"/>
        </div>
        <div class="form-group">
            <label for="boardContent">boardContent :</label>
            <textarea class="form-control" name="boardContent" id="boardContent" rows="5" cols="20"></textarea>
        </div>
        <div class="form-group">
            <label for="boardName">boardName :</label>
            <input class="form-control" name="boardUser" id="boardUser" type="text"/>
        </div>
    <div>
        <input class="btn btn-dark" id="addButton" type="button" value="���Է�"/>
        <input class="btn btn-dark" type="reset" value="�ʱ�ȭ"/>
        <a class="btn btn-dark" href="<%=request.getContextPath()%>/jsp_board/boardList.jsp">���</a>
    </div>
</form>
</div>
</body>
</html>


