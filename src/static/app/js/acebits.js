// ace extensions
ace.define('apb/abide/token_tooltip', ['require', 'exports', 'module' , 'ace/lib/dom', 'ace/lib/event', 'ace/range'], function(require, exports, module) {
var dom = ace.require("ace/lib/dom");
var event = ace.require("ace/lib/event");
var Range = ace.require("ace/range").Range;

var tooltipNode;

var TokenTooltip = function(editor) {
    if (editor.tokenTooltip)
        return;
    editor.tokenTooltip = this;    
    this.editor = editor;
    
    editor.tooltip = tooltipNode || this.TokenTooltip.prototype.$init();

    this.update = this.update.bind(this);
    this.onMouseMove = this.onMouseMove.bind(this);
    this.onMouseOut = this.onMouseOut.bind(this);
    event.addListener(editor.renderer.scroller, "mousemove", this.onMouseMove);
    event.addListener(editor.renderer.content, "mouseout", this.onMouseOut);
};

(function(){
    this.token = {};
    this.range = new Range();
    
    this.update = function() {
        this.$timer = null;
        
        var r = this.editor.renderer;
        if (this.lastT - (r.timeStamp || 0) > 1000) {
            r.rect = null;
            r.timeStamp = this.lastT;
            this.maxHeight = innerHeight;
            this.maxWidth = innerWidth;
        }

        var canvasPos = r.rect || (r.rect = r.scroller.getBoundingClientRect());
        var offset = (this.x + r.scrollLeft - canvasPos.left - r.$padding) / r.characterWidth;
        var row = Math.floor((this.y + r.scrollTop - canvasPos.top) / r.lineHeight);
        var col = Math.round(offset);

        var screenPos = {row: row, column: col, side: offset - col > 0 ? 1 : -1};
        var session = this.editor.session;
        var docPos = session.screenToDocumentPosition(screenPos.row, screenPos.column);
        var token = session.getTokenAt(docPos.row, docPos.column);

        if (!token && !session.getLine(docPos.row)) {
            token = {
                type: "",
                value: "",
                state: session.bgTokenizer.getState(0)
            };
        }
        if (!token) {
            session.removeMarker(this.marker);
            tooltipNode.style.display = "none";
            this.isOpen = false;
            return;
        }
        if (!this.isOpen) {
            tooltipNode.style.display = "";
            this.isOpen = true;
        }
        
        var tokenText = token.type;
        if (token.state)
            tokenText += "|" + token.state;
        if (token.merge)
            tokenText += "\n  merge";
        if (token.stateTransitions)
            tokenText += "\n  " + token.stateTransitions.join("\n  ");
        
        if (this.tokenText != tokenText) {
            tooltipNode.textContent = tokenText;
            this.tooltipWidth = tooltipNode.offsetWidth;
            this.tooltipHeight = tooltipNode.offsetHeight;
            this.tokenText = tokenText;
        }
        
        this.updateTooltipPosition(this.x, this.y);

        this.token = token;
        session.removeMarker(this.marker);
        this.range = new Range(docPos.row, token.start, docPos.row, token.start + token.value.length);
        this.marker = session.addMarker(this.range, "ace_bracket", "text");
    };
    
    this.onMouseMove = function(e) {
        this.x = e.clientX;
        this.y = e.clientY;
        if (this.isOpen) {
            this.lastT = e.timeStamp;
            this.updateTooltipPosition(this.x, this.y);
        }
        if (!this.$timer)
            this.$timer = setTimeout(this.update, 100);
    };
    
    this.onMouseOut = function(e) {
        var t = e && e.relatedTarget;
        var ct = e &&  e.currentTarget;
        while(t && (t = t.parentNode)) {
            if (t == ct)
                return;
        }
        tooltipNode.style.display = "none";
        this.editor.session.removeMarker(this.marker);
        this.$timer = clearTimeout(this.$timer);
        this.isOpen = false;
    };
    
    this.updateTooltipPosition = function(x, y) {
        var st = tooltipNode.style;
        if (x + 10 + this.tooltipWidth > this.maxWidth)
            x = innerWidth - this.tooltipWidth - 10;
        if (y > innerHeight * 0.75 || y + 20 + this.tooltipHeight > this.maxHeight)
            y = y - this.tooltipHeight - 30;
        
        st.left = x + 10 + "px";
        st.top = y + 20 + "px";
    };

    this.$init = function() {
        tooltipNode = document.documentElement.appendChild(dom.createElement("div"));
        var st = tooltipNode.style;
        st.position = "fixed";
        st.display = "none";
        st.background = "lightyellow";
        st.borderRadius = "";
        st.border = "1px solid gray";
        st.padding = "1px";
        st.zIndex = 1000;
        st.fontFamily = "monospace";
        st.whiteSpace = "pre-line";
        return tooltipNode;
    };

    this.destroy = function() {
        this.onMouseOut();
        event.removeListener(this.editor.renderer.scroller, "mousemove", this.onMouseMove);
        event.removeListener(this.editor.renderer.content, "mouseout", this.onMouseOut);
        delete this.editor.tokenTooltip;    
    };

}).call(TokenTooltip.prototype);

exports.TokenTooltip = TokenTooltip;
});

ace.define('apb/abide/settingsmenu', ['require', 'exports'],function(require,exports){
  var init = function(editor) {
   require("ace/ext/settings_menu").init(editor);
   };
 exports.init = init;
});

ace.define('apb/abide/keysmenu', ['require', 'exports'],function(require,exports){
  var init = function(editor) {
   require("ace/ext/keybinding_menu").init(editor);
   };
 exports.init = init;
});

// click in margin to toggle breakpoint
// https://groups.google.com/forum/#!topic/ace-discuss/sfGv4tRWZdY
ace.define('apb/abide/breakpoints', ['require', 'exports'],function(require,exports){
var init = function(editor) {
  console.log("breakpoints");
   EditSession = require("ace/edit_session").EditSession;
  function onGutterClick(e) {
	var s = editor.session;
	var className = e.domEvent.target.className
	if (className.indexOf('ace_fold-widget') < 0) {
		if (className.indexOf("ace_gutter-cell") != -1 && editor.isFocused()) {
			var row = e.getDocumentPosition().row;
			s[s.$breakpoints[row]?'clearBreakpoint':'setBreakpoint'](row);
			e.stop()
		}
	}
 };
 editor.on('gutterclick', onGutterClick);

};
exports.init = init;
});  

// https://groups.google.com/forum/#!topic/ace-discuss/sfGv4tRWZdY
ace.define('apb/abide/smart', ['require', 'exports'],function(require,exports,module){
 	function SmartBreakpoints() {
this.setBreakpointsAtRows = function(rows) {
this.$breakpoints = [];
for (var i=0; i<rows.length; i++) {
this.$breakpoints[rows[i]] = true;
}
this._dispatchEvent("changeBreakpoint", {});
};
this.setBreakpoints = function(bp) {
this.$breakpoints = bp;
this._dispatchEvent("changeBreakpoint", {});
};
this.clearBreakpoints = function() {
this.$breakpoints = [];
this._dispatchEvent("changeBreakpoint", {});
};

this.setBreakpoint = function(row, val) {
this.$breakpoints[row] = val ||true;
this._dispatchEvent("changeBreakpoint", {});
};

this.clearBreakpoint = function(row) {
delete this.$breakpoints[row];
this._dispatchEvent("changeBreakpoint", {});
};

this.getBreakpoints = function() {
return this.$breakpoints;
};

this._delayedDispatchEvent = function(eventName, e, delay) {
if (this[eventName+'_Timeout'] !=null || !this._eventRegistry) return;

var listeners = this._eventRegistry[eventName];
if (!listeners || !listeners.length) return;

var self = this;
this[eventName+'_Timeout'] = setTimeout(function(){
self[eventName+'_Timeout'] = null
self._dispatchEvent(eventName, e)
}, delay || 20)
};

this.updateDataOnDocChange = function(e) {
var delta = e.data;
var range = delta.range;
var len, firstRow, f1;
            
            if (range.end.row == range.start.row)
                return;

if (delta.action == "insertText") {
len = range.end.row - range.start.row
firstRow = range.start.column == 0 ? range.start.row: range.start.row + 1;
} else if (delta.action == "insertLines") {
len = range.end.row - range.start.row;
firstRow = range.start.row;
} else if (delta.action == "removeText") {
                len = range.start.row - range.end.row;
firstRow = range.start.row;
} else if (delta.action == "removeLines") {
len = range.start.row - range.end.row
firstRow = range.start.row;
}

if (len > 0) {
args = Array(len);
args.unshift(firstRow, 0)
this.$breakpoints.splice.apply(this.$breakpoints, args);
            } else if (len < 0) {
                var rem = this.$breakpoints.splice(firstRow + 1, -len);

                if(!this.$breakpoints[firstRow]){
		/*	for each(var oldBP in rem)
				if (oldBP){
					this.$breakpoints[firstRow] = oldBP
					break
				} */
			}
		}
	}

this.$init = function() {
this.doc.on('change', this.updateDataOnDocChange.bind(this));
}
};
SmartBreakpoints.call(EditSession.prototype);
});