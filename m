From: "Norayr Chilingaryan" <gnorayr@gmail.com>
Subject: problems with es1688 isa card on etch and lenny (ok
	with sarge)
Date: Wed, 6 Feb 2008 00:05:57 +0100
Message-ID: <f5976be10802051505x61480bbdq8fe61845b3c89470@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FB1124179
	for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2008 00:05:58 +0100 (CET)
Received: by ag-out-0708.google.com with SMTP id 22so4439209agd.8
	for <alsa-devel@alsa-project.org>; Tue, 05 Feb 2008 15:05:57 -0800 (PST)
Content-Disposition: inline
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

Hello,
I have an old notebook with ISA sound card which is detected by alsaconf as
es18xx, or es1688 or sb16 and works.
The problem is appeared when I replaced Debian Sarge with Debian Etch, and
when I upgraded Etch to Lenny (i. e. with  alsa versions in that distros).
So, alsaconf detects and configures a sound driver, it works, but after
restart to have a sound I must run alsaconf again. I think something is
changed in the recent alsa distributions which probably deals with debian
configuration of isa cards.

Thank you

Norayr

---
norayr.livejournal.com
