From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] hdspmixer buffer overflow
Date: Sat, 15 May 2010 12:03:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005151202320.6856@eeebox2.perex-int.cz>
References: <4BEE4F3E.9030900@schwaben.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 86EA9245C9
	for <alsa-devel@alsa-project.org>;
	Sat, 15 May 2010 12:03:17 +0200 (CEST)
In-Reply-To: <4BEE4F3E.9030900@schwaben.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Georg Rudolph <georg.rudolph@schwaben.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 15 May 2010, Georg Rudolph wrote:

> Hello,
>
> to fix https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5006
> the attached patch for alsa-tools is proposed:
>
> Summary: Fix buffer overflow in hdspmixer

Thanks, I've applied your patch to the GIT tree.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
