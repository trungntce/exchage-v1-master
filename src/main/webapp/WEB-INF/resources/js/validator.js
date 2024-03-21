/**
 * make date : 2022-03-03
 * maker : Trung.
 * className : Validator
 * description : Commons Validator for all input form
 */
function Validator(options) {
    function getParent(element, selector) {
        while (element.parentElement) {
            if (element.parentElement.matches(selector)) {
                return element.parentElement;
            }
            element = element.parentElement;
        }
    }

    var selectorRules = {};

    // function controll validate
    function validate(inputElement, rule) {
        var errorElement = getParent(inputElement, options.formGroupSelector).querySelector(options.errorSelector);
        var errorMessage;

        // get rules of selector
        var rules = selectorRules[rule.selector];

        // loops rule & check
        // if error then break
        for (var i = 0; i < rules.length; ++i) {
            switch (inputElement.type) {
                case 'radio':
                case 'checkbox':
                    errorMessage = rules[i](
                        formElement.querySelector(rule.selector + ':checked')
                    );
                    break;
                default:
                    errorMessage = rules[i](inputElement.value);
            }
            if (errorMessage) break;
        }

        if (errorMessage) {
            errorElement.innerText = errorMessage;
            getParent(inputElement, options.formGroupSelector).classList.add('invalid');
        } else {
            errorElement.innerText = '';
            getParent(inputElement, options.formGroupSelector).classList.remove('invalid');
        }

        return !errorMessage;
    }

    // get element of form then validate
    var formElement = document.querySelector(options.form);
    if (formElement) {
        // when submit form
        formElement.onsubmit = function (e) {
            e.preventDefault();

            var isFormValid = true;

            // loops rules & validate
            options.rules.forEach(function (rule) {
                var inputElement = formElement.querySelector(rule.selector);
                var isValid = validate(inputElement, rule);
                if (!isValid) {
                    isFormValid = false;
                }
            });

            if (isFormValid) {
                // if submit with javascript
                if (typeof options.onSubmit === 'function') {
                    var enableInputs = formElement.querySelectorAll('[name]');
                    var formValues = Array.from(enableInputs).reduce(function (values, input) {

                        switch(input.type) {
                            case 'radio':
                                values[input.name] = formElement.querySelector('input[name="' + input.name + '"]:checked').value;
                                break;
                            case 'checkbox':
                                if (!input.matches(':checked')) {
                                    values[input.name] = '';
                                    return values;
                                }
                                if (!Array.isArray(values[input.name])) {
                                    values[input.name] = [];
                                }
                                values[input.name].push(input.value);
                                break;
                            case 'file':
                                values[input.name] = input.files;
                                break;
                            default:
                                values[input.name] = input.value;
                        }

                        return values;
                    }, {});
                    options.onSubmit(formValues);
                }
                // if defauls submit
                else {
                    formElement.submit();
                }
            }
        }

        // loops rule event blur, input, ...
        options.rules.forEach(function (rule) {

            // save rules for input
            if (Array.isArray(selectorRules[rule.selector])) {
                selectorRules[rule.selector].push(rule.test);
            } else {
                selectorRules[rule.selector] = [rule.test];
            }

            var inputElements = formElement.querySelectorAll(rule.selector);

            Array.from(inputElements).forEach(function (inputElement) {
                // blur input
                inputElement.onblur = function () {
                    validate(inputElement, rule);
                }


                // check focus input
                inputElement.oninput = function () {
                    var errorElement = getParent(inputElement, options.formGroupSelector).querySelector(options.errorSelector);
                    errorElement.innerText = '';
                    getParent(inputElement, options.formGroupSelector).classList.remove('invalid');
                }
            });
        });
    }

}



// rules
// 1. false => return error message
// 2. success => nothing (undefined)
Validator.isRequired = function (selector, message) {
    return {
        selector: selector,
        test: function (value) {
            return value ? undefined :  message || 'Please enter a valid value'
        }
    };
}
Validator.isSelectbox = function (selector, message) {
    return {
        selector: selector,
        test: function (value) {
            value = $(selector).find("option:selected").attr("select-num");
            console.log($(selector).find("option:selected").attr("select-num"));
           if ($(selector).find("option:selected").attr("select-num") != undefined ) {
                $(selector).focus();             
            } 
            return value == '0'?  message : 'Vui lòng nhập trường này'
        }
    };
}

//Valid Email
Validator.isEmail = function (selector, message) {
    return {
        selector: selector,
        test: function (value) {
            var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            return regex.test(value) ? undefined :  message || 'Please enter a valid value';
        }
    };
}

//Check Min leng input
Validator.minLength = function (selector, min, message) {
    return {
        selector: selector,
        test: function (value) {
            return value.length >= min ? undefined :  message || `Min ${min} `;
        }
    };
}
Validator.maxLength = function (selector, max, message) {
    return {
        selector: selector,
        test: function (value) {
            return value.length < max ? undefined :  message || `Max ${max} `;
        }
    };
}

//Check confirm password or #
Validator.isConfirmed = function (selector, getConfirmValue, message) {
    return {
        selector: selector,
        test: function (value) {
            return value === getConfirmValue() ? undefined : message || 'Please enter a valid value';
        }
    }
}

//Compare value >=
Validator.isCompareGreater = function (selector, getValue, message) {
    return {
        selector: selector,
        test: function (value) {
            return value >= getValue() ? undefined : message || 'Please enter a valid value';
        }
    }
}

//Compare value <=
Validator.isCompareLess = function (selector, getValue, message) {
    return {
        selector: selector,
        test: function (value) {
            return value <= getValue() ? undefined : message || 'Please enter a valid value';
        }
    }
}
Validator.isRegexPattern = function (selector, message) {
    return {
        selector: selector,
        test: function (value) {
            var regex1 = /^\w+([\.-]?\w+)+$/;
            var regex2 = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|]+$/
            return regex1.test(value) || regex2.test(value) ? undefined :  message || 'Please enter a valid value';
        }
    };
}
Validator.isRegexPassword = function(selector, message){
    return {
        selector: selector,
        test: function(value){
            var r1 = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/
            return r1.test(value) ? undefined :  message || 'Please enter a valid value';
        }
    }
}
Validator.isRegexPhoneNumber = function (selector, message) {
    return {
        selector: selector,
        test: function (value) {
            var regex = /^(\d)*$/;
            return regex.test(value) ? undefined :  message || 'Please enter a valid value';
        }
    };
}
 //Check Min leng input
    Validator.isNotZero = function (selector,  message) {
    return {
        selector: selector,
        test: function (value) {
            return value > 0 ? undefined :  message || 'Input cannot be zero';
        }
    };
}