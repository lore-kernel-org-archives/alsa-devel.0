From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Audio driver for omap 24xx.
Date: Wed, 6 Jun 2007 16:53:48 +0530
Message-ID: <61445c750706060423s5e52fd86l8f69092a4fd85648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by alsa0.perex.cz (Postfix) with ESMTP id BDAE32446D
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2007 13:23:50 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so114619nzf
	for <alsa-devel@alsa-project.org>; Wed, 06 Jun 2007 04:23:49 -0700 (PDT)
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

Hi

I am referring the EAC driver for omap 24xx which is used by n800 board. The
EAC 24xx driver doesn't look complete since it has only hardware init
sequences and very
basic ALSA related functionalities i.e. register the sound card etc. Is omap
24xx eac driver
still in intermediate stage?Or it is complete but not yet integrated in to
omap git tree? In later case,
where can I find the complete eac driver?

Also, omap 24xx driver doesn't seem to follow the framework/structure of
other omap alsa drivers in sound/arm/omap/ , any particular reason?  Please
enlighten. I know this
might be little off topic here, but there are only two places where I can
ask this question, so I am
trying both.

-pharaoh.
