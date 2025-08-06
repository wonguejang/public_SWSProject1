package util;

import org.springframework.stereotype.Component;

@Component
public class RateLimitChecker {
	private final int maxQPS = 18;
    private final int maxMin = 18;
    private final int maxQPM = 98;

    public boolean checkRateLimit(int count, int time) {
        if (time == 1 && count > maxQPS) return false;
        if (time == 60 && count > maxMin) return false;
        if (time == 120 && count > maxQPM) return false;
        return true;
    }

    public void checkAllLimit(String[] limitArr) throws InterruptedException {
        for (String part : limitArr) {
            String[] cntArr = part.split(":");
            int count = Integer.parseInt(cntArr[0]);
            int time = Integer.parseInt(cntArr[1]);

            if (!checkRateLimit(count, time)) {
                long waitTime = time * 1000L;
                System.out.println("호출 제한! " + (waitTime / 1000) + "초 대기.");
                Thread.sleep(waitTime);
            }
        }
    }
    public void checkSafe(String appRateLimitCount) {
        try {
            String[] limitArr = appRateLimitCount.split(",");
            checkAllLimit(limitArr);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
