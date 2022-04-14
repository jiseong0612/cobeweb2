package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
	@Select("select sysdate from dual")
	String getTime();
	
	String getTime2(List<String> list);
}
