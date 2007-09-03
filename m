From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: HDA: STAC92xx: [PATCH v2] : add support for
	missing features + fix two bugs in new dynamic powersave mode
Date: Mon, 3 Sep 2007 15:48:33 +0300
Message-ID: <200709031548.33978.maximlevitsky@gmail.com>
References: <200709031514.57875.maximlevitsky@gmail.com>
	<s5h8x7neuuj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AE8F1038F6
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 15:49:10 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id d21so1447858nfb
	for <alsa-devel@alsa-project.org>; Mon, 03 Sep 2007 06:49:09 -0700 (PDT)
In-Reply-To: <s5h8x7neuuj.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, mranostay@embeddedalley.com
List-Id: alsa-devel@alsa-project.org

On Monday 03 September 2007 16:34:12 Takashi Iwai wrote:
> At Mon, 3 Sep 2007 15:14:57 +0300,
> Maxim Levitsky wrote:
> > 
> > Hi,
> > 
> > This is new version of my patchset to improve STAC driver.
> > I fixed all issues you told me about.
> > 
> > Note that I also fixed two bugs in hda driver itself, and this is
> > why I didn't have sound after resume-from ram. 
> 
> Thanks!  I applied them to HG tree now.
> 
> 
> Takashi
> 

Thanks a lot, 
If I find another bug/missing feature I will work on that too.

Best regards,
	Maxim Levitsky
