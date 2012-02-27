package com.hubba.wepledge;


import javax.mail.*;
import javax.mail.internet.*;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

public class EmailSender {

	/**
	 * this is the method to push all emails into the repository for email job to process.  
	 */
	public void pushToEmailRepository() {
		
	}
	
	
	
	
    public synchronized void sendEmail(String toEmail, String subjectStr, String bodyStr) throws UnsupportedEncodingException, MessagingException
    {
        Properties props = new Properties();
        // ask IT People for company mail server
        String mailHost = "Your Company Email Server";
        String mailSender = "Your Office Mail ID";
        String malSenderName = "Your Email";
        props.put("mail.host", mailHost);
        props.put("mail.user", mailSender);
        Session mailSession = Session.getDefaultInstance(props, null);
        MimeMessage msg = new MimeMessage(mailSession);
        Multipart multipart = new MimeMultipart();
        BodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(bodyStr, "text/html");
        multipart.addBodyPart(messageBodyPart);
        msg.setFrom(new InternetAddress(mailSender, malSenderName));
        msg.addRecipient(Message.RecipientType.TO,
        new InternetAddress(toEmail));
        msg.setSubject(subjectStr);
        msg.setContent(multipart);
        Transport.send(msg);
    }

    public synchronized void sendEmailFromGmail(String from, String to, String subject, String content, Properties props, final String username, final String password){

        Authenticator auth = new Authenticator(){
            @Override
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(username, password);
            }
        };
        Session session = Session.getInstance(props, auth);
        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            InternetAddress[] address = { new InternetAddress(to) };
            msg.setRecipients(Message.RecipientType.TO, address);
            msg.setSubject(subject);
            msg.setSentDate(new Date());
//            msg.setContent("This is a test <b>HOWTO<b>", "text/html; charset=ISO-8859-1");
//            msg.setText(content);
            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg);
        } catch (MessagingException mex){
            mex.printStackTrace();
        }

    }
	
	
	
}
