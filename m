From: =?ISO-8859-1?Q?Anders_R=F8nningen?= <andersronningen@gmail.com>
Subject: Re: Problem with DELL XPS M1530
Date: Tue, 19 Feb 2008 17:24:04 +0100
Message-ID: <47BB02A4.8080907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 0989E24607
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 17:24:19 +0100 (CET)
Received: by mu-out-0910.google.com with SMTP id i10so2093577mue.3
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 08:24:19 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi. I am the mentioned user with this problem. Just thought I'd give you 
a little more info on this problem.

What wishie described was correct, except it's the internal speakers and 
the /left/ hp-jack that stopped working, while the right one is still 
ok. Like he wrote, the reason we started this debugging was to get mic 
sound on my system. The thing I think is worth mentioning is that with 
alsa 1.0.14 on an out-of-the box Ubuntu Gutsy, both hp-jacks and the 
internal speakers worked for me. People in #alsa told me that the module 
was not loaded correctly, but whatever was loaded _almost_ worked well :-)

- Anders
