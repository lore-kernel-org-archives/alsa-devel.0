From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-user] shittiness
Date: Tue, 20 Jan 2004 10:14:44 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401201006340.1857@pnote.perex-int.cz>
References: <200401170141.16791.steveconrad@lincsatmail.com>
 <400C565D.4050906@reachone.com> <20040119222121.5540c721.rkimber@ntlworld.com>
 <200401200931.10121.markc@renta.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA15420
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2004 10:16:09 +0100
In-Reply-To: <200401200931.10121.markc@renta.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: markc@renta.net
Cc: alsa-user@lists.sourceforge.net, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Jan 2004 markc@renta.net wrote:

> So that you and I and the rest of us will test both the kernel and
> ALSA, and the kernel+ALSA, under various hardware conditions that 
> will never happen until either is declared "stable". Allow about 1/2 
> a year for both, and the combination of both, to truly stablize. 
> It may seem like a non-professional way to go about it but in the
> larger scheme of things, where some of us have been waiting _years_
> (let alone those who have been doing the actual work) for a single 
> truly open source audio environment, it's getting very close to being
> the ultimate system "we" have been waiting for.

Before flames, I would like to notice that we have only limited amount of 
hardware for tests. The current hardware vendors are producing very large 
number of configurations, modifications etc. especially for cheap 
hardware. It's very difficult to support all variations, so please, be 
patient until a developer analyses the given problem and fix it.

If you know the ethernet drivers (eepro100), you might noticed that in
past, there were / are also some issues, because many transciever
variations and configurations exists around. It's not about API, but it's 
about particular driver.

Also, we do not have any links with most of hardware vendors, so we very 
depend on free information about their hardware.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
