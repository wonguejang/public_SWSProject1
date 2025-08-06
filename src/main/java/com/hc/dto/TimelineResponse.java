package com.hc.dto;

import java.util.List;

public class TimelineResponse {
    public Info info;

    public static class Info {
        public List<Frame> frames;
    }

    public static class Frame {
        public List<Event> events;
    }

    public static class Event {
        public String type;
        public Integer skillSlot;
        public Integer participantId;
        public Integer timestamp;
    }
}