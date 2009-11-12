From: Halim Sahin <halim.sahin@freenet.de>
Subject: Re: alsa-info: problem hda-intel based card
Date: Thu, 12 Nov 2009 18:55:37 +0100
Message-ID: <20091112175537.GA20471@gentoo.local>
References: <20091030132214.GA18477@gentoo.local>
	<s5hy6mju38e.wl%tiwai@suse.de>
	<20091111164817.GA30694@gentoo.local>
	<s5haaytge8e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id AB0D9103805
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 18:56:18 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1N8du5-0008Mf-7D
	for alsa-devel@alsa-project.org; Thu, 12 Nov 2009 18:56:17 +0100
Received: from pd9e3ed68.dip.t-dialin.net ([217.227.237.104])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 18:56:17 +0100
Received: from halim.sahin by pd9e3ed68.dip.t-dialin.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 18:56:17 +0100
Content-Disposition: inline
In-Reply-To: <s5haaytge8e.wl%tiwai@suse.de>
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
On Mi, Nov 11, 2009 at 06:31:29 +0100, Takashi Iwai wrote:
> > Is there really no way to configure this with a custom ~/.asoundrc?
> 
> You can set up in a software way, of course :)
 
That's the point.
libasound configuration isn't easy enough.
I made some tests and got the sp/dif and hdmi working together (without
dmix :-(). 
Combining analog and hdmi didn't work, (only analog and sp/dif with
default setup).

Can you give me an example config?

BR.
halim

> Takashi

-- 
Halim Sahin
E-Mail:				
halim.sahin (at) t-online.de
-- 
Halim Sahin
E-Mail:				
halim.sahin (at) t-online.de
