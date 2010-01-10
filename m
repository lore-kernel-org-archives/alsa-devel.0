From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: ac97: Add Dell Dimension 2400 to
 Headphone/Line Jack Sense blacklist
Date: Sun, 10 Jan 2010 19:02:21 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001101901270.4210@eeebox2.perex-int.cz>
References: <604760771001082227s6e3f6bbah97c1cbcc4c163f7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BE27124788
	for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2010 19:02:21 +0100 (CET)
In-Reply-To: <604760771001082227s6e3f6bbah97c1cbcc4c163f7f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 9 Jan 2010, Daniel Chen wrote:

> Hi,
>
> Attached is a patch against current sound-2.6 master HEAD fixing
> inaudible playback by default.

Thanks. I've applied this patch to my "fixes" GIT tree.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
