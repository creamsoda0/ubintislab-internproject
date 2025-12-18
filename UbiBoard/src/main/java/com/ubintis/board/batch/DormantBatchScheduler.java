package com.ubintis.board.batch;

import java.util.Date;

import javax.annotation.PostConstruct;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class DormantBatchScheduler {

    @Autowired
    private JobLauncher jobLauncher;

    @Autowired
    private Job dormantUserJob;

    /**
     * 매일 새벽 3시에 휴면 계정 전환 배치 실행
     * cron: 초 분 시 일 월 요일
     */
    @Scheduled(cron = "0 0 3 * * *")
    public void runDormantJob() {
        try {
            // 스프링 배치는 동일한 JobParameter로 실행하면 '이미 완료된 작업'으로 간주하고 실행하지 않음
            // 따라서 매번 새로운 파라미터(현재 시간)를 추가하여 실행되도록 설정함
            JobParameters jobParameters = new JobParametersBuilder()
                    .addDate("requestDate", new Date())
                    .toJobParameters();

            System.out.println(">>> 휴면 계정 전환 배치 시작: " + new Date());
            
            jobLauncher.run(dormantUserJob, jobParameters);
            
            System.out.println(">>> 휴면 계정 전환 배치 종료: " + new Date());
            
        } catch (Exception e) {
            System.err.println("!!! 휴면 배치 실행 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
    }
 // 서버가 시작되자마자 딱 한 번 실행됨
    @PostConstruct
    public void testRun() {
        System.out.println("보안 테스트: 서버 시작 시 배치를 즉시 실행합니다.");
        runDormantJob();
    }
}