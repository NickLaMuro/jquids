JQ UI Date Select
=================

This is a rewrite of Tim Harper's "Calendar Date Select" gem
(https://github.com/timcharper/calendar_date_select) using the jQuery UI date
picker.  This project is still in development and still far from working.

The projects intent is to simulate the ease of use of the original while:

- Updating the code to work with Rails 3
- Using the hosted jQuery UI infastructure to avoid local dependencies


Usage
-----

Add the following some where in your page (preferablly in the head of your
layout file):

    <%= jq_ui_date_select_includes %>

Change a field to so it uses the `jq_ui_date_select_tag`:

    <%= jq_ui_date_select_tag "some_date" %>

and you should be good to go!


Customization
-------------

CalendarDateSelect allow for the use of many different formats and css styles,
and JqUiDateSelect was made to allow for that same kind of flexibility, with
out all of the weight of an full library of javascript and css files in your
public folder.


### Custom Style

To change the style, just add `:style => :new_style` to the
`jq_ui_date_select_includes` declaration:

    <%= jq_ui_date_select_includes :style => :vader %>

And the new style will be applied.  All styles come from the Google CDN
(http://code.google.com/apis/libraries/devguide.html), so they are not hosted
in your application.  If you wish to theme roll your own style
(http://jqueryui.com/themeroller/), just set `:style` to `:none`, `nil`, or
`false`, and include your style sheet in your project.

All styles that are available via the Google CDN for jQueryUI can be found
below.


### Custom Format

To set the format the same way that was done with CalendarDateSelect, just set
the JqUiDateSelect format variable using the `format=` function somewhere in
your code:

    <% JqUiDateSelect.format= :american %>

or you can set it in `jq_ui_date_select_includes` method by setting the
`:format` variable in the options hash:

    <%= jq_ui_date_select_includes :format => :american %>

All the formats used mimic what was used in the original CalendarDateSelect
gem.  The formats available are listed below.


### Customizing the jQuery UI Datepicker

The jQuery datepicker has many options that you can implement through
JqUiDateSelect via the `:datepicker_options` hash.  To add an option to a
single datepicker element, simply add the hash as an argument to
`jq_ui_date_select_tag` call:

    <%= jq_ui_date_select_tag "some_date", nil, :datepicker_options => {:showButtonPanel => true} %>

and now the datepicker will use the jQueryUI's button panel at the bottom of
the datepicker for that instance.  But if you have multiple instances that all
should have the `showButtonPanel` equal to true, add the `:datepicker_options`
to the `jq_ui_date_select_includes`:

    <%= jq_ui_date_select_includes :datepicker_options => {:showButtonPanel => true} %>

and the change will be applied to all instances of the datepicker.  You can
overide that change by setting the setting to false on the desired
`jq_ui_date_select_tag` instances.

A full list of all of the jQueryUI functions can be found here:
http://jqueryui.com/demos/datepicker/#options


Styles
------

The default style is `:base`.  The following can be implemented via the
`jq_ui_date_select_includes` function:

* `:base`
* `:black_tie`
* `:blitzer`
* `:cupertino`
* `:dark_hive`
* `:dot_luv`
* `:eggplant`
* `:excite_bike`
* `:flick`
* `:hot_sneaks`
* `:humanity`
* `:le_frog`
* `:mint_choc`
* `:overcast`
* `:pepper_grinder`
* `:redmond`
* `:smoothness`
* `:south_street`
* `:start`
* `:sunny`
* `:swanky_purse`
* `:trontastic`
* `:ui_darkness`
* `:ui_lightness`
* `:vader`


Formats
-------

The default format is `:natural`.  Other formats include:

* `:natural` = "%B %d, %Y"
* `:hyphen_ampm` = "%Y-%m-%d"
* `:iso_date` = "%Y-%m-%d"
* `:finnish` = "%d.%m.%Y"
* `:danish` = "%d/%m/%Y"
* `:american` = "%m/%d/%Y"
* `:euro_24hr` = "%d %B %Y"
* `:euro_24hr_ymd` = "%Y.%m.%d"
* `:italian` = "%d/%m/%Y"
* `:db` = "%Y-%m-%d"

The only two formats currently with time
in am-pm is `:natural`, `:hyphen_ampm`, and `:american`.

**NOTE:** Currently time is NOT implemented into the datepicker because jQuery
does not support time with it's date picker.  A fix for that will come in the
future.


TODO
----

- Allow for the choice to use different versions of jQuery and jQuery UI, or
  not include them all together
- Allow for setting the format via the `jq_ui_date_select_includes` method and
  the ability to set it on a case by case basis
- Map the option settings for CalendarDateSelect to JqUiDateSelect
- Add time module to the datepicker
- Get it to work in rails 2 and 3
- Integrate with formtastic


Contribute/Suggestions
----------------------
Suggestions and contributions to the project are welcome.
