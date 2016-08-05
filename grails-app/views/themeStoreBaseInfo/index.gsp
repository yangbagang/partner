<div>
    <ul class="breadcrumb">
        <li>
            <a href="#">主题店</a>
        </li>
        <li>
            <a href="#">主题店开业</a>
        </li>
    </ul>
</div>
<div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-user"></i> 主题店开业</h2>
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
                "url":"buildingBaseInfo/list",
                "dataSrc": "data",
                "data": function ( d ) {
                    //添加额外的参数传给服务器
                    d.name = $("#name").val();
                }
            },
            "order": [[0, 'desc']], // 默认排序(第三列降序, asc升序)
            "columns": [
                { "title": "ID", "data" : "id", "orderable": true, "searchable": false },
                { "title": "名称", "data" : "name", "orderable": true, "searchable": false },
                { "title": "省", "data" : "province", "orderable": true, "searchable": false },
                { "title": "市", "data" : "city", "orderable": true, "searchable": false },
                { "title": "区", "data" : "county", "orderable": true, "searchable": false },
                { "title": "签约时间", "data" : "signTime", "orderable": true, "searchable": false },
                { "title": "签约伙伴", "data" : "partnerName", "orderable": true, "searchable": false },
                { "title": "操作", "data" : function (data) {
                    return  '<a class="btn btn-info" href="javascript:editInfo('+data.id+');" title="开业">' +
                            '<i class="glyphicon glyphicon-edit icon-white"></i></a>';
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

    function editInfo(id) {
        var url = '${createLink(controller: "themeStoreBaseInfo", action: "show")}';
        $.ajax({
            type: "GET",
            url: url,
            data: "buildingId=" + id,
            success: function (result) {
                var content = "" +
                        '<div class="modal-header">' +
                        '<button type="button" class="close" data-dismiss="modal">×</button>' +
                        '<h3>主题店开业</h3>' +
                        '</div>' +
                        '<div class="modal-body">' +
                        '<form id="infoForm" role="form">' +
                        '<input type="hidden" id="id" name="id" value="' + result.id + '">' +
                        '<div class="form-group">' +
                        '<label for="name">名称</label>' +
                        '<input type="text" class="form-control" id="name" name="name" value="'+result.name+'">' +
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
                        '<label for="position">位置</label>' +
                        '<input type="text" class="form-control" id="position" name="position" value="'+result.position+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="openTime">开业日期</label>' +
                        '<input type="text" class="form-control" id="openTime" name="openTime" value="'+result.openTime+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="longitude">经度</label>(<a href="http://api.map.baidu.com/lbsapi/getpoint/index.html" target="_blank">点此获取</a>)' +
                        '<input type="text" class="form-control" id="longitude" name="longitude" value="'+result.longitude+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="latitude">纬度</label>(<a href="http://api.map.baidu.com/lbsapi/getpoint/index.html" target="_blank">点此获取</a>)' +
                        '<input type="text" class="form-control" id="latitude" name="latitude" value="'+result.latitude+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="status">状态</label>' +
                        '<select id="status" name="status"><option value="0">未开业</option><option value="1">营业中</option><option value="2">己关闭</option></select>' +
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
                $("#status").val(result.status);
                loadAreaList($("#province"), 1, "", result.province);
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

    function postAjaxForm() {
        var url = '${createLink(controller: "themeStoreBaseInfo", action: "save")}';
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