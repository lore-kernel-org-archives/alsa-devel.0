From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: problems with fedora 11 and pulseaudio and svn x-fi
	driver
Date: Wed, 10 Jun 2009 03:39:11 -0500
Message-ID: <1244623151.4093.3.camel@localhost.localdomain>
References: <s5hy70xsl46.wl%tiwai@suse.de> <1223583478.5018.0.camel@home>
	<s5hbpxt7zui.wl%tiwai@suse.de>  <1223619975.4700.2.camel@home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A0972456D
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 10:39:15 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c3so313377ana.2
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 01:39:13 -0700 (PDT)
In-Reply-To: <1223619975.4700.2.camel@home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I upgraded to fedora 11 with PA 9.15 and got the svn alsa-driver and
installed it for the x-fi driver.

The problem is, with pulseaudio, i get a pop every few seconds
like, every 3 seconds, "pop" and it does it over and over and over

I seem to get no sound at all with the card if I bypass pulse

What can I do?
