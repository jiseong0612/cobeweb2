package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Component	
@ToString
@RequiredArgsConstructor
public class Hotel {
	private Chef chef;
	
}
