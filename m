From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Fri, 4 Sep 2009 12:23:59 +0200
Message-ID: <7c5010d60909040323u2ef4788q6db6bc119b25c38b@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<s5hfxb3k8v8.wl%tiwai@suse.de>
	<7c5010d60909031503k36a30855h6115e4689d1dd0f4@mail.gmail.com>
	<7c5010d60909031543v4291a332ge415f91f3412dda@mail.gmail.com>
	<s5h7hwfb3h2.wl%tiwai@suse.de>
	<7c5010d60909040057m29b68361nd34a4bb1254860e8@mail.gmail.com>
	<7c5010d60909040214k2a673606j6b262ca235ba8a24@mail.gmail.com>
	<s5h8wgv12y1.wl%tiwai@suse.de>
	<7c5010d60909040233n42913563va2ed695bc383274f@mail.gmail.com>
	<s5h3a73109p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id E52DF1038ED
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 12:23:59 +0200 (CEST)
Received: by fxm3 with SMTP id 3so576837fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2009 03:23:59 -0700 (PDT)
In-Reply-To: <s5h3a73109p.wl%tiwai@suse.de>
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
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 4, 2009 at 12:18 PM, Takashi Iwai<tiwai@suse.de> wrote:
> Maybe better to add a substream id (e.g. substream->stream,
> substream->number) to avoid confusion.
>

I will add it and rerun.

-giovanni
