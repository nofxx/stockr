require "sinatra"
include Stockr
# unless const_defined?("Stockr")

#   require "stockr"

get '/hi' do
  "Hello World!"
end

get '/' do
  @parts = Part.all
  erb <<INDEX
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html class="cufon-active cufon-ready"><head>


    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Stockr : My Stock</title>
    <!--[if IE]><link rel="stylesheet" type="text/css" href="../css/tripoli.simple.ie.css" /><![endif]-->
    <!--[if lte IE 7]><link rel="stylesheet" type="text/css" href="../css/ie6ie7.css" /><![endif]-->
    <!--[if lte IE 6]><link rel="stylesheet" type="text/css" href="../css/ie6.css" /><![endif]-->
    <script type="text/javascript" src="knockout.js"></script>

              <style type="text/css">
/* Tripoli overrides */
.content { font-size: 1.1em !important; }
.content p + ul { margin-top: -0.8em; }
.sticker .content h1 { font-size: 1.6em; margin: 0.4em 0 0.4em 0; }
.sticker .content h2 { font-size: 1.4em ;}
.sticker .content h3 { font-size: 1.2em ;}
.sticker .content a, .sticker a { color: #A71500; text-decoration: underline; }
.sticker .content form { margin: 0; padding: 0; }

/* Basics */
a { text-decoration: none; }
code { font-family: Consolas, Monaco, "Courier New", mono-space, monospace !important; }
.content .syntaxhighlighter table, .content .syntaxhighlighter td { border-width: 0; }
.content .syntaxhighlighter table { margin-bottom: 0; }
.syntaxhighlighter {
  width: 680px; overflow-x: auto; margin-bottom: 1.8em;
  -moz-border-radius: 0.5em; -webkit-border-radius: 0.5em; border-radius: 0.5em;
}
.syntaxhighlighter .line {
    white-space: pre !important;
    line-height: 1.2em;
}
.syntaxhighlighter code {
    white-space: pre !important;
}
.syntaxhighlighter.ie {
  overflow-y: hidden;
}

.center { text-align: center }
.left { text-align: left }
.right { text-align: right }
.justify { text-align: justify }

.floatLeft { float: left !important; }
.floatRight { float: right !important; }
.floatNone { float: none !important; }

.clear { clear: both}
.clearfix:after { content: "."; display: block; height: 0; clear: both; visibility: hidden }

.relative { position: relative !important }
.absolute { position: absolute }

.inline { display: inline; }
.cursor { cursor: pointer }

ul.tickIcons li { list-style-type: none;
  background-image: url(../img/checkIcon.gif); background-repeat: no-repeat; background-position: 0px 6px;
  margin-left: -0.5em; padding-left: 2em; line-height: 2em; margin-bottom: 0.3em;
}

li p.smallprint { margin-top: -0.25em; line-height: 1.4em; font-size: 0.9em; margin-bottom: 0.9em; font-style: italic; color: #444; }

ul.stickerList li { margin: 0.5em 0 0.9em 0; }
ul.stickerList li p.smallprint { margin-top: 0.1em; }

/* Page */
#wrapper {margin: 0 auto; width: 982px; }
html { background: #d05400 url(../img/main-background.jpg) no-repeat top center; }
body { font-family: arial; font-size: 14px; }
.sticker {
  background-color: white; padding: 1.25em 1.45em 1.25em 1.55em; margin: 0.5em 0 3em 0; -moz-border-radius: 1em; -webkit-border-radius: 1em; border-radius: 1em;
  opacity:0.9; -moz-box-shadow: 0 0 1.1em #666; -webkit-box-shadow: 0 0 1.1em #666; box-shadow: 0 0 1.1em #666;
}
.sticker .heading, .sticker h1 { color: #A71500; margin: 0.25em 0 0.25em 0; font-weight: bold; font-size: 1.2em; }
.stickerHeading {
  background-color: rgb(229, 218, 214); height: 1.3em; margin: -2em -1.45em 1.25em -1.55em; padding: 0.7em 1em 1.1em 1.75em;
  -moz-border-radius-topright: 1em; -moz-border-radius-topleft: 1em;
  -webkit-border-top-right-radius: 1em; -webkit-border-top-left-radius: 1em;
  border-top-right-radius: 1em; border-top-left-radius: 1em;
}

.engraved {
  color: #350808;
  text-shadow: rgba(253, 204, 197, 0.4) 1px 1px 0px;
}

.vspace { height: 2em;}

.liveExample { padding: 1em; background-color: #EEEEDD; border: 1px solid #CCC; max-width: 655px; }
.liveExample input { font-family: Arial; }
.liveExample b { font-weight: bold; }
.liveExample p { margin-top: 0.9em; margin-bottom: 0.9em; }
.liveExample select[multiple] { width: 100%; height: 8em; }
.liveExample h2 { margin-top: 0.4em; }

/* Menu */
.main-menu { display:table; float:right; margin: 1em 0 0.5em 0; font-size: 14px; font-weight: bold; }
.main-menu ul li { display: inline; }
.main-menu ul li a {
  display: inline-block; padding: 0.4em 1.5em; text-decoration: none;
  -moz-border-radius: 0.5em; -webkit-border-radius: 0.5em; border-radius: 0.5em;
}
.main-menu ul li a, .main-menu ul li a:visited { color: white; }
.main-menu ul li a.active, .main-menu ul li a:hover { background-color: rgb(81, 29, 0); }

/* Intro */
#introBadges li { width: 215px; float:left; text-align: center; padding: 0 0.5em 0 0.5em; color: #555; margin-bottom: 0.5em; }

/* Homepage */
#slogan {
  float:right; width: 17em;
  padding-left: 1.4em;
  background: url(../img/vertical-bar.png) no-repeat;
  font-size: 20px;
  margin-bottom: 0.6em;
}

.download-button {
  background: url(../img/download-button-bg.png);
  width: 173px; height: 51px;
  display: block;
  margin-top: 0.6em;
}
.download-button p {
  color: #005500;
  font-size: 17px;
  padding: 0.6em 0 0 9px;
}
.download-button p.smallprint {
  font-size: 12px;
  padding: 0.1em 0 0 11px;
}
.download-button:hover p { text-decoration: underline; }


.homepageExample h2 { margin: 0.75em 0 0.5em 0;}
.homepageExample .liveExample { padding: 0.5em 1em 0.5em 1.3em; }
.homepageExample .liveExample button { padding: 0.2em 0.6em; margin-left: 0.5em; }
.homepageExample p { margin: 1.3em 0 0.8em 0; }

/* Footer */
#page-footer { padding: 15px; text-align: right; }

                .liveExample table, .liveExample td, .liveExample th { padding: 0.2em; border-width: 0; }
                .liveExample td input { width: 13em; }
                tr { vertical-align: top; }
                .liveExample input.error { border: 1px solid red; background-color: #FDC; }
                .liveExample label.error { display: block; color: Red; font-size: 0.8em; }
              </style>

  </head><body>
    <div id="wrapper">
      <div>
        <div class="full">
          <div class="sticker">
            <div class="content">

              <script src="gridEditor_files/jquery_002.js" type="text/javascript"> </script><h2>My Stock</h2><div class="liveExample">

                <form action="/someServerSideHandler">
                  <p>You have asked for <span data-bind="text: parts().length">2</span> part(s)</p>
                  <table data-bind="visible: parts().length &gt; 0">
                    <thead>
                      <tr>
                        <th>Part name</th>
                        <th>Price</th>
                        <th>
                        </th></tr>
                    </thead>
                    <tbody data-bind="template: { name: &quot;partRowTemplate&quot;, foreach: parts }">
                   </tbody></table>

                  <button data-bind="click: addPart">Add Part</button>
                  <button data-bind="enable: parts().length &gt; 0" type="submit">Submit</button>
                </form>

                <script id="partRowTemplate" type="text/html">
                  <tr>
                    <td>{{ko_code ((function() { return ko.templateRewriting.applyMemoizedBindingsToNextSibling(function() {                     return (function() { return { value: name, uniqueName: true, '_ko_property_writers' : { value : function(__ko_value) { name = __ko_value; } }  } })()                 }) })()) }}<input class='required'  /></td>
                    <td>{{ko_code ((function() { return ko.templateRewriting.applyMemoizedBindingsToNextSibling(function() {                     return (function() { return { value: price, uniqueName: true, '_ko_property_writers' : { value : function(__ko_value) { price = __ko_value; } }  } })()                 }) })()) }}<input class='required number'  /></td>
                    <td>{{ko_code ((function() { return ko.templateRewriting.applyMemoizedBindingsToNextSibling(function() {                     return (function() { return { click: function() { viewModel.removePart($data) } } })()                 }) })()) }}<a href='#' >Delete</a></td>
                  </tr>
                </script>


                <script type="text/javascript">
                  /*<![CDATA[*/
    var viewModel = {
        parts: ko.observableArray([
            <!-- { name: "Tall Hat", price: "39.95" }, -->
            <!-- { name: "Long Cloak", price: "120.00" } -->
        ]),

        addPart: function () {
            this.parts.push({ name: "", price: "" });
        },

        removePart: function (part) {
            this.parts.remove(part);
        },

        save: function (form) {
            alert("Could now transmit to server: " + ko.utils.stringifyJson(this.parts));
            // To transmit to server, write this: ko.utils.postJson($("form")[0], this.parts);
        }
    };

    ko.applyBindings(viewModel);

    $("form").validate({ submitHandler: function () { viewModel.save() } });
/*]]>*/
                </script>
              </div>



              <div class="clear"></div>
            </div>
          </div>
        </div>
        <div class="clear"></div>
        <div class="main-menu">
        </div>
        <div class="clear"></div>
      </div>

      <div id="page-footer">stockr</div>


  </body></html>


<br><br><br><br>
%h1 Stockr List

%table
  %tr
    %th Name
    %th Qty
    %th Price
  - for pr in @parts
    %tr
      %td= pr.name
      %td= pr.qty
      %td= pr.price

Total:

INDEX
end

get '/new' do
  haml :new
end

get '/knockout.js' do
  File.open(File.dirname(__FILE__) + "/assets/knockout.js")
end

get '/up' do
  "..."
end

get '/:id' do
  @part = Part.find(params[:id])
  if (@part)
    haml :show
  else
    redirect '/'
  end
end

post '/' do
  @part = Part.new(:distance => params[:distance], :minutes => params[:minutes])
  if @part.save
    redirect "/#{@part.id}"
  else
    redirect '/'
  end
end

Sinatra::Application.run!

