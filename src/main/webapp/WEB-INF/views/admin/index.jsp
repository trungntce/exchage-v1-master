<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/layout/admin/head.jsp"%>
<script src="${_ctx}/resources/js/plugins/highchart/highcharts.js"></script>
<body class="pace-done">
	<div class="pace pace-inactive">
		<div class="pace-progress" data-progress-text="100%" data-progress="99" style="transform: translate3d(100%, 0px, 0px);">
			<div class="pace-progress-inner"></div>
		</div>

		<div class="pace-activity"></div>
	</div>
	
	<!-- BEGIN #loader -->
	<div id="loader" class="app-loader loaded">
		<span class="spinner"></span>
	</div>

	<div id="app" class="app app-header-fixed app-sidebar-fixed">
		<%@ include file="/WEB-INF/layout/admin/header.jsp"%>

		<%@ include file="/WEB-INF/layout/admin/sidebar.jsp"%>

		<div id="content" class="app-content app-wrapper">
			<!-- MAIN PANEL -->
			<div id="main" class="panel panel-inverse">
				<div class="panel-heading panel-top">
					<h4 class="panel-title">
						<spring:message code="admin.subtitle.dashboard.title"/>
					</h4>
					<!-- RIBBON -->
					<div class="panel-heading-btn">
						<ol class="breadcrumb float-xl-end">
							<li class="breadcrumb-item"><spring:message code="admin.subtitle.home.title"/></li>
							<li class="breadcrumb-item active">
							    <a href="javascript:window.location.reload();"><spring:message code="admin.subtitle.dashboard.title"/></a>
							</li>
						</ol>
					</div>
					<!-- END RIBBON -->
				</div>

				<!-- MAIN CONTENT -->
				<div class="panel-body">
					<!-- 총 기간 별 대쉬 보드 시작 -->
					<div class="row" id="totalStatCalcWrapper">
						<div class="col">
							<div class="widget widget-stats bg-blue">
								<div class="stats-icon"><i class="fa fa-money-bill"></i></div>
								<div class="stats-info">
									<h4><spring:message code="common.admin.buy.amount.title"/></h4>
									<p class="text-end"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sumBuy}" /></p>
								</div>
								<div class="stats-link">
									<a href="${_ctx}/admin/analysis/list"><spring:message code="common.admin.view.detail.title"/> <i class="fa fa-arrow-alt-circle-right"></i></a>
								</div>
							</div>
						</div>

						<div class="col">
							<div class="widget widget-stats bg-orange">
								<div class="stats-icon"><i class="fa fa-money-bill"></i></div>
								<div class="stats-info">
									<h4><spring:message code="common.admin.sell.amount.title"/></h4>
									<p class="text-end"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sumSell}" /></p>
								</div>
								<div class="stats-link">
									<a href="${_ctx}/admin/analysis/list"><spring:message code="common.admin.view.detail.title"/> <i class="fa fa-arrow-alt-circle-right"></i></a>
								</div>
							</div>
						</div>
						<c:if test="${wallet.role == 'CENTRAL_BANK'}">
							<div class="col">
								<div class="widget widget-stats bg-green">
									<div class="stats-icon"><i class="fa fa-money-bill"></i></div>
									<div class="stats-info">
										<h4><spring:message code="common.admin.transfer.fee.title"/></h4>
										<p class="text-end"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sumFee.transferFee}" /></p>
									</div>
									<div class="stats-link">
										<a href="${_ctx}/admin/analysis/list"><spring:message code="common.admin.view.detail.title"/> <i class="fa fa-arrow-alt-circle-right"></i></a>
									</div>
								</div>
							</div>


							<div class="col">
								<div class="widget widget-stats bg-purple">
									<div class="stats-icon"><i class="fa fa-money-bill"></i></div>
									<div class="stats-info">
										<h4><spring:message code="common.admin.benefit.fee.title"/></h4>
										<p class="text-end"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sumFee.benefitFee}" /></p>
									</div>
									<div class="stats-link">
										<a href="${_ctx}/admin/analysis/list"><spring:message code="common.admin.view.detail.title"/> <i class="fa fa-arrow-alt-circle-right"></i></a>
									</div>
								</div>
							</div>
						</c:if>
						
						<div class="col">
							<div class="widget widget-stats bg-red">
								<div class="stats-icon"><i class="fa fa-money-bill"></i></div>
								<div class="stats-info">
									<h4><spring:message code="common.admin.total.fee.title"/></h4>
									<p class="text-end"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sumFee.transferFee + sumFee.benefitFee}" /></p>
								</div>
								<div class="stats-link">
									<a href="${_ctx}/admin/analysis/list"><spring:message code="common.admin.view.detail.title"/> <i class="fa fa-arrow-alt-circle-right"></i></a>
								</div>
							</div>
						</div>

						<div class="col">
							<div class="widget widget-stats bg-pink">
								<div class="stats-icon"><i class="fa fa-user-check"></i></div>
								<div class="stats-info">
									<h4><spring:message code="common.admin.wallet.reg.title"/></h4>
									<p class="text-end"><fmt:formatNumber type="number" maxFractionDigits="3" value="${countWallet}" /></p>
								</div>
								<div class="stats-link">
									<a href="${_ctx}/admin/wallet/list"><spring:message code="common.admin.view.detail.title"/> <i class="fa fa-arrow-alt-circle-right"></i></a>
								</div>
							</div>
						</div>

						<div class="col">
							<form>
							<div class="d-sm-flex align-items-center mb-1px">
								<button class="btn btn-dark text-truncate w-100" id="total-view-daterange">
									<i class="fa fa-calendar fa-fw text-white text-opacity-50 ms-n1"></i>
									<span><spring:message code="common.admin.filter.by.time.title"/></span>
								</button>
							</div>
							<div class="fw-bold mt-10px input-daterange">
								<input type="date" value='${search.searchDateStart}' id="searchDateStart" name="searchDateStart" class="form-control p-1 d-inline-block" style="width: 47%">~
								<input type="date" value='${search.searchDateEnd}' id="searchDateEnd" name="searchDateEnd" class="form-control p-1 d-inline-block" style="width: 47%">
							</div>
							<div class="fw-bold mt-10px">
								<button type="submit" class="btn btn-primary d-block w-100"><spring:message code="common.button.search.title"/></button>
							</div>
							</form>
						</div>
					</div>
					<!-- 총 기간 별 대쉬 보드 끝 -->

					<!-- Page Content -->
					<div id="analysis-token" class="row" style="height: calc(100vh - 290px);">
						<div id="img-loading-gif" class="text-center">
							<img src="${_ctx}/resources/img/loading.gif" width="50">
						</div>
					</div>
					<!-- * Page Content -->
				</div>
			</div>
		</div>
	</div>
	<script>

		init()

		function init(){
			//Init time filter
			actionView()
			loadData()
		}

		function actionView(){
			$("#searchDateStart").change(function(){
				var mDate = new Date($(this).val())
				var maxDate = mDate.addDays(365)
				$("#searchDateEnd").attr("min", $(this).val())
				$("#searchDateEnd").attr("max", (maxDate > new Date()) ? new Date().toStringByType("yyyy-MM-dd") : maxDate.toStringByType("yyyy-MM-dd"))
			})

			$("#searchDateEnd").change(function(){
				$("#searchDateStart").attr("max", $(this).val())
			})			
		}

		function roundOf(n, p) {
		    const n1 = n * Math.pow(10, p + 1);
		    const n2 = Math.floor(n1 / 10);
		    if (n1 >= (n2 * 10 + 5)) {
		        return (n2 + 1) / Math.pow(10, p);
		    }
		    return n2 / Math.pow(10, p);
		}

		async function loadData(){
			var startTime = $("#searchDateStart").val()
			var endTime = $("#searchDateEnd").val()
			var data = await analysis.tokenHome({searchDateStart: startTime,searchDateEnd: endTime})
			$("#img-loading-gif").remove()
			for(var key in data){
				$("#analysis-token").append(itemAnalysisToken(key))
				loadChartCircle(data[key], `chart-holder-`+key);
				loadChartCol(data[key], `chart-order-`+key)
			}
		}

		function itemAnalysisToken(symbol){
			return `
				<div id="analysis-token-`+symbol+`" class="col-12 mb-2">
					<div class="card">
						<div class="card-body">
							<div class="row">
								<div class="col-xl-4 col-sm-12">
									<div class="chart-holder chart-holder-`+symbol+`" id="chart-holder-`+symbol+`">
										
									</div>
								</div>
								<div class="col-xl-8 col-sm-12">
									<div class="chart-order chart-order-`+symbol+`" id="chart-order-`+symbol+`">
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			`
		}

		function loadChartCircle(data, view){
			var available = data.totalSupply - data.holders['CENTRAL_BANK'].value
			var userToken = available - data.holders["OPERATOR"].value - data.holders["VIETKO_FEE"].value - data.holders["OPERATOR_FEE"].value - data.holders["CLIENT"].value - data.holders["CLIENT_TRADER"].value - data.holders["TRADER"].value
			var colors = Highcharts.getOptions().colors,
			categories = ["AVAILABLE","UNAVAILABLE"],
			data = [
				{
					y: roundOf(available * 100 / data.totalSupply, 2),
			        color: colors[2],
					drilldown: {
						name: "AVAILABLE",
						categories: ["OPERATOR","VIETKO_FEE","OPERATOR_FEE","CLIENT","CLIENT_TRADER","TRADER","USER"],
						data: [
							roundOf(data.holders["OPERATOR"].value * 100 / data.totalSupply, 2),
							roundOf(data.holders["VIETKO_FEE"].value * 100 / data.totalSupply, 2),
							roundOf(data.holders["OPERATOR_FEE"].value * 100 / data.totalSupply, 2),
							roundOf(data.holders["CLIENT"].value * 100 / data.totalSupply, 2),
							roundOf(data.holders["CLIENT_TRADER"].value * 100 / data.totalSupply, 2),
							roundOf(data.holders["TRADER"].value * 100 / data.totalSupply, 2),
							roundOf(userToken * 100 / data.totalSupply, 2),
						]
					}
				},
			    {
			        y: roundOf(data.holders['CENTRAL_BANK'].value * 100 / data.totalSupply, 2),
			        color: colors[1],
			        drilldown: {
			            name: 'UNAVAILABLE',
			            categories: ['UNAVAILABLE'],
			            data: [
			            	roundOf(data.holders['CENTRAL_BANK'].value * 100 / data.totalSupply, 2),
			            ]
			        }
			    }
			],
			browserData = [],
			versionsData = [],
			i,
			j,
			dataLen = data.length,
			drillDataLen,
			brightness;

			// Build the data arrays
			for (i = 0; i < dataLen; i += 1) {

			    // add browser data
			    browserData.push({
			        name: categories[i],
			        y: data[i].y,
			        color: data[i].color
			    });

			    // add version data
			    drillDataLen = data[i].drilldown.data.length;
			    for (j = 0; j < drillDataLen; j += 1) {
			        brightness = 0.2 - (j / drillDataLen) / 5;
			        versionsData.push({
			            name: data[i].drilldown.categories[j],
			            y: data[i].drilldown.data[j],
			            color: Highcharts.color(data[i].color).brighten(brightness).get()
			        });
			    }
			}
			Highcharts.chart(view, {
			    chart: {
			        type: 'pie'
			    },
			    title: {
			        text: 'BANI',
			        align: 'left'
			    },
			    plotOptions: {
			        pie: {
			            shadow: false,
			            center: ['50%', '50%']
			        }
			    },
			    tooltip: {
			        valueSuffix: '%'
			    },
			    series: [{
			        name: 'Browsers',
			        data: browserData,
			        size: '60%',
			        dataLabels: {
			            formatter: function () {
			                return this.y > 5 ? this.point.name : null;
			            },
			            color: '#ffffff',
			            distance: -30
			        }
			    }, {
			        name: 'Versions',
			        data: versionsData,
			        size: '80%',
			        innerSize: '60%',
			        dataLabels: {
			            formatter: function () {
			                // display only if larger than 1
			                return this.y > 1 ? '<b>' + this.point.name + ':</b> ' +
			                    this.y + '%' : null;
			            }
			        },
			        id: 'versions'
			    }],
			    responsive: {
			        rules: [{
			            condition: {
			                maxWidth: 400
			            },
			            chartOptions: {
			                series: [{
			                }, {
			                    id: 'versions',
			                    dataLabels: {
			                        enabled: false
			                    }
			                }]
			            }
			        }]
			    }
			});
		}

		function loadChartCol(data, view){
			Highcharts.chart(view, {
			    chart: {type: 'column'},
			    title: {text: 'Buy and sell BANI'},
			    yAxis: {
			        min: 0,
			        title: {
			            text: 'Token'
			        }
			    },
			    xAxis: {
			        type: 'category',
			        categories: data.titles,
			        labels: {
			            rotation: -80,
			            style: {
			                fontSize: '11px',
			                fontFamily: 'Verdana, sans-serif'
			            }
			        }
			    },
			    tooltip: {
			        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
			        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
			            '<td style="padding:0"><b>{point.y:.1f} Token</b></td></tr>',
			        footerFormat: '</table>',
			        shared: true,
			        useHTML: true
			    },
			    series: [{
			    	name: data.orders["BUY"].name,
			    	data: data.orders["BUY"].values
			    },{
			    	name: data.orders["SELL"].name,
			    	data: data.orders["SELL"].values
			    }]
			});
		}
	</script>
</body>
</html>