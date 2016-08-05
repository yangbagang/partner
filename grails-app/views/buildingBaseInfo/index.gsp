<div>
    <ul class="breadcrumb">
        <li>
            <a href="#">合作伙伴</a>
        </li>
        <li>
            <a href="#">楼宇签约</a>
        </li>
    </ul>
</div>
<div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-user"></i> 楼宇签约</h2>
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
                '<h3>添加签约楼宇</h3>' +
                '</div>' +
                '<div class="modal-body">' +
                '<form id="infoForm" role="form">' +
                '<div class="form-group">' +
                '<label for="name">名称</label>' +
                '<input type="text" class="form-control" id="name" name="name" placeholder="大楼名称。">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="partnerBaseInfoId">签约伙伴</label>' +
                '<select id="partnerBaseInfoId" name="partner.id"></select>' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="address">地址</label>' +
                '<input type="text" class="form-control" id="address" name="address" placeholder="地址">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="areaNum">建筑面积</label>' +
                '<input type="text" class="form-control" id="areaNum" name="areaNum" placeholder="建筑面积平方">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="buildDate">建成时间</label>' +
                '<input type="text" class="form-control" id="buildDate" name="buildDate" placeholder="建成日期。格式2016-01-12">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="floorNum">楼层数</label>' +
                '<input type="text" class="form-control" id="floorNum" name="floorNum" placeholder="楼层数">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="peopleNum">入驻人数</label>' +
                '<input type="text" class="form-control" id="peopleNum" name="peopleNum" placeholder="入驻人数">' +
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
                '<label for="descriptions">备注</label>' +
                '<input type="text" class="form-control" id="descriptions" name="descriptions" placeholder="备注">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="signTime">签约日期</label>' +
                '<input type="text" class="form-control" id="signTime" name="signTime" placeholder="签约日期">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="company">物业</label>' +
                '<input type="text" class="form-control" id="company" name="company" placeholder="物业简称">' +
                '</div>' +
                '<div class="form-group">' +
                '<label for="auditStatus">审核状态</label>' +
                '<select id="auditStatus" name="auditStatus"><option value="1">通过</option><option value="0">未通过</option></select>' +
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
        loadPartnerList(0);
    }

    function showInfo(id) {
        var url = '${createLink(controller: "buildingBaseInfo", action: "show")}';
        $.ajax({
            type: "GET",
            url: url,
            data: "id=" + id,
            success: function (result) {
                var content = "" +
                        '<div class="modal-header">' +
                        '<button type="button" class="close" data-dismiss="modal">×</button>' +
                        '<h3>签约楼宇信息</h3>' +
                        '</div>' +
                        '<div class="modal-body">' +
                        '<div class="form-group">' +
                        '<label for="name">名称</label>' +
                        '<input type="text" class="form-control" id="name" name="name" readonly="readonly" value="'+result.name+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="partnerBaseInfoId">签约伙伴</label>' +
                        '<select id="partnerBaseInfoId" name="partner.id" disabled="disabled">' +
                        '<option value="">'+result.partnerName+'</option>' +
                        '</select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="address">地址</label>' +
                        '<input type="text" class="form-control" id="address" name="address" readonly="readonly" value="'+result.address+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="areaNum">建筑面积</label>' +
                        '<input type="text" class="form-control" id="areaNum" name="areaNum" readonly="readonly" value="'+result.areaNum+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="buildDate">建成时间</label>' +
                        '<input type="text" class="form-control" id="buildDate" name="buildDate" readonly="readonly" value="'+result.buildDate+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="floorNum">楼层数</label>' +
                        '<input type="text" class="form-control" id="floorNum" name="floorNum" readonly="readonly" value="'+result.floorNum+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="peopleNum">入驻人数</label>' +
                        '<input type="text" class="form-control" id="peopleNum" name="peopleNum" readonly="readonly" value="'+result.peopleNum+'">' +
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
                        '<label for="descriptions">备注</label>' +
                        '<input type="text" class="form-control" id="descriptions" name="descriptions" readonly="readonly" value="'+result.descriptions+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="signTime">签约日期</label>' +
                        '<input type="text" class="form-control" id="signTime" name="signTime" readonly="readonly" value="'+result.signTime+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="company">物业</label>' +
                        '<input type="text" class="form-control" id="company" name="company" readonly="readonly" value="'+result.company+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="auditStatus">审核状态</label>' +
                        '<select id="auditStatus" name="auditStatus" disabled="disabled"><option value="0">未通过</option><option value="1">通过</option></select>' +
                        '</div>' +
                        '<div class="modal-footer">' +
                        '<a href="#" class="btn btn-default" data-dismiss="modal">关闭</a>' +
                        '</div>';
                $("#modal-content").html("");
                $("#modal-content").html(content);
                $('#myModal').modal('show');
                $("#auditStatus").val(result.auditStatus);
            },
            error: function (data) {
                showErrorInfo(data.responseText);
            }
        });
    }

    function editInfo(id) {
        var url = '${createLink(controller: "buildingBaseInfo", action: "show")}';
        $.ajax({
            type: "GET",
            url: url,
            data: "id=" + id,
            success: function (result) {
                var content = "" +
                        '<div class="modal-header">' +
                        '<button type="button" class="close" data-dismiss="modal">×</button>' +
                        '<h3>修改楼宇签约信息</h3>' +
                        '</div>' +
                        '<div class="modal-body">' +
                        '<form id="infoForm" role="form">' +
                        '<input type="hidden" id="id" name="id" value="' + result.id + '">' +
                        '<div class="form-group">' +
                        '<label for="name">名称</label>' +
                        '<input type="text" class="form-control" id="name" name="name" value="'+result.name+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="partnerBaseInfoId">签约伙伴</label>' +
                        '<select id="partnerBaseInfoId" name="partner.id"></select>' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="address">地址</label>' +
                        '<input type="text" class="form-control" id="address" name="address" value="'+result.address+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="areaNum">建筑面积</label>' +
                        '<input type="text" class="form-control" id="areaNum" name="areaNum" value="'+result.areaNum+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="buildDate">建成时间</label>' +
                        '<input type="text" class="form-control" id="buildDate" name="buildDate" value="'+result.buildDate+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="floorNum">楼层数</label>' +
                        '<input type="text" class="form-control" id="floorNum" name="floorNum" value="'+result.floorNum+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="peopleNum">入驻人数</label>' +
                        '<input type="text" class="form-control" id="peopleNum" name="peopleNum" value="'+result.peopleNum+'">' +
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
                        '<label for="descriptions">备注</label>' +
                        '<input type="text" class="form-control" id="descriptions" name="descriptions" value="'+result.descriptions+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="signTime">签约日期</label>' +
                        '<input type="text" class="form-control" id="signTime" name="signTime" value="'+result.signTime+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="company">物业</label>' +
                        '<input type="text" class="form-control" id="company" name="company" value="'+result.company+'">' +
                        '</div>' +
                        '<div class="form-group">' +
                        '<label for="auditStatus">审核状态</label>' +
                        '<select id="auditStatus" name="auditStatus"><option value="0">未通过</option><option value="1">通过</option></select>' +
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
                $("#auditStatus").val(result.auditStatus);
                loadAreaList($("#province"), 1, "", result.province);
                $("#province").change(function () {
                    loadAreaList($("#city"), 2, $(this).val(), "0");
                });
                $("#city").change(function () {
                    loadAreaList($("#county"), 3, $(this).val(), "0");
                });
                loadPartnerList(result.partner.id);
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
        var url = '${createLink(controller: "buildingBaseInfo", action: "delete")}/' + id;
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
        var url = '${createLink(controller: "buildingBaseInfo", action: "save")}';
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
                $("#partnerBaseInfoId").empty();
                $.each(result, function (index, item) {
                    $("#partnerBaseInfoId").append("<option value='"+item.id+"'>"+item.shortName+"</option>");
                });
                if (defaultValue != 0) {
                    $("#partnerBaseInfoId").val(defaultValue);
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