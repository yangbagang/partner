<div>
    <ul class="breadcrumb">
        <li>
            <a href="#">机器设备</a>
        </li>
        <li>
            <a href="#">轨道错误</a>
        </li>
    </ul>
</div>
<div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-user"></i> 轨道错误</h2>
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
            <label class="control-label" for="devStatus">选择状态:</label>
            <select class="form-control" id="devStatus" name="devStatus">
                <option value="1" selected="selected">未修复</option>
                <option value="0">己修复</option>
            </select>
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
                "url":"vendMachineInfoErrorInfo/list",
                "dataSrc": "data",
                "data": function ( d ) {
                    //添加额外的参数传给服务器
                    d.status = $("#devStatus").val();
                }
            },
            "order": [[0, 'desc']], // 默认排序(第三列降序, asc升序)
            "columns": [
                { "title": "ID", "data" : "id", "orderable": true, "searchable": false },
                { "title": "主题店", "data" : "themeStoreName", "orderable": false, "searchable": false },
                { "title": "机器名称", "data" : "machineName", "orderable": false, "searchable": false },
                { "title": "轨道编号", "data" : "orbitalNo", "orderable": true, "searchable": false },
                { "title": "创建时间", "data" : "createTime", "orderable": true, "searchable": false },
                { "title": "修复时间", "data" : "fixTime", "orderable": true, "searchable": false},
                { "title": "错误信息", "data" : "errorInfo", "orderable": false, "searchable": false},
                { "title": "状态", "data" : function (data) {
                    return data.status == 1 ? "未修复" : "己修复";
                }, "orderable": false, "searchable": false}
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
        $("#devStatus").change(function () {
            table.ajax.reload(null, false);
        });
    });

</script>