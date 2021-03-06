<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- header -->
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<link rel="stylesheet"
	href="<s:url value="/ueditor/themes/default/css/ueditor.css"></s:url>" />
	<script type="text/javascript"
		src="<s:url value="/ueditor/ueditor.config.js"></s:url>"></script>
	<script type="text/javascript"
		src="<s:url value="/ueditor/ueditor.all.min.js"></s:url>"></script>
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<script type="text/javascript">
			try {
				ace.settings.check('main-container', 'fixed')
			} catch (e) {
			}
		</script>

		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<!-- /section:settings.box -->
					<div class="row">
						<div class="col-xs-12">
							<form class="form-horizontal"  onsubmit="return false;" role="form" id="broadcastFrom">

								<div class="form-group">
									<label class="col-sm-1 control-label no-padding-right"
										for="title">标题</label>
									<div class="col-sm-4">
										<input type="text" name="title" id="title" placeholder="请输入标题"
											value="${centuryNewscast.title}"
											class="form-control required"
											>
									</div>



									<label class="col-sm-2 control-label no-padding-right"
										for="url">链接</label>
									<div class="col-sm-4">
										<input type="text" name="url" id="url" placeholder="请输入链接"
											value="${centuryNewscast.url}" class="form-control required">
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-1 control-label no-padding-right"
										for="image">图像</label>
									<div class="col-sm-4">
										<input class="col-xs-9" type="text" name="image" id="image" placeholder="请输入链接" readonly="readonly"
											value="${centuryNewscast.image}" class="form-control required">
										
										<button class="btn btn-sm btn-success col-xs-3" onclick="upImage()">图片修改</button>
									</div>
									<label class="col-sm-2 control-label no-padding-right"
										for="orderBy">排序</label>
									<div class="col-sm-4">
										<input type="number" name="orderBy" id="orderBy"
											placeholder="请输入链接" value="${centuryNewscast.orderBy}"
											class="form-control ">

									</div>

								</div>

								<input type="hidden" name="content" id="content">
								<input type="hidden" name="newsType" id="newsType" value="${centuryNewscast.newsType}">
								<input type="hidden" name="sysId" id="sysId" value="${centuryNewscast.sysId}">

							</form>
							<form class="form-horizontal" role="form">
								<div class="form-group">
									<label class="col-sm-1 control-label no-padding-right"
										for="content">活动内容</label>
									<div class="col-sm-10">
										<textarea id="container">${centuryNewscast.content }</textarea>
									</div>
								</div>

							</form>
							<h3 class="header smaller lighter green"></h3>
							<div class="col-xs-9" align="right">
								<button class="btn btn-sm btn-primary" id="save">
									<i class="ace-icon fa fa-pencil align-top bigger-125"></i>保存
								</button>
								&nbsp;&nbsp;
								<button class="btn btn-sm btn-pink" id="reset">
									<i class="ace-icon fa fa-pencil align-top bigger-125"></i>重置
								</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->

		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

		<!-- dialog -->
		<%@ include file="/WEB-INF/views/include/dialog.jsp"%>
	</div>
	<!-- /.main-container -->
	</div>
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script type="text/plain" id="upload_ue"></script>
	<script type="text/javascript">
		var ue = UE.getEditor('container', {
			initialFrameHeight : 300,
			autoHeightEnabled : false
		});

		jQuery(function($) {
			$('.date-picker').datepicker({
				inline : true,
				format : "yyyy-mm-dd",
				autoclose : true,
				todayHighlight : true,
				language : 'cn'
			})
			//show datepicker when clicking on the icon
			.next().on(ace.click_event, function() {
				$(this).prev().focus();
			});
		});
 
 

 $("#save").click(function(){
	 $("#content").val(ue.getContent());
 	if($("#broadcastFrom").valid()) {

 						postCallBack({
 							data:serialize("#broadcastFrom"),
 							url:'<s:url value="/modules/century/broadcast/edit"></s:url>',
							successMessage: "更新成功",
							successTitle: "消息对话框",
							failMessage: "更新失败",
							failTitle: "消息对话框"
 						});		
 					var appid = "broadcastEdit";
 					window.parent.closeapp($("#task-content li[app-id='"+ appid +"']",parent.document));
 					

 		} else {
 			showGritter("操作提示", "您当前未按照要求填写数据，请查看具体的表单提示信息");//消息提示
 		}
 	});

 $("#reset").click(function(){
 	//重置表单
 	$('#broadcastFrom')[0].reset();
 });
 
 
//上传独立使用
 var _editor = UE.getEditor('upload_ue');
 _editor.ready(function () {
     _editor.setDisabled();
     _editor.hide();
     _editor.addListener('beforeInsertImage', function (t, arg) {     //侦听图片上传
     	//将地址赋值给相应的input
         $("#image").attr("value", arg[0].src);
         //图片预览
         $("#preview").attr("src", arg[0].src);
     })
     _editor.addListener('afterUpfile', function (t, arg) {
         $("#file").attr("value", arg[0].url);
     })
 });
 function upImage() {
     var myImage = _editor.getDialog("insertimage");
     myImage.open();
 }
 function upFiles() {
     var myFiles = _editor.getDialog("attachment");
     myFiles.open();
 }
	</script>
</body>
</html>