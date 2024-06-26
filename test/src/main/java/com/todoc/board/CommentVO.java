package com.todoc.board;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class CommentVO {
	private int commentidx;
	private int postidx;
	private int useridx;
	private int hosidx;
	private String content;
	private Date commentdate;
	private String nickname;
	private String hosname;
	private String formattedCommentDate;
	private String title;
	
	public int getCommentidx() {
		return commentidx;
	}
	public void setCommentidx(int commentidx) {
		this.commentidx = commentidx;
	}
	public int getPostidx() {
		return postidx;
	}
	public void setPostidx(int postidx) {
		this.postidx = postidx;
	}
	public int getUseridx() {
		return useridx;
	}
	public void setUseridx(int useridx) {
		this.useridx = useridx;
	}
	public int getHosidx() {
		return hosidx;
	}
	public void setHosidx(int hosidx) {
		this.hosidx = hosidx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	public Date getCommentdate() {
		return commentdate;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	public void setCommentdate(Date commentdate) {
		this.commentdate = commentdate;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getHosname() {
		return hosname;
	}
	public void setHosname(String hosname) {
		this.hosname = hosname;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	@Override
	public String toString() {
		return "CommentVO [commentidx=" + commentidx + ", postidx=" + postidx + ", useridx=" + useridx + ", hosidx="
				+ hosidx + ", content=" + content + ", commentdate=" + commentdate + ", nickname=" + nickname
				+ ", hosname=" + hosname + ", formattedCommentDate=" + formattedCommentDate + ", title=" + title + "]";
	}
	public String getFormattedCommentDate() {
		return formattedCommentDate;
	}
	public void setFormattedCommentDate(String formattedCommentDate) {
		this.formattedCommentDate = formattedCommentDate;
	}
	
	
}
