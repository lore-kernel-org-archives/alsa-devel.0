From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: Emvy24control s/pidf input issue
Date: Mon, 17 Mar 2008 17:44:26 +0100
Message-ID: <47DE9FEA.3020509@xs4all.nl>
References: <47DE9D12.9030900@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr6.xs4all.nl (smtp-vbr6.xs4all.nl [194.109.24.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EAA52450B
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 17:44:33 +0100 (CET)
Received: from surfplank2.hierzo (pindarots.xs4all.nl [82.92.197.115])
	(authenticated bits=0)
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id m2HGiRYY012324
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 17:44:32 +0100 (CET)
	(envelope-from udovdh@xs4all.nl)
In-Reply-To: <47DE9D12.9030900@xs4all.nl>
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

Udo van den Heuvel wrote:
> I just noticed that S/PDIF input on my Audiophile 2496 does not work.
> I see:
> 
> [udo@wda ~]$ envy24control
> using    --- input_channels: 0
>          --- output_channels: 4
>          --- pcm_output_channels: 8
>          --- spdif in/out channels: 2
> Unable to read S/PDIF input switch: No such file or directory

I still get the message now, but using envy24control 0.6.0 from
alsa-tools 1.0.16 I do get meters.

Any ideas about the messages I see?

Udo
