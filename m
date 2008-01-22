From: James Pearson <james-p@moving-picture.com>
Subject: Re: 1.0.16rc1 release
Date: Tue, 22 Jan 2008 17:39:47 +0000
Message-ID: <47962A63.8020204@moving-picture.com>
References: <Pine.LNX.4.61.0801221247570.9698@tm8103.perex-int.cz>	<47961880.3090309@moving-picture.com>	<s5h4pd5954z.wl%tiwai@suse.de>	<479624A6.7040700@moving-picture.com>
	<s5hwsq17p64.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 42D06103805
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 18:39:48 +0100 (CET)
In-Reply-To: <s5hwsq17p64.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>>
>>>Or, RH has an uncomplete mutex implementation?
>>
>>Don't know - see above?
> 
> 
> Looks like so...  Sigh.
> 
> Can someone report RedHat to fix their kernel?

May be that should be someone that has an interest in sound and has 
recently started working for RedHat ??

Is it possible to define mutex_destroy in the ALSA code if it isn't 
defined elsewhere for this case?

Thanks

James Pearson
