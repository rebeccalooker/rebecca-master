project_name: "rebecca_fashionly"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }

constant: html_format__red_as_negative {
  value: "<div style='color:{%if value < 0%}#ff0000{%else%}#00b04f{%endif%}'>{{rendered_value}}</div>"
}
constant: html_format__style_red_as_negative {
  value: "color:{%if value < 0%}#ff0000{%else%}#00b04f{%endif%};"
}
constant: html_format__style_bold_for_certain_kpis {
  value: "font-weight:bold;"
}
constant: html_format__style_bold {
  value: "font-weight:bold;"
}
constant: html_format__vs_ly_bold_italic {
  value: "<b><em><font size=4 color={% if value < 0 %}#ff0000>{% else %}#00b04f>+{% endif %}{{ rendered_value }}<br/>vs. LY</font></em></b>"
}
constant: html_format__ac_small_font {
  value: "<font size=2><b>{{ rendered_value }} AC (k)</b></font>"
}
constant: html_format__diff_triangles {
#   value: "<b><em><font size=5 color={% if value < 0 %}#ff0000>&#9661{% else %}color=#00b04f>&#9651{% endif %} {{ rendered_value }}</font></em></b>"
value: "<b><em><font size=4 color={% if value < 0 %}#ff0000>&#9661{% else %}#00b04f>&#9651{% endif %} {{ rendered_value }}</font></em></b>"
### Borders require a div class, which in turn makes the rest of the
### single value viz not display correctly.
# style='border:6px solid #F6F6F8
}
constant: html_format__header_blocks {
  value: "<div class='vis'><div class='vis-single-value' style='font-size:20px;background-vertical-align:middle;width:100%;"
}
