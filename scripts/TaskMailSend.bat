Rem # [Batch File] TaskMailSend.bat

Rem ### 실행 주기 : 5분 간격 수행
Rem # Task 시작, 종료 알림 메일 발송
Rem # Program  : sbTaskMailSend_mxJPO.java
Rem # Function : doProcess

C:\enoviaV6R2019x\studio\win_b64\code\bin\mql.exe -v -bootfile MATRIX-R -c "set context person creator;exec program sbTaskMailSend -method doProcess"