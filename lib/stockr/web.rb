
require "sinatra"
unless Module.const_defined?("Stockr")
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__) + "/../"))
  require "stockr"
end
include Stockr


get '/' do
  parts = Part.all
  @parts = parts.map(&:to_json)
  @sum = parts.reduce(0) { |n, p| n += p.price_total }

  erb <<INDEX
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html class="cufon-active cufon-ready"><head>


    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Stockr : My Stock</title>
    <script type="text/javascript" src="bundle.js"></script>

    <style type="text/css">
/* CSS ************************************************************************/
.content { font-size: 1.1em !important; }
.content p + ul { margin-top: -0.8em; }
.sticker .content h1 { font-size: 1.6em; margin: 0.4em 0 0.4em 0; }
.sticker .content h2 { font-size: 1.4em ;}
.sticker .content h3 { font-size: 1.2em ;}
.sticker .content a, .sticker a { color: #A71500; text-decoration: underline; }
.sticker .content form { margin: 0; padding: 0; }

/* Basics */
a { text-decoration: none; }

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

.small { margin-top: -0.25em; line-height: 1.4em; font-size: 0.8em; margin-bottom: 0.9em; font-style: italic; color: #444; }

/* Page */
#wrapper {margin: 0 auto; width: 982px; }
html { background: #d05400 no-repeat top center; }
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

.engraved {  color: #350808;  text-shadow: rgba(253, 204, 197, 0.4) 1px 1px 0px;}
.vspace { height: 2em;}

.liveExample { padding: 1em; background-color: #EEEEDD; border: 1px solid #CCC; max-width: 98%; }
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


/* Footer */
#page-footer { padding: 15px; text-align: right; }

.liveExample table, .liveExample td, .liveExample th { padding: 0.2em; border-width: 0; }
.liveExample td input { width: 13em; }
tr { vertical-align: top; }
.liveExample input.error { border: 1px solid red; background-color: #FDC; }
.liveExample label.error { display: block; color: Red; font-size: 0.8em; }

/* CSS ****************************************************************************/

</style>


  </head><body>
    <div id="wrapper">
      <div>
        <div class="full">
          <div class="sticker">
            <div class="content">

                <h2>My Stock - <%= Time.now %> </h2>
                <div class="liveExample">
                <form action="/up">
                  <table data-bind="visible: parts().length &gt; 0">
                    <thead>
                      <tr>
                        <th>Qty</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>
                        </th></tr>
                    </thead>
                    <tbody data-bind="template: { name: &quot;partRowTemplate&quot;, foreach: parts }">
                   </tbody></table>

                  <button data-bind="click: addPart">Add Part</button>
                  <button data-bind="enable: parts().length &gt; 0" type="submit">Submit</button>
                  <p>We got <span data-bind="text: parts().length">2</span> part(s). $ <%= @sum %> </p>
                </form>

<script type="text/html" id="partRowTemplate">
    <tr>
        <td><input class="required number" data-bind="value: qty, uniqueName: true"/></td>
        <td><input class="required" data-bind="value: name, uniqueName: true"/></td>
        <td><input class="number" data-bind="value: price, uniqueName: true"/></td>
        <td><span class="small" data-bind="text: total_price"></span></td>
        <td><a href="#" data-bind="click: function() { viewModel.removePart($data) }">Delete</a></td>
    </tr>
</script>


                <script type="text/javascript">
                  /*<![CDATA[*/
    var viewModel = {
        parts: ko.observableArray([<%= @parts.join(',') %>]),

        addPart: function () {
            this.parts.push({ qty: "", name: "", price: "", total_price: "" });
        },

        removePart: function (part) {
            this.parts.remove(part);
        },

        save: function (form) {
            //lert("Could now transmit to server: " + ko.utils.stringifyJson(this.parts));
            ko.utils.postJson($("form")[0], this.parts);
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


Total:

INDEX
end

get '/new' do
  haml :new
end

get '/bundle.js' do
  File.open(File.dirname(__FILE__) + "/assets/bundle.js")
end


get '/:id' do
  @part = Part.find(params[:id])
  if (@part)
    haml :show
  else
    redirect '/'
  end
end


post '/up' do
  params.each do |id, data|
    data.gsub!(/\\|\"/, "")
    # just to not require json and play
    attrs = [:qty, :name, :price].map { |a| data.match(/\{?\s?(#{a})\s?:\s?(\w*)}?/)[2] }
    p attrs
    Part.find_or_create(*attrs)
  end
  "..."
  redirect '/'
end


post '/' do
  @part = Part.new(:distance => params[:distance], :minutes => params[:minutes])
  if @part.save
    redirect "/#{@part.id}"
  else
    redirect '/'
  end
end

# Sinatra::Application.run!

