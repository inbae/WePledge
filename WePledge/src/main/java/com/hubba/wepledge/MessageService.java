package com.hubba.wepledge;

import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;

public class MessageService implements MessageSourceAware{

	private MessageSource messageSource;
	
	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}

	public MessageSource getMessageSource() {
		return messageSource;
	}

}
