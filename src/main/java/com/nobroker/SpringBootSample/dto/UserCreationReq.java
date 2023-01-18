package com.nobroker.SpringBootSample.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import javax.validation.constraints.NotBlank;
import lombok.Data;

@JsonIgnoreProperties
@Data
public class UserCreationReq {

  @NotBlank(message = "name cannot be blank")
  String name;
  String email;
  String phone;
}
