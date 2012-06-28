From: raj raja <yuvaraj.addu@gmail.com>
Subject: kcontrol get method
Date: Thu, 28 Jun 2012 15:17:30 +0530
Message-ID: <CADgpFcrZPMkFMsHXfpbc7DQAq7ZnepyD7-NRRWLS69ZPGgddCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 027E3103B49
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 11:47:30 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so1602350bkc.38
	for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2012 02:47:30 -0700 (PDT)
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

Hi,

 Generally get and set methods of Kcontrol called via mixer controls. I
want to update variable value based on my kcontrol set method.  I could not
call get method, like as normal functions. So any way to call particular
kcontrol get method in driver itself

Thanks

Raj
