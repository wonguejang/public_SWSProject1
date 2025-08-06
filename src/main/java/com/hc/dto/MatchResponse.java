package com.hc.dto;

import java.util.List;

public class MatchResponse {
    public Info info;

    public static class Info {
        public long gameStartTimestamp;
        public long gameEndTimestamp;
        public List<Participant> participants;
        public List<Team> teams;
    }

    public static class Participant {
        public String puuid;
        public String riotIdGameName;
        public String riotIdTagline;
        public String championName;
        public int championId;
        public int kills, deaths, assists;
        public int totalDamageDealtToChampions;
        public int profileIcon;
        public int teamId;
        public int item0, item1, item2, item3, item4, item5, item6;
        public int summoner1Id, summoner2Id;
        public Perks perks;
    }

    public static class Perks {
        public List<Style> styles;
    }

    public static class Style {
        public List<Selection> selections;
    }

    public static class Selection {
        public int perk;
    }

    public static class Team {
        public int teamId;
        public boolean win;
        public List<Ban> bans;
    }

    public static class Ban {
        public int championId;
    }
}
