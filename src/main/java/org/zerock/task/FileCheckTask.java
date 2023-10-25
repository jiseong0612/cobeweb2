package org.zerock.task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class FileCheckTask {

	@Scheduled(cron="0 0 2 * * *")
	public void checkFiless()throws Exception{
		log.debug("file check task run......");
		log.debug("=====================");
		
	}
}
