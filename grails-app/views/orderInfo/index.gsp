<div>
    <ul class="breadcrumb">
        <li>
            <a href="#">实时数据</a>
        </li>
        <li>
            <a href="#">订单记录</a>
        </li>
    </ul>
</div>
<div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-user"></i> 订单记录</h2>
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
                "url":"orderInfo/list",
                "dataSrc": "data",
                "data": function ( d ) {
                    //添加额外的参数传给服务器
                    d.name = $("#name").val();
                }
            },
            "order": [[0, 'desc']], // 默认排序(第三列降序, asc升序)
            "columns": [
                { "title": "订单编号", "data" : "orderNo", "orderable": true, "searchable": false },
                { "title": "金额", "data" : "realMoney", "orderable": true, "searchable": false },
                { "title": "机器编号", "data" : "vmCode", "orderable": true, "searchable": false },
                { "title": "下单时间", "data" : "createTime", "orderable": true, "searchable": false },
                { "title": "状态", "data" :function (data) {
                    if (data.isCancel == 0) {
                        return "未取消";
                    } else if (data.isCancel == 1) {
                        return "手动取消";
                    } else if (data.isCancel == 2) {
                        return "超时取消";
                    } else {
                        return "未知";
                    }
                }, "orderable": false, "searchable": false },
                { "title": "付款状态", "data" : function (data) {
                    return data.payStatus == 1 ? "已付款" : "未付款";
                }, "orderable": false, "searchable": false },
                { "title": "付款时间", "data" : "confirmTime", "orderable": true, "searchable": false },
                { "title": "支付方式", "data" : function (data) {
                    if (data.payWay == 1) {
                        return "支付宝";
                    } else if (data.payWay == 2) {
                        return "微信";
                    } else {
                        return "其它";
                    }
                }, "orderable": true, "searchable": false },
                { "title": "完成时间", "data" : "completeTime", "orderable": true, "searchable": false }
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