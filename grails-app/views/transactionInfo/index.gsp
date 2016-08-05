<div>
    <ul class="breadcrumb">
        <li>
            <a href="#">实时数据</a>
        </li>
        <li>
            <a href="#">支付记录</a>
        </li>
    </ul>
</div>
<div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-user"></i> 支付记录</h2>
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
                "url":"transactionInfo/list",
                "dataSrc": "data",
                "data": function ( d ) {
                    //添加额外的参数传给服务器
                    d.name = $("#name").val();
                }
            },
            "order": [[0, 'desc']], // 默认排序(第三列降序, asc升序)
            "columns": [
                { "title": "交易ID", "data" : "chargeId", "orderable": true, "searchable": false },
                { "title": "订单号", "data" : "orderNo", "orderable": true, "searchable": false },
                { "title": "订单金额", "data" : "orderMoney", "orderable": true, "searchable": false },
                { "title": "支付类型", "data" : function (data) {
                    if (data.payType == "1") {
                        return "支付宝";
                    } else if (data.payType == "2") {
                        return "微信";
                    } else {
                        return "其它";
                    }
                }, "orderable": false, "searchable": false },
                { "title": "支付状态", "data" : function (data) {
                    return data.isSuccess == 1 ? "支付成功" : "未支付";
                }, "orderable": false, "searchable": false },
                { "title": "支付账号", "data" : "payAccount", "orderable": true, "searchable": false },
                { "title": "下单时间", "data" : "createTime", "orderable": true, "searchable": false },
                { "title": "支付时间", "data" : "updateTime", "orderable": true, "searchable": false }
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