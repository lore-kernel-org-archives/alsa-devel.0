From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/4] ak411x fix patches for ice1724 Juli@
Date: Fri, 16 Jan 2015 18:27:39 +0100
Message-ID: <54B94A0B.2000102@perex.cz>
References: <1421428603-6739-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 5942926041B
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 18:27:40 +0100 (CET)
In-Reply-To: <1421428603-6739-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>
List-Id: alsa-devel@alsa-project.org

Dne 16.1.2015 v 18:16 Takashi Iwai napsal(a):
> Hi,
> 
> here is a bit more cooked patch series for ak411x and juli@ device.
> 
>  [PATCH 1/4] ALSA: ak411x: Fix stall in work callback
>  [PATCH 2/4] ALSA: ak4114: Move EXPORT_SYMBOL() after each function
>  [PATCH 3/4] ALSA: ak411x: Add PM helper functions
>  [PATCH 4/4] ALSA: ak411x: Fix race of reinit() calls

Acked-by: Jaroslav Kysela <perex@perex.cz>

for all of them...

			Thanks,
				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
