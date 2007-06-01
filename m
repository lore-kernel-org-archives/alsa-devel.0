From: Michael Buesch <mb-fseUSCV1ubazQB+pC5nmwQ@public.gmane.org>
Subject: Re: [1/3] 2.6.22-rc3: known regressions v2
Date: Fri, 1 Jun 2007 22:48:53 +0200
Message-ID: <200706012248.53971.mb@bu3sch.de>
References: <46600F1C.5000302@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <46600F1C.5000302-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Piotrowski <michal.k.k.piotrowski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Toralf =?iso-8859-2?q?F=F6rster?= <toralf.foerster-Mmb7MZpHnFY@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Volpiatto <tvolpiatt-8puV8OjpVw0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-AlSwsSmVLrQ@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Ben Collins <bcollins-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maximilian Engelhardt <maxi-OwNUvPV92VfddJNmlsFzeA@public.gmane.org>, Gary Zambrano <zambrano-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Friday 01 June 2007 14:20:44 Michal Piotrowski wrote:
> Networking
> 
> Subject    : b44: regression in 2.6.22
> References : http://lkml.org/lkml/2007/5/27/108
> Submitter  : Maximilian Engelhardt <maxi-OwNUvPV92VfddJNmlsFzeA@public.gmane.org>
> Handled-By : Michael Buesch <mb-fseUSCV1ubazQB+pC5nmwQ@public.gmane.org>

Well, it looks like a highres-timers problem or something
like that. So I can't really be handling that, as I have no
clue about this.
I suggest you also add Gary Zambrano <zambrano-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
here, as he is actually the maintainer of b44. Not me.
My role was just helping in debugging the issue, as I know
some details of b44.

> Status     : problem is being debugged



-- 
Greetings Michael.
