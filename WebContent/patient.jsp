<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Patient Portal</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
	<%String name=(String)request.getAttribute("data");%>
	<div class="header">
		<strong>Patient Portal</strong>
		<h4 style="float:right">Hello <%=name%>!</h4>
	</div>
	<div class="container">
		<h4 style="margin-top:20px">Click Here to contact Doctor</h4>
		<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Fill Form</button>
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
			  <!-- Modal content-->
			  <div class="modal-content">
				<div class="modal-header">
				<h3 style="float:left"><class="modal-title">Patient Details</h3>
				  <button type="button" class="close" data-dismiss="modal" style="float:right">&times;</button>
				</div>
				<div class="modal-body">
				<h5>
						<label>Enter Body Temperature(<span>&#8451;</span>)</label>
						<input class="form-control" type="tel" name="temp" id="temp" style="margin:10px 0;" required>
						<label>Enter Oxygen Levels</label>
						<input class="form-control" type="tel" name="vital" id="vital" style="margin:10px 0;" required>
						<label>Enter Pulse Rate</label>
						<input class="form-control" type="tel" name="pulse" id="pulse" style="margin:10px 0;" required>
						<label>Enter Phone Number:</label>
						<input class="form-control" type="tel" name="phone" id="phone" style="margin:10px 0;" required>
				</h5>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					<button type="button" onclick="sendVitals();" class="btn btn-success " data-dismiss="modal">Submit</button>
				</div>
			  </div>
			</div>
		</div>
		<br /><br />
		<table id="example" class="table">
			<thead>
				<tr>
					<th>From</th>
					<th>Medicine</th>
					<th>Description</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				</tr>
			</tbody>
		</table>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script>
		var websocket=new WebSocket("ws://localhost:8080/WebSocket/VitalCheckEndPoint");
		websocket.onmessage=function processVital(vital){
			var jsonData=JSON.parse(vital.data);
			if(jsonData.message!=null)
			{
				var details=jsonData.message.split(',');
				var row=document.getElementById('example').insertRow();
				if(details.length>2)
				{
					row.innerHTML="<td>"+details[0]+"</td><td>"+details[1]+"</td><td>"+details[2]+"</td>";		
				}
				else
				{
					alert(details[0]+" has summoned an ambulance");
					row.innerHTML="<td>"+details[0]+"</td><td></td><td>"+details[1]+"</td>";		
				}
			}
		}
		function sendVitals()
		{
			var o2=document.getElementById("vital").value;
			var phone=document.getElementById("phone").value;
			var temp=document.getElementById("temp").value;
			var pulse=document.getElementById("pulse").value;
			var regex=/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/;
			console.log(o2,phone,temp,pulse);
			if(02==null || o2=="" || phone==null || phone=="" || temp=="" || temp==null){
				alert("Enter the details");
			}
			else if(regex.test(phone)==false){
				alert("Enter phone number correctly!");
			}
			else if(o2<95 && (temp>37.2 || temp<36.1)){
				alert("Data sent to Doctor!");
				websocket.send(o2+","+temp+","+pulse+","+phone);
				vital.value="";
				temp.value="";
				pulse.value="";
				phone.value="";
			}
			else{
				confirm("Your are fine! No need of doctor");
			}
		}
	</script>
	<style>
		.container{
			text-align:center;
			margin-top: 5px;	
		}
		.header{
			font-size:25px;
			text-align:center;
			border-bottom:5px red;
			padding: 25px;
			background-color:#80ced6;
		}
		body{
			background-color:#F6F6F6;
		}
		tr,td,th{
			border:2px solid black;
			font-weight:bold;
		}
		th{
			background-color:#b1cbbb;
		}
		table{
			color:black;
		}
	</style>
</body>
</html>
