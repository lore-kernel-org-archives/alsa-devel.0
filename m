From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: Re: problems with fedora 11 and pulseaudio and svn
	x-fi driver
Date: Wed, 10 Jun 2009 03:52:35 -0500
Message-ID: <1244623955.6367.0.camel@localhost.localdomain>
References: <s5hy70xsl46.wl%tiwai@suse.de> <1223583478.5018.0.camel@home>
	<s5hbpxt7zui.wl%tiwai@suse.de>  <1223619975.4700.2.camel@home>
	<1244623151.4093.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217])
	by alsa0.perex.cz (Postfix) with ESMTP id C4C271037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 10:52:38 +0200 (CEST)
Received: by gxk17 with SMTP id 17so631829gxk.8
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 01:52:37 -0700 (PDT)
In-Reply-To: <1244623151.4093.3.camel@localhost.localdomain>
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

I killed pulseaudio and the problem is the same as far as every few
seconds, just a different sound.  it seems to be the xfi driver.

I did not have this problem with XFiDrv_Linux_Public_US_1.00.tar.gz
however, I am trying to get away from that driver because of other
issues.

Thanks!

On Wed, 2009-06-10 at 03:39 -0500, Ted T. Logan wrote:

> Hello,
> 
> I upgraded to fedora 11 with PA 9.15 and got the svn alsa-driver and
> installed it for the x-fi driver.
> 
> The problem is, with pulseaudio, i get a pop every few seconds
> like, every 3 seconds, "pop" and it does it over and over and over
> 
> I seem to get no sound at all with the card if I bypass pulse
> 
> What can I do?
> 
> 
