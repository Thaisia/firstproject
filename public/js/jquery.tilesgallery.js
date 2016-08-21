/*!
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * jQuery Tiles Gallery
 * Version: 2.0
 * Author: GreenTreeLabs <http://www.greentreelabs.net>
 */


; (function ($, window, document, undefined) {


    // Create the defaults once
    var pluginName = 'tilesGallery',
        defaults = {
            margin: 10,
            keepArea: true,
            enableTwitter: false,
            enableFacebook: false,
            enableGplus: false,
            enablePinterest: false,
            hoverEffect: 'fade',
            hoverEasing: 'swing',
            hoverEffectDuration: 250,
        };

    // The actual plugin constructor
    function Plugin(element, options) {
        this.element = element;
        this.$element = $(element);
        this.$itemsCnt = this.$element.find(".items");
        this.$items = this.$itemsCnt.find(".item");

        this.options = $.extend({}, defaults, options);

        this._defaults = defaults;
        this._name = pluginName;

        this.tiles = [];
        this.$tilesCnt = null;
        this.completed = false;
        this.lastWidth = 0;
        this.resizeTO = 0;
        this.init();
    }

    Plugin.prototype.createGrid = function () {
        var plugin = this;
        
        for (var i = 0; i < this.$items.not(".jtg-hidden").length; i++)
            this.tiles.push(plugin.getSlot());
        
        this.tiles.sort(function (x, y) {
            return x.position - y.position;
        });

        this.$items.not(".jtg-hidden").each(function (i, item) {
            var slot = plugin.tiles[i];
            
            $(item)
		   		.data('size', slot)
		   		.addClass('tiled')
		   		.addClass(slot.width > slot.height ? 'tile-h' : 'tile-v')
                .data('position');
        });

        //apply css
        this.$items.each(function (i, item) {
            $(item).css($(item).data('size'));
        });

        setTimeout(function () {
            plugin.$items.css({
                transition: 'all .5s'
            });
        }, 1000);
        this.completed = true;
    }

    Plugin.prototype.getSlot = function () {

        if (this.tiles.length == 0) {
            var tile = {
                top: 0,
                left: 0,
                width: this.$itemsCnt.width(),
                height: this.$itemsCnt.height(),
                area: this.$itemsCnt.width() * this.$itemsCnt.height(),
                position: 0
            };            
            return tile;
        }

        var maxTileIdx = 0;
        for (var i = 0; i < this.tiles.length; i++) {
            var tile = this.tiles[i];
            if (tile.area > this.tiles[maxTileIdx].area) {
                maxTileIdx = i;
            }
        }

        var tile = {};

        var maxTileData = this.tiles[maxTileIdx];

        if (maxTileData.width > maxTileData.height) {
            maxTileData.prevWidth = maxTileData.width;
            maxTileData.width = Math.floor((maxTileData.width / 2) + ((maxTileData.width / 3) * (Math.random() - .5)));

            tile = {
                top: maxTileData.top,
                left: maxTileData.left + maxTileData.width + this.options.margin,
                width: maxTileData.prevWidth - maxTileData.width - this.options.margin,
                height: maxTileData.height
            }

        } else {
            maxTileData.prevHeight = maxTileData.height;
            maxTileData.height = Math.floor((maxTileData.height / 2) + ((maxTileData.height / 3) * (Math.random() - .5)));

            tile = {
                left: maxTileData.left,
                top: maxTileData.top + maxTileData.height + this.options.margin,
                width: maxTileData.width,
                height: maxTileData.prevHeight - maxTileData.height - this.options.margin
            }
        }

        tile.area = tile.width * tile.height;
        tile.position = tile.top * 1000 + tile.left;

        maxTileData.position = maxTileData.top * 1000 + maxTileData.left;

        this.tiles[maxTileIdx] = maxTileData;
        this.tiles[maxTileIdx].area = maxTileData.width * maxTileData.height;
        
        return tile;
    }

    Plugin.prototype.reset = function () {
        var instance = this;
        instance.tiles = [];
        instance.createGrid();
        instance.$itemsCnt.find('.pic').each(function (i, o) {
            instance.placeImage(i);
        });
        instance.lastWidth = instance.$itemsCnt.width();
    }

    Plugin.prototype.onResize = function (instance) {
        if (instance.lastWidth == instance.$itemsCnt.width())
            return;

        clearTimeout(instance.resizeTO);
        instance.resizeTO = setTimeout(function () {

            if (instance.options.keepArea) {
                var area = instance.$itemsCnt.data('area');
                instance.$itemsCnt.height(area / instance.$itemsCnt.width());
            }

            instance.reset();

        }, 100);
    }

    Plugin.prototype.placeImage = function (index) {

        var $tile = this.$items.eq(index);
        var $image = $tile.find('.pic');

        var tSize = $tile.data('size');
        var iSize = $image.data('size');


        var tRatio = tSize.width / tSize.height;
        var iRatio = iSize.width / iSize.height;

        var valign = $image.data('valign') ? $image.data('valign') : 'middle';
        var halign = $image.data('halign') ? $image.data('halign') : 'center';

        var cssProps = {
            top: 'auto',
            bottom: 'auto',
            left: 'auto',
            right: 'auto',
            width: 'auto',
            height: 'auto',
            maxWidth: '999em'
        };

        if (tRatio > iRatio) {
            cssProps.width = tSize.width;
            cssProps.left = 0;

            switch (valign) {
                case 'top':
                    cssProps.top = 0;
                    break;
                case 'middle':
                    cssProps.top = 0 - (tSize.width * (1 / iRatio) - tSize.height) / 2;
                    break;
                case 'bottom':
                    cssProps.bottom = 0;
                    break;
            }

        } else {

            cssProps.height = tSize.height;
            cssProps.top = 0;

            switch (halign) {
                case 'left':
                    cssProps.left = 0;
                    break;
                case 'center':
                    cssProps.left = 0 - (tSize.height * iRatio - tSize.width) / 2;
                    break;
                case 'right':
                    cssProps.right = 0;
                    break;
            }
        }

        $image.css(cssProps).fadeIn();
    }

    Plugin.prototype.loadImage = function (index) {
        var instance = this;
        var source = instance.$items.eq(index).find('.pic');
        var img = new Image();
        img.onerror = function () {
            if (index + 1 < instance.$tiles.length)
                instance.loadImage(index + 1);
        }
        img.onload = function () {
            source.data('size', { width: this.width, height: this.height });
            instance.placeImage(index);

            if (index + 1 < instance.$items.length)
                instance.loadImage(index + 1);
        }
        img.src = source.attr('src');
    }

    Plugin.prototype.setupFilters = function () {
        var instance = this;
        instance.$element.delegate(".filters a", "click", function (e) {
            e.preventDefault();

            var filter = $(this).attr("href").substr(1);
            if (filter) {
                instance.$items.removeClass('jtg-hidden');
                instance.$items.show();
                instance.$items.not("." + filter).addClass("jtg-hidden").hide();                
            } else {
                instance.$items.removeClass('jtg-hidden');
                instance.$items.show();
            }

            instance.reset();
        });
    };

    Plugin.prototype.init = function () {
        var instance = this;

        this.$itemsCnt.css({
            position: 'relative',
            zIndex: 1
        });
                        
        this.$items.addClass("tile");

        if (this.options.width) {
            this.$itemsCnt.width(this.options.width);
        }

        if (this.options.height) {
            this.$itemsCnt.height(this.options.height);
        }

        this.$itemsCnt.data('area', this.$itemsCnt.width() * this.$itemsCnt.height());

        this.lastWidth = this.$itemsCnt.width();
        this.createGrid();

        this.loadImage(0);

        var instance = this;
        $(window).resize(function () {
            instance.onResize(instance);
        });

        this.setupFilters();
        this.setupHover();
        this.setupSocial();
    };

    Plugin.prototype.setupHover = function () {
        var instance = this;
        instance.$items.each(function (i, tile) {
            var $tile = $(tile);
            var $caption = $tile.find(".caption");

            if ($caption.length > 0) {
                $caption.css({
                    position: "absolute",
                    width: "100%",
                    height: "100%",
                    opacity: 0
                });
                var props = {
                    enter: {},
                    leave: {}
                };
                switch (instance.options.hoverEffect) {
                    default:
                    case "fade":
                        $caption.css({
                            left: 0,
                            top: 0
                        });
                        props.enter.opacity = 1;
                        props.leave.opacity = 0;
                        break;
                    case "slide-top":
                        $caption.css({
                            left: 0,
                            top: 0 - $tile.data('size').height
                        });
                        props.enter.top = 0;
                        props.leave.top = 0 - $tile.data('size').height;
                        props.enter.opacity = 1;
                        props.leave.opacity = 0;
                        break;
                    case "slide-bottom":
                        $caption.css({
                            left: 0,
                            bottom: 0 - $tile.data('size').height
                        });
                        props.enter.bottom = 0;
                        props.leave.bottom = 0 - $tile.data('size').height;
                        props.enter.opacity = 1;
                        props.leave.opacity = 0;
                        break;
                    case "slide-left":
                        $caption.css({
                            left: 0 - $tile.data('size').width,
                            top: 0
                        });
                        props.enter.left = 0;
                        props.leave.left = 0 - $tile.data('size').width;
                        props.enter.opacity = 1;
                        props.leave.opacity = 0;
                        break;
                    case "slide-right":
                        $caption.css({
                            right: 0 - $tile.data('size').width,
                            top: 0
                        });
                        props.enter.right = 0;
                        props.leave.right = 0 - $tile.data('size').width;
                        props.enter.opacity = 1;
                        props.leave.opacity = 0;
                        break;
                }
                $tile.mouseenter(function () {
                    $caption.css('display', 'block');
                    $caption.animate(props.enter,
                            instance.options.hoverEffectDuration,
                            instance.options.hoverEasing,
                            function () { });
                });
                $tile.mouseleave(function () {
                    $caption.animate(props.leave,
                            instance.options.hoverEffectDuration,
                            instance.options.hoverEasing,
                            function () { });
                });
            }
        });

    }

    Plugin.prototype.setupSocial = function () {
        if (this.options.enableTwitter || this.options.enableFacebook ||
            this.options.enableGplus || this.options.enablePinterest) {

            this.$items.each(function (i, tile) {
                var $tile = $(tile);
                $tile.append("<div class='jtg-social' />");
            });
        }

        if (this.options.enableTwitter)
            setupTwitter(this.$items, this);
        if (this.options.enableFacebook)
            setupFacebook(this.$items, this);
        if (this.options.enableGplus)
            setupGplus(this.$items, this);
        if (this.options.enablePinterest)
            setupPinterest(this.$items, this);
    }

    var addSocialIcon = function ($tiles, cssClass, name) {
        $tiles.find(".jtg-social").each(function (i, tile) {
            var $tile = $(tile);

            var tw = $("<a class='" + cssClass + "' href='#'></a>");
            $tile.append(tw);
        });
    }

    //credits James Padolsey http://james.padolsey.com/
    var qualifyURL = function (url) {
        var img = document.createElement('img');
        img.src = url; // set string url
        url = img.src; // get qualified url
        img.src = null; // no server request
        return url;
    }

    var setupTwitter = function ($tiles, plugin) {
        addSocialIcon($tiles, "tw-icon fa fa-twitter", "Twitter");
        $tiles.find(".tw-icon").click(function (e) {
            e.preventDefault();
            var $caption = $(this).parents(".tile:first").find(".caption");
            var text = plugin.options.twitterText || document.title;
            if (!plugin.options.twitterText && $caption.length == 1 && $caption.text().length > 0)
                text = $.trim($caption.text());
            var w = window.open("https://twitter.com/intent/tweet?url=" + encodeURI(location.href.split('#')[0]) + "&text=" + encodeURI(text), "ftgw", "location=1,status=1,scrollbars=1,width=600,height=400");
            w.moveTo((screen.width / 2) - (300), (screen.height / 2) - (200));
        });
    }

    var setupFacebook = function ($tiles, plugin) {
        addSocialIcon($tiles, "fb-icon fa fa-facebook", "Facebook");
        $tiles.find(".fb-icon").click(function (e) {
            e.preventDefault();

            var image = $(this).parents(".tile:first").find(".pic");

            var $caption = $(this).parents(".tile:first").find(".caption");
            var text = plugin.options.facebookText || document.title;
            if (!plugin.options.facebookText && $caption.length == 1 && $caption.text().length > 0)
                text = $.trim($caption.text());

            var url = "http://www.facebook.com/sharer.php?u=" + encodeURI(location.href.split('#')[0]) + "&t=" + encodeURI(text);

            if (image.length == 1) {
                var src = image.attr("src");
                url += ("&p[images][0]=" + qualifyURL(src));
            }

            var w = window.open(url, "ftgw", "location=1,status=1,scrollbars=1,width=600,height=400");
            w.moveTo((screen.width / 2) - (300), (screen.height / 2) - (200));
        });
    }

    var setupPinterest = function ($tiles, plugin) {
        addSocialIcon($tiles, "pi-icon fa fa-pinterest", "Pinterest");
        $tiles.find(".pi-icon").click(function (e) {
            e.preventDefault();

            var image = $(this).parents(".tile:first").find(".pic");

            var $caption = $(this).parents(".tile:first").find(".caption");
            var text = plugin.options.facebookText || document.title;
            if (!plugin.options.facebookText && $caption.length == 1 && $caption.text().length > 0)
                text = $.trim($caption.text());

            var url = "http://pinterest.com/pin/create/button/?url=" + encodeURI(location.href) + "&description=" + encodeURI(text);

            if (image.length == 1) {
                var src = image.attr("src");
                url += ("&media=" + qualifyURL(src));
            }

            var w = window.open(url, "ftgw", "location=1,status=1,scrollbars=1,width=600,height=400");
            w.moveTo((screen.width / 2) - (300), (screen.height / 2) - (200));
        });
    }

    var setupGplus = function ($tiles, plugin) {
        addSocialIcon($tiles, "gp-icon fa fa-google-plus", "G+");
        $tiles.find(".gp-icon").click(function (e) {
            e.preventDefault();

            var url = "https://plus.google.com/share?url=" + encodeURI(location.href);

            var w = window.open(url, "ftgw", "location=1,status=1,scrollbars=1,width=600,height=400");
            w.moveTo((screen.width / 2) - (300), (screen.height / 2) - (200));
        });
    }

    $.fn[pluginName] = function (options) {
        var args = arguments;

        if (options === undefined || typeof options === 'object') {
            return this.each(function () {

                if (!$.data(this, 'plugin_' + pluginName)) {
                    $.data(this, 'plugin_' + pluginName, new Plugin(this, options));
                }
            });

        } else if (typeof options === 'string' && options[0] !== '_' && options !== 'init') {

            var returns;

            this.each(function () {
                var instance = $.data(this, 'plugin_' + pluginName);

                // Tests that there's already a plugin-instance
                // and checks that the requested public method exists
                if (instance instanceof Plugin && typeof instance[options] === 'function') {

                    // Call the method of our plugin instance,
                    // and pass it the supplied arguments.
                    returns = instance[options].apply(instance, Array.prototype.slice.call(args, 1));
                }

                // Allow instances to be destroyed via the 'destroy' method
                if (options === 'destroy') {
                    $.data(this, 'plugin_' + pluginName, null);
                }
            });

            return returns !== undefined ? returns : this;
        }
    };

}(jQuery, window, document));