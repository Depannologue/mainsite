$( document ).ready(function() {
  var chartInPage = document.getElementsByClassName("ct-chart");
  if (chartInPage.length != 0) {

    var interventionAmongTime = document.getElementById('interventions_among_time_chart').getAttribute("interventionAmongTime");
    var interventionAmongTime = JSON.parse(interventionAmongTime);

    var myData = interventionAmongTime.map(function(stat){
      stat.date = new Date(stat.date);
      return stat;
    });

    MG.data_graphic({
      title: "Interventions au fil du temps",
      data: myData,
      interpolate: d3.curveLinear,
      right: 40,
      height: 600,
      full_width: true,
      target: '#interventions_among_time_chart'
    });

    var mylabels = [];
    var mySeries = [];
    var chartProfessionsRevenues = JSON.parse(document.getElementById('revenue_percentage_chart').getAttribute("chartProfessionsRevenues"));
    var totalRevenues = JSON.parse(document.getElementById('revenue_percentage_chart').getAttribute("totalRevenues"));

    for (var profession in chartProfessionsRevenues) {
      if (chartProfessionsRevenues[profession].revenues>0){
        var percentage = Math.round((((chartProfessionsRevenues[profession].revenues*100)/totalRevenues)*100))/100;
        mylabels.push(chartProfessionsRevenues[profession].name+' - ' +String(percentage) +'%');
        mySeries.push(chartProfessionsRevenues[profession].revenues);
      }
    }

    var data = {
      labels: mylabels,
      series: mySeries
    };

    var options = {
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

    new Chartist.Pie('#revenue_percentage_chart', data, options, responsiveOptions);

    var mylabels2 = [];
    var mySeries2 = [];
    var chartProfessionsRevenues = JSON.parse(document.getElementById('revenue_percentage_chart').getAttribute("chartProfessionsRevenues"));

    for (var profession in chartProfessionsRevenues) {
      mylabels2.push(chartProfessionsRevenues[profession].name);
      mySeries2.push(chartProfessionsRevenues[profession].nb_interventions);
    }
    new Chartist.Bar('#number_of_intervention_by_profession_chart', {
      labels: mylabels2,
      series: mySeries2
    }, {
      distributeSeries: true,
      horizontalBars: true,
      axisY: {
        offset: 100,
      },
      axisX: {
      onlyInteger: true
    }
    });
  }
});
