explore: html {}

view: html {
  sql_table_name: (select 1 as foo) ;;

  dimension: button_color {
    sql: foo ;;
    html: <div class='vis' style="background-color:#F6F6F8"><div class='vis-single-value'>
            <div class="btn-group btn-group-toggle btn-group-justified" data-toggle="buttons" style="background-color:#F6F6F8;vertical-align:middle;width:100%;">
            <center>
            <div class="btn-group" style="width: 33%"><a href="/dashboards/89"
            class="btn btn-lg btn-secondary" style="background-color:green"> <b>Button 1 text</b></a>
            </div>
            <div class="btn-group" style="width: 33%"><a href="/dashboards/101"
            class="btn btn-lg btn-secondary"> <b>Button 2 text</b></a>
            </div>
            <div class="btn-group" style="width: 33%"><a href="/dashboards/100"
            class="btn btn-lg btn-secondary"> <b>Button 3 text</b></a>
            </div>
            </center>
            </div>
          </div></div>
         ;;
  }
}




### copy-paste from Jesse S.

explore: html_test {}

view: html_test {
  derived_table: {
    sql: SELECT 1 ;;
  }

  dimension: text_wrap {
    type: string
    sql: 'This is a really long sentence that I want wrapped.' ;;
    html: <div class="vis">
          <div style="white-space: normal; word-wrap: break-word;width:100%; font-size:40%;">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
          incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
          <strong>quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</strong>
          </div>
          </div> ;;
  }

  measure: background {
    type: string
    sql: 10 ;;
    html:
    <div style="background-color: #F6F6F7; height:500px;width:100%"></div>
    <div style="background-color: #F6F6F7; height:100%; width:100%"><center>{{ value }}</center></div>
    <div style="background-color: #F6F6F7; height:500px;width:100%"></div>;;
  }

  measure: progress_bar {
    type: number
    sql: 50 ;;
    html:
    <br>
    <div class="progress">
    <div class="progress-bar progress-bar-striped active" role="progressbar"
     aria-valuenow="{{value}}" aria-valuemin="0" aria-valuemax="100" style="width:{{value}}%">
    {{value}}%
    </div>
  </div>;;
  }

  measure: tooltip {
    type: string
    sql: 'Hey' ;;
    html: <a href="#" data-toggle="tooltip" title="Hooray!">Hover over me</a> ;;
  }

  measure: badge {
    type: number
    sql: 5 ;;
    html: <div style="text-align:left"><a href="#">Text Example <span class="badge">{{value}}</span></a><div>;;
  }


  parameter: field_1 {
    label: "Enter Field Name"
    type: string
#     default_value: "What is your preferred car color?"
  }

  parameter: field_2 {
    label: "Enter Response"
    type: string
    default_value: "Blue"
  }

  dimension: field_1_response {
    type: string
    label: "{{ field_1._parameter_value }}"
    sql: {{ field_2._parameter_value }} ;;
  }

  dimension: test {
    hidden: yes
    primary_key: yes
    sql: 1 ;;
  }

  measure: new_york {
    type: string
    sql: 1;;
    html:
      <table>
      <tr>
      <td style="margin:0; padding:0;"></td>
      <td rowspan=2 style="padding:0; margin:0;"><img src="https://www.evernote.com/l/An_9zXI6nbtHJJ9cqs3zJnyOReehbLekBgMB/image.png" height="auto" width="100%"></td>
      </tr>
      <tr style="padding:0; margin:0 auto; width:100%">
      <td colspan=2 style="color:#fff; text-align:center; font-size:80%;padding:0; margin:0;"><strong>$3,765,930</strong>
      <br><font style="font-size:75%;">New York</font></td>
      <td style="margin:0; padding:0;"></td>
      </tr>
      </table>  ;;

    }

  measure: chicago {
    type: string
    sql: 1;;
    html:
    <table>
      <tr>
        <td style="margin:0; padding:0;"></td>
        <td rowspan=2 style="padding:0; margin:0;"><img src="https://www.evernote.com/l/An-thWJBDF1B7aDVoHpnTzTy_rhtifu5rDsB/image.png" height="auto" width="100%"></td>
      </tr>
      <tr style="padding:0; margin:0 auto; width:100%">
        <td colspan=2 style="color:#fff; text-align:center; font-size:80%;padding:0; margin:0;"><strong>$1,245,120</strong>
        <br><font style="font-size:75%;">Chicago</font></td>
        <td style="margin:0; padding:0;"></td>
      </tr>
    </table>  ;;
  }


  measure: london {
    type: string
    sql: 1;;
    html:
        <table>
        <tr>
        <td style="margin:0; padding:0;"></td>
        <td rowspan=2 style="padding:0; margin:0;"><img src="https://www.evernote.com/l/An-6f5bRH-pMXqlOnzp8g12ITA3BxwKZHVkB/image.png" height="auto" width="100%"></td>
        </tr>
        <tr style="padding:0; margin:0 auto; width:100%">
        <td colspan=2 style="color:#fff; text-align:center; font-size:80%;padding:0; margin:0;"><strong>$965,240</strong>
        <br><font style="font-size:75%;">London</font></td>
        <td style="margin:0; padding:0;"></td>
        </tr>
        </table>  ;;
  }

  measure: background_2 {
    type: string
    sql: 10 ;;
    html:
        <div style="margin:0; padding:0; border-radius:0; background-color: blue; height:1000px; width:100%">{{ rendered_value }}</div>;;
  }

  measure: custom_viz {
    hidden: yes
    type: number
    sql: 1 ;;
    html:
        <img src="https://quickchart.io/chart?c={type:'radialGauge',data:{datasets:[{data:[{{ attainment_display._value }}],backgroundColor:'green'}]}}" height=200 width=auto>

             ;;
  }

  measure: qualified_pipe_display {
    hidden: yes
    type: number
    sql: 1 ;;
    html:
    <div style="width:100%; text-align:left" >
    <h1 style="text-align:center;">
    <font size="5" color="gray"> Current Pipeline </font>
    </h1>
    <hr/>
    <h2 style= "margin-left: 30px">
    <font size="6">
    {{ total_active_acv._rendered_value}} </font>
    <font size="4" color="gray"> Qualified </font>
    <font size="4" color="#7CC8FA"> <strong>({{ won_plus_qualified_attainment._rendered_value}})</strong> </font>
    </h2>
    <h3 style= "margin-left: 30px">
    <font size="6">
    {{ projected_active_acv._rendered_value}} </font>
    <font size="4"color="gray"> Projected </font>
    <font size="4" color="#7CC8FA"> <strong>({{ projected_won_plus_qualified_attainment._rendered_value}})</strong> </font>
     </h3>
    </div>;;
  }

#   measure: section {
#     type: string
#     sql: 1 ;;
#     html: <div style="margin-top:0; padding: 0; float: center; background-color: #e8e8e8; width:100%;height:100px;">
#     <h1 style="text-align: center; font-size: 75%; color:#555; font-weight: 100;padding-top: 15px; padding-bottom: 0">$66k</h1>
#     <h2 style="text-align: center; font-size: 50%; color:#555; font-weight: 100; padding:inherit">Average Deal Size</h2>
# </div>
# <div style="border:none; margin:0; padding:0; background-color: #fff;width: 100%;text-align: left">
#     <ul style="border:none; font-size:75%; width: 30%; list-style: none;margin-left: 35%;margin-right: 35%">
#         <li style="padding-bottom: 10px;"><span style="margin-left:110px; font-size: 60%; padding:5px">$100k</span>ABC Company</li>
#         <li style="padding-bottom: 10px"><span style="margin-left:110px; font-size: 60%; padding:5px">$75k</span>The Company</li>
#         <li style="padding-bottom: 10px"><span style="margin-left:110px;font-size: 60%; padding:5px">$70k</span>Inc Company</li>
#         <li style="padding-bottom: 10px"><span style="margin-left:110px; font-size: 60%; padding:5px">$60k</span>My Company</li>
#     </ul>
# </div>     ;;
#   }


  }
