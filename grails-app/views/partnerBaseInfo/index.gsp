<div>
    <ul class="breadcrumb">
        <li>
            <a href="#">合作伙伴</a>
        </li>
        <li>
            <a href="#">基本信息</a>
        </li>
    </ul>
</div>
<div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-user"></i> 基本信息</h2>
        <div class="box-icon">
            <a href="javascript:addInfo();" class="btn btn-plus btn-round btn-default"><i
                    class="glyphicon glyphicon-plus"></i></a>
            <a href="#" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="#" class="btn btn-close btn-round btn-default"><i
                    class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
</div>
<div class="box-content">
    <form class="form-inline" role="form" action="#">
        <div class="form-group">
            <label class="control-label" for="name">名称:</label>
            <input type="text" class="form-control" id="name">
            <input type="button" class="btn btn-primary" value="查询" id="sercher"/>
        </div>
    </form><br />
    <div id="msgInfo" class="box-content alerts"></div>
    <table class="table table-striped table-bordered search_table" id="dataTable"></table>
</div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">

    <div class="modal-dialog">
        <div class="modal-content" id="modal-content">

        </div>
    </div>
</div>
<script>
    var gridTable;
    $(document).ready(function(){
        var table=$('#dataTable').DataTable({
            "bLengthChange": true,
            "bFilter": false,
            "lengthMenu": [10, 20, 50, 100],
            "paginate": true,
            "processing": true,
            "pagingType": "full_numbers",
            "serverSide": true,
            "bAutoWidth": true,
            "ajax": {
                "url":"partnerBaseInfo/list",
                "dataSrc": "data",
                "data": function ( d ) {
                    //添加额外的参数传给服务器
                    d.name = $("#name").val();
                }
            },
            "order": [[0, 'desc']], // 默认排序(第三列降序, asc升序)
            "columns": [
                { "title": "ID", "data" : "id", "orderable": true, "searchable": false },
                { "title": "添加时间", "data" : "createTime", "orderable": true, "searchable": false },
                { "title": "简称", "data" : "shortName", "orderable": true, "searchable": false },
                { "title": "注册资本", "data" : "registMoney", "orderable": true, "searchable": false },
                { "title": "联系人", "data" : "contactName", "orderable": true, "searchable": false },
                { "title": "联系电话", "data" : "contactPhone", "orderable": true, "searchable": false },
                { "title": "联系邮箱", "data" : "contactMail", "orderable": true, "searchable": false },
                { "title": "性质", "data" : function (data) {
                    return data.type == 1 ? "代理" : "经营";
                }, "orderable": false, "searchable": false },
                { "title": "状态", "data" : function (data) {
                    return data.status == 1 ? "正常" : "停止";
                }, "orderable": false, "searchable": false },
                { "title": "操作", "data" : function (data) {
                    return '<a class="btn btn-success" href="javascript:showInfo('+data.id+');" title="查看">' +
                            '<i class="glyphicon glyphicon-zoom-in icon-white"></i></a>&nbsp;&nbsp;' +
                            '<a class="btn btn-info" href="javascript:editInfo('+data.id+');" title="编辑">' +
                            '<i class="glyphicon glyphicon-edit icon-white"></i></a>&nbsp;&nbsp;' +
                            '<a class="btn btn-danger" href="javascript:removeInfo('+data.id+');" title="删除">' +
                            '<i class="glyphicon glyphicon-trash icon-white"></i></a>';
                }, "orderable": false, "searchable": false }
            ],
            "language": {
                "zeroRecords": "没有数据",
                "lengthMenu" : "_MENU_",
                "info": "显示第 _START_ 至 _END_ 条记录，共 _TOTAL_ 条",
                "loadingRecords": "加载中...",
                "processing": "加载中...",
                "infoFiltered": "",
                "infoEmpty": "暂无记录",
                "paginate": {
                    "first": "首页",
                    "last": "末页",
                    "next": "下一页",
                    "previous": "上一页"
                }
            }
        });
        gridTable = table;
        //查询 重新加载
        $("#sercher").click(function(){
            table.ajax.reload(null, false);
        });

    });

    function addInfo() {
        var content = "" +
                '<div class="modal-header">' +
                '<button type="button" class="close" data-dismiss="modal">×</button>' +
                '<h3>新建合作伙伴</h3>' +
                '</div>' +
                '<div class="modal-body">' +
                '<form id="infoForm" role="form">' +
                '<div class="form-group">' +
                '<label for="companyName">名称</label>' +
                '<input type="text" class="form-control" id="companyName" name="companyName" placeholder="个人填姓名,公司填公司全称。">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="shortName">简称</label>' +
                '<input type="text" class="form-control" id="shortName" name="shortName" placeholder="个人填姓名,公司填公司简称。">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="companyCode">代码</label>' +
                '<input type="text" class="form-control" id="companyCode" name="companyCode" placeholder="个人填身份证号,公司填组织机构代码。">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="bornDate">成立时间</label>' +
                '<input type="text" class="form-control" id="bornDate" name="bornDate" placeholder="个人填出生日期,公司填注册时间。格式2016-01-12">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="registMoney">注册资本</label>' +
                '<input type="text" class="form-control" id="registMoney" name="registMoney" placeholder="公司填注册资本,个人随意填。">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="phoneNum">电话</label>' +
                '<input type="text" class="form-control" id="phoneNum" name="phoneNum" placeholder="公司填公司前台电话,个人填常用电话。">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="province">省</label>' +
                '<select id="province" name="province"></select>' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="city">市</label>' +
                '<select id="city" name="city"></select>' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="county">区</label>' +
                '<select id="county" name="county"></select>' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="address">地址</label>' +
                '<input type="text" class="form-control" id="address" name="address" placeholder="公司填所在地地址,个人填位址。">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="contactName">联系人</label>' +
                '<input type="text" class="form-control" id="contactName" name="contactName" placeholder="联系人">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="contactPhone">联系电话</label>' +
                '<input type="text" class="form-control" id="contactPhone" name="contactPhone" placeholder="联系人手机号码">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="contactMail">联系邮箱</label>' +
                '<input type="text" class="form-control" id="contactMail" name="contactMail" placeholder="联系出箱">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="bankName">开户行</label>' +
                '<input type="text" class="form-control" id="bankName" name="bankName" placeholder="开户行">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="accountNum">账号</label>' +
                '<input type="text" class="form-control" id="accountNum" name="accountNum" placeholder="银行账号">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="accountName">账户名</label>' +
                '<input type="text" class="form-control" id="accountName" name="accountName" placeholder="银行账户名">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="type">性质</label>' +
                '<select id="type" name="type"><option value="0">经营</option><option value="1">代理</option></select>' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="status">状态</label>' +
                '<select id="status" name="status"><option value="1">正常</option><option value="0">停止</option></select>' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="type">推广人ID</label>' +
                '<input type="text" class="form-control" id="type" name="type" placeholder="从列表中找到推广人的ID">' +
                '</div>' +
                '</form>' +
                '</div>' +
                '<div class="modal-footer">' +
                '<a href="#" class="btn btn-default" data-dismiss="modal">关闭</a>' +
                '<a href="javascript:postAjaxForm();" class="btn btn-primary">保存</a>' +
                '</div>';
        $("#modal-content").html("");
        $("#modal-content").html(content);
        $('#myModal').modal('show');
        loadAreaList($("#province"), 1, "", "0");
        $("#province").change(function () {
            loadAreaList($("#city"), 2, $(this).val(), "0");
        });
        $("#city").change(function () {
            loadAreaList($("#county"), 3, $(this).val(), "0");
        });
    }

    function showInfo(id) {
        var url = '${createLink(controller: "partnerBaseInfo", action: "show")}';
        $.ajax({
            type: "GET",
            url: url,
            data: "id=" + id,
            success: function (result) {
                var content = "" +
                        '<div class="modal-header">' +
                        '<button type="button" class="close" data-dismiss="modal">×</button>' +
                        '<h3>合作伙伴基本信息</h3>' +
                        '</div>' +
                        '<div class="modal-body">' +
                        '<div class="form-group">' +
                        '<label for="companyName">名称</label>' +
                        '<input type="text" class="form-control" id="companyName" name="companyName" readonly="readonly" value="'+result.companyName+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="shortName">简称</label>' +
                        '<input type="text" class="form-control" id="shortName" name="shortName" readonly="readonly" value="'+result.shortName+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="companyCode">代码</label>' +
                        '<input type="text" class="form-control" id="companyCode" name="companyCode" readonly="readonly" value="'+result.companyCode+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="bornDate">成立时间</label>' +
                        '<input type="text" class="form-control" id="bornDate" name="bornDate" readonly="readonly" value="'+result.bornDate+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="registMoney">注册资本</label>' +
                        '<input type="text" class="form-control" id="registMoney" name="registMoney" readonly="readonly" value="'+result.registMoney+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="phoneNum">电话</label>' +
                        '<input type="text" class="form-control" id="phoneNum" name="phoneNum" readonly="readonly" value="'+result.phoneNum+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="province">省</label>' +
                        '<select id="province" name="province" disabled="disabled">' +
                        '<option value="">'+result.province+'</option>' +
                        '</select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="city">市</label>' +
                        '<select id="city" name="city" disabled="disabled">' +
                        '<option value="">'+result.city+'</option>' +
                        '</select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="county">区</label>' +
                        '<select id="county" name="county" disabled="disabled">' +
                        '<option value="">'+result.county+'</option>' +
                        '</select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="address">地址</label>' +
                        '<input type="text" class="form-control" id="address" name="address" readonly="readonly" value="'+result.address+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="contactName">联系人</label>' +
                        '<input type="text" class="form-control" id="contactName" name="contactName" readonly="readonly" value="'+result.contactName+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="contactPhone">联系电话</label>' +
                        '<input type="text" class="form-control" id="contactPhone" name="contactPhone" readonly="readonly" value="'+result.contactPhone+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="contactMail">联系邮箱</label>' +
                        '<input type="text" class="form-control" id="contactMail" name="contactMail" readonly="readonly" value="'+result.contactMail+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="bankName">开户行</label>' +
                        '<input type="text" class="form-control" id="bankName" name="bankName" readonly="readonly" value="'+result.bankName+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="accountNum">账号</label>' +
                        '<input type="text" class="form-control" id="accountNum" name="accountNum" readonly="readonly" value="'+result.accountNum+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="accountName">账户名</label>' +
                        '<input type="text" class="form-control" id="accountName" name="accountName" readonly="readonly" value="'+result.accountName+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="type">性质</label>' +
                        '<select id="type" name="type" disabled="disabled"><option value="0">经营</option><option value="1">代理</option></select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="status">状态</label>' +
                        '<select id="status" name="status" disabled="disabled"><option value="0">停止</option><option value="1">正常</option></select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="pid">推广人ID</label>' +
                        '<input type="text" class="form-control" id="pid" name="pid" readonly="readonly" value="'+result.pid+'">' +
                        '</div>' +
                        '</div>' +
                        '<div class="modal-footer">' +
                        '<a href="#" class="btn btn-default" data-dismiss="modal">关闭</a>' +
                        '</div>';
                $("#modal-content").html("");
                $("#modal-content").html(content);
                $('#myModal').modal('show');
                $("#type").val(result.type);
                $("#status").val(result.status);
            },
            error: function (data) {
                showErrorInfo(data.responseText);
            }
        });
    }

    function editInfo(id) {
        var url = '${createLink(controller: "partnerBaseInfo", action: "show")}';
        $.ajax({
            type: "GET",
            url: url,
            data: "id=" + id,
            success: function (result) {
                var content = "" +
                        '<div class="modal-header">' +
                        '<button type="button" class="close" data-dismiss="modal">×</button>' +
                        '<h3>编辑合作伙伴基本信息</h3>' +
                        '</div>' +
                        '<div class="modal-body">' +
                        '<form id="infoForm" role="form">' +
                        '<input type="hidden" id="id" name="id" value="' + result.id + '">' +
                        '<div class="form-group">' +
                        '<label for="companyName">名称</label>' +
                        '<input type="text" class="form-control" id="companyName" name="companyName" value="'+result.companyName+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="shortName">简称</label>' +
                        '<input type="text" class="form-control" id="shortName" name="shortName" value="'+result.shortName+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="companyCode">代码</label>' +
                        '<input type="text" class="form-control" id="companyCode" name="companyCode" value="'+result.companyCode+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="bornDate">成立时间</label>' +
                        '<input type="text" class="form-control" id="bornDate" name="bornDate" value="'+result.bornDate+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="registMoney">注册资本</label>' +
                        '<input type="text" class="form-control" id="registMoney" name="registMoney" value="'+result.registMoney+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="phoneNum">电话</label>' +
                        '<input type="text" class="form-control" id="phoneNum" name="phoneNum" value="'+result.phoneNum+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="province">省</label>' +
                        '<select id="province" name="province">' +
                        '</select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="city">市</label>' +
                        '<select id="city" name="city">' +
                        '<option value="'+result.city+'">'+result.city+'</option>' +
                        '</select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="county">区</label>' +
                        '<select id="county" name="county">' +
                        '<option value="'+result.county+'">'+result.county+'</option>' +
                        '</select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="address">地址</label>' +
                        '<input type="text" class="form-control" id="address" name="address" value="'+result.address+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="contactName">联系人</label>' +
                        '<input type="text" class="form-control" id="contactName" name="contactName" value="'+result.contactName+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="contactPhone">联系电话</label>' +
                        '<input type="text" class="form-control" id="contactPhone" name="contactPhone" value="'+result.contactPhone+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="contactMail">联系邮箱</label>' +
                        '<input type="text" class="form-control" id="contactMail" name="contactMail" value="'+result.contactMail+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="bankName">开户行</label>' +
                        '<input type="text" class="form-control" id="bankName" name="bankName" value="'+result.bankName+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="accountNum">账号</label>' +
                        '<input type="text" class="form-control" id="accountNum" name="accountNum" value="'+result.accountNum+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="accountName">账户名</label>' +
                        '<input type="text" class="form-control" id="accountName" name="accountName" value="'+result.accountName+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="type">性质</label>' +
                        '<select id="type" name="type"><option value="0">经营</option><option value="1">代理</option></select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="status">状态</label>' +
                        '<select id="status" name="status"><option value="0">停止</option><option value="1">正常</option></select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="pid">推广人ID</label>' +
                        '<input type="text" class="form-control" id="pid" name="pid" value="'+result.pid+'">' +
                        '</div>' +
                        '</form>' +
                        '</div>' +
                        '<div class="modal-footer">' +
                        '<a href="#" class="btn btn-default" data-dismiss="modal">关闭</a>' +
                        '<a href="javascript:postAjaxForm();" class="btn btn-primary">更新</a>' +
                        '</div>';
                $("#modal-content").html("");
                $("#modal-content").html(content);
                $('#myModal').modal('show');
                $("#type").val(result.type);
                $("#status").val(result.status);
                loadAreaList($("#province"), 1, "", '"' + result.province + '"');
                $("#province").change(function () {
                    loadAreaList($("#city"), 2, $(this).val(), "0");
                });
                $("#city").change(function () {
                    loadAreaList($("#county"), 3, $(this).val(), "0");
                });
            },
            error: function (data) {
                showErrorInfo(data.responseText);
            }
        });
    }

    function removeInfo(id) {
        var content = "" +
                '<div class="modal-header">' +
                '<button type="button" class="close" data-dismiss="modal">×</button>' +
                '<h3>提示</h3>' +
                '</div>' +
                '<div class="modal-body">' +
                '<p>删除后信息将无法恢复,是否继续?</p>' +
                '</div>' +
                '<div class="modal-footer">' +
                '<a href="#" class="btn btn-default" data-dismiss="modal">取消</a>' +
                '<a href="javascript:postAjaxRemove('+id+');" class="btn btn-primary">删除</a>' +
                '</div>';
        $("#modal-content").html("");
        $("#modal-content").html(content);
        $('#myModal').modal('show');
    }

    function postAjaxRemove(id) {
        var url = '${createLink(controller: "partnerBaseInfo", action: "delete")}/' + id;
        $.ajax({
            type: "DELETE",
            dataType: "json",
            url: url,
            success: function (result) {
                var isSuccess = result.success;
                var errorMsg = result.msg;
                var content = "";
                if (isSuccess) {
                    content = "" +
                            '<div class="alert alert-success">' +
                            '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                            '删除完成' +
                            '</div>';
                } else {
                    content = "" +
                            '<div class="alert alert-danger">' +
                            '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                            JSON.stringify(errorMsg) +
                            '</div>';
                }
                $("#myModal").modal('hide');
                gridTable.ajax.reload(null, false);
                $("#msgInfo").html(content);
                $("#msgInfo").html(content).fadeIn(300).delay(2000).fadeOut(300);
            },
            error: function (data) {
                var errorContent = "" +
                        '<div class="alert alert-danger">' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                        data.responseText +
                        '</div>';
                $("#myModal").modal('hide');
                $("#msgInfo").html(errorContent);
                $("#msgInfo").html(errorContent).fadeIn(300).delay(2000).fadeOut(300);
            }
        });
    }

    function postAjaxForm() {
        var url = '${createLink(controller: "partnerBaseInfo", action: "save")}';
        $.ajax({
            type: "POST",
            dataType: "json",
            url: url,
            data: $('#infoForm').serialize(),
            success: function (result) {
                var isSuccess = result.success;
                var errorMsg = result.msg;
                var content = "";
                if (isSuccess) {
                    content = "" +
                            '<div class="alert alert-success">' +
                            '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                            '操作完成' +
                            '</div>';
                } else {
                    content = "" +
                            '<div class="alert alert-danger">' +
                            '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                            JSON.stringify(errorMsg) +
                            '</div>';
                }
                $("#myModal").modal('hide');
                gridTable.ajax.reload(null, false);
                $("#msgInfo").html(content).fadeIn(300).delay(2000).fadeOut(300);
            },
            error: function(data) {
                var errorContent = "" +
                        '<div class="alert alert-danger">' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                        data.responseText +
                        '</div>';
                $("#myModal").modal('hide');
                $("#msgInfo").html(errorContent);
                $("#msgInfo").html(content).fadeIn(300).delay(2000).fadeOut(300);
            }
        });
    }

    function loadAreaList(targetSelectObj, level, pname, defaultValue) {
        var url = '${createLink(controller: "baseAreaInfo", action: "listArea")}';
        $.ajax({
            type: "post",
            dataType: "json",
            data: "level=" + level + "&pname=" + pname,
            url: url,
            success: function (result) {
                $(targetSelectObj).empty();
                $.each(result, function (index, item) {
                    $(targetSelectObj).append("<option value='"+item.name+"'>"+item.name+"</option>");
                });
                if (defaultValue != "0") {
                    $(targetSelectObj).val(defaultValue);
                }
            },
            error: function (data) {
                alert(data.responseText)
            }
        });
    }

</script>