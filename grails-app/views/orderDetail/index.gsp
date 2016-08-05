<div>
    <ul class="breadcrumb">
        <li>
            <a href="#">实时数据</a>
        </li>
        <li>
            <a href="#">商品记录</a>
        </li>
    </ul>
</div>
<div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-user"></i> 商品记录</h2>
        <div class="box-icon">
            <a href="#" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="#" class="btn btn-close btn-round btn-default"><i
                    class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
</div>
<div class="box-content">
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
                "url":"orderDetail/list",
                "dataSrc": "data",
                "data": function ( d ) {
                    //添加额外的参数传给服务器
                    d.name = $("#name").val();
                }
            },
            "order": [[0, 'desc']], // 默认排序(第三列降序, asc升序)
            "columns": [
                { "title": "ID", "data" : "id", "orderable": true, "searchable": false },
                { "title": "时间", "data" : "createTime", "orderable": false, "searchable": false },
                { "title": "订单号", "data" : "orderNo", "orderable": false, "searchable": false },
                { "title": "机器号", "data" : "vmCode", "orderable": false, "searchable": false },
                { "title": "轨道号", "data" : "orbitalNo", "orderable": true, "searchable": false },
                { "title": "商品", "data" : "goodsName", "orderable": true, "searchable": false },
                { "title": "规格", "data" : "goodsSpec", "orderable": true, "searchable": false },
                { "title": "数量", "data" : "goodsNum", "orderable": true, "searchable": false },
                { "title": "单价", "data" : "buyPrice", "orderable": true, "searchable": false },
                { "title": "是否支付", "data" : function (data) {
                    if (data.status == 0) {
                        return "未出货";
                    } else if (data.status == 1) {
                        return "申请退款";
                    } else if (data.status == 2) {
                        return "已退款";
                    } else if (data.status == 3) {
                        return "己出货";
                    } else {
                        return "其它";
                    }
                }, "orderable": true, "searchable": false },
                { "title": "是否异常", "data" : function (data) {
                    if (data.errorStatus == 0) {
                        return "正常";
                    } else if (data.errorStatus == 1) {
                        return "异常";
                    } else if (data.errorStatus == 2) {
                        return "已处理"
                    } else {
                        return "其它";
                    }
                }, "orderable": true, "searchable": false }
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
    });

</script>