"use strict";
(function ($) {
    if (!window.console) {
        var console = {
            log: function () { },
            warn: function () { },
            error: function () { },
            time: function () { },
            timeEnd: function () { }
        }
    }
    if ($) {
        $(function () {
            var fieldsets = $('fieldset');
            if (fieldsets) {
                fieldsets.each(function (index, element) {
                    var context = $(element);
                    if (!context.hasClass('form-horizontal')) context.addClass('form-horizontal');
                    /*<fieldset class="col-md-6 form-horizontal" data-bootstrap-label="col-sm-4 control-label" data-bootstrap-control="form-control" data-bootstrap-control-size="col-sm-8">*/
                    var labelClasses = context.data('bootstrap-label') || 'col-sm-4 control-label';
                    var controlClasses = context.data('bootstrap-control') || 'form-control';
                    var controlClassSize = context.data('bootstrap-control-size') || 'col-sm-8';

                    var children = context.children();
                    $.each(children, function (index, value) {
                        if (value.nodeName === 'LABEL' && value.classList.length === 0) {
                            $(value).addClass(labelClasses);
                            var sibling = $(value).next();
                            if (sibling) {
                                switch ($(sibling).prop('tagName')) {
                                    case 'TEXTAREA': {
                                        sibling.addClass(controlClassSize).addClass(controlClasses);
                                        $(value).next().addBack().wrapAll('<div class="form-group" />')
                                        break;
                                    }
                                    case 'INPUT': {
                                        // process as an input tag of the different types
                                        switch ($(sibling).attr('type')) {
                                            case 'text':
                                            case 'password':
                                            case 'number':
                                            case 'email':
                                            case 'tel':
                                            case 'search':
                                            case 'color':
                                            case 'url':
                                            case 'week':
                                            case 'month':
                                            case 'date':
                                            case 'datetime':
                                            case 'datetime-local':
                                            case 'time':
                                                sibling.addClass(controlClassSize).addClass(controlClasses);
                                                $(value).next().addBack().wrapAll('<div class="form-group" />')
                                                break;
                                            case 'range':
                                                sibling.addClass(controlClassSize).addClass(controlClasses);
                                                $(value).next().addBack().wrapAll('<div class="form-group" />')
                                                break;
                                            case 'file':
                                                sibling.addClass(controlClassSize).addClass(controlClasses);
                                                $(value).next().addBack().wrapAll('<div class="form-group" />')
                                                break;
                                            case 'radio':
                                                break;
                                            case 'checkbox':
                                                //sibling.addClass(controlClasses);
                                                var next = $(sibling).next();
                                                if (next.length === 1 && next[0].nodeName === 'LABEL') {
                                                    //$(next).addClass('control-label')
                                                    $(sibling).prependTo(next);
                                                    $(next).wrapAll('<div class="checkbox" />').addClass(controlClassSize);
                                                    $(value).next().addBack().wrapAll('<div class="form-group" />')
                                                } else {
                                                    $(sibling).wrapAll('<div class="checkbox" />');
                                                    //$(sibling).wrapAll('<label class="control-label" />').wrapAll('<div class="checkbox" />');
                                                    $(value).next().addBack().wrapAll('<div class="form-group" />')
                                                }

                                                break;
                                            default:
                                                break;
                                        }
                                        break;
                                    }
                                    case 'SELECT': {
                                        sibling.addClass(controlClassSize).addClass(controlClasses);
                                        $(value).next().addBack().wrapAll('<div class="form-group" />')
                                        break;
                                    }
                                    case 'TABLE': { // RadioButtonList/CheckBoxList .RepeatLayout="Table" (the default)
                                        sibling.wrap('<div />');
                                        $(value).next().addClass(controlClassSize).addClass('control-span');
                                        $(value).next().addBack().wrapAll('<div class="form-group" />')
                                        break;
                                    }
                                    case 'SPAN': { // RadioButtonList/CheckBoxList .RepeatLayout="Flow" (the default)
                                        sibling.addClass(controlClassSize).addClass('control-span');
                                        document.wha = sibling;
                                        $(value).next().addBack().wrapAll('<div class="form-group" />')
                                        break;
                                    }
                                    case 'OL': { // RadioButtonList/CheckBoxList .RepeatLayout="OrderedList" (the default)
                                        sibling.addClass('list-unstyled');
                                        sibling.wrap('<div />');
                                        $(value).next().addClass(controlClassSize).addClass('control-span');
                                        $(value).next().addBack().wrapAll('<div class="form-group" />')
                                        break;
                                    }
                                    case 'UL': { // RadioButtonList/CheckBoxList .RepeatLayout="UnorderedList" (the default)
                                        sibling.addClass('list-unstyled');
                                        sibling.wrap('<div />');
                                        $(value).next().addClass(controlClassSize).addClass('control-span');
                                        $(value).next().addBack().wrapAll('<div class="form-group" />')
                                        break;
                                    }
                                }
                            }
                        }
                    });
                });
            }
        });
    } else {
        console.log('jQuery is not defined. This script requires jQuery.')
    }
})(jQuery);

