package com.sw.service;

import org.commonmark.node.Node;
import org.commonmark.parser.Parser;
import org.commonmark.renderer.html.HtmlRenderer;
import org.springframework.stereotype.Service;

@Service
public class MarkDownService {

	 private static final Parser parser = Parser.builder().build();
    private static final HtmlRenderer renderer = HtmlRenderer.builder().build();
    
    public String markdownToHtml(String markdown) {
       
       if(markdown == null) return "";
       
       Node document = parser.parse(markdown);
       
       return renderer.render(document);
    }
}
