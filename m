From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: asoundconf removed from alsa-utils?
Date: Wed, 13 May 2009 15:28:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905131527010.25064@eeebox2.perex-int.cz>
References: <9203434.1242220124470.JavaMail.root@mswamui-andean.atl.sa.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 71A3C10388B
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 15:28:17 +0200 (CEST)
In-Reply-To: <9203434.1242220124470.JavaMail.root@mswamui-andean.atl.sa.earthlink.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Susan Cragin <susancragin@earthlink.net>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 13 May 2009, Susan Cragin wrote:

> The message says that asoundconf is not present because alsa-utils is 
> not installed. However, I have just installed the latest. 20090512.
>
> And the following alsa-utils work:
> arecord works, as well as alsamixer and alsactl.
>
> I hesitate to even report this, because I'm on karmic with 
> 2.6.30-5-generic kernel, and I know there are bugs, and that I am 
> pre-alpha.
>
> So this is FYI -- no response needed or expected.

asoundconf is probably an Ubuntu specific tool. We do not maintain this 
utility. Ask on appropriate place.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
