package com.wg.service;


import org.commonmark.node.Node;
import org.commonmark.parser.Parser;
import org.commonmark.renderer.html.HtmlRenderer;
import org.springframework.stereotype.Service;

@Service
public class MarkdownService {

	private static final Parser parser = Parser.builder().build();
    private static final HtmlRenderer renderer = HtmlRenderer.builder().build();
    
    //마크다운 에디터를 사용하기 위해 만든 서비스 메서드
    public String markdownToHtml(String markdown) {
    	
    	if(markdown == null) return "";
    	
    	Node document = parser.parse(markdown);
    	
    	return renderer.render(document);
    }
    
}
