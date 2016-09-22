$( document ).ready(function() {
  var chartInPage = document.getElementsByClassName("ct-chart");
  if (chartInPage.length > 0){
    initializeCharts(interventionAmongTimeData(),revenuePercentageData(),numberOfInterventionData());
  }
});

function interventionAmongTimeData() {
  var interventionAmongTime = document.getElementById('interventions_among_time_chart').getAttribute("interventionAmongTime");
  var interventionAmongTime = JSON.parse(interventionAmongTime);

  var interventionAmongTimeData = interventionAmongTime.map(function(stat){
    stat.date = new Date(stat.date);
    return stat;
  });
  return interventionAmongTimeData;
}

function revenuePercentageData() {
  var revenuePercentagelabels = [];
  var revenuePercentageSeries = [];
  var chartProfessionsRevenues = JSON.parse(document.getElementById('revenue_percentage_chart').getAttribute("chartProfessionsRevenues"));
  var totalRevenues = JSON.parse(document.getElementById('revenue_percentage_chart').getAttribute("totalRevenues"));

  for (var profession in chartProfessionsRevenues) {
    if (chartProfessionsRevenues[profession].revenues>0){
      var percentage = Math.round((((chartProfessionsRevenues[profession].revenues*100)/totalRevenues)*100))/100;
      revenuePercentagelabels.push(chartProfessionsRevenues[profession].name+' - ' +String(percentage) +'%');
      revenuePercentageSeries.push(chartProfessionsRevenues[profession].revenues);
    }
  }

  var data = {
    labels: revenuePercentagelabels,
    series: revenuePercentageSeries
  };
  return data;
}

function numberOfInterventionData() {
  var numberOfInterventionlabels = [];
  var numberOfInterventionSeries = [];
  var chartProfessionsRevenues = JSON.parse(document.getElementById('revenue_percentage_chart').getAttribute("chartProfessionsRevenues"));

  for (var profession in chartProfessionsRevenues) {
    numberOfInterventionlabels.push(chartProfessionsRevenues[profession].name);
    numberOfInterventionSeries.push(chartProfessionsRevenues[profession].nb_interventions);
  }
  var data = {
    labels: numberOfInterventionlabels,
    series: numberOfInterventionSeries
  };
  return data;
}

function initializeCharts(interventionAmongTimeData,revenuePercentageData,numberOfInterventionData) {
  //InterventionAmontTime chart
  MG.data_graphic({
    title: "Interventions au fil du temps",
    data: interventionAmongTimeData,
    interpolate: d3.curveLinear,
    right: 40,
    height: 600,
    full_width: true,
    target: '#interventions_among_time_chart'
  });
  //Revenue_percentage_chart
  var revenuePercentageChartOptions = {
    labelInterpolationFnc: function(value) {
      return value[0]+value[1]+value[2]+value[3]
    }
  };

  var responsiveOptions = [
    ['screen and (min-width: 640px)', {
      chartPadding: 30,
      labelOffset: 0,
      labelDirection: 'explode',
      labelInterpolationFnc: function(value) {
        return value;
      }
    }],
    ['screen and (min-width: 1024px)', {
      labelOffset: 0,
      chartPadding: 30
    }]
  ];

  new Chartist.Pie('#revenue_percentage_chart', revenuePercentageData, revenuePercentageChartOptions, responsiveOptions);
  // numberOfInterventionByProfession chart
  var numberOfInterventionOptions = {
     distributeSeries: true,
     horizontalBars: true,
     axisY: {
       offset: 100,
     },
     axisX: {
     onlyInteger: true
     }
   };
  new Chartist.Bar('#number_of_intervention_by_profession_chart',numberOfInterventionData,numberOfInterventionOptions);
}
