From: Kevin Gilbert <kevin952@tpg.com.au>
Subject: Re: Problems with pulseaudio / asla on PS3
Date: Fri, 5 Sep 2008 21:02:06 +1000
Message-ID: <200809052102.06534.kevin952@tpg.com.au>
References: <200809050842.08596.kevin952@tpg.com.au>
	<s5hwshrt84y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail9.tpgi.com.au (mail9.tpgi.com.au [203.12.160.104])
	by alsa0.perex.cz (Postfix) with ESMTP id B0123103825
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 13:02:35 +0200 (CEST)
Received: from giles.localnet (60-242-39-232.static.tpgi.com.au
	[60.242.39.232]) (authenticated bits=0)
	by mail9.tpgi.com.au (envelope-from kevin952@tpg.com.au)
	(8.14.3/8.14.3) with ESMTP id m85B2UcA003855
	for <alsa-devel@alsa-project.org>; Fri, 5 Sep 2008 21:02:32 +1000
In-Reply-To: <s5hwshrt84y.wl%tiwai@suse.de>
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

Hi Takashi,

On Fri, 5 Sep 2008, Takashi Iwai opined:
> Well, it's no bug in softvol, at least.  The softvol doesn't do any
> format or layout conversions.  The layout conversion is done via plug
> plugin applied onto the softvol.

OK (not that I fully understand what you have said) but where does that leave 
me? Is there something that I should try? Some ALSA or kernel configuration 
option that might be in error?

Kevin
