From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/3] ALSA: firewire: Remove superfluous
 snd_info_register() calls
Date: Wed, 6 Feb 2019 16:38:36 +0100
Message-ID: <b598248f-6ee7-13c3-d43f-1da95db0d477@perex.cz>
References: <20190205160527.8815-1-tiwai@suse.de>
 <20190205160527.8815-2-tiwai@suse.de> <20190206143322.GA4337@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A42D26793F
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 16:38:39 +0100 (CET)
In-Reply-To: <20190206143322.GA4337@workstation>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 6.2.2019 v 15:33 Takashi Sakamoto napsal(a):
> By the way, would I request you to sync alsa-utils repo in
> git.alsa-project.org to the one in github.com? 9 patches
> were applied to the latter, but never to the former.

Fixed. Thanks. I don't know why the sync was not triggered from github
this time. I will create a cron job.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
