package com.apollo.exchange.web.apidocument.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MessageDTO<T>  {

    private String state = null;
    private String message = null;

    private T response = null;
}
