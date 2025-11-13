# Solution - DevOps SRE Challenge Season 1 (Day 1)
---------------------------------------------------------------------------------------------------------

Hello Learners, solving this challenge enable me to think on different perspectives. In terms of how maintaining and managing systems at its very core level.

This helped me to understand the valuable information of any Linux based systems is a crucial part of monitoring.

As a DevOps and SRE Engineer this challenge will help in gaining skills around scripting and systems resource management.

While solving this challenge, I come across some issues and problems.I have fixed these issue and able to complete this challenge.



## Issues and Problems
---

  1. Displaying the commands output into single file as a report.

     - To fix this issue I have saved and concatenatd the command output in to a text file called `report.txt` with timestamp included.


  2. Creating and maintaining the file format for report.txt

     - To have a fixed format for report file is crucial. As, it helps the stakeholder to easily able to read and understand the data in the file.


  3. Sending the System Health Check report file via Email
   
     - Sending a report via email is bit challenging as proper configuration of SMTP server, Email API key configurations is required.

     - I have used goggle email services to send an email to stake holders.

     - This helped me understand how email sending process is and what configs are needed to send an email.

   
     - Also, I have to ensure that email body must have the report file attached and it should received by the receiver in the same exact format.





     Linkedin post
     -------------


     Can you build a System Health Check tool that can help you save a lot of time? Let's build it with me.

Hello Folks, I am back again with a new DevOps SRE Challenge Season 1 Series. 

Excited to share my learning journey through this challenge series.

What is new in this series? What skills will you gain? 

This new series will help you with hands-on challenges designed to enhance your DevOps and Site Reliability Engineering skills through practical, real-world scenarios.

The Day 1 Challenge is to build a Menu based system health check script to check system health and send a comprehensive report at scheduled time.


So, what I learned from the day 1 challenge?

- Understand `Fucntions in linux` and utilized it to create a `reusable functionality`(such as Evalute CPU usages, Monitor Running Services, Assess Disk usages, Assess Memory Usages, Send a Comprehensive report via email )

- Utilized the power of `while loop` and `case statement` to reuse the above functionality repeatedly.

- Utilized linux builtin command such  `echo` and linux operator to Collect and represent system health data in good format.

- Utilized the power of `Linux Crontab' for task scheduling and automating the whole process.

- Used SMTP protocol to send an email at schedule time.


Key Challenges and Solutions:

- Ensuring the format of system health check report must be well formatted and represented.

- Faced issues on email notification, for this I have utlized gmail smtp service.

You can find my learnings here: [https://lnkd.in/gvgnfqUN]

Thanks @   for this awesome challenge.




