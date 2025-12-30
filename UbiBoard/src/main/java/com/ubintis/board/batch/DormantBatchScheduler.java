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


    @Scheduled(cron = "0 0 3 * * *")
    public void runDormantJob() {
        try {

            JobParameters jobParameters = new JobParametersBuilder()
                    .addDate("requestDate", new Date())
                    .toJobParameters();

            System.out.println("휴면 계정 전환 배치 시작: " + new Date());
            
            jobLauncher.run(dormantUserJob, jobParameters);
            
            System.out.println("휴면 계정 전환 배치 종료: " + new Date());
            
        } catch (Exception e) {
            System.err.println("휴면 배치 실행 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
    }
 // 서버가 시작되자마자 딱 한 번 실행됨
    @PostConstruct
    public void testRun() {
        System.out.println("서버 시작 시 배치를 실행합니다.");
        runDormantJob();
    }
}