<script>
    //for Mobile-V3

    /*global $, window*/
    /*jslint browser, devel, multivar:true*/
    /*jshint maxparams:10, maxdepth:5, maxstatements:40, maxcomplexity:15 */
    (function(window) {
        "use strict";

    $(function() {
        //[383C79E9-E57D-F40E-980A-42808F4438C2]
        let groupName = "ACBDE";

    const $win = $(window);

    const sliderStep = 0.25;

    $win.on("xtopiaSignalRTrigger", function(e, event, param) {
        console.log(event, param);

    XSignalR.connection.invoke(
    "XtopiaSignalRTrigger",
    groupName,
    event,
    param
    );

    switch (event) {

                    case "showFundGraph": //intercept showfunddetails to show the graph

    $(".com-f6ab0226-8465-4b09-a07c-8e69d5edb8e4").show();
    $(".com-18306a23-ae4e-4b6a-8ef3-922e5d3ff4b3").show();
    $(".com-b3663a99-bda5-45d2-a241-da72bfbdd3d1").show();
    $(".com-67980f1c-3685-4be8-a340-c4b369743d22").show();
    $(".com-b3d1f9fc-7aa8-4161-9b9e-673c78301efa").show();

    $('[data-tid~="wfp-chart-type"]').val("Performance");
    $('[data-tid~="wfp-chart-from"]').val("1 Jan 2015");
    $('[data-tid~="wfp-chart-to"]').val("1 June 2022");

    break;

    case "showFundDetails":
    case "showFundTable": //intercept showfunddetails to show the graph

    $(".com-f6ab0226-8465-4b09-a07c-8e69d5edb8e4").hide();
    $(".com-18306a23-ae4e-4b6a-8ef3-922e5d3ff4b3").hide();
    $(".com-b3663a99-bda5-45d2-a241-da72bfbdd3d1").hide();
    $(".com-67980f1c-3685-4be8-a340-c4b369743d22").hide();
    $(".com-b3d1f9fc-7aa8-4161-9b9e-673c78301efa").hide();
    break;

    case "showInvestment":

    $('[data-tid~="wfp-txt-amount"]').val("100");
    $win.trigger("xtopiaSignalRTrigger", ["amountSetText", "100"]);
    $('input:radio[name=ccc26bed-6fd9-4d71-851a-7043ac84ef03]:nth(0)').attr('checked', true);

    default:

                }
            });

    //events

    //*********************************************************************************************************



    var UpdatePerfChart = function() {

        XSignalR.connection.invoke(
            "UpdatePerfChart",
            groupName,
            $('[data-tid~="wfp-chart-type"]').val(),
            $('[data-tid~="wfp-chart-from"]').val(),
            $('[data-tid~="wfp-chart-to"]').val()
        );

    //reset chart
    if ($('[data-tid~="wfp-chart-type"]').val() === "Please select one") {
        $('[data-tid~="wfp-chart-type"]').val("Performance");
                }
    if ($('[data-tid~="wfp-chart-from"]').val() === "null" || $('[data-tid~="wfp-chart-from"]').val() === "") {
        $('[data-tid~="wfp-chart-from"]').val("1 Jan 2015");
                }
    if ($('[data-tid~="wfp-chart-to"]').val() === "null" || $('[data-tid~="wfp-chart-to"]').val() === "") {
        $('[data-tid~="wfp-chart-to"]').val("1 June 2022");
                }

            }

    var UpdateInvestmentChart = function() {

        XSignalR.connection.invoke(
            "UpdateInvestmentChart",
            groupName,
            $('[data-tid~="wfp-txt-amount"]').val(),
            $('[data-tid~="wfp-rbl-investment-timeframe"] input').val()
        );

            }

    //$('[data-tid^="wfp-chart-"]')
    $('[data-tid~="wfp-chart-type"]').change(function() {

        UpdatePerfChart();

    //reset slider after click update chart
    sliderPerfChart.noUiSlider.set(0);

            });

    $('[data-tid^="wfp-chart-from"]').on("dp.hide", function(e) {
        UpdatePerfChart();
            });

    $('[data-tid^="wfp-chart-to"]').on("dp.hide", function(e) {
        UpdatePerfChart();
            });

    $('[data-tid~="wfp-txt-amount"]').change(function() {

        UpdateInvestmentChart();

    //reset slider after click update chart
    sliderInvestmentChart.noUiSlider.set(0);

            });

    $('[data-tid~="wfp-rbl-investment-timeframe"] input').change(function() {

        XSignalR.connection.invoke(
            "XtopiaSignalRTrigger",
            groupName,
            "updateInvestmentTimeframe",
            $(this).val()
        );

    UpdateInvestmentChart();

    //reset slider after click update chart
    sliderInvestmentChart.noUiSlider.set(0);

            });

            //setupSlider();

        });
    })(window);
//for Mobile-V3
</script>