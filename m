From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: Re: [PATCH v2] sound: pci: asihpi: hpifunc.c: Remove
	some unused functions
Date: Thu, 1 Jan 2015 17:28:05 +0100
Message-ID: <CAKXHbyNEhxSBjuHyFz0RLfDh0xcBRnwkxX=ncgiqtyf_qeQ=Qw@mail.gmail.com>
References: <1420039022-10018-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <s5h7fx7hkga.wl-tiwai@suse.de>
 <CAKXHbyOEp=juzjaqsNt9RXn02VYDJXvESK4o_vAhMtFGmK=dHA@mail.gmail.com>
 <s5hvbkrg44c.wl-tiwai@suse.de>
 <CAKXHbyPEr+HOAXB8ibtpYidh_GVD0qAgcQK3A4kXpgVWgLbtQA@mail.gmail.com>
 <s5hsifvg192.wl-tiwai@suse.de>
 <54A46CEF.3030108@blennerhassett.gen.nz>
 <s5hoaqjexm7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id CB7E7261A90
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:28:11 +0100 (CET)
Received: by mail-ig0-f174.google.com with SMTP id hn15so14717843igb.7
 for <alsa-devel@alsa-project.org>; Thu, 01 Jan 2015 08:28:10 -0800 (PST)
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com.
 [209.85.213.175])
 by mx.google.com with ESMTPSA id qc7sm18465758igb.5.2015.01.01.08.28.05
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 01 Jan 2015 08:28:05 -0800 (PST)
Received: by mail-ig0-f175.google.com with SMTP id h15so14733749igd.2
 for <alsa-devel@alsa-project.org>; Thu, 01 Jan 2015 08:28:05 -0800 (PST)
In-Reply-To: <s5hoaqjexm7.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

2015-01-01 9:03 GMT+01:00 Takashi Iwai <tiwai@suse.de>:

> At Thu, 01 Jan 2015 10:38:55 +1300,
> Eliot Blennerhassett wrote:
> >
> > >>> More code changes may land in near future, so removing functions
> isn't
> > >>> good at all at this moment.  We need to wait until the all things are
> > >>> settled down.  IOW, forget about this for a while :)
> >
> > Hi Richard, Takashi,
> >
> > In principle I don't object to this patch (thanks for the work Richard),
> > but right now I'm really on vacation, and then at LCA so won't be
> > spending time on it until late January.
> >
> > How about I take the patch into my tree, and include in my next set of
> > updates, allowing for any further tweaks to the unused function list.
>
> It's up to you, and indeed this would be a good solution.
>
>
> thanks,
>
> Takashi
>


Hi Eliot

That sounds just fine to me.

Hope you have a good holiday :)

Kind regards
Rickard Strandqvist
