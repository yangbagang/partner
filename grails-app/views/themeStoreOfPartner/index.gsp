<div>
    <ul class="breadcrumb">
        <li>
            <a href="#">主题店</a>
        </li>
        <li>
            <a href="#">绑定伙伴</a>
        </li>
    </ul>
</div>
<div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-user"></i> 绑定伙伴</h2>
        <div class="box-icon">
            <a href="#" class="btn btn-plus btn-round btn-default"><i
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
                "url":"themeStoreBaseInfo/list",
                "dataSrc": "data",
                "data": function ( d ) {
                    //添加额外的参数传给服务器
                    //d.name = $("#name").val();
                }
            },
            "ordering": false, // 默认排序(第三列降序, asc升序)
            "columns": [
                { "title": "主题店", "data" : "name", "orderable": true, "searchable": false },
                { "title": "省", "data" : "province", "orderable": true, "searchable": false },
                { "title": "市", "data" : "city", "orderable": true, "searchable": false },
                { "title": "区", "data" : "county", "orderable": true, "searchable": false },
                { "title": "经营伙伴", "data" : "partnerName", "orderable": false, "searchable": false },
                { "title": "收入比例", "data" : "scale", "orderable": false, "searchable": false },
                { "title": "操作", "data" : function (data) {
                    return  '<a class="btn btn-info" href="javascript:editInfo('+data.id+', \''+data.name+'\');" title="绑定">' +
                            '<i class="glyphicon glyphicon-edit icon-white"></i></a>&nbsp;&nbsp;' +
                            '<a class="btn btn-danger" href="javascript:removeInfo('+data.id+');" title="解除">' +
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

    function editInfo(id, name) {
        var url = '${createLink(controller: "themeStoreOfPartner", action: "show")}';
        $.ajax({
            type: "GET",
            url: url,
            data: "themeStoreId=" + id,
            success: function (result) {
                var hiddenId = "";
                var defValue = 0;
                if (result.partner != null && result.partner != undefined) {
                    hiddenId = '<input type="hidden" id="id" name="id" value="' + result.id + '">';
                    defValue = result.partner.id;
                }
                var content = "" +
                        '<div class="modal-header">' +
                        '<button type="button" class="close" data-dismiss="modal">×</button>' +
                        '<h3>'+name+' 绑定合作伙伴</h3>' +
                        '</div>' +
                        '<div class="modal-body">' +
                        '<form id="infoForm" role="form">' +
                        hiddenId +
                        '<input type="hidden" id="baseInfoId" name="baseInfo.id" value="' + result.baseInfo.id + '">' +
                        '<div class="form-group">' +
                        '<label for="partnerId">伙伴</label>' +
                        '<select id="partnerId" name="partner.id">' +
                        '</select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="scale">比例(百分比数,如2%填2。)</label>' +
                        '<input type="text" class="form-control" id="scale" name="scale" value="'+result.scale+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="fromDate">起始日期</label>' +
                        '<input type="text" class="form-control" id="fromDate" name="fromDate" value="'+result.fromDate+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="toDate">终止日期</label>' +
                        '<input type="text" class="form-control" id="toDate" name="toDate" value="'+result.toDate+'">' +
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
                loadPartnerList(defValue);
            },
            error: function (data) {
                showErrorInfo(data.responseText);
            }
        });
    }

    function removeInfo(themeStoreId) {
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
                '<a href="javascript:postAjaxRemove('+themeStoreId+');" class="btn btn-primary">删除</a>' +
                '</div>';
        $("#modal-content").html("");
        $("#modal-content").html(content);
        $('#myModal').modal('show');
    }

    function postAjaxRemove(themeStoreId) {
        var url = '${createLink(controller: "themeStoreOfPartner", action: "delete")}';
        $.ajax({
            type: "DELETE",
            dataType: "json",
            url: url,
            data: "themeStoreId=" + themeStoreId,
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
        var url = '${createLink(controller: "themeStoreOfPartner", action: "save")}';
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

    function loadPartnerList(defaultValue) {
        var url = '${createLink(controller: "partnerBaseInfo", action: "listPartners")}';
        $.ajax({
            type: "get",
            dataType: "json",
            url: url,
            success: function (result) {
                $("#partnerId").empty();
                $.each(result, function (index, item) {
                    $("#partnerId").append("<option value='"+item.id+"'>"+item.shortName+"</option>");
                });
                if (defaultValue != 0) {
                    $("#partnerId").val(defaultValue);
                }
            },
            error: function (data) {
                var errorContent = "" +
                        '<div class="alert alert-danger">' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                        data.responseText +
                        '</div>';
                $("#msgInfo").html(errorContent);
                $("#msgInfo").html(content).fadeIn(300).delay(2000).fadeOut(300);
            }
        });
    }

</script>