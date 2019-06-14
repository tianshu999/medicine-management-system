<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/inc.jsp"></jsp:include>
	<style>
	.huibd {
		border: 1px solid #000000;
			}
	td {
		white-space: nowrap;
		font-size: 12px;
		}
	</style>
<link rel="stylesheet" href="<%=basePath%>/main/include/css/button-usr.css" type="text/css"></link>
<script language="javascript" type="text/javascript" src="<%=basePath%>/main/include/js/form_valid.js"></script>
<script language="javascript" type="text/javascript" src="<%=basePath%>/jslib/datepicker/WdatePicker.js"></script>
<link rel="stylesheet" href="<%=basePath%>/main/css/tablelock.css" mce_href="tablelock.css" /> 
<script type="text/javascript" language="javascript" src="<%=basePath%>/main/js/tablelock.js"></script> 

<script type="text/javascript" src="<%=basePath%>/jslib/Validform_v5.3.1/Validform_v5.3.1_min.js"></script>
<link rel="stylesheet" href="<%=basePath%>/jslib/Validform_v5.3.1/Validform_v5.3.1.css"/> 

<script type="text/javascript" charset="utf-8">
var myForm;
$(document).ready(function() {
		//$.fn.TableLock({table:'jeecgOrderCustom_table',lockRow:0,lockColumn:0,width:'960px',height:'100%'});
	//$.fn.TableLock({table:'jeecgOrderProduct_table',lockRow:0,lockColumn:0,width:'960px',height:'100%'});
	
	//$(".tabs").tabs();
	//update-begin--Author:xiewenyu  Date:20130313
	$(".tabs").tabs({width:907});
	//update-end--Author:xiewenyu  Date:20130313
	$("#doReturn").click(function(){
		 window.parent.window.closePayoutDialog();
		});
	
	 //订单客户明细追加
	 $("#button_add_jeecgOrderCustom").bind("click", function(){
	  	  var tr =  $("#add_jeecgOrderCustom_table_template tr").clone();
	 	 $("#add_jeecgOrderCustom_table").append(tr);
	 	  resetTrNum('add_jeecgOrderCustom_table');
	 });
	 //订单客户明细删除
	 $("#button_del_jeecgOrderCustom").bind("click", function(){
	  	$("#add_jeecgOrderCustom_table").find("input:checked").parent().parent().remove(); 
	 	 resetTrNum('add_jeecgOrderCustom_table');
	 });
	 //订单产品明细追加
	 $("#button_add_jeecgOrderProduct").bind("click", function(){
	  	  var tr =  $("#add_jeecgOrderProduct_table_template tr").clone();
	 	 $("#add_jeecgOrderProduct_table").append(tr);
	 	  resetTrNum('add_jeecgOrderProduct_table');
	 });
	 //订单产品明细删除
	 $("#button_del_jeecgOrderProduct").bind("click", function(){
	  	$("#add_jeecgOrderProduct_table").find("input:checked").parent().parent().remove(); 
	 	 resetTrNum('add_jeecgOrderProduct_table');
	 });
});

	 //初始化下标
	function resetTrNum(tableId) {
		$tbody = $("#"+tableId+"");
		$tbody.find('>tr').each(function(i){
			$(':input, select', this).each(function(){
				var $this = $(this), name = $this.attr('name'), val = $this.val();
				if(name!=null){
					if (name.indexOf("#index#") >= 0){
						$this.attr("name",name.replace('#index#',i));
					}else{
						var s = name.indexOf("[");
						var e = name.indexOf("]");
						var new_name = name.substring(s+1,e);
						$this.attr("name",name.replace(new_name,i));
					}
				}
			});
		});
	}
	//form提交
	function dosubmit() {
		myForm = $("#myForm").Validform( {
			postonce : true,
			showAllError:false,
			tiptype:function(msg,o,cssctl){
			//msg：提示信息;
			//o:{obj:*,type:*,curform:*},
			//obj指向的是当前验证的表单元素（或表单对象，验证全部验证通过，提交表单时o.obj为该表单对象），
			//type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, 
			//curform为当前form对象;
			//cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
				if($(".messager-window").length!==0){return false;}
				if(o.type==3){
					$.messager.alert('提示',msg,'warning',function (){
						o.obj.focus();
					});
				}
			}
		});
		myForm.config({
			url : "jeecgOrderMainAction!addMain.action",
			ajaxpost : {
				//可以传入$.ajax()能使用的，除dataType外的所有参数;
				success : function(data) {
					if (data && data.success) {
						//父窗口刷新datagrid,提示操作消息
						window.parent.window.datagrid.datagrid('reload');
						window.parent.window.messageshow('成功', data.msg);
						window.parent.window.addDialog.close();
					} else {
						window.parent.window.messageshow('失败', '操作失败!');
					}
				}
			}
		});
		myForm.ajaxPost(false);
	}
</script>
</head>
<body>
        <div id="chk_idAll">
            <form name="myForm" id="myForm" method="post">
             <div>
              <table>
                  <tr bgcolor="#CCE6D1">
                    <td colspan="8"  align="center" style="font-size:14px;"><strong>订单主数据</strong></td>
                  </tr>
					<tr>
                   	 	<td align="left">订单号</td>
                    	<td align="left">
                    	<input name="goOrderCode" type="text"  maxlength="36" datatype="s6-10"
								nullmsg="请输入订单号！" errormsg="订单号应该为6到10位"/>
                    	</td>
                   	 	<td align="left">订单类型 0</td>
                    	<td align="left">
                    	<input name="goderType" type="text"  maxlength="2" />
                    	</td>
                   	 	<td align="left">订单团购状态</td>
                    	<td align="left">
                    	<input name="goStatus" type="text"  maxlength="2" />
                    	</td>
                   	 	<td align="left">旅行社ID</td>
                    	<td align="left">
                    	<input name="touristid" type="text"  maxlength="36" />
                    	</td>
					</tr>
					<tr>
                   	 	<td align="left">旅行社门店I</td>
                    	<td align="left">
                    	<input name="agencyId" type="text"  maxlength="36" />
                    	</td>
                   	 	<td align="left">旅行社名称</td>
                    	<td align="left">
                    	<input name="agencyName" type="text"  maxlength="50" data-options=""/>
                    	</td>
                   	 	<td align="left">联系人ID</td>
                    	<td align="left">
                    	<input name="linkmenid" type="text"  maxlength="36" data-options=""/>
                    	</td>
                   	 	<td align="left">顾客类型 :</td>
                    	<td align="left">
                    	<input name="usertype" type="text"  maxlength="1" data-options=""/>
                    	</td>
					</tr>
					<tr>
                   	 	<td align="left">客户</td>
                    	<td align="left">
                    	<input name="goCusName" type="text"  maxlength="50" data-options=""/>
                    	</td>
                   	 	<td align="left">销售人</td>
                    	<td align="left">
                    	<input name="goSaleName" type="text"  maxlength="100" data-options=""/>
                    	</td>
                   	 	<td align="left">销售人ID</td>
                    	<td align="left">
                    	<input name="goSaleId" type="text"  maxlength="36" data-options=""/>
                    	</td>
                   	 	<td align="left">联系人</td>
                    	<td align="left">
                    	<input name="goContactName" type="text"  maxlength="50" data-options=""/>
                    	</td>
					</tr>
					<tr>
                   	 	<td align="left">区号</td>
                    	<td align="left">
                    	<input name="goZoneNo" type="text"  maxlength="6" data-options=""/>
                    	</td>
                   	 	<td align="left">电话</td>
                    	<td align="left">
                    	<input name="goPhone" type="text"  maxlength="20" data-options=""/>
                    	</td>
                   	 	<td align="left">手机</td>
                    	<td align="left">
                    	<input name="goTelphone" type="text"  maxlength="20" data-options=""/>
                    	</td>
                   	 	<td align="left">传真</td>
                    	<td align="left">
                    	<input name="goFacsimile" type="text"  maxlength="32" data-options=""/>
                    	</td>
					</tr>
					<tr>
                   	 	<td align="left">邮箱</td>
                    	<td align="left">
                    	<input name="goMail" type="text"  maxlength="32" data-options=""/>
                    	</td>
                   	 	<td align="left">订单人数</td>
                    	<td align="left">
                    	<input name="goOrderCount" type="text" class="easyui-numberbox" maxlength="" data-options=""/>
                    	</td>
                   	 	<td align="left">总价(不含返</td>
                    	<td align="left">
                    	<input name="goAllPrice" type="text" class="easyui-numberbox" maxlength="" data-options=""/>
                    	</td>
                   	 	<td align="left">返款</td>
                    	<td align="left">
                    	<input name="goReturnPrice" type="text" class="easyui-numberbox" maxlength="" data-options=""/>
                    	</td>
					</tr>
					<tr>
                   	 	<td align="left">备注</td>
                    	<td align="left">
                    	<input name="goContent" type="text"  maxlength="200" data-options=""/>
                    	</td>
                   	 	<td align="left">审核状态 0</td>
                    	<td align="left">
                    	<input name="auditorStatus" type="text"  maxlength="2" data-options=""/>
                    	</td>
                   	 	<td align="left">审核人ID</td>
                    	<td align="left">
                    	<input name="auditorObid" type="text"  maxlength="36" data-options=""/>
                    	</td>
                   	 	<td align="left">审核人</td>
                    	<td align="left">
                    	<input name="auditorName" type="text"  maxlength="50" data-options=""/>
                    	</td>
					</tr>
				   </table>
			</div>
				
				
		<div class="tabs">
				
				
				 <div title="订单客户明细">
				  <table>
                  <tr bgcolor="#CCE6D1">
                    <td align="left" ><strong>&nbsp;&nbsp;订单客户明细&nbsp;&nbsp;</strong>
                    <input type="button" id="button_add_jeecgOrderCustom" class=" wd1 btn" value="添加"/>
                    <input type="button" id="button_del_jeecgOrderCustom" class=" wd1 btn" value="删除"/>
                    </td>
                  </tr>
                 
                   <tr>
                    <td  align="left">
                    <table border="0" cellpadding="2" cellspacing="0" id="jeecgOrderCustom_table">
                        <tr bgcolor="#E6E6E6">
                          <td align="center" bgcolor="#EEEEEE">序号</td>
							  <td align="left" bgcolor="#EEEEEE">客户英文名</td>
							  <td align="left" bgcolor="#EEEEEE">姓名</td>
							  <td align="left" bgcolor="#EEEEEE">人员类型</td>
							  <td align="left" bgcolor="#EEEEEE">性别</td>
							  <td align="left" bgcolor="#EEEEEE">身份证号</td>
							  <td align="left" bgcolor="#EEEEEE">出生日期</td>
							  <td align="left" bgcolor="#EEEEEE">护照号</td>
							  <td align="left" bgcolor="#EEEEEE">护照有效期</td>
							  <td align="left" bgcolor="#EEEEEE">业务</td>
							  <td align="left" bgcolor="#EEEEEE">同住</td>
							  <td align="left" bgcolor="#EEEEEE">备注</td>
                        </tr>
                        <tr>
                          <td align="center" colspan="20" height="1" bgcolor="#D8D8D8"></td>
                        </tr>
                        <tbody id="add_jeecgOrderCustom_table">
	                        <tr>
	                          <td align="center"><input type="checkbox" name="ck"/></td>
								<td align="left"><input nullmsg="请输入订单客户明细的客户英文名！" datatype="s6-10"
									errormsg="订单客户明细的客户英文名应该为6到10位" name="jeecgOrderCustomList[0].gocCusNameEn" maxlength="50" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderCustomList[0].gocCusName" maxlength="50" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderCustomList[0].gocCusType" maxlength="3" type="text"  style="width:120px;" ></td>
								
								
								<td align="left">
								<input name="jeecgOrderCustomList[0].gocSex" maxlength="2" type="text" class="easyui-combobox easyui-validatebox" style="width:120px;"
								     data-options="  
					                    url:'dictParamAction!dictCombobox.action?paramLevel=001',  
					                    valueField:'paramValue',  
					                    textField:'paramName',  
					                    panelHeight:'auto'" />
					            </td>
								
								<td align="left"><input name="jeecgOrderCustomList[0].gocIdcard" maxlength="32" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderCustomList[0].gocBirthday" maxlength="" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderCustomList[0].gocPassportCode" maxlength="32" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderCustomList[0].gocPassportEndDate" maxlength="" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderCustomList[0].gocBussContent" maxlength="100" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderCustomList[0].gocRoomNum" maxlength="10" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderCustomList[0].gocContent" maxlength="200" type="text"  style="width:120px;" ></td>
	                        </tr>
                       </tbody>
                      </table>
                    </td>
                  </tr>
             	 </table> 
			  </div>
				
				
				 <div title="订单产品明细">
				  <table>
                  <tr bgcolor="#CCE6D1">
                    <td align="left" ><strong>&nbsp;&nbsp;订单产品明细&nbsp;&nbsp;</strong>
                    <input type="button" id="button_add_jeecgOrderProduct" class=" wd1 btn" value="添加"/>
                    <input type="button" id="button_del_jeecgOrderProduct" class=" wd1 btn" value="删除"/>
                    </td>
                  </tr>
                 
                   <tr>
                    <td  align="left">
                    <table border="0" cellpadding="2" cellspacing="0" id="jeecgOrderProduct_table">
                        <tr bgcolor="#E6E6E6">
                          <td align="center" bgcolor="#EEEEEE">序号</td>
							  <td align="left" bgcolor="#EEEEEE">服务项目类型</td>
							  <td align="left" bgcolor="#EEEEEE">产品名称</td>
							  <td align="left" bgcolor="#EEEEEE">个数</td>
							  <td align="left" bgcolor="#EEEEEE">单位</td>
							  <td align="left" bgcolor="#EEEEEE">单价</td>
							  <td align="left" bgcolor="#EEEEEE">小计</td>
							  <td align="left" bgcolor="#EEEEEE">备注</td>
                        </tr>
                        <tr>
                          <td align="center" colspan="20" height="1" bgcolor="#D8D8D8"></td>
                        </tr>
                        <tbody id="add_jeecgOrderProduct_table">
	                        <tr>
	                          <td align="center"><input type="checkbox" name="ck"/></td>
								<td align="left"><input name="jeecgOrderProductList[0].gopProductType" maxlength="3" type="text"  style="width:120px;" ></td>
								<td align="left"><input nullmsg="请输入订单产品明细的产品名称！" datatype="s6-10"
									errormsg="订单产品明细的产品名称应该为6到10位" name="jeecgOrderProductList[0].gopProductName" maxlength="100" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderProductList[0].gopCount" maxlength="" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderProductList[0].gopUnit" maxlength="2" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderProductList[0].gopOnePrice" maxlength="" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderProductList[0].gopSumPrice" maxlength="" type="text"  style="width:120px;" ></td>
								<td align="left"><input name="jeecgOrderProductList[0].gopContent" maxlength="200" type="text"  style="width:120px;" ></td>
	                        </tr>
                       </tbody>
                      </table>
                    </td>
                  </tr>
             	 </table> 
			  </div>
	   </div>
<%--			<div align="center">--%>
<%--				<table>--%>
<%--                  <tr>--%>
<%--                    <td height="50" colspan="8"  align="center">--%>
<%--                        <input value=" 关 闭 " type="button" id="doReturn"/>--%>
<%--                      	<input value=" 提 交 " type="button" onClick="dosubmit();"  />--%>
<%--                    </td>--%>
<%--                  </tr>--%>
<%--              </table>--%>
<%--		    </div>	--%>
 		 </form>
        </div>

<table style="display:none">
       <tbody id="add_jeecgOrderCustom_table_template">
          <tr>
             <td align="center"><input type="checkbox" name="ck"/></td>
				 <td align="left"><input nullmsg="请输入订单客户明细的客户英文名！" datatype="s6-10"
									errormsg="订单客户明细的客户英文名应该为6到10位" name="jeecgOrderCustomList[#index#].gocCusNameEn" maxlength="50" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderCustomList[#index#].gocCusName" maxlength="50" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderCustomList[#index#].gocCusType" maxlength="3" type="text" style="width:120px;"></td>
								<td align="left">
								<input name="jeecgOrderCustomList[0].gocSex" maxlength="2" type="text" class="easyui-combobox easyui-validatebox" style="width:120px;"
								     data-options="  
					                    url:'dictParamAction!dictCombobox.action?paramLevel=001',  
					                    valueField:'paramValue',  
					                    textField:'paramName',  
					                    panelHeight:'auto'">
					            </td>
				 
				 <td align="left"><input name="jeecgOrderCustomList[#index#].gocIdcard" maxlength="32" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderCustomList[#index#].gocBirthday" maxlength="" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderCustomList[#index#].gocPassportCode"  class="combo-text validatebox-text" maxlength="32" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderCustomList[#index#].gocPassportEndDate" maxlength="" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderCustomList[#index#].gocBussContent" maxlength="100" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderCustomList[#index#].gocRoomNum" maxlength="10" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderCustomList[#index#].gocContent" maxlength="200" type="text" style="width:120px;"></td>
           </tr>
      </tbody>
       <tbody id="add_jeecgOrderProduct_table_template">
          <tr>
             <td align="center"><input type="checkbox" name="ck"/></td>
				 <td align="left"><input name="jeecgOrderProductList[#index#].gopProductType" maxlength="3" type="text" style="width:120px;"></td>
				 <td align="left"><input nullmsg="请输入订单产品明细的产品名称！" datatype="s6-10"
									errormsg="订单产品明细的产品名称应该为6到10位" name="jeecgOrderProductList[#index#].gopProductName" maxlength="100" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderProductList[#index#].gopCount" maxlength="" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderProductList[#index#].gopUnit" maxlength="2" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderProductList[#index#].gopOnePrice" maxlength="" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderProductList[#index#].gopSumPrice" maxlength="" type="text" style="width:120px;"></td>
				 <td align="left"><input name="jeecgOrderProductList[#index#].gopContent" maxlength="200" type="text" style="width:120px;"></td>
           </tr>
      </tbody>
</table>
</body>
</html>