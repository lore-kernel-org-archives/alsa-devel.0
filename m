From: Vadim Lebedev <vadim@mbdsys.com>
Subject: Re: Output to Input routing
Date: Thu, 2 Aug 2007 17:21:21 +0000 (UTC)
Message-ID: <loom.20070802T191711-797@post.gmane.org>
References: <loom.20070731T162636-233@post.gmane.org>
	<s5hir7yruda.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D06B1037ED
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Aug 2007 19:21:59 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IGeMr-00038M-7T
	for alsa-devel@alsa-project.org; Thu, 02 Aug 2007 19:21:47 +0200
Received: from nor75-12-82-230-65-242.fbx.proxad.net ([82.230.65.242])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 02 Aug 2007 19:21:45 +0200
Received: from vadim by nor75-12-82-230-65-242.fbx.proxad.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 02 Aug 2007 19:21:45 +0200
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

Takashi Iwai <tiwai <at> suse.de> writes:
....
> > This setting is ideal for echo cancellation algorithm.
> 
> 	% amixer cset iface=MIXER,name='Capture Source' 0,5
.....
Hi Takashi,
Tjis is very helpful, thanks a lot....
I wonder howvere if somoedy can post the same thing said in C?

Thanks
Vadim
